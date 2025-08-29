Route23HyperTrainingRoom_h:
	db GYM ; tileset
	db ROUTE_23_HYPER_TRAINING_ROOM_HEIGHT, ROUTE_23_HYPER_TRAINING_ROOM_WIDTH ; dimensions (y, x)
	dw Route23HyperTrainingRoom_Blocks ; blocks
	dw Route23HyperTrainingRoom_TextPointers ; texts
	dw Route23HyperTrainingRoom_Script ; scripts
	db 0 ; connections
	dw Route23HyperTrainingRoom_Object ; objects
