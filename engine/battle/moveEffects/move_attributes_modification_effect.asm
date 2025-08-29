; function to handle moves whose base power or other attributes vary
MoveAttributesModifications_:
	ld hl, wPlayerMoveEffect
	ld a, [H_WHOSETURN] 
	and a 
	jr z, .main 
	ld hl, wEnemyMoveEffect
.main
	ld a, [hl]
	cp WEIGHT_DAMAGE_EFFECT
	jp z, WeightDamageEffect
	cp WEIGHT_DIFFERENCE_EFFECT
	jp z, WeightDifferenceEffect
	cp REVENGE_EFFECT
	jp z, RevengeEffectHandler
	cp BRICK_BREAK_EFFECT
	jp z, BrickBreakEffect
	cp HEX_EFFECT
	jp z, HexEffect
	cp VENOSHOCK_EFFECT
	jp z, VenoshockEffect
	cp JUDGMENT_EFFECT			; handle Judgment here since it affects the move's attributes
	jp z, JudgmentEffect
	ret

; handler for moves whose Base Power varies according to the target's weight
WeightDamageEffect:
	ld de, wPlayerMovePower
	ld hl, wEnemyMonSpecies		; to handle 2 bytes species IDs
	ld a, [H_WHOSETURN] 
	and a 
	jr z, .main 
	ld de, wEnemyMovePower
	ld hl, wBattleMonSpecies	; to handle 2 bytes species IDs
.main
	call GetWeight
	ld h, 20				; lowest base power possible for this effect
	ld a, b
	and a
	jr nz, .atLeastTier2
	ld a, c
	cp 220					; check low byte to see if target is tier 1 or tier 2
	jr c, .finish			; the target is in the lowest tier, so use initial value for base power
.atLeastTier2
	ld h, 40				; Base Power for tier 2
	ld a, b					; if we're here, it means b >= 1
	cp 2
	jr c, .finish			; if high byte of weight is < 2, it means target is tier 2
	jr nz, .atLeastTier3
	ld a, c
	cp 40					; check low byte to see if target is tier 2 or tier 3
	jr c, .finish			; the target is in tier 2, so use current value for base power
.atLeastTier3
	ld h, 60				; Base Power for tier 3
	ld a, b					; if we're here, it means b >= 2
	cp 4
	jr c, .finish			; if high byte of weight is < 4, it means target is tier 3
	jr nz, .atLeastTier4
	ld a, c
	cp 79					; check low byte to see if target is tier 3 or tier 4
	jr c, .finish			; the target is in tier 3, so use current value for base power
.atLeastTier4
	ld h, 80				; Base Power for tier 4
	ld a, b					; if we're here, it means b >= 4
	cp 8
	jr c, .finish			; if high byte of weight is < 8, it means target is tier 4
	jr nz, .atLeastTier5	; if high byte is also not equal to 8, then it means it's > 8, so target is tier 5
	ld a, c
	cp 157					; check low byte to see if target is tier 4 or tier 5
	jr c, .finish			; the target is in tier 4, so use current value for base power
.atLeastTier5
	ld h, 100				; Base Power for tier 5
	ld a, b					; if we're here, it means b >= 8
	cp 17
	jr c, .finish			; if high byte of weight is < 17, it means target is tier 5
	jr nz, .tier6			; if high byte is also not equal to 17, then it means it's > 17, so target is tier 6
	ld a, c
	cp 58					; check low byte to see if target is tier 5 or tier 6
	jr c, .finish			; the target is in tier 5, so use current value for base power
.tier6
	ld h, 120				; Base Power for tier 6
.finish
	ld a, h
	ld [de], a				; put calculated Base Power in RAM
	ret

RevengeEffectHandler:
	ld de, wPlayerMovePower
	ld bc, wEnemyMoveExtra
	ld a, [H_WHOSETURN] 
	and a 
	jr z, .main 
	ld de, wEnemyMovePower
	ld bc, wPlayerMoveExtra
.main
	ld a, [bc]
	and ((1 << IS_SPECIAL_MOVE) | (1 << IS_STATUS_MOVE))
	cp ((1 << IS_SPECIAL_MOVE) | (1 << IS_STATUS_MOVE))
	ret z												; if the target hit itself in confusion, don't boost the power
	ld hl, wDamage
	ld a, [hli]
	ld b, a
	ld a, [hl]
	or b
	ret z												; if the target didn't do damage this turn, don't boost the power
	ld a, [wNewBattleFlags]								; variable holding the flag that indicates whether a Substitute has taken damage this turn
	and (1 << SUBSTITUTE_TOOK_DAMAGE)					; reset all the bits except the flag SUBSTITUTE_TOOK_DAMAGE
	ret nz												; if the target hit a substitute this turn, don't boost the power
	ld a, [de]
	sla a												; double the base power if user was hit during this turn
	ld [de], a											; if used with a move with BP >= 128, it will rollover!
	ret

BrickBreakEffect:
	ld hl, wEnemyReflectCounter
	ld bc, wPlayerMoveEffect
	ld a, [H_WHOSETURN]
	and a
	jr z, .main
	ld hl, wPlayerReflectCounter
	ld bc, wEnemyMoveEffect
.main
	ld a, [hli]							; check for Reflect counter
	and a
	jr nz, .targetHasWall
	ld a, [hl]							; check for Light Screen counter
	and a
	jr nz, .targetHasWall
	jr .resetEffect						; if the move doesn't break any wall, reset the move effect
