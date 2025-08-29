TriAttackEffect_:
	xor a
	ld [wAnimationType], a
	ld hl, wEnemyMonStatus
	ld a, [H_WHOSETURN]
	and a
	jr z, .main
	ld hl, wBattleMonStatus
.main
	ld a, [hl]					; load target's status
	and a
	ret nz						; can't status an already statused target
	call BattleRandom
	cp TWENTY_PERCENT			; 20% chance [TWENTY_PERCENT-255] is no effect
	ret nc
	ld c, ELECTRIC
	cp 34						; [34-TWENTY_PERCENT[ is Paralysis
	jr c, .notParalyzed
	call CheckTypeImmunityToStatus
	ret z
	jp ApplyParalysisToTarget
.notParalyzed
	ld c, FIRE
	cp 17						; [17-33] is Burn
	jr c, .notBurned
	call CheckTypeImmunityToStatus
	ret z
	jp ApplyBurnToTarget
.notBurned						; [0-16] is Freeze
	ld c, ICE
	call CheckTypeImmunityToStatus
	ret z
	jp ApplyFreezeToTarget

; moved from bank F
FreezeBurnParalyzeEffect_:
	xor a
	ld [wAnimationType], a
	ld hl, wEnemyMonStatus
	ld a, [H_WHOSETURN]
	and a
	ld a, [wPlayerMoveEffect]
	jr z, .checkImmunityToStatus
	ld hl, wBattleMonStatus
	ld a, [wEnemyMoveEffect]
.checkImmunityToStatus:
	ld b, a
	ld a, [hl]					; load target's status
	and a
	ret nz						; don't check for defrosting here, simply return if target already has a status condition
	ld a, b     				; what type of effect is this?
	cp AUTODEFROST_BURN_SIDE_EFFECT1
	jr nz, .next
	ld a, BURN_SIDE_EFFECT1		; map AUTODEFROST_BURN_SIDE_EFFECT1 to BURN_SIDE_EFFECT1
	ld b, a
.next
	cp AUTODEFROST_BURN_SIDE_EFFECT2
	jr nz, .next2
	ld a, BURN_SIDE_EFFECT2		; map AUTODEFROST_BURN_SIDE_EFFECT2 to BURN_SIDE_EFFECT2
	ld b, a
.next2
	ld c, FIRE					; ID of the Fire type
	cp a, BURN_SIDE_EFFECT1
	jr z, .checkImmunityDueToType	; if effect is Burn, check if target is Fire type
	cp a, BURN_SIDE_EFFECT2
	jr z, .checkImmunityDueToType	; if effect is Burn, check if target is Fire type
	ld c, ELECTRIC					; ID of the Electric type
	cp a, PARALYZE_SIDE_EFFECT1
	jr z, .checkImmunityDueToType	; if effect is Paralyze, check if target is Electric type
	cp a, PARALYZE_SIDE_EFFECT2
	jr z, .checkImmunityDueToType	; if effect is Paralyze, check if target is Electric type
	ld c, ICE						; ID of the Ice type (if we're here it means effect is Freeze)
.checkImmunityDueToType:
	call CheckTypeImmunityToStatus
	ret z							; if target has type immunity, return
	ld a, b							; load move effect
	cp a, PARALYZE_SIDE_EFFECT1 + 1
	ld b, TEN_PERCENT+1
	jr c, .diceRoll					; branch ahead if this is a 10% chance effect
	ld b, THIRTY_PERCENT+1
	sub a, BURN_SIDE_EFFECT2 - BURN_SIDE_EFFECT1	; map 30% chance effects to equivalent 10% chance effects
.diceRoll
	push af					; push effect
	call BattleRandom		; get random 8bit value for probability test
	cp b					; success?
	pop bc					; pop effect into b
	ret nc					; do nothing if random value is >= TEN_PERCENT or THIRTY_PERCENT [no status applied]
	ld a, b					; what type of effect is this?
	cp a, BURN_SIDE_EFFECT1	; BURN_SIDE_EFFECT2 was mapped to BURN_SIDE_EFFECT1 earlier, so no need to check both
	jr z, ApplyBurnToTarget
	cp a, FREEZE_SIDE_EFFECT
	jr z, ApplyFreezeToTarget
ApplyParalysisToTarget:
	ld a, 1 << PAR						; not burn or freeze, so paralyze
	ld [hl], a							; put paralysed status in target's status
	call QuarterSpeedDueToParalysis_	; quarter speed of affected monster
	call ScreenShake
	call PrintMayNotAttackText
	jpab DrawHUDsAndHPBars
ApplyBurnToTarget:
	ld a, 1 << BRN
	ld [hl], a
	call HalveAttackDueToBurn_		; halve attack of the affected monster
	call ScreenShake
	ld hl, BurnedText
	jr displayText
ApplyFreezeToTarget:
	ld a, 1 << FRZ
	ld [hl], a
	call ScreenShake
	ld hl, wEnemyBattleStatus1		; variable holding the Bide/Trashing about flags
	ld a, [H_WHOSETURN]
	and a
	jr z, .disruptTarget
	ld hl, wPlayerBattleStatus1		; variable holding the Bide/Thrashing about flags
.disruptTarget
	res STORING_ENERGY, [hl]		; disrupt Bide
	res THRASHING_ABOUT, [hl]		; disrupt thrashing moves
	ld hl, FrozenText
displayText
	call PrintText
	jpab DrawHUDsAndHPBars

; function to check if the target's types make it immune to the status
; input: target's status in hl
; input: immune type in c
; output: z flag set if immune, unset if not
; output: target's status in hl
CheckTypeImmunityToStatus:
	inc hl				; make hl point to the target's type 1
	ld a, [hli]			; load type 1 of the target and make hl point to type 2
	cp c				; compare it with immune type
	ret z  				; return if they match [can't burn a fire type or freeze an ice type]
	ld a, [hld]			; load type 2 of the target and make hl point back to type 1
	cp c				; compare it with immune type
	ret z				; return if they match [can't burn a fire type or freeze an ice type]
	dec hl				; make hl point back to target's status
	ret
	
; Play the screenshake animation only if it's the player's turn
ScreenShake:
	ld a, [H_WHOSETURN]
	and a
	ret nz
	ld a, ANIM_A9
	ld [wAnimationID], a
	call Delay3
	predef_jump MoveAnimation
	ret

BurnedText:
	TX_FAR _BurnedText
	db "@"

FrozenText:
	TX_FAR _FrozenText
	db "@"

PrintMayNotAttackText:
	ld hl, ParalyzedMayNotAttackText
	jp PrintText

ParalyzedMayNotAttackText:
	TX_FAR _ParalyzedMayNotAttackText
	db "@"

; moved from bank F
QuarterSpeedDueToParalysis_:
	ld a, [H_WHOSETURN]
	and a
	jr z, .playerTurn
.enemyTurn ; quarter the player's speed
	ld a, [wBattleMonStatus]
	and 1 << PAR
	ret z ; return if player not paralysed
	ld hl, wBattleMonSpeed + 1
	ld a, [hld]
	ld b, a
	ld a, [hl]
	srl a
	rr b
	srl a
	rr b
	ld [hli], a
	or b
	jr nz, .storePlayerSpeed
	ld b, 1 ; give the player a minimum of at least one speed point
.storePlayerSpeed
	ld [hl], b
	ret
.playerTurn ; quarter the enemy's speed
	ld a, [wEnemyMonStatus]
	and 1 << PAR
	ret z ; return if enemy not paralysed
	ld hl, wEnemyMonSpeed + 1
	ld a, [hld]
	ld b, a
	ld a, [hl]
	srl a
	rr b
	srl a
	rr b
	ld [hli], a
	or b
	jr nz, .storeEnemySpeed
	ld b, 1 ; give the enemy a minimum of at least one speed point
.storeEnemySpeed
	ld [hl], b
	ret

; moved from bank F
HalveAttackDueToBurn_:
	ld a, [H_WHOSETURN]
	and a
	jr z, .playerTurn
.enemyTurn ; halve the player's attack
	ld a, [wBattleMonStatus]
	and 1 << BRN
	ret z ; return if player not burnt
	ld hl, wBattleMonAttack + 1
	ld a, [hld]
	ld b, a
	ld a, [hl]
	srl a
	rr b
	ld [hli], a
	or b
	jr nz, .storePlayerAttack
	ld b, 1 ; give the player a minimum of at least one attack point
.storePlayerAttack
	ld [hl], b
	ret
.playerTurn ; halve the enemy's attack
	ld a, [wEnemyMonStatus]
	and 1 << BRN
	ret z ; return if enemy not burnt
	ld hl, wEnemyMonAttack + 1
	ld a, [hld]
	ld b, a
	ld a, [hl]
	srl a
	rr b
	ld [hli], a
	or b
	jr nz, .storeEnemyAttack
	ld b, 1 ; give the enemy a minimum of at least one attack point
.storeEnemyAttack
	ld [hl], b
	ret
