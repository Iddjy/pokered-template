Route5Mons:
	db $0F
	IF DEF(_RED)
		dbw 13, ODDISH
		dbw 13, PIDGEY
		dbw 15, PIDGEY
		dbw 10, MANKEY
		dbw 12, MANKEY
		dbw 15, ODDISH
		dbw 16, ODDISH
		dbw 16, PIDGEY
		dbw 14, MANKEY
		dbw 16, MANKEY
	ENDC
	IF DEF(_BLUE)
		dbw 13, BELLSPROUT
		dbw 13, PIDGEY
		dbw 15, PIDGEY
		dbw 10, MEOWTH
		dbw 12, MEOWTH
		dbw 15, BELLSPROUT
		dbw 16, BELLSPROUT
		dbw 16, PIDGEY
		dbw 14, MEOWTH
		dbw 16, MEOWTH
	ENDC
	db $00
