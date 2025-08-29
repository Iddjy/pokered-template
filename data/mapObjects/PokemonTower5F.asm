PokemonTower5F_Object:
	db $1 ; border block

	db 2 ; warps
	warp 3, 9, 0, POKEMON_TOWER_4F
	warp 18, 9, 0, POKEMON_TOWER_6F

	db 0 ; signs

	db 6 ; objects
	object SPRITE_MEDIUM, 12, 8, STAY, NONE, 1 ; person
	object SPRITE_MEDIUM, 17, 7, STAY, LEFT, 2, CHANNELER, 7	; decreased by 7 since 7 unused trainers were removed
	object SPRITE_MEDIUM, 14, 3, STAY, LEFT, 3, CHANNELER, 8	; decreased by 8 since 8 unused trainers were removed
	object SPRITE_MEDIUM, 6, 10, STAY, RIGHT, 4, CHANNELER, 9	; decreased by 8 since 8 unused trainers were removed
	object SPRITE_MEDIUM, 9, 16, STAY, RIGHT, 5, CHANNELER, 10	; decreased by 8 since 8 unused trainers were removed
	object SPRITE_BALL, 6, 14, STAY, NONE, 6, NUGGET

	; warp-to
	warp_to 3, 9, POKEMON_TOWER_5F_WIDTH ; POKEMON_TOWER_4F
	warp_to 18, 9, POKEMON_TOWER_5F_WIDTH ; POKEMON_TOWER_6F
