BattleFacility_Object:
	db $d ; border block

	db 2 ; warps
	warp 5, 0, 0, BATTLE_FACILITY_ELEVATOR
	warp 0, 0, 4, SILPH_CO_1F				; used to teleport the player back after winning a 7 streak run

	db 0 ; signs

	db 3 ; objects
	object SPRITE_WAITER, 3, 1, STAY, DOWN, 1
	object SPRITE_WAITER, 7, 1, STAY, DOWN, 2
	object SPRITE_RED, 5, 0, STAY, NONE, 3

	; warp-to
	warp_to 5, 0, BATTLE_FACILITY_WIDTH
	warp_to 0, 0, BATTLE_FACILITY_WIDTH
