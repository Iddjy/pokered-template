Route13_Object:
	db $43 ; border block

	db 0 ; warps

	db 3 ; signs
	sign 15, 13, 12 ; Route13Text11
	sign 33, 5, 13 ; Route13Text12
	sign 31, 11, 14 ; Route13Text13

	db 11 ; objects
	object SPRITE_BLACK_HAIR_BOY_1, 49, 10, STAY, RIGHT, 1, BIRD_KEEPER, 1
	object SPRITE_LASS, 48, 10, STAY, DOWN, 2, JR_TRAINER_F, 11				; decreased by one since one unused trainer was removed
	object SPRITE_LASS, 27, 9, STAY, DOWN, 3, JR_TRAINER_F, 12				; decreased by one since one unused trainer was removed
	object SPRITE_LASS, 23, 10, STAY, LEFT, 4, JR_TRAINER_F, 13				; decreased by one since one unused trainer was removed
	object SPRITE_LASS, 50, 5, STAY, DOWN, 5, JR_TRAINER_F, 14				; decreased by one since one unused trainer was removed
	object SPRITE_BLACK_HAIR_BOY_1, 12, 4, STAY, RIGHT, 6, BIRD_KEEPER, 2
	object SPRITE_FOULARD_WOMAN, 33, 6, STAY, DOWN, 7, BEAUTY, 4
	object SPRITE_FOULARD_WOMAN, 32, 6, STAY, DOWN, 8, BEAUTY, 5
	object SPRITE_BIKER, 10, 7, STAY, UP, 9, BIKER, 1
	object SPRITE_BLACK_HAIR_BOY_1, 7, 13, STAY, UP, 10, BIRD_KEEPER, 3
	object SPRITE_BALL, 34, 6, STAY, NONE, 11, TM_88
