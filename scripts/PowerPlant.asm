PowerPlant_Script:
	call EnableAutoTextBoxDrawing
	ld hl, Voltorb0TrainerHeader
	ld de, PowerPlant_ScriptPointers
	ld a, [wPowerPlantCurScript]
	call ExecuteCurMapScriptInTable
	ld [wPowerPlantCurScript], a
	ret

PowerPlant_ScriptPointers
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw PowerPlant_Script0
	dw PowerPlant_Script1

PowerPlant_TextPointers:
	dw Voltorb0Text
	dw Voltorb1Text
	dw Voltorb2Text
	dw Voltorb3Text
	dw Voltorb4Text
	dw Voltorb5Text
	dw Voltorb6Text
	dw Voltorb7Text
	dw ZapdosText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText

Voltorb0TrainerHeader:
	dbEventFlagBit EVENT_BEAT_POWER_PLANT_VOLTORB_0
	db 0 ; view range
	dwEventFlagAddress EVENT_BEAT_POWER_PLANT_VOLTORB_0
	dw VoltorbBattleText ; TextBeforeBattle
	dw VoltorbBattleText ; TextAfterBattle
	dw VoltorbBattleText ; TextEndBattle
	dw VOLTORB				; use this to store the static mon id

Voltorb1TrainerHeader:
	dbEventFlagBit EVENT_BEAT_POWER_PLANT_VOLTORB_1
	db 0 ; view range
	dwEventFlagAddress EVENT_BEAT_POWER_PLANT_VOLTORB_1
	dw VoltorbBattleText ; TextBeforeBattle
	dw VoltorbBattleText ; TextAfterBattle
	dw VoltorbBattleText ; TextEndBattle
	dw VOLTORB				; use this to store the static mon id

Voltorb2TrainerHeader:
	dbEventFlagBit EVENT_BEAT_POWER_PLANT_VOLTORB_2
	db 0 ; view range
	dwEventFlagAddress EVENT_BEAT_POWER_PLANT_VOLTORB_2
	dw VoltorbBattleText ; TextBeforeBattle
	dw VoltorbBattleText ; TextAfterBattle
	dw VoltorbBattleText ; TextEndBattle
	dw VOLTORB				; use this to store the static mon id

Voltorb3TrainerHeader:
	dbEventFlagBit EVENT_BEAT_POWER_PLANT_VOLTORB_3
	db 0 ; view range
	dwEventFlagAddress EVENT_BEAT_POWER_PLANT_VOLTORB_3
	dw VoltorbBattleText ; TextBeforeBattle
	dw VoltorbBattleText ; TextAfterBattle
	dw VoltorbBattleText ; TextEndBattle
	dw ELECTRODE			; use this to store the static mon id

Voltorb4TrainerHeader:
	dbEventFlagBit EVENT_BEAT_POWER_PLANT_VOLTORB_4
	db 0 ; view range
	dwEventFlagAddress EVENT_BEAT_POWER_PLANT_VOLTORB_4
	dw VoltorbBattleText ; TextBeforeBattle
	dw VoltorbBattleText ; TextAfterBattle
	dw VoltorbBattleText ; TextEndBattle
	dw VOLTORB				; use this to store the static mon id

Voltorb5TrainerHeader:
	dbEventFlagBit EVENT_BEAT_POWER_PLANT_VOLTORB_5
	db 0 ; view range
	dwEventFlagAddress EVENT_BEAT_POWER_PLANT_VOLTORB_5
	dw VoltorbBattleText ; TextBeforeBattle
	dw VoltorbBattleText ; TextAfterBattle
	dw VoltorbBattleText ; TextEndBattle
	dw VOLTORB				; use this to store the static mon id

Voltorb6TrainerHeader:
	dbEventFlagBit EVENT_BEAT_POWER_PLANT_VOLTORB_6
	db 0 ; view range
	dwEventFlagAddress EVENT_BEAT_POWER_PLANT_VOLTORB_6
	dw VoltorbBattleText ; TextBeforeBattle
	dw VoltorbBattleText ; TextAfterBattle
	dw VoltorbBattleText ; TextEndBattle
	dw ELECTRODE			; use this to store the static mon id

Voltorb7TrainerHeader:
	dbEventFlagBit EVENT_BEAT_POWER_PLANT_VOLTORB_7, 1
	db 0 ; view range
	dwEventFlagAddress EVENT_BEAT_POWER_PLANT_VOLTORB_7, 1
	dw VoltorbBattleText ; TextBeforeBattle
	dw VoltorbBattleText ; TextAfterBattle
	dw VoltorbBattleText ; TextEndBattle
	dw VOLTORB				; use this to store the static mon id

ZapdosTrainerHeader:
	dbEventFlagBit EVENT_BEAT_ZAPDOS, 1
	db 0 ; view range
	dwEventFlagAddress EVENT_BEAT_ZAPDOS, 1
	dw ZapdosBattleText ; TextBeforeBattle
	dw ZapdosBattleText ; TextAfterBattle
	dw ZapdosBattleText ; TextEndBattle
	dw ZAPDOS				; use this to store the static mon id

	db $ff

InitVoltorbBattle:
	call TalkToTrainer
	ld a, [wCurMapScript]
	ld [wPowerPlantCurScript], a
	jp TextScriptEnd

Voltorb0Text:
	TX_ASM
	ld hl, Voltorb0TrainerHeader
	jr InitVoltorbBattle

Voltorb1Text:
	TX_ASM
	ld hl, Voltorb1TrainerHeader
	jr InitVoltorbBattle

Voltorb2Text:
	TX_ASM
	ld hl, Voltorb2TrainerHeader
	jr InitVoltorbBattle

Voltorb3Text:
	TX_ASM
	ld hl, Voltorb3TrainerHeader
	jr InitVoltorbBattle

Voltorb4Text:
	TX_ASM
	ld hl, Voltorb4TrainerHeader
	jr InitVoltorbBattle

Voltorb5Text:
	TX_ASM
	ld hl, Voltorb5TrainerHeader
	jr InitVoltorbBattle

Voltorb6Text:
	TX_ASM
	ld hl, Voltorb6TrainerHeader
	jr InitVoltorbBattle

Voltorb7Text:
	TX_ASM
	ld hl, Voltorb7TrainerHeader
	jr InitVoltorbBattle

ZapdosText:
	TX_ASM
	ld hl, ZapdosTrainerHeader
	call TalkToTrainer
	ld a, 3							; run PowerPlant_Script1 after Zapdos battle to set the flag in case it was caught
	ld [wPowerPlantCurScript], a
	ld [wCurMapScript], a
	jp TextScriptEnd

VoltorbBattleText:
	TX_FAR _VoltorbBattleText
	db "@"

ZapdosBattleText:
	TX_FAR _ZapdosBattleText
	TX_ASM
	ld bc, ZAPDOS					; replaced a with bc to handle 2 bytes species IDs
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd

PowerPlant_Script0:
	xor a
	ld [wPowerPlantCurScript], a	; go back to 1st script after this one to avoid running PowerPlant_Script1 after static mons battle (Voltorb/Electrode)
	ld [wCurMapScript], a
	call EndTrainerBattle
	ld a, [wEnemyMonOrTrainerClass]
	cp STATIC_MON
	ret nz
	xor a
	ld [wEnemyMonOrTrainerClass], a
	ret

; use a distinct script to handle the zapdos flag so that other static mons don't set it by mistake when caught
PowerPlant_Script1:
	call PowerPlant_Script0
	ld a, [wSuccessfulCapture]
	and a
	ret z
	SetEvent EVENT_CAUGHT_ZAPDOS
	ret
