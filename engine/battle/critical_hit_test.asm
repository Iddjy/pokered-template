CriticalHitTest_:
	ld a, [wCriticalHitOrOHKO]	; check if an OHKO move has hit
	cp 2						; wCriticalHitOrOHKO is set to 2 when an OHKO move hits
	ret z						; if the move is already an OHKO, no need to check if it crits
	ld c, 0						; initialize critical hit modifier level to zero
	ld a, [H_WHOSETURN]
	and a
	ld hl, wPlayerMovePower
	ld de, wPlayerBattleStatus2
	jr z, .calcCriticalHitProbability
	ld hl, wEnemyMovePower
	ld de, wEnemyBattleStatus2
.calcCriticalHitProbability
	ld a, [hld]					; read base power from RAM
	and a
	ret z						; do nothing if zero
	dec hl
	ld b, [hl]					; read move id
	ld a, [de]
	bit GETTING_PUMPED, a		; test for focus energy
	jr z, .noFocusEnergyUsed
	inc c						; increase critical hit modifier level by 2 if Focus Energy or Dire Hit was used
	inc c						; increase critical hit modifier level by 2 if Focus Energy or Dire Hit was used
.noFocusEnergyUsed
	ld hl, wNewBattleFlags
	bit USING_SIGNATURE_MOVE, [hl]
	ld hl, HighCriticalSignatureMoves
	jr nz, .Loop
	ld hl, HighCriticalMoves	; table of high critical hit moves
.Loop
	ld a, [hli]					; read move from move table
	cp b						; does it match the move about to be used?
	jr z, .HighCritical			; if so, the move about to be used is a high critical hit ratio move
	inc a						; move on to the next move, FF terminates loop
	jr nz, .Loop				; check the next move in HighCriticalMoves
	jr .SkipHighCritical		; continue as a normal move
.HighCritical
	inc c						; increase critical hit modifier level by 1 if it's a high crit rate move
.SkipHighCritical
	ld hl, HighCriticalRatios
	ld b, 0
	add hl, bc					; make hl point to the ratio that corresponds to the computed critical hit modifier level
	ld a, [hl]					; read critical hit ratio from the table
	ld b, a
	inc a						; test if ratio is $FF
	jr z, .criticalHit			; if critical hit modifier level is maxed, skip random roll and force the critical hit
	call BattleRandom			; generates a random value, in "a"
	cp b						; check a against calculated crit rate
	ret nc						; no critical hit if no carry
.criticalHit
	ld a, $1
	ld [wCriticalHitOrOHKO], a	; set critical hit flag
	ret

; high critical hit moves
HighCriticalMoves:
	db KARATE_CHOP
	db RAZOR_LEAF
	db SLASH
	db RAZOR_WIND
	db SKY_ATTACK
	db NIGHT_SLASH
	db AIR_CUTTER
	db CROSS_CHOP
	db CROSS_POISON
	db DRILL_RUN
	db LEAF_BLADE
	db PSYCHO_CUT
	db SHADOW_CLAW
	db STONE_EDGE
	db X_SCISSOR
	db $FF

; high critical hit signature moves
HighCriticalSignatureMoves:
	db CRABHAMMER
	db POISON_TAIL
	db $FF

; different ratios according to critical hit modifier level
HighCriticalRatios:
	db $0b				; 1/24 chance
	db ONE_OUT_OF_EIGHT
	db FIFTY_PERCENT
	db HUNDRED_PERCENT	; is actually $FF
	