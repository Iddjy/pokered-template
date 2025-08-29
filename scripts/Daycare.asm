Daycare_Script:
	jp EnableAutoTextBoxDrawing

Daycare_TextPointers:
	dw DayCareMText1

DayCareMText1:
	TX_ASM
	call SaveScreenTilesToBuffer2
	ld a, [wDayCareInUse]
	and a
	jp nz, .daycareInUse
	ld hl, DayCareIntroText
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	ld hl, DayCareAllRightThenText
	jp nz, .done
	ld a, [wPartyCount]
	dec a
	ld hl, DayCareOnlyHaveOneMonText
	jp z, .done
	ld hl, DayCareWhichMonText
	call PrintText
	xor a
	ld [wUpdateSpritesEnabled], a
	ld [wPartyMenuTypeOrMessageID], a
	ld [wMenuItemToSwap], a
	call DisplayPartyMenu
	push af
	call GBPalWhiteOutWithDelay3
	call RestoreScreenTilesAndReloadTilePatterns
	call LoadGBPal
	pop af
	ld hl, DayCareAllRightThenText
	jp c, .done
	callab KnowsHMMove
	ld hl, DayCareCantAcceptMonWithHMText
	jp c, .done
	ld a, PARTY_TO_DAYCARE
	ld [wMoveMonType], a
	call MoveMon
	jr nc, .ok
	ld hl, DayCareCantTakeLastNonFaintedMonText
	jp .done
.ok
	xor a
	ld [wPartyAndBillsPCSavedMenuItem], a
	ld a, [wWhichPokemon]
	ld hl, wPartyMonNicks
	call GetPartyMonName
	ld hl, DayCareWillLookAfterMonText
	call PrintText
	ld a, 1
	ld [wDayCareInUse], a
	xor a
	ld [wRemoveMonFromBox], a
	call RemovePokemon
	ld a, [wMonSpeciesTemp]						; to handle 2 bytes species IDs
	ld b, a										; to handle 2 bytes species IDs
	ld a, [wMonSpeciesTemp + 1]					; to handle 2 bytes species IDs
	ld c, a										; to handle 2 bytes species IDs
	call PlayCry
	ld hl, DayCareComeSeeMeInAWhileText
	jp .done

.daycareInUse
	xor a
	ld hl, wDayCareMonName
	call GetPartyMonName
	ld a, DAYCARE_DATA
	ld [wMonDataLocation], a
	call LoadMonData
	callab CalcLevelFromExperience
	ld a, d
	cp MAX_LEVEL
	jr c, .skipCalcExp

	ld d, MAX_LEVEL
	callab CalcExperience
	ld hl, wDayCareMonExp
	ld a, [hExperience]
	ld [hli], a
	ld a, [hExperience + 1]
	ld [hli], a
	ld a, [hExperience + 2]
	ld [hl], a
	ld d, MAX_LEVEL

.skipCalcExp
	xor a
	ld [wDayCareNumLevelsGrown], a
	ld hl, wDayCareMonBoxLevel
	ld a, [hl]
	ld [wDayCareStartLevel], a
	cp d
	ld [hl], d
	ld hl, DayCareMonNeedsMoreTimeText
	jr z, .next
	ld a, [wDayCareStartLevel]
	ld b, a
	ld a, d
	sub b
	ld [wDayCareNumLevelsGrown], a
	ld hl, DayCareMonHasGrownText

.next
	call PrintText
	ld a, [wPartyCount]
	cp PARTY_LENGTH
	ld hl, DayCareNoRoomForMonText
	jp z, .leaveMonInDayCare
	ld de, wDayCareTotalCost
	xor a
	ld [de], a
	inc de
	ld [de], a
	ld hl, wDayCarePerLevelCost
	ld a, $1
	ld [hli], a
	ld [hl], $0
	ld a, [wDayCareNumLevelsGrown]
	inc a
	ld b, a
	ld c, 2
.calcPriceLoop
	push hl
	push de
	push bc
	predef AddBCDPredef
	pop bc
	pop de
	pop hl
	dec b
	jr nz, .calcPriceLoop
	ld hl, DayCareOweMoneyText
	call PrintText
	ld a, MONEY_BOX
	ld [wTextBoxID], a
	call DisplayTextBoxID
	call YesNoChoice
	ld hl, DayCareAllRightThenText
	ld a, [wCurrentMenuItem]
	and a
	jp nz, .leaveMonInDayCare
	ld hl, wDayCareTotalCost
	ld [hMoney], a
	ld a, [hli]
	ld [hMoney + 1], a
	ld a, [hl]
	ld [hMoney + 2], a
	call HasEnoughMoney
	jr nc, .enoughMoney
	ld hl, DayCareNotEnoughMoneyText
	jp .leaveMonInDayCare

