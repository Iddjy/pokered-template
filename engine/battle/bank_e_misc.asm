; formats a string at wMovesString that lists the moves at wMoves
FormatMovesString:
	ld hl, wMoves
	ld de, wMovesString
	ld b, $0
.printMoveNameLoop
	ld a, [hli]
	and a ; end of move list?
	jr z, .printDashLoop ; print dashes when no moves are left
	push hl
	push de							; GetMoveName clobbers de so need to save it here
	ld [wd11e], a					; for GetMoveName
	ld a, [wMoveMenuType]
	and a
	jr nz, .getMoveName				; ignore wPlayerMimicSlot for menus other than the regular move choice menu
	ld a, [wPlayerMimicSlot]		; check if wPlayerMimicSlot is non-zero
	and a
	jr z, .getMoveName
	dec a							; if it is, check if current move slot +1 is equal to it
	cp b
	jr nz, .getMoveName
	ld hl, wNewBattleFlags			; if it is, set USING_SIGNATURE_MOVE in wNewBattleFlags before calling GetMoveName
	set USING_SIGNATURE_MOVE, [hl]
.getMoveName
	call GetMoveName				; use GetMoveName instead of GetName
	pop de							; restore de after GetMoveName
	ld hl, wNewBattleFlags
	res USING_SIGNATURE_MOVE, [hl]	; reset flag after GetMoveName
	ld hl, wcd6d
.copyNameLoop
	ld a, [hli]
	cp $50
	jr z, .doneCopyingName
	ld [de], a
	inc de
	jr .copyNameLoop
.doneCopyingName
	ld a, b
	ld [wNumMovesMinusOne], a
	inc b
	ld a, $4e ; line break
	ld [de], a
	inc de
	pop hl
	ld a, b
	cp NUM_MOVES
	jr z, .done
	jr .printMoveNameLoop
.printDashLoop
	ld a, "-"
	ld [de], a
	inc de
	inc b
	ld a, b
	cp NUM_MOVES
	jr z, .done
	ld a, $4e ; line break
	ld [de], a
	inc de
	jr .printDashLoop
.done
	ld a, "@"
	ld [de], a
	ret
	
; XXX this is called in a few places, but it doesn't appear to do anything useful
InitList:
	ld a, [wInitListType]
	cp INIT_ENEMYOT_LIST
	jr nz, .notEnemy
	ld hl, wEnemyPartyCount
	ld de, wEnemyMonOT
	ld a, ENEMYOT_NAME
	jr .done
.notEnemy
	cp INIT_PLAYEROT_LIST
	jr nz, .notPlayer
	ld hl, wPartyCount
	ld de, wPartyMonOT
	ld a, PLAYEROT_NAME
	jr .done
.notPlayer
	cp INIT_MON_LIST
	jr nz, .notMonster
	ld hl, wItemList
	ld de, MonsterNames
	ld a, MONSTER_NAME
	jr .done
.notMonster
	cp INIT_BAG_ITEM_LIST
	jr nz, .notBag
	ld hl, wNumBagItems
	ld de, ItemNames
	ld a, ITEM_NAME
	jr .done
.notBag
	ld hl, wItemList
	ld de, ItemNames
	ld a, ITEM_NAME
.done
	ld [wNameListType], a
	ld a, l
	ld [wListPointer], a
	ld a, h
	ld [wListPointer + 1], a
	ld bc, ItemPrices
	ld a, c
	ld [wItemPrices], a
	ld a, b
	ld [wItemPrices + 1], a
	ret

; get species of mon e in list [wMonDataLocation] for LoadMonData
GetMonSpecies:
	ld hl, wPartySpecies
	ld a, [wMonDataLocation]
	and a
	jr z, .getSpecies
	dec a
	jr z, .enemyParty
	ld hl, wBoxSpecies
	jr .getSpecies
.enemyParty
	ld hl, wEnemyPartyMons
.getSpecies
	ld d, 0
	add hl, de
	add hl, de						; to handle 2 bytes species IDs
	ld a, [hli]						; to handle 2 bytes species IDs
	ld [wMonSpeciesTemp], a			; to handle 2 bytes species IDs
	ld a, [hl]						; to handle 2 bytes species IDs
	ld [wMonSpeciesTemp + 1], a		; to handle 2 bytes species IDs
	ret

; moved out of bank F
_AnyPartyAlive:
	ld a, [wPartyCount]
	ld e, a
	xor a
	ld hl, wPartyMon1HP
	ld bc, wPartyMon2 - wPartyMon1 - 1
.partyMonsLoop
	or [hl]
	inc hl
	or [hl]
	add hl, bc
	dec e
	jr nz, .partyMonsLoop
	ld d, a
	ret

; moved out of bank F
_HasMonFainted:
	ld a, [wWhichPokemon]
	ld hl, wPartyMon1HP
	ld bc, wPartyMon2 - wPartyMon1
	call AddNTimes
	ld a, [hli]
	or [hl]
	ret nz
	ld a, [wFirstMonsNotOutYet]
	and a
	jr nz, .done
	ld hl, NoWillText
	call PrintText
.done
	xor a
	ret

; moved out of bank F
NoWillText:
	TX_FAR _NoWillText
	db "@"

; moved out of bank F
_CopyPlayerMonCurHPAndStatusFromBattleToParty:
	ld a, [wPlayerMonNumber]
	ld hl, wPartyMon1HP
	ld bc, wPartyMon2 - wPartyMon1
	call AddNTimes
	ld d, h
	ld e, l
	ld hl, wBattleMonHP
	ld bc, (wBattleMonStatus + 1) - wBattleMonHP
	jp CopyData										; copy current HP and status from battle data to party data

; moved out of bank F
_CheckPlayerSwitchAllowed:
	ld hl, wBattleMonType
	ld a, [hli]						; check type 1
	cp GHOST
	ret z							; GHOST types can't be trapped
	ld a, [hl]						; check type 2
	cp GHOST
	ret z							; GHOST types can't be trapped
	xor a
	ld [H_WHOSETURN], a				; set the turn to the player's turn to display the player's pokemon name in CantSwitchText
	ld hl, wEnemyBattleStatus1
	bit USING_TRAPPING_MOVE, [hl]	; is the pokemon being trapped by Wrap or similar?
	ret nz							; if yes, cannot switch
	ld hl, wPlayerBattleStatus3
	bit TRAPPED, [hl]				; check if pokemon is under the effect of Mean Look
	ret
