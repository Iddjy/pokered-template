PokemonMansionB1F_Object:
	db $1 ; border block

	db 1 ; warps
	warp 23, 22, 5, POKEMON_MANSION_1F

	db 0 ; signs

	db 8 ; objects
	object SPRITE_BLACK_HAIR_BOY_2, 16, 23, STAY, NONE, 1, BURGLAR, 6	; decreased by 3 since 3 unused trainers were removed
	object SPRITE_OAK_AIDE, 27, 11, STAY, DOWN, 2, SCIENTIST, 1			; put the last one first in place of an unused trainer
	object SPRITE_BALL, 10, 2, STAY, NONE, 3, RARE_CANDY
	object SPRITE_BALL, 1, 22, STAY, NONE, 4, FULL_RESTORE
	object SPRITE_BALL, 19, 25, STAY, NONE, 5, TM_79
	object SPRITE_BALL, 5, 4, STAY, NONE, 6, TM_22
	object SPRITE_BOOK_MAP_DEX, 16, 20, STAY, NONE, 7 ; person
	object SPRITE_BALL, 5, 13, STAY, NONE, 8, SECRET_KEY

	; warp-to
	warp_to 23, 22, POKEMON_MANSION_B1F_WIDTH ; POKEMON_MANSION_1F