.enoughMoney
	xor a
	ld [wDayCareInUse], a
	ld hl, wDayCareNumLevelsGrown
	ld [hli], a
	inc hl
	ld de, wPlayerMoney + 2
	ld c, $3
	predef SubBCDPredef
	ld a, SFX_PURCHASE
	call PlaySoundWaitForCurrent
	ld a, MONEY_BOX
	ld [wTextBoxID], a
	call DisplayTextBoxID
	ld hl, DayCareHeresYourMonText
	call PrintText
	ld a, DAYCARE_TO_PARTY
	ld [wMoveMonType], a
	call MoveMon
	ld a, [wDayCareMonSpecies]
	ld [wMonSpeciesTemp], a							; to handle 2 bytes species IDs
	ld a, [wDayCareMonSpecies + 1]					; to handle 2 bytes species IDs
	ld [wMonSpeciesTemp + 1], a						; to handle 2 bytes species IDs
	ld a, [wPartyCount]
	dec a
	push af
	ld bc, wPartyMon2 - wPartyMon1
	push bc
	ld hl, wPartyMon1Moves
	call AddNTimes
	ld d, h
	ld e, l
	ld a, 1
	ld [wLearningMovesFromDayCare], a
	predef WriteMonMoves
	pop bc
	pop af

; set mon's HP to max
	ld hl, wPartyMon1HP
	call AddNTimes
	ld d, h
	ld e, l
	ld bc, wPartyMon1MaxHP - wPartyMon1HP
	add hl, bc
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a

	ld a, [wMonSpeciesTemp]							; to handle 2 bytes species IDs
	ld b, a											; to handle 2 bytes species IDs
	ld a, [wMonSpeciesTemp + 1]						; to handle 2 bytes species IDs
	ld c, a											; to handle 2 bytes species IDs
	call PlayCry
	ld hl, DayCareGotMonBackText
	jp .done

.leaveMonInDayCare
	ld a, [wDayCareStartLevel]
	ld [wDayCareMonBoxLevel], a
	; add the whole part below to emulate Egg Moves
	ld hl, DayCareLetMonsPlayTogetherText
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	ld hl, DayCareYouShouldTryItText
	jp nz, .done
	ld hl, DayCareWhichMonPlayText
	call PrintText
	xor a
	ld [wUpdateSpritesEnabled], a
	ld [wPartyMenuTypeOrMessageID], a
	ld [wMenuItemToSwap], a
	call DisplayPartyMenu
	push af
	call GBPalWhiteOutWithDelay3
	call RestoreScreenTilesAndReloadTilePatterns
	call LoadGBPal
	pop af
	ld hl, DayCareYouShouldTryItText
	jp c, .done
	xor a
	ld [wPartyAndBillsPCSavedMenuItem], a
	ld a, [wWhichPokemon]
	ld hl, wPartyMonNicks
	call GetPartyMonName
	ld hl, DayCarePlayerLetOutMonText
	call PrintText
	ld hl, wPartyMon1Species
	ld bc, wPartyMon2Species - wPartyMon1Species
	ld a, [wWhichPokemon]
	call AddNTimes
	ld a, [hli]
	ld b, a
	ld a, [hl]
	ld c, a
	push bc
	call PlayCry
	pop bc						; restore species id of recipient mon
	push bc
	ld hl, DaycareGroups
	dec bc
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld d, a
	ld a, [hl]
	ld e, a						; put Daycare groups of recipient mon in de
	ld hl, DaycareGroups
	ld a, [wDayCareMonSpecies]
	ld b, a
	ld a, [wDayCareMonSpecies + 1]
	ld c, a
	push bc
	dec bc
	add hl, bc
	add hl, bc
	ld a, [hli]					; hl points to first Daycare group of giver mon
	cp NO_EGGS_DISCOVERED_GROUP
	jr z, .ignoreEachOther
	cp d
	jr z, .matchingGroup
	cp e
	jr z, .matchingGroup
	ld a, [hl]
	cp NO_EGGS_DISCOVERED_GROUP
	jr z, .ignoreEachOther
	cp d
	jr z, .matchingGroup
	cp e
	jr z, .matchingGroup
.ignoreEachOther
	pop bc
	pop bc
	ld c, 50
	call DelayFrames
	ld hl, DayCareMonsIgnoreEachOtherText
	jr .done
