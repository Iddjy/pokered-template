Route4Mons:
	db $14
	IF DEF(_RED)
		dbw 10, RATTATA
		dbw 10, SPEAROW
		dbw 8, RATTATA
		dbw 6, EKANS
		dbw 8, SPEAROW
		dbw 10, EKANS
		dbw 12, RATTATA
		dbw 12, SPEAROW
		dbw 8, EKANS
		dbw 12, EKANS
	ENDC
	IF DEF(_BLUE)
		dbw 10, RATTATA
		dbw 10, SPEAROW
		dbw 8, RATTATA
		dbw 6, SANDSHREW
		dbw 8, SPEAROW
		dbw 10, SANDSHREW
		dbw 12, RATTATA
		dbw 12, SPEAROW
		dbw 8, SANDSHREW
		dbw 12, SANDSHREW
	ENDC
	db $00
