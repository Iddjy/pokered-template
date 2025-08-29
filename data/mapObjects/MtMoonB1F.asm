MtMoonB1F_Object:
	db $3 ; border block

	db 10 ; warps
	warp 5, 5, 2, MT_MOON_1F
	warp 17, 11, 0, MT_MOON_B2F
	warp 25, 9, 3, MT_MOON_1F
	warp 25, 15, 4, MT_MOON_1F
	warp 21, 17, 1, MT_MOON_B2F
	warp 13, 27, 2, MT_MOON_B2F
	warp 23, 3, 3, MT_MOON_B2F
	warp 27, 3, 2, -1
	warp 19, 21, 4, MT_MOON_B2F
	warp 3, 27, 5, MT_MOON_B2F

	db 0 ; signs

	db 2 ; objects
	object SPRITE_BOULDER, 4, 20, STAY, BOULDER_MOVEMENT_BYTE_2, 1
	object SPRITE_BOULDER, 5, 21, STAY, BOULDER_MOVEMENT_BYTE_2, 2

	; warp-to
	warp_to 5, 5, MT_MOON_B1F_WIDTH ; MT_MOON_1F
	warp_to 17, 11, MT_MOON_B1F_WIDTH ; MT_MOON_B2F
	warp_to 25, 9, MT_MOON_B1F_WIDTH ; MT_MOON_1F
	warp_to 25, 15, MT_MOON_B1F_WIDTH ; MT_MOON_1F
	warp_to 21, 17, MT_MOON_B1F_WIDTH ; MT_MOON_B2F
	warp_to 13, 27, MT_MOON_B1F_WIDTH ; MT_MOON_B2F
	warp_to 23, 3, MT_MOON_B1F_WIDTH ; MT_MOON_B2F
	warp_to 27, 3, MT_MOON_B1F_WIDTH
	warp_to 19, 21, MT_MOON_B1F_WIDTH
	warp_to 3, 27, MT_MOON_B1F_WIDTH
