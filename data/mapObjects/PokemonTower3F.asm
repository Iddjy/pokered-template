PokemonTower3F_Object:
	db $1 ; border block

	db 2 ; warps
	warp 3, 9, 0, POKEMON_TOWER_2F
	warp 18, 9, 1, POKEMON_TOWER_4F

	db 0 ; signs

	db 4 ; objects
	object SPRITE_MEDIUM, 12, 3, STAY, LEFT, 1, CHANNELER, 1	; decreased by 4 since 4 unused trainers were removed
	object SPRITE_MEDIUM, 9, 8, STAY, DOWN, 2, CHANNELER, 2		; decreased by 4 since 4 unused trainers were removed
	object SPRITE_MEDIUM, 10, 13, STAY, DOWN, 3, CHANNELER, 3	; decreased by 5 since 5 unused trainers were removed
	object SPRITE_BALL, 12, 1, STAY, NONE, 4, ESCAPE_ROPE

	; warp-to
	warp_to 3, 9, POKEMON_TOWER_3F_WIDTH ; POKEMON_TOWER_2F
	warp_to 18, 9, POKEMON_TOWER_3F_WIDTH ; POKEMON_TOWER_4F
