Route8Mons:
	db $0F
	IF DEF(_RED)
		dbw 18, PIDGEY
		dbw 18, MANKEY
		dbw 17, EKANS
		dbw 16, GROWLITHE
		dbw 20, PIDGEY
		dbw 20, MANKEY
		dbw 19, EKANS
		dbw 17, GROWLITHE
		dbw 15, GROWLITHE
		dbw 18, GROWLITHE
	ENDC
	IF DEF(_BLUE)
		dbw 18, PIDGEY
		dbw 18, MEOWTH
		dbw 17, SANDSHREW
		dbw 16, VULPIX
		dbw 20, PIDGEY
		dbw 20, MEOWTH
		dbw 19, SANDSHREW
		dbw 17, VULPIX
		dbw 15, VULPIX
		dbw 18, VULPIX
	ENDC
	db $00
