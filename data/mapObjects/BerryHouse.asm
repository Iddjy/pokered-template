BerryHouse_Object:
	db $3 ; border block

	db 2 ; warps
	warp 2, 7, 5, -1
	warp 3, 7, 5, -1

	db 4 ; signs
	sign 2, 0, 3	; scroll
	sign 3, 0, 4	; scroll
	sign 4, 0, 5	; scroll
	sign 5, 0, 6	; scroll

	db 2 ; objects
	object SPRITE_OLD_MEDIUM_WOMAN, 3, 2, STAY, DOWN, 1 ; person
	object SPRITE_LITTLE_GIRL, 5, 5, STAY, LEFT, 2 ; person

	; warp-to
	warp_to 2, 7, BERRY_HOUSE_WIDTH
	warp_to 3, 7, BERRY_HOUSE_WIDTH
