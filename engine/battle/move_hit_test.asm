; some tests that need to pass for a move to hit
; moved from bank F
_MoveHitTest:
	ld hl, wNewBattleFlags
	bit USING_SIGNATURE_MOVE, [hl]		; skip TOXIC check if move used is a signature move
	jr nz, .suckerPunchCheck
	ld hl, wBattleMonType
	ld bc, wPlayerMoveNum
	ld a, [H_WHOSETURN]
	and a
	jr z, .poisonTypeUsingToxicCheck
	ld hl, wEnemyMonType
	ld bc, wEnemyMoveNum
.poisonTypeUsingToxicCheck
	ld a, [bc]
	cp TOXIC
	jr nz, .suckerPunchCheck
	ld a, [hli]
	cp POISON
	ret z
	ld a, [hl]
	cp POISON
	ret z								; Poison-types using Toxic always hit, even during semi-invulnerable turns
.suckerPunchCheck
	ld hl, wPlayerMoveEffect
	ld a, [H_WHOSETURN]
	and a
	jr z, .checkSuckerPunch
	ld hl, wEnemyMoveEffect
.checkSuckerPunch
	ld a, [hl]
	cp SUCKER_PUNCH_EFFECT
	jr nz, .afterSuckerPunch
	call SuckerPunchChecks
	jp nz, .moveMissed					; if previous function unsets z flag, it means sucker punch can't work
.afterSuckerPunch
	ld hl, wEnemyMonHP 
	ld a, [H_WHOSETURN] 
	and a 
	jr z, .playersTurn 
	ld hl, wBattleMonHP 
.playersTurn 
	ld a, [hli] 
	ld b, a 
	ld a, [hl] 
	or b
	jp z, .moveMissed					; target mon is already down, make the move miss
; player's turn
	ld hl, wEnemyBattleStatus1
	ld de, wPlayerMoveEffect
	ld bc, wEnemyMonStatus
	ld a, [H_WHOSETURN]
	and a
	jr z, .dreamEaterCheck
; enemy's turn
	ld hl, wPlayerBattleStatus1
	ld de, wEnemyMoveEffect
	ld bc, wBattleMonStatus
.dreamEaterCheck
	ld a, [de]
	cp DREAM_EATER_EFFECT
	jr nz, .invulnerabilityCheck
	ld a, [bc]
	and SLP								; is the target pokemon sleeping?
	jp z, .moveMissed
.invulnerabilityCheck
	bit INVULNERABLE, [hl]				; moved this up before swift and struggle checks so that they can't
	jr z, .notInvulnerable				; hit a Pokémon in the semi-invulnerable turn of Dig, Fly etc.
	ld hl, wEnemyMoveNum
	ld bc, wPlayerMoveNum
	ld a, [H_WHOSETURN]
	and a
	jr z, .invulnerabilityBypassCheck
	ld hl, wPlayerMoveNum
	ld bc, wEnemyMoveNum
.invulnerabilityBypassCheck				; added this part to make certain moves hit during semi-invulnerable turns
	push hl
	ld hl, wNewBattleFlags
	bit USING_SIGNATURE_MOVE, [hl]		; no signature move can hit during semi-invulnerable turns
	pop hl
	jp nz, .moveMissed
	ld a, [hl]
	cp FLY
	jr nz, .notHighInTheAir
	ld a, [bc]
	cp GUST
	jr z, .notInvulnerable				; Gust can hit during Fly
	cp THUNDER
	jr z, .notInvulnerable				; Thunder can hit during Fly
	cp HURRICANE
	jr z, .notInvulnerable				; Hurricane can hit during Fly
	cp TWISTER
	jr z, .notInvulnerable				; Twister can hit during Fly
	cp SKY_UPPERCUT
	jr z, .notInvulnerable				; Sky Uppercut can hit during Fly
	jp .moveMissed						; other moves can't hit during Fly
.notHighInTheAir
	cp DIG								; is the target in the middle of Dig?
	jr nz, .notUnderground
	ld a, [bc]							; which move is the target being hit with?
	cp EARTHQUAKE
	jr z, .notInvulnerable				; Earthquake can hit during Dig
	cp FISSURE
	jr z, .notInvulnerable				; Fissure can hit during Dig
	jp .moveMissed						; other moves can't hit during Dig
