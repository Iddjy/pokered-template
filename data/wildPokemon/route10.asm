Route10Mons:
	db $0F
	IF DEF(_RED)
		dbw 16, VOLTORB
		dbw 16, SPEAROW
		dbw 14, VOLTORB
		dbw 11, EKANS
		dbw 13, SPEAROW
		dbw 15, EKANS
		dbw 17, VOLTORB
		dbw 17, SPEAROW
		dbw 13, EKANS
		dbw 17, EKANS
	ENDC
	IF DEF(_BLUE)
		dbw 16, VOLTORB
		dbw 16, SPEAROW
		dbw 14, VOLTORB
		dbw 11, SANDSHREW
		dbw 13, SPEAROW
		dbw 15, SANDSHREW
		dbw 17, VOLTORB
		dbw 17, SPEAROW
		dbw 13, SANDSHREW
		dbw 17, SANDSHREW
	ENDC
	db $00
