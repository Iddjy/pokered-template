CinnabarLab_Script:
	call EnableAutoTextBoxDrawing
	ret

CinnabarLab_TextPointers:
	dw Lab1Text1
	dw CinnabarLabTMSalesmanText		; TM salesman
	dw CinnabarLabMoveSpecialistText	; move specialist
	dw Lab1Text2
	dw Lab1Text3
	dw Lab1Text4
	dw Lab1Text5

Lab1Text1:
	TX_FAR _Lab1Text1
	db "@"

Lab1Text2:
	TX_FAR _Lab1Text2
	db "@"

Lab1Text3:
	TX_FAR _Lab1Text3
	db "@"

Lab1Text4:
	TX_FAR _Lab1Text4
	db "@"

Lab1Text5:
	TX_FAR _Lab1Text5
	db "@"

CinnabarLabMoveSpecialistText:
	TX_ASM
	call SaveScreenTilesToBuffer2
	ld hl, MoveSpecialistIntroText
	call PrintText
	ld a, FORGET_REMEMBER_NOTHANKS_MENU
	ld [wTextBoxID], a
	call DisplayTextBoxID
	ld a, [wMenuExitMethod]
	cp CHOSE_MENU_ITEM
	jp nz, .finish
	ld a, [wChosenMenuItem]
	cp FORGET_ITEM
	jp nz, .notForget
	call SelectMonFromParty
	jp c, .finish
	
	call SaveScreenTilesToBuffer1
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
	push hl
	ld de, wMoves
	ld bc, NUM_MOVES
	call CopyData
	callab FormatMovesString
	
	call GetPartyMonName2
	ld hl, wcd6d
	ld de, wLearnMoveMonName
	ld bc, NAME_LENGTH
	call CopyData
	
	ld a, [wNumMovesMinusOne]
	and a
	jr nz, .hasMultipleMoves
	ld hl, MoveSpecialistCannotForgetLastMove
	call PrintText
	pop hl
	jp .end
.hasMultipleMoves
	ld hl, MoveSpecialistWhichMoveToDelete
	call PrintText
	
	coord hl, 4, 7
	ld b, 4
	ld c, 14
	call TextBoxBorder
	coord hl, 6, 8
	ld de, wMovesString
	ld a, [hFlags_0xFFF6]
	set 2, a				; no empty lines between items in the list
	ld [hFlags_0xFFF6], a
	ld a, [wd730]
	push af
	set 6, a ; no pauses between printing each letter
	ld [wd730], a
	call PlaceString
	pop af
	ld [wd730], a
	call UpdateSprites	; hide sprites that are behind the textbox
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
	jp nz, .finish
	ld a, [wCurrentMenuItem]
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	ld [wd11e], a
	call GetMoveName			; used to populate wcd6d for MoveSpecialistForgotText later
	ld a, [wCurrentMenuItem]
	ld b, a
	ld a, [wNumMovesMinusOne]
	sub b
	jr z, .eraseMoveSlot
	ld c, a
	push bc
	push hl
.shiftMoves
	inc hl
	ld a, [hld]
	ld [hli], a
	dec c
	jr nz, .shiftMoves
	pop hl
	ld bc, wPartyMon1PP - wPartyMon1Moves
	add hl, bc
	pop bc
.shiftPPs
	inc hl
	ld a, [hld]
	ld [hli], a
	dec c
	jr nz, .shiftPPs
	ld bc, wPartyMon1Moves - wPartyMon1PP
	add hl, bc
.eraseMoveSlot
	ld [hl], 0								; make move slot empty
	ld bc, wPartyMon1PP - wPartyMon1Moves
	add hl, bc
	ld [hl], 0								; zero the PP of this move slot
	ld hl, MoveSpecialistForgotText			; uses wcd6d that was populated earlier by GetMoveName
	call PrintText
	jp .end

.notForget
	cp REMEMBER_ITEM
	jp nz, .finish
	call SaveScreenTilesToBuffer1
	call SelectMonFromParty
	jp c, .finish
