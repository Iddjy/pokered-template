; sets z flag if move used is Cotton Spore and target is Grass Type, unsets it otherwise
CheckCottonSpore:
	ld hl, wBattleMonSpecies
	ld de, wEnemyMonType
	ld a, [H_WHOSETURN]
	and a
	ld a, [wPlayerMoveNum]
	jr z, .statModifierDownEffect
	ld a, [wEnemyMoveNum]
	ld hl, wEnemyMonSpecies
	ld de, wBattleMonType
.statModifierDownEffect
	push hl
	ld hl, wNewBattleFlags
	bit USING_SIGNATURE_MOVE, [hl]
	pop hl
	jr nz, .usingSignatureMove
	cp SIGNATURE_MOVE_1
	ret c
	ld [wd11e], a
	push hl
	ld a, [hli]
	ld [wMonSpeciesTemp], a
	ld a, [hl]
	ld [wMonSpeciesTemp + 1], a
	push de
	callab MapSignatureMove
	ld a, d
	pop de
	pop hl
.usingSignatureMove
	cp COTTON_SPORE
	ret nz
	ld a, [de]
	cp GRASS
	ret z
	inc de
	ld a, [de]
	cp GRASS
	ret
