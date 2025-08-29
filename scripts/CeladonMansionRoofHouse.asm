CeladonMansionRoofHouse_Script:
	jp EnableAutoTextBoxDrawing

CeladonMansionRoofHouse_TextPointers:
	dw CeladonMansion5Text1
	dw CeladonMansion5Text2

CeladonMansion5Text1:
	TX_FAR _CeladonMansion5Text1
	db "@"

CeladonMansion5Text2:
	TX_ASM
	ld bc, EEVEE					; to handle 2 bytes species IDs
	ld hl, wMonSpeciesTemp			; to handle 2 bytes species IDs
	ld a, b							; to handle 2 bytes species IDs
	ld [hli], a						; to handle 2 bytes species IDs
	ld [hl], c						; to handle 2 bytes species IDs
	ld c, 25						; to handle 2 bytes species IDs
	call GivePokemon
	jr nc, .asm_24365
	ld a, HS_CELADON_MANSION_EEVEE_GIFT
	ld [wMissableObjectIndex], a
	predef HideObject
.asm_24365
	jp TextScriptEnd
