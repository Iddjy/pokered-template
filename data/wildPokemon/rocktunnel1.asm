TunnelMonsB1:
	db $0F
	dbw 16, ZUBAT
	dbw 17, ZUBAT
	dbw 17, GEODUDE
	dbw 15, MACHOP
	dbw 16, GEODUDE
	dbw 18, ZUBAT
	dbw 15, ZUBAT
	dbw 17, MACHOP
	dbw 13, ONIX
	dbw 15, ONIX
	db $00

; add a different encounter table for when the map has been lit by FLASH
TunnelMonsB1_Flash:
	db $0F
	dbw 16, ZUBAT
	dbw 17, ZUBAT
	dbw 17, GEODUDE
	dbw 15, MACHOP
	dbw 16, GEODUDE
	dbw 18, ZUBAT
	dbw 15, ZUBAT
	dbw 17, MACHOP
	dbw 13, ONIX
	dbw 15, ONIX
	db $00
