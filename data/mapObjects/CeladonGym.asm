CeladonGym_Object:
	db $3 ; border block

	db 2 ; warps
	warp 4, 17, 6, -1
	warp 5, 17, 6, -1

	db 0 ; signs

	db 8 ; objects
	object SPRITE_ERIKA, 4, 3, STAY, DOWN, 1, ERIKA, 1
	object SPRITE_LASS, 2, 11, STAY, RIGHT, 2, LASS, 17
	object SPRITE_FOULARD_WOMAN, 7, 10, STAY, LEFT, 3, BEAUTY, 1
	object SPRITE_LASS, 9, 5, STAY, DOWN, 4, JR_TRAINER_F, 10		; decreased by one since one unused trainer was removed
	object SPRITE_FOULARD_WOMAN, 1, 5, STAY, DOWN, 5, BEAUTY, 2
	object SPRITE_LASS, 6, 3, STAY, DOWN, 6, LASS, 18
	object SPRITE_FOULARD_WOMAN, 3, 3, STAY, DOWN, 7, BEAUTY, 3
	object SPRITE_LASS, 5, 3, STAY, DOWN, 8, COOLTRAINER_F, 1

	; warp-to
	warp_to 4, 17, CELADON_GYM_WIDTH
	warp_to 5, 17, CELADON_GYM_WIDTH