.notUnderground
	jp .moveMissed						; if it's not DIG or FLY, nothing can bypass (with currently implemented moves)
.notInvulnerable
	ld a, [de]
	cp ALWAYS_HIT_EFFECT
	ret z						; Swift never misses
	cp STRUGGLE_EFFECT
	ret z						; make Struggle hit independently of accuracy/evasion
	ld a, [H_WHOSETURN]
	and a
	ld a, [wPlayerMonMinimized]	; add this to check for moves that always hit minimized targets
	ld hl, wEnemyMoveNum		; add this to check for moves that always hit minimized targets
	jr nz, .enemyTurn
	ld a, [wEnemyMonMinimized]	; add this to check for moves that always hit minimized targets
	ld hl, wPlayerMoveNum		; add this to check for moves that always hit minimized targets
.playerTurn
	and a							; check if target is minimized
	jr z, .enemyNotMinimized		; if not, perform other checks
	ld a, [de]						; check move effect
	cp WEIGHT_DIFFERENCE_EFFECT		; moves that do damage proportionately to the ratio of the user's to the target's weight always hit minimized targets
	ret z
	push hl
	ld hl, wNewBattleFlags
	bit USING_SIGNATURE_MOVE, [hl]
	pop hl
	ld a, [hl]						; load id of move used
	jr nz, .playerUsingSignatureMove
	cp STOMP						; Stomp always hits minimized targets
	ret z
	cp BODY_SLAM					; Body Slam always hits minimized targets
	ret z
	cp DRAGON_RUSH					; Dragon Rush always hits minimized targets
	ret z
	cp SIGNATURE_MOVE_1
	jr z, .mapPlayerSignatureMove
	cp SIGNATURE_MOVE_2
	jr nz, .enemyNotMinimized
.mapPlayerSignatureMove
	ld [wd11e], a
	push hl
	push bc
	push de
	callab MapAttackerSignatureMove
	ld a, d
	pop de
	pop bc
	pop hl
.playerUsingSignatureMove
	cp STEAMROLLER					; Steamroller always hits minimized targets
	ret z
.enemyNotMinimized
; this checks if the move effect is disallowed by mist
	ld a, [wPlayerMoveEffect]
	cp ATTACK_DOWN1_EFFECT
	jr c, .calcHitChance
	cp HAZE_EFFECT + 1
	jr c, .enemyMistCheck
	cp ATTACK_DOWN2_EFFECT
	jr c, .calcHitChance
	cp REFLECT_EFFECT + 1
	jr c, .enemyMistCheck
	jr .calcHitChance
.enemyMistCheck
; if move effect is from $12 to $19 inclusive or $3a to $41 inclusive
; i.e. the following moves
; GROWL, TAIL WHIP, LEER, STRING SHOT, SAND-ATTACK, SMOKESCREEN, KINESIS,
; FLASH, CONVERSION*, HAZE*, SCREECH, LIGHT SCREEN*, REFLECT*
; the moves that are marked with an asterisk are not affected since this
; function is not called when those moves are used
	ld a, [wEnemyMistCounter]	; use the counter instead of the flag
	and a						; if counter is not zero, enemy is protected by Mist
	jp nz, .moveMissed
.enemyTurn
	and a							; check if target is minimized
	jr z, .playerNotMinimized		; if not, perform other checks
	ld a, [de]						; check move effect
	cp WEIGHT_DIFFERENCE_EFFECT		; moves that do damage proportionately to the ratio of the user's to the target's weight always hit minimized targets
	ret z
	push hl
	ld hl, wNewBattleFlags
	bit USING_SIGNATURE_MOVE, [hl]
	pop hl
	ld a, [hl]						; load id of move used
	jr nz, .enemyUsingSignatureMove
	cp STOMP						; Stomp always hit minimized targets
	ret z
	cp BODY_SLAM					; Body Slam always hit minimized targets
	ret z
	cp DRAGON_RUSH					; Dragon Rush always hits minimized targets
	ret z
	cp SIGNATURE_MOVE_1
	jr z, .mapEnemySignatureMove
	cp SIGNATURE_MOVE_2
	jr nz, .playerNotMinimized
