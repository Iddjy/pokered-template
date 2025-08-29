Route2Mons:
	db $19
	dbw 3, RATTATA
	dbw 3, PIDGEY
	dbw 4, PIDGEY
	dbw 4, RATTATA
	dbw 5, PIDGEY
	IF DEF(_RED)
		dbw 3, WEEDLE
	ENDC
	IF DEF(_BLUE)
		dbw 3, CATERPIE
	ENDC
	dbw 2, RATTATA
	dbw 5, RATTATA
	IF DEF(_RED)
		dbw 4, WEEDLE
		dbw 5, WEEDLE
	ENDC
	IF DEF(_BLUE)
		dbw 4, CATERPIE
		dbw 5, CATERPIE
	ENDC
	db $00
