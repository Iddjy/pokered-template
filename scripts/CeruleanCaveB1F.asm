CeruleanCaveB1F_Script:
	call EnableAutoTextBoxDrawing
	ld hl, MewtwoTrainerHeader
	ld de, CeruleanCaveB1F_ScriptPointers
	ld a, [wCeruleanCaveB1FCurScript]
	call ExecuteCurMapScriptInTable
	ld [wCeruleanCaveB1FCurScript], a
	ret

CeruleanCaveB1F_ScriptPointers
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw CeruleanCaveB1F_Script0
	dw CeruleanCaveB1F_Script1

CeruleanCaveB1F_TextPointers:
	dw MewtwoText
	dw PickUpItemText
	dw PickUpItemText

MewtwoTrainerHeader:
	dbEventFlagBit EVENT_BEAT_MEWTWO
	db ($0 << 4) ; trainer's view range
	dwEventFlagAddress EVENT_BEAT_MEWTWO
	dw MewtwoBattleText ; TextBeforeBattle
	dw MewtwoBattleText ; TextAfterBattle
	dw MewtwoBattleText ; TextEndBattle
	dw MEWTWO			; use this to store the static mon id

	db $ff

MewtwoText:
	TX_ASM
	ld hl, MewtwoTrainerHeader
	call TalkToTrainer
	ld a, 3								; run CeruleanCaveB1F_Script1 after Mewtwo battle to set the flag in case it was caught
	ld [wCeruleanCaveB1FCurScript], a
	ld [wCurMapScript], a
	jp TextScriptEnd

MewtwoBattleText:
	TX_FAR _MewtwoBattleText
	TX_ASM
	ld bc, MEWTWO				; replaced a with bc to handle 2 bytes species IDs
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd

CeruleanCaveB1F_Script0:
	xor a
	ld [wCeruleanCaveB1FCurScript], a
	ld [wCurMapScript], a
	call EndTrainerBattle
	ld a, [wEnemyMonOrTrainerClass]
	cp STATIC_MON
	ret nz
	xor a
	ld [wEnemyMonOrTrainerClass], a
	ret

; use a distinct script to handle the mewtwo flag in case other static mons get added to the map
CeruleanCaveB1F_Script1:
	call CeruleanCaveB1F_Script0
	ld a, [wSuccessfulCapture]
	and a
	ret z
	SetEvent EVENT_CAUGHT_MEWTWO
	ret
