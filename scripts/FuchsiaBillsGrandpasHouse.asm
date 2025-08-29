FuchsiaBillsGrandpasHouse_Script:
	call EnableAutoTextBoxDrawing
	ret

FuchsiaBillsGrandpasHouse_TextPointers:
	dw FuchsiaHouse1Text1
	dw FuchsiaHouse1Text2
	dw FuchsiaHouse1Text3

FuchsiaHouse1Text1:
	TX_FAR _FuchsiaHouse1Text1
	db "@"

FuchsiaHouse1Text2:
	TX_ASM
	CheckEvent EVENT_GOT_TM87
	jr nz, .alreadyGotTM87
	ld hl, BillsGrandadText1
	call PrintText
	lb bc, TM_87, 1
	call GiveItem
	SetEvent EVENT_GOT_TM87
	ld hl, ReceivedTM87Text
	jr .end
.alreadyGotTM87
	ld hl, BillsGrandadText2
.end
	call PrintText
	jp TextScriptEnd

BillsGrandadText1
	TX_FAR _BillsGrandadText1
	db "@"

BillsGrandadText2
	TX_FAR _BillsGrandadText2
	db "@"

FuchsiaHouse1Text3:
	TX_FAR _FuchsiaHouse1Text3
	db "@"

ReceivedTM87Text:
	TX_FAR _ReceivedItemText
	TX_SFX_ITEM_1
	db "@"
