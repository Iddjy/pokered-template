DungeonMonsB1:
	db $19
	dbw 55, RHYDON
	dbw 55, MAROWAK
	dbw 55, ELECTRODE
	dbw 64, CHANSEY
	dbw 64, PARASECT
	dbw 64, RAICHU
	IF DEF(_RED)
		dbw 57, ARBOK
	ENDC
	IF DEF(_BLUE)
		dbw 57, SANDSLASH
	ENDC
	dbw 65, DITTO
	dbw 63, DITTO
	dbw 67, DITTO
	db $00
