SilphCo1F_Object:
	db $2e ; border block

	db 6 ; warps
	warp 10, 17, 5, -1
	warp 11, 17, 5, -1
	warp 26, 0, 0, SILPH_CO_2F
	warp 20, 0, 0, SILPH_CO_ELEVATOR
	warp 4, 4, 1, BATTLE_FACILITY
	warp 8, 0, 0, BATTLE_FACILITY_ELEVATOR

	db 0 ; signs

	db 3 ; objects
	object SPRITE_CABLE_CLUB_WOMAN,  4,  2, STAY, DOWN, 1 ; person
	object SPRITE_PAPER_SHEET,  6,  3, STAY, NONE, 2
	object SPRITE_MART_GUY,  2,  2, STAY, DOWN, 3 ; person

	; warp-to
	warp_to 10, 17, SILPH_CO_1F_WIDTH
	warp_to 11, 17, SILPH_CO_1F_WIDTH
	warp_to 26, 0, SILPH_CO_1F_WIDTH ; SILPH_CO_2F
	warp_to 20, 0, SILPH_CO_1F_WIDTH ; SILPH_CO_ELEVATOR
	warp_to 4, 4, SILPH_CO_1F_WIDTH ; BATTLE_FACILITY
	warp_to 8, 0, SILPH_CO_1F_WIDTH ; BATTLE_FACILITY_ELEVATOR
