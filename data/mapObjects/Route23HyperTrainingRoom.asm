Route23HyperTrainingRoom_Object:
	db $3 ; border block

	db 2 ; warps
	warp 4, 7, 4, -1
	warp 5, 7, 4, -1

	db 0 ; signs

	db 2 ; objects
	object SPRITE_HIKER, 4, 2, STAY, DOWN, 1
	object SPRITE_HIKER, 5, 2, STAY, DOWN, 2

	; warp-to
	warp_to 4, 7, ROUTE_23_HYPER_TRAINING_ROOM_WIDTH
	warp_to 5, 7, ROUTE_23_HYPER_TRAINING_ROOM_WIDTH
