; add this function to display a pokeball icon for caught species during wild battles
PlacePokeballIcon:
	ld a, [wIsInBattle]
	cp BATTLE_STATE_WILD
	ret nz							; only do this for wild battles
	ld a, [wEnemyMonSpecies2]
	ld [wMonSpeciesTemp], a
	ld a, [wEnemyMonSpecies2 + 1]
	ld [wMonSpeciesTemp + 1], a
	callab CheckPokedexOwnedBySpeciesID		; test whether the species of the wild mon is owned in the dex
	ret z									; if the species is not owned, don't display the ball icon
	coord hl, 1, 1							; coordinates for the pokeball icon
	ld a, "(-)"								; pokeball icon (added it to the font.png file)
	ld [hl], a
	ret
