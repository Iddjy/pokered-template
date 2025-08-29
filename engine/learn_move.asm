LearnMove:
	call SaveScreenTilesToBuffer1
	ld a, [wWhichPokemon]
	ld hl, wPartyMonNicks
	call GetPartyMonName
	ld hl, wcd6d
	ld de, wLearnMoveMonName
	ld bc, NAME_LENGTH
	call CopyData

DontAbandonLearning:
	ld hl, wPartyMon1Species
	ld bc, wPartyMon2Species - wPartyMon1Species
	ld a, [wWhichPokemon]
	call AddNTimes
	ld a, [hli]													; read the species id and put it in wMonSpeciesTemp for GetMoveName
	ld [wMonSpeciesTemp], a										; read the species id and put it in wMonSpeciesTemp for GetMoveName
	ld a, [hl]													; read the species id and put it in wMonSpeciesTemp for GetMoveName
	ld [wMonSpeciesTemp + 1], a									; read the species id and put it in wMonSpeciesTemp for GetMoveName
	ld bc, wPartyMon1Moves - (wPartyMon1Species + 1)			; make hl point to the pokemon moves
	add hl, bc													; make hl point to the pokemon moves
	ld d, h
	ld e, l
	ld b, NUM_MOVES
.findEmptyMoveSlotLoop
	ld a, [hl]
	and a
	jr z, .next
	inc hl
	dec b
	jr nz, .findEmptyMoveSlotLoop
	push de
	call TryingToLearn
	pop de
	jp c, AbandonLearning
	push hl
	push de
	ld [wd11e], a
	call GetMoveName
	ld hl, OneTwoAndText
	call PrintText
	pop de
	pop hl
	jr .next2
.next
	ld [wUsingTM], a				; if we found an emply move slot, reset wUsingTM so that the new move has PP
.next2
	ld a, [wMoveNum]
	ld [hl], a						; update move id in party data
	ld bc, wPartyMon1PP - wPartyMon1Moves
	add hl, bc
	push hl
	push de
	ld de, wBuffer
	cp SIGNATURE_MOVE_1
	jr z, .signatureMove
	cp SIGNATURE_MOVE_2
	jr nz, .notSignatureMove
.signatureMove
	ld [wd11e], a
	callab ReadSignatureMoveData
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
	pop hl
	ld a, [wUsingTM]
	and a
	ld a, [wBuffer + MOVEDATA_PP]	; a = new move's max PP
	jr z, .ovewritePP				; if we're not using a TM, always overwrite PP with new value
	cp [hl]							; else compare new move's max PP to old move's current PP
	jr nc, .dontOverwritePP			; if old move's current PP is <= to new move's max PP, leave it unchanged to prevent
									; using infinite TMs as a way to restore PP for free
.ovewritePP
	ld [hl], a
.dontOverwritePP
	ld a, [wIsInBattle]
	and a
	jp z, PrintLearnedMove
	ld a, [wWhichPokemon]
	ld b, a
	ld a, [wPlayerMonNumber]
	cp b
	jp nz, PrintLearnedMove
	ld h, d
	ld l, e
	ld de, wBattleMonMoves
	ld bc, NUM_MOVES
	call CopyData
	ld bc, wPartyMon1PP - wPartyMon1OTID
	add hl, bc
	ld de, wBattleMonPP
	ld bc, NUM_MOVES
	call CopyData
	jp PrintLearnedMove

AbandonLearning:
	ld hl, AbandonLearningText
	call PrintText
	coord hl, 14, 7
	lb bc, 8, 15
	ld a, TWO_OPTION_MENU
	ld [wTextBoxID], a
	call DisplayTextBoxID ; yes/no menu
	ld a, [wCurrentMenuItem]
	and a
	jp nz, DontAbandonLearning
	ld hl, DidNotLearnText
	call PrintText
	ld b, 0
	ret

PrintLearnedMove:
	ld hl, LearnedMove1Text
	call PrintText
	ld b, 1
	ret

TryingToLearn:
	push hl
	ld hl, TryingToLearnText
	call PrintText
	coord hl, 14, 7
	lb bc, 8, 15
	ld a, TWO_OPTION_MENU
	ld [wTextBoxID], a
	call DisplayTextBoxID ; yes/no menu
	pop hl
	ld a, [wCurrentMenuItem]
	rra
	ret c
	ld bc, -NUM_MOVES
	add hl, bc
	push hl
	ld de, wMoves
	ld bc, NUM_MOVES
	call CopyData
	callab FormatMovesString
	pop hl
.loop
	push hl
	ld hl, WhichMoveToForgetText
	call PrintText
	coord hl, 4, 7
	ld b, 4
	ld c, 14
	call TextBoxBorder
	coord hl, 6, 8
	ld de, wMovesString
	ld a, [hFlags_0xFFF6]
	set 2, a
	ld [hFlags_0xFFF6], a
	call PlaceString
	call UpdateSprites				; hide sprites that are behind the textbox (for Daycare moves)
	ld a, [hFlags_0xFFF6]
	res 2, a
	ld [hFlags_0xFFF6], a
	ld hl, wTopMenuItemY
	ld a, 8
	ld [hli], a ; wTopMenuItemY
	ld a, 5
	ld [hli], a ; wTopMenuItemX
	xor a
	ld [hli], a ; wCurrentMenuItem
	inc hl
	ld a, [wNumMovesMinusOne]
	ld [hli], a ; wMaxMenuItem
	ld a, A_BUTTON | B_BUTTON
	ld [hli], a ; wMenuWatchedKeys
	ld [hl], 0 ; wLastMenuItem
	ld hl, hFlags_0xFFF6
	set 1, [hl]
	call HandleMenuInput
	ld hl, hFlags_0xFFF6
	res 1, [hl]
	push af
	call LoadScreenTilesFromBuffer1
	pop af
	pop hl
	bit 1, a ; pressed b
	jr nz, .cancel
	push hl
	ld a, [wCurrentMenuItem]
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	push af
	push bc
	call IsMoveHM
	pop bc
	pop de
	ld a, d
	jr c, .hm
	pop hl
	add hl, bc
	and a
	ret
.hm
	ld hl, HMCantDeleteText
	call PrintText
	pop hl
	jr .loop
.cancel
	scf
	ret

LearnedMove1Text:
	TX_FAR _LearnedMove1Text
	TX_SFX_ITEM_1 ; plays SFX_GET_ITEM_1 in the party menu (rare candy) and plays SFX_LEVEL_UP in battle
	TX_BLINK
	db "@"

WhichMoveToForgetText:
	TX_FAR _WhichMoveToForgetText
	db "@"

AbandonLearningText:
	TX_FAR _AbandonLearningText
	db "@"

DidNotLearnText:
	TX_FAR _DidNotLearnText
	db "@"

TryingToLearnText:
	TX_FAR _TryingToLearnText
	db "@"

OneTwoAndText:
	TX_FAR _OneTwoAndText
	TX_DELAY
	TX_ASM
	ld a, SFX_SWAP
	call PlaySoundWaitForCurrent
	ld hl, PoofText
	ret

PoofText:
	TX_FAR _PoofText
	TX_DELAY
ForgotAndText:
	TX_FAR _ForgotAndText
	db "@"

HMCantDeleteText:
	TX_FAR _HMCantDeleteText
	db "@"
