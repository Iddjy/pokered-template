BattleFacilityElevator_Script:
	call EnableAutoTextBoxDrawing
	ld hl, BattleFacilityElevator_ScriptPointers
	ld a, [wBattleFacilityElevatorCurScript]
	jp CallFunctionInTable

BattleFacilityElevator_ScriptPointers:
	dw BattleFacilityElevator_Script0
	dw BattleFacilityElevator_Script1
	dw BattleFacilityElevator_Script2
	dw BattleFacilityElevator_Script3
	dw BattleFacilityElevator_Script4
	dw BattleFacilityElevator_Script5

BattleFacilityElevator_Script0:
	ld a, [wWarpedFromWhichMap]
	cp SILPH_CO_1F
	jr nz, .next
	ld a, 1
	ld [wBattleFacilityElevatorCurScript], a
	ret
.next
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	push hl
	call nz, BattleFacilityElevatorScript_UpdateWarpEntries
	pop hl
	bit 7, [hl]
	res 7, [hl]
	call nz, BattleFacilityElevatorScript_Shake
	xor a
	ld [wAutoTextBoxDrawingControl], a
	inc a
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ret

BattleFacilityElevatorScript_UpdateWarpEntries:
	ld hl, wWarpEntries
	ld a, [wWarpedFromWhichWarp]
	ld b, a
	ld a, [wWarpedFromWhichMap]
	ld c, a
	call BattleFacilityElevatorScript_UpdateWarpEntries2

BattleFacilityElevatorScript_UpdateWarpEntries2:
	inc hl
	inc hl
	ld a, b
	ld [hli], a
	ld a, c
	ld [hli], a
	ret

BattleFacilityElevatorScript_LoadFloorWarps:
	ld hl, BattleFacilityElavatorFloors
	call LoadItemList
	ld hl, BattleFacilityElevatorWarpMaps
	ld de, wElevatorWarpMaps
	ld bc, BattleFacilityElevatorWarpMapsEnd - BattleFacilityElevatorWarpMaps
	call CopyData
	ret

BattleFacilityElavatorFloors:
	db $02 ; num elements in list
	db FLOOR_1F
	db FLOOR_B1F
	db $FF ; terminator

BattleFacilityElevatorWarpMaps:
; first byte is warp number
; second byte is map number
; These specify where the player goes after getting out of the elevator.
	db $05, SILPH_CO_1F
	db $00, BATTLE_FACILITY
BattleFacilityElevatorWarpMapsEnd:

BattleFacilityElevatorScript_Shake:
	call Delay3
	callba ShakeElevator
	ret

BattleFacilityElevator_Script1:
	ld a, 1
	ld [wSimulatedJoypadStatesIndex], a
	ld a, D_UP
	ld [wSimulatedJoypadStatesEnd], a
	call StartSimulatingJoypadStates
	ld a, 2
	ld [wBattleFacilityElevatorCurScript], a
	ret

BattleFacilityElevator_Script3:
	ld a, PLAYER_DIR_RIGHT
	ld [wPlayerMovingDirection], a
	ld a, 1
	ld [H_SPRITEINDEX], a
	call GetSpriteMovementByte2Pointer
	ld [hl], LEFT
	ld a, SPRITE_FACING_LEFT
	ld [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay
	call UpdateSprites
	ld a, 3
	ld [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, 1
	ld [H_SPRITEINDEX], a
	call GetSpriteMovementByte2Pointer
	ld [hl], DOWN
	xor a
	ld [hSpriteFacingDirection], a
	ld a, PLAYER_DIR_DOWN
	ld [wPlayerMovingDirection], a
	call SetSpriteFacingDirectionAndDelay
	call UpdateSprites
	call BattleFacilityElevatorScript_Shake
	ld hl, wWarpEntries
	ld b, 0
	ld c, BATTLE_FACILITY
	call BattleFacilityElevatorScript_UpdateWarpEntries2
	ld a, $2
	ld [wSimulatedJoypadStatesIndex], a
	ld a, D_DOWN
	ld [wSimulatedJoypadStatesEnd], a
	ld [wSimulatedJoypadStatesEnd + 1], a
	call StartSimulatingJoypadStates
	ld a, 4
	ld [wBattleFacilityElevatorCurScript], a
	ret

BattleFacilityElevator_Script2:
BattleFacilityElevator_Script4:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	call Delay3
	ld a, [wBattleFacilityElevatorCurScript]
	inc a
	ld [wBattleFacilityElevatorCurScript], a
	ret

BattleFacilityElevator_Script5:
	xor a
	ld [wJoyIgnore], a
	ld [wBattleFacilityElevatorCurScript], a
	ret

BattleFacilityElevator_TextPointers:
	dw BattleFacilityElevatorText1
	dw BattleFacilityElevatorText2
	dw BattleFacilityElevatorText3

BattleFacilityElevatorText1:
	TX_FAR _BattleFacilityElevatorText1
	db "@"

BattleFacilityElevatorText2:
	TX_ASM
	call BattleFacilityElevatorScript_LoadFloorWarps
	ld hl, BattleFacilityElevatorWarpMaps
	predef DisplayElevatorFloorMenu
	jp TextScriptEnd

BattleFacilityElevatorText3:
	TX_FAR _BattleFacilityElevatorText3
	db "@"
