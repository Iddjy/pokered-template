Route3_Object:
	db $2c ; border block

	db 0 ; warps

	db 1 ; signs
	sign 59, 9, 10 ; Route3Text10

	db 9 ; objects
	object SPRITE_BLACK_HAIR_BOY_2, 57, 11, STAY, NONE, 1 ; person
	object SPRITE_BUG_CATCHER, 10, 6, STAY, RIGHT, 2, BUG_CATCHER, 4
	object SPRITE_BUG_CATCHER, 14, 4, STAY, DOWN, 3, YOUNGSTER, 1
	object SPRITE_LASS, 16, 9, STAY, LEFT, 4, LASS, 1
	object SPRITE_BUG_CATCHER, 19, 5, STAY, DOWN, 5, BUG_CATCHER, 5
	object SPRITE_LASS, 23, 4, STAY, LEFT, 6, LASS, 2
	object SPRITE_BUG_CATCHER, 22, 9, STAY, LEFT, 7, YOUNGSTER, 2
	object SPRITE_BUG_CATCHER, 24, 6, STAY, RIGHT, 8, BUG_CATCHER, 6
	object SPRITE_LASS, 33, 10, STAY, UP, 9, LASS, 3
