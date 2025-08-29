MtMoonB2F_Object:
	db $3 ; border block

	db 6 ; warps
	warp 25, 9, 1, MT_MOON_B1F
	warp 21, 17, 4, MT_MOON_B1F
	warp 15, 27, 5, MT_MOON_B1F
	warp 5, 7, 6, MT_MOON_B1F
	warp 21, 7, 8, MT_MOON_B1F
	warp 3, 13, 9, MT_MOON_B1F

	db 0 ; signs

	db 10 ; objects
	object SPRITE_BLACK_HAIR_BOY_2, 12, 8, STAY, RIGHT, 1, SUPER_NERD, 2
	object SPRITE_ROCKET, 11, 16, STAY, DOWN, 2, ROCKET, 1
	object SPRITE_ROCKET, 15, 22, STAY, DOWN, 3, ROCKET, 2
	object SPRITE_ROCKET, 29, 11, STAY, UP, 4, ROCKET, 3
	object SPRITE_ROCKET, 29, 17, STAY, LEFT, 5, ROCKET, 4
	object SPRITE_OMANYTE, 12, 6, STAY, NONE, 6 ; person
	object SPRITE_OMANYTE, 13, 6, STAY, NONE, 7 ; person
	object SPRITE_BALL, 25, 21, STAY, NONE, 8, HP_UP
	object SPRITE_BALL, 29, 5, STAY, NONE, 9, TM_01
	object SPRITE_BALL, 1, 13, STAY, NONE, 10, TM_63

	; warp-to
	warp_to 25, 9, MT_MOON_B2F_WIDTH ; MT_MOON_B1F
	warp_to 21, 17, MT_MOON_B2F_WIDTH ; MT_MOON_B1F
	warp_to 15, 27, MT_MOON_B2F_WIDTH ; MT_MOON_B1F
	warp_to 5, 7, MT_MOON_B2F_WIDTH ; MT_MOON_B1F
	warp_to 21, 7, MT_MOON_B2F_WIDTH
	warp_to 3, 13, MT_MOON_B2F_WIDTH
