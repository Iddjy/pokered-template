BattleFacility_h:
	db INTERIOR ; tileset
	db BATTLE_FACILITY_HEIGHT, BATTLE_FACILITY_WIDTH ; dimensions (y, x)
	dw BattleFacility_Blocks ; blocks
	dw BattleFacility_TextPointers ; texts
	dw BattleFacility_Script ; scripts
	db 0 ; connections
	dw BattleFacility_Object ; objects
