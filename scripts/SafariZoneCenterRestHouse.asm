SafariZoneCenterRestHouse_Script:
	jp EnableAutoTextBoxDrawing

SafariZoneCenterRestHouse_TextPointers:
	dw SafariZoneRestHouse1Text1
	dw SafariZoneRestHouse1Text2

SafariZoneRestHouse1Text1:
	TX_ASM
	CheckEvent EVENT_GOT_TM57
	jr nz, .alreadyGotTM57
	ld hl, SafariZoneSaraText1
	call PrintText
	SetEvent EVENT_TALKED_TO_SARA
	CheckEvent EVENT_TALKED_TO_ERIK
	jr z, .end
	call WaitForTextScrollButtonPress
	ld hl, SafariZoneSaraText2
	call PrintText
	lb bc, TM_57, 1
	call GiveItem
	SetEvent EVENT_GOT_TM57
	ld hl, ReceivedTM57Text
	call PrintText
	jr .end
.alreadyGotTM57
	ld hl, SafariZoneSaraText3
	call PrintText
.end
	jp TextScriptEnd

SafariZoneSaraText1:
	TX_FAR _SafariZoneSaraText1
	db "@"

SafariZoneSaraText2:
	TX_FAR _SafariZoneSaraText2
	db "@"

SafariZoneSaraText3:
	TX_FAR _SafariZoneSaraText3
	db "@"

ReceivedTM57Text:
	TX_FAR _ReceivedItemText
	TX_SFX_ITEM_1
	db "@"

SafariZoneRestHouse1Text2:
	TX_FAR _SafariZoneRestHouse1Text2
	db "@"
