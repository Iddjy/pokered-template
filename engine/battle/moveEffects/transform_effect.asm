TransformEffect_:
	ld hl, wEnemyMonHP
	ld bc, wEnemyBattleStatus2
	ld de, wEnemyBattleStatus3
	ld a, [H_WHOSETURN]
	and a
	jr z, .playersTurn
	ld hl, wBattleMonHP
	ld bc, wPlayerBattleStatus2
	ld de, wPlayerBattleStatus3
.playersTurn
	ld a, [bc]
	bit HAS_SUBSTITUTE_UP, a
	jp nz, .failed					; fail if target is behind a substitute
	ld a, [de]
	bit TRANSFORMED, a
	jp nz, .failed					; fail if target is transformed
	ld a, [hli]
	ld b, a
	ld a, [hl]
	or b
	jp z, .failed					; if target is down, fail
	ld hl, wBattleMonSpecies
	ld de, wEnemyMonSpecies
	ld bc, wEnemyBattleStatus3
	ld a, [H_WHOSETURN]
	and a
	ld a, [wPlayerBattleStatus1]
	jr nz, .hitTest
	ld hl, wEnemyMonSpecies
	ld de, wBattleMonSpecies
	ld bc, wPlayerBattleStatus3
	ld [wPlayerMoveListIndex], a
	ld a, [wEnemyBattleStatus1]
.hitTest
	bit INVULNERABLE, a ; is mon invulnerable to typical attacks? (fly/dig)
	jp nz, .failed
	push hl
	push de
	push bc
	ld hl, wPlayerBattleStatus2
	ld bc, wPlayerLastMoveListIndex		; add this to make disable fail when opponent just used transform
	ld a, [H_WHOSETURN]
	and a
	jr z, .transformEffect
	ld hl, wEnemyBattleStatus2
	ld bc, wEnemyLastMoveListIndex		; add this to make disable fail when opponent just used transform
.transformEffect
	ld a, $ff							; reset index of last used move since the moveset changes
	ld [bc], a							; reset index of last used move since the moveset changes
	bit HAS_SUBSTITUTE_UP, [hl]
	push af
	ld hl, HideSubstituteShowMonAnim
	ld b, BANK(HideSubstituteShowMonAnim)
	call nz, Bankswitch
	ld a, [wOptions]
	add a
	ld hl, PlayCurrentMoveAnimation
	ld b, BANK(PlayCurrentMoveAnimation)
	jr nc, .gotAnimToPlay
	ld hl, AnimationTransformMon
	ld b, BANK(AnimationTransformMon)
.gotAnimToPlay
	call Bankswitch
	ld hl, ReshowSubstituteAnim
	ld b, BANK(ReshowSubstituteAnim)
	pop af
	call nz, Bankswitch
	pop bc
	ld a, [bc]
	set TRANSFORMED, a ; mon is now transformed
	ld [bc], a
	pop de
	pop hl
	push hl
	xor a
	ld [wd11e], a
	ld a, [H_WHOSETURN]
	and a
	jr z, .transform
	ld a, [wTransformedEnemyMonOriginalSpecies]
	ld b ,a
	ld a, [wTransformedEnemyMonOriginalSpecies + 1]
	or b
	jr nz, .transform								; if the original species is already saved, don't overwrite it
	inc a
	ld [wd11e], a									; put 1 in wd11e to remember we need to save original DVs
	ld a, [de]
	ld [wTransformedEnemyMonOriginalSpecies], a		; save the enemy's species so that if it's caught, we don't automatically get Ditto
	inc de
	ld a, [de]
	ld [wTransformedEnemyMonOriginalSpecies + 1], a	; save the enemy's species so that if it's caught, we don't automatically get Ditto
	dec de
.transform
; transform user into opposing Pokemon species
	ld a, [hli]										; to handle 2 bytes species IDs
	ld [de], a										; to handle 2 bytes species IDs
	inc de											; to handle 2 bytes species IDs
	ld a, [hl]
	ld [de], a
