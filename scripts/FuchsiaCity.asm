FuchsiaCity_Script:
	jp EnableAutoTextBoxDrawing

FuchsiaCity_TextPointers:
	dw FuchsiaCityText1
	dw FuchsiaCityText2
	dw FuchsiaCityText3
	dw FuchsiaCityText4
	dw FuchsiaCityText5
	dw FuchsiaCityText6
	dw FuchsiaCityText7
	dw FuchsiaCityText8
	dw FuchsiaCityText9
	dw FuchsiaCityText10
	dw FuchsiaCityText11
	dw FuchsiaCityText12
	dw FuchsiaCityText13
	dw MartSignText
	dw PokeCenterSignText
	dw FuchsiaCityText16
	dw FuchsiaCityText17
	dw FuchsiaCityText18
	dw FuchsiaCityText19
	dw FuchsiaCityText20
	dw FuchsiaCityText21
	dw FuchsiaCityText22
	dw FuchsiaCityText23
	dw FuchsiaCityText24

FuchsiaCityText1:
	TX_FAR _FuchsiaCityText1
	db "@"

FuchsiaCityText2:
	TX_FAR _FuchsiaCityText2
	db "@"

FuchsiaCityText3:
	TX_ASM
	CheckEvent EVENT_GOT_TM57
	jr nz, .alreadyGotTM57
	ld hl, FuchsiaCityErikText1
	call PrintText
	SetEvent EVENT_TALKED_TO_ERIK
	CheckEvent EVENT_TALKED_TO_SARA
	jr z, .end
	call WaitForTextScrollButtonPress
	ld hl, FuchsiaCityErikText2
	call PrintText
	lb bc, TM_57, 1
	call GiveItem
	SetEvent EVENT_GOT_TM57
	ld hl, ReceivedTM57Text2
	call PrintText
	jr .end
.alreadyGotTM57
	ld hl, FuchsiaCityErikText3
	call PrintText
.end
	jp TextScriptEnd

FuchsiaCityErikText1:
	TX_FAR _FuchsiaCityErikText1
	db "@"

FuchsiaCityErikText2:
	TX_FAR _FuchsiaCityErikText2
	db "@"

FuchsiaCityErikText3:
	TX_FAR _FuchsiaCityErikText3
	db "@"

ReceivedTM57Text2:
	TX_FAR _ReceivedItemText
	TX_SFX_ITEM_1
	db "@"
	
FuchsiaCityText4:
	TX_FAR _FuchsiaCityText4
	db "@"

FuchsiaCityText5:
FuchsiaCityText6:
FuchsiaCityText7:
FuchsiaCityText8:
FuchsiaCityText9:
FuchsiaCityText10:
	TX_FAR _FuchsiaCityText5
	db "@"

FuchsiaCityText12:
FuchsiaCityText11:
	TX_FAR _FuchsiaCityText11
	db "@"

FuchsiaCityText13:
	TX_FAR _FuchsiaCityText13
	db "@"

FuchsiaCityText16:
	TX_FAR _FuchsiaCityText16
	db "@"

FuchsiaCityText17:
	TX_FAR _FuchsiaCityText17
	db "@"

FuchsiaCityText18:
	TX_FAR _FuchsiaCityText18
	db "@"

FuchsiaCityText19:
	TX_ASM
	ld hl, FuchsiaCityChanseyText
	call PrintText
	ld bc, CHANSEY					; to handle 2 bytes species IDs
	ld a, b							; to handle 2 bytes species IDs
	ld [wMonSpeciesTemp], a			; to handle 2 bytes species IDs
	ld a, c							; to handle 2 bytes species IDs
	ld [wMonSpeciesTemp + 1], a		; to handle 2 bytes species IDs
	call DisplayPokedex
	jp TextScriptEnd

FuchsiaCityChanseyText:
	TX_FAR _FuchsiaCityChanseyText
	db "@"

