ViridianGym_Object:
	db $3 ; border block

	db 2 ; warps
	warp 16, 17, 4, -1
	warp 17, 17, 4, -1

	db 0 ; signs

	db 11 ; objects
	object SPRITE_GIOVANNI, 2, 1, STAY, DOWN, 1, GIOVANNI, 3
	object SPRITE_BLACK_HAIR_BOY_1, 12, 7, STAY, DOWN, 2, COOLTRAINER_M, 5		; decreased by 4 since 4 unused trainers were removed
	object SPRITE_HIKER, 11, 11, STAY, UP, 3, BLACKBELT, 6
	object SPRITE_ROCKER, 10, 7, STAY, DOWN, 4, TAMER, 3
	object SPRITE_HIKER, 3, 7, STAY, LEFT, 5, BLACKBELT, 7
	object SPRITE_BLACK_HAIR_BOY_1, 13, 5, STAY, RIGHT, 6, COOLTRAINER_M, 6		; decreased by 4 since 4 unused trainers were removed
	object SPRITE_HIKER, 10, 1, STAY, DOWN, 7, BLACKBELT, 8
	object SPRITE_ROCKER, 2, 16, STAY, RIGHT, 8, TAMER, 4
	object SPRITE_BLACK_HAIR_BOY_1, 6, 5, STAY, DOWN, 9, COOLTRAINER_M, 1
	object SPRITE_GYM_HELPER, 16, 15, STAY, DOWN, 10 ; person
	object SPRITE_BALL, 16, 9, STAY, NONE, 11, REVIVE

	; warp-to
	warp_to 16, 17, VIRIDIAN_GYM_WIDTH
	warp_to 17, 17, VIRIDIAN_GYM_WIDTH
