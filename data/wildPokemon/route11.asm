Route11Mons:
	db $0F
	IF DEF(_RED)
		dbw 14, EKANS
		dbw 15, SPEAROW
		dbw 12, EKANS
		dbw 9, DROWZEE
		dbw 13, SPEAROW
		dbw 13, DROWZEE
		dbw 15, EKANS
		dbw 17, SPEAROW
		dbw 11, DROWZEE
		dbw 15, DROWZEE
	ENDC
	IF DEF(_BLUE)
		dbw 14, SANDSHREW
		dbw 15, SPEAROW
		dbw 12, SANDSHREW
		dbw 9, DROWZEE
		dbw 13, SPEAROW
		dbw 13, DROWZEE
		dbw 15, SANDSHREW
		dbw 17, SPEAROW
		dbw 11, DROWZEE
		dbw 15, DROWZEE
	ENDC
	db $00
