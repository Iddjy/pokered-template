BattleFacilityElevator_h:
	db LOBBY ; tileset
	db BATTLE_FACILITY_ELEVATOR_HEIGHT, BATTLE_FACILITY_ELEVATOR_WIDTH ; dimensions (y, x)
	dw BattleFacilityElevator_Blocks ; blocks
	dw BattleFacilityElevator_TextPointers ; texts
	dw BattleFacilityElevator_Script ; scripts
	db 0 ; connections
	dw BattleFacilityElevator_Object ; objects
