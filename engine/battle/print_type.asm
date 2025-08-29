; [wd0b5] = pokemon ID
; hl = dest addr
PrintMonType:
	call GetPredefRegisters
	push hl
	call GetMonHeader
	pop hl
	push hl
	ld a, [wMonHType1]
	call PrintType
	ld a, [wMonHType1]
	ld b, a
	ld a, [wMonHType2]
	cp b
	pop hl
	jr z, EraseType2Text
	ld bc, SCREEN_WIDTH * 2
	add hl, bc

; a = type
; hl = dest addr
PrintType:
	add "<NORMAL>"
	ld [hli], a				; display the type symbol
	sub "<NORMAL>"
	push hl
	jr PrintType_

; erase "TYPE2/" if the mon only has 1 type
EraseType2Text:
	ld a, " "
	ld bc, $14				; increased by 1 to take into account the added type symbol
	add hl, bc
	ld bc, $6
	jp FillMemory

PrintMoveType:
	call GetPredefRegisters
	ld a, [wPlayerMoveType]
	add "<NORMAL>"
	ld [hli], a				; display the type symbol
	sub "<NORMAL>"
	push hl
; fall through

PrintType_:
	call GetTypeName
	pop hl
	jp PlaceString

; add this to get the type name corresponding to a type ID
; input: the type ID in a
; output: offset of the type name in de
GetTypeName:
	add a
	ld hl, TypeNames
	ld e, a
	ld d, $0
	add hl, de
	ld a, [hli]
	ld e, a
	ld d, [hl]
	ret

; for calls from another bank
; input: Type ID in d
; output: the type name in wcf4b
FarGetTypeName:
	ld a, d
	call GetTypeName
	ld hl, wcf4b
.copyToCF4B
	ld a, [de]
	ld [hli], a
	inc de
	cp "@"
	jr nz, .copyToCF4B
	ret

INCLUDE "text/type_names.asm"

; add this to display the move's category in battle
PrintMoveCategory:
	ld a, [wPlayerMoveExtra]
	and ((1 << IS_SPECIAL_MOVE) | (1 << IS_STATUS_MOVE))	; only keep category bits
	call GetCategoryName
	coord hl, 1, 9
	jp PlaceString	

; add this to display the move's category in battle
GetCategoryName:
	add a
	ld hl, CategoryNames
	ld e, a
	ld d, $0
	add hl, de
	ld a, [hli]
	ld e, a
	ld d, [hl]
	ret

INCLUDE "text/category_names.asm"