.getMoveList
	call GetPartyMonName2							; can't use GetPartyMonName here after first loop iteration
	ld hl, wPartyMon1Species
	ld bc, wPartyMon2Species - wPartyMon1Species
	ld a, [wWhichPokemon]
	push af
	call AddNTimes
	ld a, [hli]										; read the species id and put it in wMonSpeciesTemp for GetMoveName
	ld [wMonSpeciesTemp], a							; read the species id and put it in wMonSpeciesTemp for GetMoveName
	ld a, [hl]										; read the species id and put it in wMonSpeciesTemp for GetMoveName
	ld [wMonSpeciesTemp + 1], a						; read the species id and put it in wMonSpeciesTemp for GetMoveName
	ld bc, wPartyMon1Moves - (wPartyMon1Species + 1)
	add hl, bc
	ld de, wMoves
	ld bc, NUM_MOVES
	call CopyData
	ld bc, wPartyMon1Level - (wPartyMon1Moves + NUM_MOVES)
	add hl, bc
	ld a, [hl]										; read mon's level
	ld d, a
	callab FillUpRememberMoveList
	ld a, [wRelearnableMoves]
	and a
	jr nz, .showList
	ld hl, MoveSpecialistCantTeachAnythingText
	call PrintText
	jr .finishPopAf
.showList
	ld hl, MoveSpecialistWhichMoveToTeach
	call PrintText
	ld hl, wRelearnableMoves
	ld a, l
	ld [wListPointer], a
	ld a, h
	ld [wListPointer + 1], a
	ld a, [wListScrollOffset]
	push af
	xor a
	ld [wCurrentMenuItem], a
	ld [wListScrollOffset], a
	ld [wPrintItemPrices], a
	ld a, MOVESLISTMENU
	ld [wListMenuID], a
	call DisplayListMenuID
	pop bc
	ld a, b
	ld [wListScrollOffset], a
	jr c, .finishPopAf
	ld a, [wWhichPokemon]		; chosen move index in item list
	inc a
	ld hl, wRelearnableMoves
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	ld [wd11e], a					; store move id to learn in wd11e for next function
	pop af
	ld [wWhichPokemon], a			; restore which pokemon was selected in the party
	ld a, 1
	ld [wLetterPrintingDelayFlags], a	; necessary to make the moveset menu appear all at once because we are already within a text command
	callab _LearnSpecificMove
	jp .getMoveList
.finishPopAf
	pop af
.finish
	call LoadScreenTilesFromBuffer2
	ld hl, MoveSpecialistOutroText
	call PrintText
.end
	jp TextScriptEnd

SelectMonFromParty:
	xor a
	ld [wPartyMenuTypeOrMessageID], a
	ld [wUpdateSpritesEnabled], a
	ld [wMenuItemToSwap], a
	call DisplayPartyMenu
	push af
	call GBPalWhiteOutWithDelay3
	call RestoreScreenTilesAndReloadTilePatterns
	call LoadGBPal
	pop af
	ld a, [wWhichPokemon]
	ret

MoveSpecialistIntroText:
	TX_FAR _MoveSpecialistIntroText
	db "@"

MoveSpecialistWhichMoveToDelete:
	TX_FAR _MoveSpecialistWhichMoveToDelete
	db "@"

MoveSpecialistForgotText:
	TX_FAR _OneTwoAndText
	TX_DELAY
	TX_ASM
	ld a, SFX_SWAP
	call PlaySoundWaitForCurrent
	ld hl, MoveSpecialistForgotText.poof
	ret
.poof
	TX_FAR _PoofText
	TX_DELAY
	TX_FAR _ForgotText
	db "@"

MoveSpecialistCannotForgetLastMove:
	TX_FAR _MoveSpecialistCannotForgetLastMove
	db "@"

MoveSpecialistWhichMoveToTeach:
	TX_FAR _MoveSpecialistWhichMoveToTeach
	db "@"

MoveSpecialistCantTeachAnythingText:
	TX_FAR _MoveSpecialistCantTeachAnythingText
	db "@"

MoveSpecialistOutroText:
	TX_FAR _MoveSpecialistOutroText
	db "@"
