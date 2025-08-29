BattleFacilityElevator_Object:
	db $f ; border block

	db 2 ; warps
	warp 1, 3, 0, BATTLE_FACILITY
	warp 2, 3, 0, BATTLE_FACILITY

	db 1 ; signs
	sign 3, 0, 2

	db 1 ; objects
	object SPRITE_CABLE_CLUB_WOMAN, 2, 2, STAY, DOWN, 1 ; person

	; warp-to
	warp_to 1, 3, BATTLE_FACILITY_ELEVATOR_WIDTH
	warp_to 2, 3, BATTLE_FACILITY_ELEVATOR_WIDTH
