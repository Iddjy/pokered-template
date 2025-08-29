LavenderCuboneHouse_Script:
	call EnableAutoTextBoxDrawing
	ret

LavenderCuboneHouse_TextPointers:
	dw LavenderHouse2Text1
	dw LavenderHouse2Text2

LavenderHouse2Text1:
	TX_FAR _LavenderHouse2Text1
	TX_ASM
	ld bc, CUBONE					; to handle 2 bytes species IDs
	call PlayCry
	jp TextScriptEnd

LavenderHouse2Text2:
	TX_ASM
	CheckEvent EVENT_GOT_TM67
	jr nz, .alreadyGotTM67
	CheckEvent EVENT_BEAT_GHOST_MAROWAK
	jr nz, .asm_65711
	ld hl, LavenderHouse2Text_1d9dc
	call PrintText
	jr .end
.asm_65711
	ld hl, LavenderHouse2Text_1d9e1
	call PrintText
	lb bc, TM_67, 1
	call GiveItem
	SetEvent EVENT_GOT_TM67
	ld hl, ReceivedTM67Text
	call PrintText
	jr .end
.alreadyGotTM67
	ld hl, LavenderHouse2AlreadyGotTM67
	call PrintText
.end
	jp TextScriptEnd

LavenderHouse2Text_1d9dc:
	TX_FAR _LavenderHouse2Text_1d9dc
	db "@"

LavenderHouse2Text_1d9e1:
	TX_FAR _LavenderHouse2Text_1d9e1
	db "@"

LavenderHouse2AlreadyGotTM67:
	TX_FAR _LavenderHouse2AlreadyGotTM67
	db "@"

ReceivedTM67Text:
	TX_FAR _ReceivedItemText
	TX_SFX_ITEM_1
	db "@"