.mapEnemySignatureMove
	ld [wd11e], a
	push hl
	push bc
	push de
	callab MapAttackerSignatureMove
	ld a, d
	pop de
	pop bc
	pop hl
.enemyUsingSignatureMove
	cp STEAMROLLER					; Steamroller always hits minimized targets
	ret z
.playerNotMinimized
	ld a, [wEnemyMoveEffect]
	cp ATTACK_DOWN1_EFFECT
	jr c, .calcHitChance
	cp HAZE_EFFECT + 1
	jr c, .playerMistCheck
	cp ATTACK_DOWN2_EFFECT
	jr c, .calcHitChance
	cp REFLECT_EFFECT + 1
	jr c, .playerMistCheck
	jr .calcHitChance
.playerMistCheck
; similar to enemy mist check
	ld a, [wPlayerMistCounter]	; use the counter instead of the flag
	and a						; if counter is not zero, player is protected by Mist
	jp nz, .moveMissed
.calcHitChance
	call _CalcHitChance ; scale the move accuracy according to attacker's accuracy and target's evasion
	ld a, [wPlayerMoveAccuracy]
	ld b, a
	ld a, [H_WHOSETURN]
	and a
	jr z, .doAccuracyCheck
	ld a, [wEnemyMoveAccuracy]
	ld b, a
.doAccuracyCheck
; if the random number generated is greater than or equal to the scaled accuracy, the move misses
; note that this means that even the highest accuracy is still just a 255/256 chance, not 100%
	call BattleRandom
	cp b
	ret z	; return also when rolled number is equal to accuracy value, so that 100% accurate moves cannot miss
	ret c
.moveMissed
	xor a
	ld hl, wDamage ; zero the damage
	ld [hli], a
	ld [hl], a
	inc a
	ld [wMoveMissed], a
	ret

; moved from bank F
_CalcHitChance:
; values for player turn
	ld hl, wPlayerMoveAccuracy
	ld de, wPlayerMoveEffect			; add this to check for OHKO effect
	ld a, [H_WHOSETURN]
	and a
	ld a, [wPlayerMonAccuracyMod]
	ld b, a
	ld a, [wEnemyMonEvasionMod]
	ld c, a
	jr z, .next
; values for enemy turn
	ld hl, wEnemyMoveAccuracy
	ld de, wEnemyMoveEffect				; add this to check for OHKO effect
	ld a, [wEnemyMonAccuracyMod]
	ld b, a
	ld a, [wPlayerMonEvasionMod]
	ld c, a
.next
	ld a, [de]
	cp OHKO_EFFECT						; if the move is an OHKO move, accuracy is calculated differently
	jp z, OneHitKOEffect
	xor a
	ld [H_MULTIPLICAND], a
	ld [H_MULTIPLICAND + 1], a
	ld a, [hl]
	ld [H_MULTIPLICAND + 2], a ; set multiplicand to move accuracy
	push hl
	ld hl, _StatModifierRatios  ; stat modifier ratios
	ld a, STAT_MODIFIER_DEFAULT	; initialize a to STAT_MODIFIER_DEFAULT
	add b						; a = STAT_MODIFIER_DEFAULT + accuracy mod
	sub c						; a = STAT_MODIFIER_DEFAULT + accuracy mod - evasion mod
	jr z, .floor				; cap at STAT_MODIFIER_MINUS_6 if combination is zero
	jr nc, .checkMax			; or if combination is negative
.floor
	ld a, STAT_MODIFIER_MINUS_6	; smallest possible value for when combination of accuracy and evasion mods give the worst hit ratio
.checkMax
	cp STAT_MODIFIER_PLUS_6 + 1
	jr c, .noCap
	ld a, STAT_MODIFIER_PLUS_6	; cap the combination of accuracy and evasion mods to STAT_MODIFIER_PLUS_6