FuchsiaCityText20:
	TX_ASM
	ld hl, FuchsiaCityVoltorbText
	call PrintText
	ld bc, VOLTORB					; to handle 2 bytes species IDs
	ld a, b							; to handle 2 bytes species IDs
	ld [wMonSpeciesTemp], a			; to handle 2 bytes species IDs
	ld a, c							; to handle 2 bytes species IDs
	ld [wMonSpeciesTemp + 1], a		; to handle 2 bytes species IDs
	call DisplayPokedex
	jp TextScriptEnd

FuchsiaCityVoltorbText:
	TX_FAR _FuchsiaCityVoltorbText
	db "@"

FuchsiaCityText21:
	TX_ASM
	ld hl, FuchsiaCityKangaskhanText
	call PrintText
	ld bc, KANGASKHAN				; to handle 2 bytes species IDs
	ld a, b							; to handle 2 bytes species IDs
	ld [wMonSpeciesTemp], a			; to handle 2 bytes species IDs
	ld a, c							; to handle 2 bytes species IDs
	ld [wMonSpeciesTemp + 1], a		; to handle 2 bytes species IDs
	call DisplayPokedex
	jp TextScriptEnd

FuchsiaCityKangaskhanText:
	TX_FAR _FuchsiaCityKangaskhanText
	db "@"

FuchsiaCityText22:
	TX_ASM
	ld hl, FuchsiaCitySlowpokeText
	call PrintText
	ld bc, SLOWPOKE					; to handle 2 bytes species IDs
	ld a, b							; to handle 2 bytes species IDs
	ld [wMonSpeciesTemp], a			; to handle 2 bytes species IDs
	ld a, c							; to handle 2 bytes species IDs
	ld [wMonSpeciesTemp + 1], a		; to handle 2 bytes species IDs
	call DisplayPokedex
	jp TextScriptEnd

FuchsiaCitySlowpokeText:
	TX_FAR _FuchsiaCitySlowpokeText
	db "@"

FuchsiaCityText23:
	TX_ASM
	ld hl, FuchsiaCityLaprasText
	call PrintText
	ld bc, LAPRAS					; to handle 2 bytes species IDs
	ld a, b							; to handle 2 bytes species IDs
	ld [wMonSpeciesTemp], a			; to handle 2 bytes species IDs
	ld a, c							; to handle 2 bytes species IDs
	ld [wMonSpeciesTemp + 1], a		; to handle 2 bytes species IDs
	call DisplayPokedex
	jp TextScriptEnd

FuchsiaCityLaprasText:
	TX_FAR _FuchsiaCityLaprasText
	db "@"

FuchsiaCityText24:
	TX_ASM
	CheckEvent EVENT_GOT_DOME_FOSSIL
	jr nz, .asm_3b4e8
	CheckEventReuseA EVENT_GOT_HELIX_FOSSIL
	jr nz, .asm_667d5
	ld hl, FuchsiaCityText_19b2a
	call PrintText
	jr .asm_4343f
.asm_3b4e8
	ld hl, FuchsiaCityOmanyteText
	call PrintText
	ld bc, OMANYTE					; to handle 2 bytes species IDs
	jr .asm_81556
.asm_667d5
	ld hl, FuchsiaCityKabutoText
	call PrintText
	ld bc, KABUTO					; to handle 2 bytes species IDs
.asm_81556
	ld a, b							; to handle 2 bytes species IDs
	ld [wMonSpeciesTemp], a			; to handle 2 bytes species IDs
	ld a, c							; to handle 2 bytes species IDs
	ld [wMonSpeciesTemp + 1], a		; to handle 2 bytes species IDs
	call DisplayPokedex
.asm_4343f
	jp TextScriptEnd

FuchsiaCityOmanyteText:
	TX_FAR _FuchsiaCityOmanyteText
	db "@"

FuchsiaCityKabutoText:
	TX_FAR _FuchsiaCityKabutoText
	db "@"

FuchsiaCityText_19b2a:
	TX_FAR _FuchsiaCityText_19b2a
	db "@"
