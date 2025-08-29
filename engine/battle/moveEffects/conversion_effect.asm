; update this function to the behaviour of later gens
ConversionEffect_:
	ld hl, wBattleMonMoves
	ld bc, wBattleMonType1
	ld de, wPlayerMoveListIndex
	ld a, [H_WHOSETURN]
	and a
	jr z, .conversionEffect
	ld hl, wEnemyMonMoves
	ld bc, wEnemyMonType1
	ld de, wEnemyMoveListIndex
.conversionEffect
	ld a, [de]
	ld [wBuffer + MoveEnd - Moves], a		; save the initial movelist index after the move's data in wBuffer
	ld de, wBuffer
	push bc
	push de
	ld a, [hl]
	ld [wd11e], a
	cp SIGNATURE_MOVE_1
	jr z, .signatureMove
	cp SIGNATURE_MOVE_2
	jr z, .signatureMove
	push hl
	ld hl, wPlayerMimicSlot
	ld a, [H_WHOSETURN]
	and a
	jr z, .next
	ld hl, wEnemyMimicSlot
.next
	ld a, [hl]
	dec a							; conversion uses the first move slot
	ld a, [wd11e]
	pop hl
	jr nz, .notSignatureMove
	ld de, wPlayerMoveListIndex
	ld a, [H_WHOSETURN]
	and a
	jr z, .next2
	ld de, wEnemyMoveListIndex
.next2
	xor a							; set the movelist index to 1 for next function to force it to read the data of the first move slot
	ld [de], a
.signatureMove
	push de
	ld de, wBuffer
	callab ReadSignatureMoveDataInBattle
	pop de
	ld a, [wBuffer + MoveEnd - Moves]
	ld [de], a								; restore the initial movelist index
	jr .afterReadMove
.notSignatureMove
	dec a
	ld hl, Moves
	ld bc, MoveEnd - Moves
	call AddNTimes
	ld a, BANK(Moves)
	call FarCopyData
.afterReadMove
	pop de
	ld bc, MOVEDATA_TYPE		; distance from move id to move type
	ld h, d						; copy de to hl
	ld l, e
	add hl, bc					; make hl point to the move type
	ld a, [hl]
	pop bc
	ld [bc], a					; overwrite type 1
	inc bc
	ld [bc], a					; overwrite type 2
	call GetTypeName			; use type ID in a to get type name address in de
	ld h, d						; copy type name address from de to hl
	ld l, e
	ld de, wcd6d				; target of CopyData
	ld bc, TYPE_NAME_LENGTH + 1	; copy TYPE_NAME_LENGTH + 1 bytes to include the @ terminator
	call CopyData
	callab PlayCurrentMoveAnimation
	ld hl, ConvertedTypeText
	jp PrintText

CallBankF:
	ld b, BANK(PrintButItFailedText_)
	jp Bankswitch

; in case Reflect Type's effect gets added one day
;ReflectTypeEffect_:
;	ld hl, wEnemyMonType1
;	ld de, wBattleMonType1
;	ld a, [H_WHOSETURN]
;	and a
;	ld a, [wEnemyBattleStatus1]
;	jr z, .conversionEffect
;	push hl
;	ld h, d
;	ld l, e
;	pop de
;	ld a, [wPlayerBattleStatus1]
;.conversionEffect
;	bit INVULNERABLE, a
;	jr nz, PrintButItFailedText
;	ld a, [hli]
;	ld [de], a
;	inc de
;	ld a, [hl]
;	ld [de], a
;	callab PlayCurrentMoveAnimation
;	ld hl, ReflectTypeText
;	jp PrintText

ConvertedTypeText:
	TX_FAR _ConvertedTypeText
	db "@"

;ReflectTypeText:
;	TX_FAR _ReflectTypeText
;	db "@"