.targetHasWall
	ld a, [wMoveMissed]
	and a
	jr nz, .resetEffect					; if move missed or target is immune, don't break walls
	xor a
	ld [hld], a							; reset wall counters
	ld [hl], a							; reset wall counters
	ret
.resetEffect							; this is to prevent the "shattered" text from displaying
	ld a, NO_ADDITIONAL_EFFECT
	ld [bc], a
	ret

VenoshockEffect:
	ld d, (1 << PSN | 1 << BADLY_POISONED)	; Venoshock only works with poison
	jr HexEffect.main

HexEffect:
	ld d, $ff							; Hex works with any status condition
.main
	ld hl, wEnemyMonStatus
	ld bc, wPlayerMovePower
	ld a, [H_WHOSETURN] 
	and a 
	jr z, .checkTargetStatus
	ld hl, wBattleMonStatus
	ld bc, wEnemyMovePower
.checkTargetStatus
	ld a, [hl]
	and d								; apply bitmask so that we can reuse this handler for Venoshock
	and a
	ret z
	ld a, [bc]
	sla a								; double move power if target has a status condition
	ld [bc], a							; if used with a move with BP >= 128, it will rollover!
	ret

WeightDifferenceEffect:
	ld hl, wEnemyMonSpecies
	ld de, wBattleMonSpecies
	ld a, [H_WHOSETURN] 
	and a
	jr z, .main 
	ld hl, wBattleMonSpecies
	ld de, wEnemyMonSpecies		
.main
	call GetWeight			; get target's weight in bc
	push bc					; target's weight is saved in the stack
	ld h, d					; put user's species id in hl
	ld l, e					; put user's species id in hl
	call GetWeight			; get user's weight in bc
	pop hl					; restore target's weight in hl (user's weight is in bc)
	ld d, h					; copy the target's weight in de
	ld e, l
	add hl, de				; add the target's weight to itself
	call CompareBCtoHL
	ld a, 40				; minimum base power
	jr c, .finish			; jump if user's weight < target's weight * 2
	add hl, de				; add the target's weight again
	call CompareBCtoHL
	ld a, 60				; tier 2 base power
	jr c, .finish			; jump if user's weight < target's weight * 3
	add hl, de				; add the target's weight again
	call CompareBCtoHL
	ld a, 80				; tier 3 base power
	jr c, .finish			; jump if user's weight < target's weight * 4
	add hl, de				; add the target's weight again
	call CompareBCtoHL
	ld a, 100				; tier 4 base power
	jr c, .finish			; jump if user's weight < target's weight * 5
	ld a, 120
.finish
	ld b, a
	ld hl, wPlayerMovePower
	ld a, [H_WHOSETURN] 
	and a 
	jr z, .storePower 
	ld hl, wEnemyMovePower
.storePower
	ld a, b
	ld [hl], a
	ret

; input: pointer to species id in hl/hl+1
; output: species weight in bc (low byte in c)
GetWeight:
	push de
	push hl
	ld a, [hli]
	ld c, [hl]
	ld b, a
	ld hl, SpecificWeights
.checkExceptions
	ld a, [hl]
	cp $ff
	jr nz, .notDone
	inc hl
	ld a, [hld]
	cp $ff
	jr z, .notException
.notDone
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	push hl
	ld l, e
	ld h, d
	call CompareBCtoHL
	pop hl
	jr z, .matchFound
	inc hl
	inc hl
	jr .checkExceptions
.matchFound
	ld a, [hli]				; load low byte of target's weight
	ld c, a
	ld b, [hl]				; load high byte of target's weight
	pop hl
	pop de
	ret
.notException
	pop hl
	call GetSpeciesWeight
	ld a, [hli]				; load low byte of target's weight
	ld c, a
	ld b, [hl]				; load high byte of target's weight
	pop de
	ret

; List of species whose weight are not stored in their dex entries (because they don't have any)
SpecificWeights:
	dw GIRATINA_ORIGIN, 14330
	dw $ffff

; input: pointer to species id in hl/hl+1
; output: pointer to species weight low byte in hl
GetSpeciesWeight:
	ld a, [hli]
	ld c, [hl]
	ld b, a
	call ConvertSpeciesIDtoDexNumber
	dec	bc
	ld hl, PokedexEntryPointers
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld c, a
	ld h, [hl]
	ld l, c					; hl now points to the dex entry
.loopSkipSpeciesName		; this part skips the string containing the species name
	ld a, [hli]
	cp "@"
	jr nz, .loopSkipSpeciesName
	inc hl					; skip height
	inc hl					; skip height
	ret

; Check if user is ARCEUS, and if yes, change the move's type to match the user's type
JudgmentEffect:
	ld bc, wBattleMonType
	ld de, wPlayerMoveType
	ld hl, wBattleMonSpecies
	ld a, [H_WHOSETURN] 
	and a
	jr z, .main 
	ld bc, wEnemyMonType
	ld de, wEnemyMoveType
	ld hl, wEnemyMonSpecies
.main
	push bc
	ld a, [hli]
	ld b, a
	ld c, [hl]
	ld hl, ARCEUS_NORMAL
	call CompareBCtoHL
	jr nc, .next
.notArceus
	pop bc
	ret
.next
	ld hl, ARCEUS_FAIRY + 1
	call CompareBCtoHL
	jr nc, .notArceus
	pop bc
	ld a, [bc]
	ld [de], a
	ret
