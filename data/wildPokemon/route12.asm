Route12Mons:
	db $0F
	IF DEF(_RED)
		dbw 24, ODDISH
		dbw 25, PIDGEY
		dbw 23, PIDGEY
		dbw 24, VENONAT
		dbw 22, ODDISH
		dbw 26, VENONAT
		dbw 26, ODDISH
		dbw 27, PIDGEY
		dbw 28, GLOOM
		dbw 30, GLOOM
	ENDC
	IF DEF(_BLUE)
		dbw 24, BELLSPROUT
		dbw 25, PIDGEY
		dbw 23, PIDGEY
		dbw 24, VENONAT
		dbw 22, BELLSPROUT
		dbw 26, VENONAT
		dbw 26, BELLSPROUT
		dbw 27, PIDGEY
		dbw 28, WEEPINBELL
		dbw 30, WEEPINBELL
	ENDC
	db $00
