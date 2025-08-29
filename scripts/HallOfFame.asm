HallOfFame_Script:
	call EnableAutoTextBoxDrawing
	ld hl, HallOfFame_ScriptPointers
	ld a, [wHallOfFameCurScript]
	jp CallFunctionInTable

HallofFameRoomScript_5a4aa:
	xor a
	ld [wJoyIgnore], a
	ld [wHallOfFameCurScript], a
	ret

HallOfFame_ScriptPointers:
	dw HallofFameRoomScript0
	dw HallofFameRoomScript1
	dw HallofFameRoomScript2
	dw HallofFameRoomScript3

HallofFameRoomScript3:
	ret

HallofFameRoomScript2:
	call Delay3
	ld a, [wLetterPrintingDelayFlags]
	push af
	xor a
	ld [wJoyIgnore], a
	predef HallOfFamePC
	pop af
	ld [wLetterPrintingDelayFlags], a
	ld hl, wFlags_D733
	res 1, [hl]
	inc hl
	set 0, [hl]
	xor a
	ld hl, wLoreleisRoomCurScript
	ld [hli], a ; wLoreleisRoomCurScript
	ld [hli], a ; wBrunosRoomCurScript
	ld [hl], a ; wAgathasRoomCurScript
	ld [wLancesRoomCurScript], a
	ld [wHallOfFameCurScript], a
	; Elite 4 events
	ResetEventRange ELITE4_EVENTS_START, ELITE4_CHAMPION_EVENTS_END, 1
	ResetEventRange EVENT_BEAT_BROCK_REMATCH, EVENT_BEAT_GIOVANNI_REMATCH   ; Gym Leader rematches events
	xor a
	ld [wHallOfFameCurScript], a
	ld a, PALLET_TOWN
	ld [wLastBlackoutMap], a
	callba SaveSAVtoSRAM
	ld b, 5
.delayLoop
	ld c, 600 / 5
	call DelayFrames
	dec b
	jr nz, .delayLoop
	call WaitForTextScrollButtonPress
	jp Init

HallofFameRoomScript0:
	ld a, $ff
	ld [wJoyIgnore], a
	ld hl, wSimulatedJoypadStatesEnd
	ld de, RLEMovement5a528
	call DecodeRLEList
	dec a
	ld [wSimulatedJoypadStatesIndex], a
	call StartSimulatingJoypadStates
	ld a, $1
	ld [wHallOfFameCurScript], a
	ret

RLEMovement5a528:
	db D_UP,$5
	db $ff

HallofFameRoomScript1:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	ld a, PLAYER_DIR_RIGHT
	ld [wPlayerMovingDirection], a
	ld a, $1
	ld [H_SPRITEINDEX], a
	call SetSpriteMovementBytesToFF
	ld a, SPRITE_FACING_LEFT
	ld [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay
	call Delay3
	xor a
	ld [wJoyIgnore], a
	inc a ; PLAYER_DIR_RIGHT
	ld [wPlayerMovingDirection], a
	ld a, $1
	ld [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, $ff
	ld [wJoyIgnore], a
	ld a, HS_CERULEAN_CAVE_GUY
	ld [wMissableObjectIndex], a
	predef HideObject
	CheckEvent EVENT_CAUGHT_ARTICUNO
	jr nz, .checkZapdos
	ld a, HS_ARTICUNO
	ld [wMissableObjectIndex], a
	predef ShowObject						; make Articuno respawn after E4 win unless it has already been caught
	ResetEvent EVENT_BEAT_ARTICUNO
.checkZapdos
	CheckEvent EVENT_CAUGHT_ZAPDOS
	jr nz, .checkMoltres
	ld a, HS_ZAPDOS
	ld [wMissableObjectIndex], a
	predef ShowObject						; make Zapdos respawn after E4 win unless it has already been caught
	ResetEvent EVENT_BEAT_ZAPDOS
.checkMoltres
	CheckEvent EVENT_CAUGHT_MOLTRES
	jr nz, .checkMewtwo
	ld a, HS_MOLTRES
	ld [wMissableObjectIndex], a
	predef ShowObject						; make Moltres respawn after E4 win unless it has already been caught
	ResetEvent EVENT_BEAT_MOLTRES
.checkMewtwo
	CheckEvent EVENT_CAUGHT_MEWTWO
	jr nz, .done
	ld a, HS_MEWTWO
	ld [wMissableObjectIndex], a
	predef ShowObject						; make Mewtwo respawn after E4 win unless it has already been caught
	ResetEvent EVENT_BEAT_MEWTWO
.done
	ld a, $2
	ld [wHallOfFameCurScript], a
	ret

HallOfFame_TextPointers:
	dw HallofFameRoomText1

HallofFameRoomText1:
	TX_FAR _HallofFameRoomText1
	db "@"
