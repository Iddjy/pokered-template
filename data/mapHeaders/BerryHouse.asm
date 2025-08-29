BerryHouse_h:
	db GYM ; tileset
	db BERRY_HOUSE_HEIGHT, BERRY_HOUSE_WIDTH ; dimensions (y, x)
	dw BerryHouse_Blocks ; blocks
	dw BerryHouse_TextPointers ; texts
	dw BerryHouse_Script ; scripts
	db 0 ; connections
	dw BerryHouse_Object ; objects
