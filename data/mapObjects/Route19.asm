Route19_Object:
	db $43 ; border block

	db 0 ; warps

	db 1 ; signs
	sign 11, 9, 11 ; Route19Text11

	db 10 ; objects
	object SPRITE_BLACK_HAIR_BOY_1, 8, 7, STAY, LEFT, 1, SWIMMER, 2
	object SPRITE_BLACK_HAIR_BOY_1, 13, 7, STAY, LEFT, 2, SWIMMER, 3
	object SPRITE_SWIMMER, 13, 25, STAY, LEFT, 3, SWIMMER, 4
	object SPRITE_SWIMMER, 4, 27, STAY, RIGHT, 4, SWIMMER, 5
	object SPRITE_SWIMMER, 16, 31, STAY, UP, 5, SWIMMER, 6
	object SPRITE_SWIMMER, 9, 11, STAY, DOWN, 6, SWIMMER, 7
	object SPRITE_SWIMMER, 8, 43, STAY, LEFT, 7, BEAUTY, 11				; decreased by one since one unused trainer was removed
	object SPRITE_SWIMMER, 11, 43, STAY, RIGHT, 8, BEAUTY, 12			; decreased by one since one unused trainer was removed
	object SPRITE_SWIMMER, 9, 42, STAY, UP, 9, SWIMMER, 8
	object SPRITE_SWIMMER, 10, 44, STAY, DOWN, 10, BEAUTY, 13			; decreased by one since one unused trainer was removed

	; warp-to