.matchingGroup
	ld hl, DayCareMonObservesAttentivelyText
	call PrintText
	pop bc										; restore species id of daycare mon
	call PlayCry
	pop bc										; restore species id of recipient mon
	ld hl, DaycareMovesPointerTable
	dec bc
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld d, [hl]
	ld e, a
	push de
	xor a
	ld [wd11e], a								; this allows us to detect if a move was compatible
	ld hl, wDayCareMonMoves
	ld c, NUM_MOVES
.loopGiver
	ld a, [hli]
	and a
	jr z, .nextGiverMove						; skip empty move slots
	ld b, a
.loopRecipient
	ld a, [de]
	inc de
	cp $FF
	jr z, .nextGiverMove
	cp b
	jr nz, .loopRecipient
	ld d, a
	call CheckMoveIsKnown						; this function sets the carry flag if the move is known by the recipient mon
	jr c, .nextGiverMove
	ld a, d
	ld [wd11e], a
	ld a, 1
	ld [wLetterPrintingDelayFlags], a
	push hl
	push bc
	callab _LearnSpecificMove					; found a daycare move that matches, propose to learn it
	pop bc
	pop hl
.nextGiverMove
	pop de
	push de
	dec c
	jr nz, .loopGiver
	pop de
	ld hl, DayCareAllRightThenText
	ld a, [wd11e]
	and a
	jr nz, .done
	ld c, 50
	call DelayFrames
	ld hl, DayCareMonGivesBlankLookText			; if no moves were compatible, display special text
.done
	call PrintText
	jp TextScriptEnd

; add this to check if move is known by recipient mon
CheckMoveIsKnown:
	push hl
	push bc
	ld hl, wPartyMon1Moves
	ld bc, wPartyMon2Moves - wPartyMon1Moves
	ld a, [wWhichPokemon]
	call AddNTimes
	ld c, NUM_MOVES
.loop
	ld a, [hli]
	cp d
	jr z, .moveIsKnown
	dec c
	jr nz, .loop
	and a
	jr .done
.moveIsKnown
	scf
.done
	pop bc
	pop hl
	ret

DayCareIntroText:
	TX_FAR _DayCareIntroText
	db "@"

DayCareWhichMonText:
	TX_FAR _DayCareWhichMonText
	db "@"

DayCareWillLookAfterMonText:
	TX_FAR _DayCareWillLookAfterMonText
	db "@"

DayCareComeSeeMeInAWhileText:
	TX_FAR _DayCareComeSeeMeInAWhileText
	db "@"

DayCareMonHasGrownText:
	TX_FAR _DayCareMonHasGrownText
	db "@"

DayCareOweMoneyText:
	TX_FAR _DayCareOweMoneyText
	db "@"

DayCareGotMonBackText:
	TX_FAR _DayCareGotMonBackText
	db "@"

DayCareMonNeedsMoreTimeText:
	TX_FAR _DayCareMonNeedsMoreTimeText
	db "@"

DayCareAllRightThenText:
	TX_FAR _DayCareAllRightThenText
DayCareComeAgainText:
	TX_FAR _DayCareComeAgainText
	db "@"

DayCareNoRoomForMonText:
	TX_FAR _DayCareNoRoomForMonText
	db "@"

DayCareOnlyHaveOneMonText:
	TX_FAR _DayCareOnlyHaveOneMonText
	db "@"

DayCareCantAcceptMonWithHMText:
	TX_FAR _DayCareCantAcceptMonWithHMText
	db "@"

DayCareCantTakeLastNonFaintedMonText:
	TX_FAR _DayCareCantTakeLastNonFaintedMonText
	db "@"

DayCareHeresYourMonText:
	TX_FAR _DayCareHeresYourMonText
	db "@"

DayCareNotEnoughMoneyText:
	TX_FAR _DayCareNotEnoughMoneyText
	db "@"

DayCareLetMonsPlayTogetherText:
	TX_FAR _DayCareLetMonsPlayTogetherText
	db "@"

DayCareYouShouldTryItText:
	TX_FAR _DayCareYouShouldTryItText
	db "@"

DayCareWhichMonPlayText:
	TX_FAR _DayCareWhichMonPlayText
	db "@"

DayCarePlayerLetOutMonText:
	TX_FAR _DayCarePlayerLetOutMonText
	db "@"

DayCareMonsIgnoreEachOtherText:
	TX_FAR _DayCareMonsIgnoreEachOtherText
	db "@"

DayCareMonObservesAttentivelyText:
	TX_FAR _DayCareMonObservesAttentivelyText
	db "@"

DayCareMonGivesBlankLookText:
	TX_FAR _DayCareMonGivesBlankLookText
	db "@"
