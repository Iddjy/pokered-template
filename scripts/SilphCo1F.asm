SilphCo1F_Script:
	call EnableAutoTextBoxDrawing
	CheckEvent EVENT_BEAT_SILPH_CO_GIOVANNI
	ret z
	CheckAndSetEvent EVENT_SILPH_CO_RECEPTIONIST_AT_DESK
	jr nz, .next
	ld a, HS_SILPH_CO_1F_RECEPTIONIST
	ld [wMissableObjectIndex], a
	predef ShowObject
	ld a, HS_SILPH_CO_1F_CLERK
	ld [wMissableObjectIndex], a
	predef ShowObject
.next
	ld hl, SilphCo1F_ScriptPointers
	ld a, [wSilphCo1FCurScript]
	jp CallFunctionInTable

SilphCo1F_ScriptPointers:
	dw SilphCo1FScript0
	dw SilphCo1FScript1

SilphCo1FScript0:
	xor a
	ld [wJoyIgnore], a
	ret

; save the game when exiting the Battle Facility
SilphCo1FScript1:
	ld a, [wcf0d]
	dec a
	ld [wcf0d], a
	ret nz							; this is to give some time to the map sprites to appear
	ld a, 1
	ld [hSpriteIndexOrTextID], a
	ld [wEnteringCableClub], a		; this is to force the text box to close automatically (since we're hijacking the cable club special text id, we can't use wDoNotWaitForButtonPressAfterDisplayingText)
	call DisplayTextID
	xor a
	ld [wEnteringCableClub], a
	ret

SilphCo1F_TextPointers:
	dw SilphCo1FText1
	dw SilphCo1FText2
	dw SilphCo1FText3

; reuse the cable club special ID for DisplayTextID so that we can properly save the game from outside a map script or text processor
SilphCo1FText1:
	TX_CABLE_CLUB_RECEPTIONIST

SilphCo1FText2:
	TX_FAR _BattleFacilityRulesText
	db "@"

SilphCo1FText3:
	TX_PRIZE_VENDOR