.noCap
	dec a
	sla a						; double a because ratios are 2 bytes long
	ld c, a
	ld b, $00
	add hl, bc ; hl = address of stat modifier ratio
	ld a, [hli]
	ld [H_MULTIPLIER], a ; set multiplier to the numerator of the ratio
	call Multiply
	ld a, [hl]
	ld [H_DIVISOR], a ; set divisor to the the denominator of the ratio
	                 ; (the dividend is the product of the previous multiplication)
	ld b, $04 ; number of bytes in the dividend
	call Divide
	ld a, [H_QUOTIENT + 3]
	ld b, a
	ld a, [H_QUOTIENT + 2]
	or b
	jp nz, .capHitChance
; make sure the result is always at least one
	ld [H_QUOTIENT + 2], a
	ld a, $01
	ld [H_QUOTIENT + 3], a
.capHitChance
	ld a, [H_QUOTIENT + 2]
	and a ; is the calculated hit chance over 0xFF?
	ld a, [H_QUOTIENT + 3]
	jr z, .storeAccuracy
; if calculated hit chance over 0xFF
	ld a, $ff ; set the hit chance to 0xFF
.storeAccuracy
	pop hl
	ld [hl], a ; store the hit chance in the move accuracy variable
	ret

_StatModifierRatios:
; first byte is numerator, second byte is denominator
	db 3, 9  ; 0.33
	db 3, 8  ; 0.36
	db 3, 7  ; 0.43
	db 3, 6  ; 0.50
	db 3, 5  ; 0.60
	db 3, 4  ; 0.75
	db 1, 1  ; 1.00
	db 4, 3  ; 1.33
	db 5, 3  ; 1.66
	db 6, 3  ; 2.00
	db 7, 3  ; 2.33
	db 8, 3  ; 2.66
	db 9, 3  ; 3.00

; checks if conditions are met for Sucker Punch to succeed
; sets z flag if conditions are met, unsets it otherwise
SuckerPunchChecks:
	ld hl, wEnemyMoveExtra
	ld bc, wEnemyBattleStatus3
	ld a, [H_WHOSETURN]
	and a
	jr z, .main
	ld hl, wPlayerMoveExtra
	ld bc, wPlayerBattleStatus3
	ld a, [wActionResultOrTookBattleTurn]
	and a
	ret nz						; move fails if used by enemy when player tries to run, uses an item, or switches out
.main
	bit IS_STATUS_MOVE, [hl]
	ret nz
	ld h, b
	ld l, c
	bit CANT_BE_SUCKER_PUNCHED, [hl]
	ret

OneHitKOEffect:
	ld hl, wPlayerMoveAccuracy
	ld bc, wBattleMonLevel
	ld de, wEnemyMonLevel
	ld a, [H_WHOSETURN]
	and a
	jr z, .OHKOFormula
	ld hl, wEnemyMoveAccuracy
	push bc
	push de
	pop bc
	pop de
.OHKOFormula
	ld a, [de]
	ld d, a
	ld a, [bc]
	sub d								; calculate the difference between user's level and target's level
	jr c, .OHKOMiss						; if user is lower level than target, make the move miss
	ld [H_MULTIPLICAND + 2], a
	xor a
	ld [H_MULTIPLICAND], a
	ld [H_MULTIPLICAND + 1], a
	dec a								; set a to 255
	ld [H_MULTIPLIER], a
	call Multiply						; multiply level difference by 255
	ld a, [H_PRODUCT + 2]
	ld [H_DIVIDEND], a
	ld a, [H_PRODUCT + 3]
	ld [H_DIVIDEND + 1], a
	ld a, 100
	ld [H_DIVISOR], a
	ld b, 2								; this value serves both for wCriticalHitOrOHKO and as input for the Divide function (dividend length)
	ld a, b
	ld [wCriticalHitOrOHKO], a
	call Divide							; scale level difference so that it's a percentage of 255
	ld a, [H_QUOTIENT + 3]
	ld b, [hl]
	add b								; add move accuracy to the scaled level difference
	ld [hl], a
	ret
.OHKOMiss
	xor a
	ld [hl], a							; in case of a miss, zero the move accuracy to make it fail
	inc a
	ld [wMoveMissed], a
	ret