; type 1, type 2, catch rate, and moves
	ld bc, wBattleMonType1 - (wBattleMonSpecies + 1); to handle 2 bytes species IDs
	add hl, bc
	push hl
	ld h, d
	ld l, e
	add hl, bc										; instead of 5 inc de, use this code to increment de as much as hl
	ld d, h
	ld e, l
	pop hl
	ld bc, (wBattleMonMoves + NUM_MOVES) - wBattleMonType1
	call CopyData
	ld a, [H_WHOSETURN]
	and a
	jr z, .next
	ld a, [wd11e]									; here wd11e is 1 if this is the 1st time the mon used transform
	and a
	jr z, .next										; if the mon has already transformed at least once during the battle, don't overwrite its original DVs
; save enemy mon DVs at wTransformedEnemyMonOriginalDVs
	ld a, [de]
	ld [wTransformedEnemyMonOriginalDVs], a
	inc de
	ld a, [de]
	ld [wTransformedEnemyMonOriginalDVs + 1], a
	inc de											; add this for the new DV for special defense
	ld a, [de]										; add this for the new DV for special defense
	ld [wTransformedEnemyMonOriginalDVs + 2], a		; add this for the new DV for special defense
	dec de											; add this for the new DV for special defense
	dec de
.next
; DVs
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]										; add this for the new DV for special defense
	ld [de], a										; add this for the new DV for special defense
	inc de											; add this for the new DV for special defense
; Attack, Defense, Speed, Special Attack and Special Defense stats
	inc hl											; skip the level
	inc hl											; skip the HP
	inc hl											; skip the HP
	inc de											; skip the level
	inc de											; skip the HP
	inc de											; skip the HP
	ld bc, (NUM_STATS - 1) * 2
	call CopyData
	ld bc, wBattleMonMoves - wBattleMonPP
	add hl, bc ; ld hl, wBattleMonMoves
	ld b, NUM_MOVES
.copyPPLoop
; 5 PP for all moves
	ld a, [hli]
	and a
	jr z, .lessThanFourMoves
	ld a, 5
	ld [de], a
	inc de
	dec b
	jr nz, .copyPPLoop
	jr .copyStats
.lessThanFourMoves
; 0 PP for blank moves
	xor a
	ld [de], a
	inc de
	dec b
	jr nz, .lessThanFourMoves
.copyStats
; original (unmodified) stats and stat mods
	pop hl
	ld a, [hli]										; to handle 2 bytes species IDs
	ld [wMonSpeciesTemp], a							; to handle 2 bytes species IDs
	ld a, [hl]										; to handle 2 bytes species IDs
	ld [wMonSpeciesTemp + 1], a						; to handle 2 bytes species IDs
	call GetMonName
	ld hl, wEnemyMonUnmodifiedAttack
	ld de, wPlayerMonUnmodifiedAttack
	call .copyBasedOnTurn							; original (unmodified) stats
	ld hl, wEnemyMonStatMods
	ld de, wPlayerMonStatMods
	call .copyBasedOnTurn ; stat mods
	ld hl, wPlayerMimicSlot
	ld a, [H_WHOSETURN]
	and a
	jr z, .clearMimicSlot
	ld hl, wEnemyMimicSlot
.clearMimicSlot
	xor a
	ld [hl], a										; clear the Mimic slot variable since Transform overwrites the moveset
	ld hl, TransformedText
	jp PrintText

.copyBasedOnTurn
	ld a, [H_WHOSETURN]
	and a
	jr z, .gotStatsOrModsToCopy
	push hl
	ld h, d
	ld l, e
	pop de
.gotStatsOrModsToCopy
	ld bc, (NUM_STATS - 1) * 2
	jp CopyData

.failed
	ld c, 40						; add a small pause before printing that the move failed
	call DelayFrames
	ld hl, PrintButItFailedText_
	jp BankswitchEtoF

TransformedText:
	TX_FAR _TransformedText
	db "@"
