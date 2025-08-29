RockTunnelB1F_Object:
	db $3 ; border block

	db 4 ; warps
	warp 33, 25, 4, ROCK_TUNNEL_1F
	warp 27, 3, 5, ROCK_TUNNEL_1F
	warp 23, 11, 6, ROCK_TUNNEL_1F
	warp 3, 3, 7, ROCK_TUNNEL_1F

	db 0 ; signs

	db 9 ; objects
	object SPRITE_LASS, 11, 13, STAY, DOWN, 1, JR_TRAINER_F, 8				; decreased by one since one unused trainer was removed
	object SPRITE_HIKER, 6, 10, STAY, DOWN, 2, HIKER, 9
	object SPRITE_BLACK_HAIR_BOY_2, 3, 5, STAY, DOWN, 3, POKEMANIAC, 3
	object SPRITE_BLACK_HAIR_BOY_2, 20, 21, STAY, RIGHT, 4, POKEMANIAC, 4
	object SPRITE_HIKER, 30, 10, STAY, DOWN, 5, HIKER, 10
	object SPRITE_LASS, 14, 28, STAY, RIGHT, 6, JR_TRAINER_F, 9				; decreased by one since one unused trainer was removed
	object SPRITE_HIKER, 33, 5, STAY, RIGHT, 7, HIKER, 11
	object SPRITE_BLACK_HAIR_BOY_2, 26, 30, STAY, DOWN, 8, POKEMANIAC, 5
	object SPRITE_BALL, 3, 25, STAY, NONE, 9, TM_76

	; warp-to
	warp_to 33, 25, ROCK_TUNNEL_B1F_WIDTH ; ROCK_TUNNEL_1F
	warp_to 27, 3, ROCK_TUNNEL_B1F_WIDTH ; ROCK_TUNNEL_1F
	warp_to 23, 11, ROCK_TUNNEL_B1F_WIDTH ; ROCK_TUNNEL_1F
	warp_to 3, 3, ROCK_TUNNEL_B1F_WIDTH ; ROCK_TUNNEL_1F
