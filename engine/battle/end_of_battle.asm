EndOfBattle:
	ld a, [wLinkState]
	cp LINK_STATE_BATTLING
	jr nz, .notLinkBattle
; link battle
	ld a, [wEnemyMonPartyPos]
	ld hl, wEnemyMon1Status
	ld bc, wEnemyMon2 - wEnemyMon1
	call AddNTimes
	ld a, [wEnemyMonStatus]
	ld [hl], a
	call ClearScreen
	ld b, SET_PAL_LINK_END						; add this to make the pokeballs red in the Link battle versus screen
	call RunPaletteCommand						; add this to make the pokeballs red in the Link battle versus screen
	callab DisplayLinkBattleVersusTextBox
	ld a, [wBattleResult]
	cp $1
	ld de, YouWinText
	jr c, .placeWinOrLoseString
	ld de, YouLoseText
	jr z, .placeWinOrLoseString
	ld de, DrawText
.placeWinOrLoseString
	coord hl, 6, 8
	call PlaceString
	ld c, 200
	call DelayFrames
	jr .evolution
.notLinkBattle
	ld a, [wBattleType]
	cp BATTLE_TYPE_FACILITY
	jr z, .resetVariables		; skip pay day money and evolutions in Battle Facility
	ld a, [wBattleResult]
	and a
	jr nz, .resetVariables
	ld hl, wTotalPayDayMoney
	ld a, [hli]
	or [hl]
	inc hl
	or [hl]
	jr z, .evolution ; if pay day money is 0, jump
	ld de, wPlayerMoney + 2
	ld c, $3
	predef AddBCDPredef
	ld hl, PickUpPayDayMoneyText
	call PrintText
.evolution
	xor a
	ld [wForceEvolution], a
	predef EvolutionAfterBattle
.resetVariables
	xor a
	ld [wLowHealthAlarm], a ;disable low health alarm
	ld [wChannelSoundIDs + Ch4], a
	ld [wIsInBattle], a
	ld [wBattleType], a
	ld [wMoveMissed], a
	ld [wCurOpponent], a
	ld [wCurOpponent + 1], a
	ld [wForcePlayerToChooseMon], a
	ld [wNumRunAttempts], a
	ld [wEscapedFromBattle], a
	ld hl, wPartyAndBillsPCSavedMenuItem
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld [wListScrollOffset], a
.removeToxicStatusFromParty					; add this part to remove toxic status from the entire party after battle
	ld b, PARTY_LENGTH						; initialize b as a counter for Pokemon left to be cured of toxic status
	ld hl, wPartyMon1Status					; status of 1st pokemon in the party
	ld de, wPartyMon2 - wPartyMon1
.removeToxicStatusFromPartyLoop
	res BADLY_POISONED, [hl]				; reset toxic status for current Pokemon
	add hl, de								; make hl point to the status of the next pokemon in the party
	dec b									; decrement Pokemon counter
	jr nz, .removeToxicStatusFromPartyLoop	; if b is not zero, that means there are still Pokemon in the party who may need resetting their toxic status
	ld hl, wPlayerMimicSlot
	ld b, $18
.loop
	ld [hli], a
	dec b
	jr nz, .loop
	ld hl, wd72c
	set 0, [hl]
	call WaitForSoundToFinish
	call GBPalWhiteOut
	ld a, $ff
	ld [wDestinationWarpID], a
	ret

YouWinText:
	db "YOU WIN@"

YouLoseText:
	db "YOU LOSE@"

DrawText:
	db "  DRAW@"

PickUpPayDayMoneyText:
	TX_FAR _PickUpPayDayMoneyText
	db "@"
