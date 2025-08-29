Route12_Object:
	db $43 ; border block

	db 4 ; warps
	warp 10, 15, 0, ROUTE_12_GATE_1F
	warp 11, 15, 1, ROUTE_12_GATE_1F
	warp 10, 21, 2, ROUTE_12_GATE_1F
	warp 11, 77, 0, ROUTE_12_SUPER_ROD_HOUSE

	db 2 ; signs
	sign 13, 13, 11 ; Route12Text11
	sign 11, 63, 12 ; Route12Text12

	db 10 ; objects
	object SPRITE_SNORLAX, 10, 62, STAY, DOWN, 1 ; person
	object SPRITE_FISHER2, 14, 31, STAY, LEFT, 2, FISHER, 3
	object SPRITE_FISHER2, 5, 39, STAY, UP, 3, FISHER, 4
	object SPRITE_BLACK_HAIR_BOY_1, 11, 92, STAY, LEFT, 4, JR_TRAINER_M, 8	; decreased by one since one unused trainer was removed
	object SPRITE_BLACK_HAIR_BOY_2, 14, 76, STAY, UP, 5, ROCKER, 2
	object SPRITE_FISHER2, 12, 40, STAY, LEFT, 6, FISHER, 5
	object SPRITE_FISHER2, 9, 52, STAY, RIGHT, 7, FISHER, 6
	object SPRITE_FISHER2, 6, 87, STAY, DOWN, 8, FISHER, 11
	object SPRITE_BALL, 14, 35, STAY, NONE, 9, TM_16
	object SPRITE_BALL, 5, 89, STAY, NONE, 10, IRON

	; warp-to
	warp_to 10, 15, ROUTE_12_WIDTH ; ROUTE_12_GATE_1F
	warp_to 11, 15, ROUTE_12_WIDTH ; ROUTE_12_GATE_1F
	warp_to 10, 21, ROUTE_12_WIDTH ; ROUTE_12_GATE_1F
	warp_to 11, 77, ROUTE_12_WIDTH ; ROUTE_12_SUPER_ROD_HOUSE
