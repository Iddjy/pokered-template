; reads from right to left
KeyItemBitfield:
	db %11110000
	db %00000001
	db %11110000
	db %00001111	; set bit 6 to zero to make OLD AMBER non-key
	db %00000000
	db %10111000	; set bits 1 and 2 to zero to make HELIX FOSSIL and DOME FOSSIL non-key
	db %00000000
	db %11000000
	db %11000000
	db %11111111	; set bit 4 to one to make EXP. SHARE a key item
	db %00000000
	db %00000000
	db %00000010	; set bit 1 to one to make ORIGIN PLATE a key item
	db %00000000
	db %00000001	; set bit 0 to one to make GRISEOUS CORE a key item
	db %00000000
	db %00000000
	db %00000000
