; [wPartyMenuTypeOrMessageID] = menu type / message ID
; if less than $F0, it is a menu type
; menu types:
; 00: normal pokemon menu (e.g. Start menu)
; 01: use healing item on pokemon menu
; 02: in-battle switch pokemon menu
; 03: learn TM/HM menu
; 04: swap pokemon positions menu
; 05: use evolution stone on pokemon menu
; 06: use ORIGIN_PLATE
; otherwise, it is a message ID
; f0: poison healed
; f1: burn healed
; f2: freeze healed
; f3: sleep healed
; f4: paralysis healed
; f5: HP healed
; f6: health returned
; f7: revitalized
; f8: leveled up
DrawPartyMenu_:
	xor a
	ld [H_AUTOBGTRANSFERENABLED], a
	call ClearScreen
	call UpdateSprites
	callba LoadMonPartySpriteGfxWithLCDDisabled ; load pokemon icon graphics

RedrawPartyMenu_:
	ld a, [wPartyMenuTypeOrMessageID]
	cp SWAP_MONS_PARTY_MENU
	jp z, .printMessage
	call ErasePartyMenuCursors
	callba InitPartyMenuBlkPacket
	coord hl, 3, 0
	ld de, wPartySpecies
	xor a
	ld c, a
	ld [hPartyMonIndex], a
	ld [wWhichPartyMenuHPBar], a
.loop
	ld a, [de]
	cp $FF ; reached the terminator?
	jp z, .afterDrawingMonEntries
	push bc
	push de
	push hl
	ld a, c
	push hl
	ld hl, wPartyMonNicks
	call GetPartyMonName
	pop hl
	call PlaceString ; print the pokemon's name
	callba WriteMonPartySpriteOAMByPartyIndex ; place the appropriate pokemon icon
	ld a, [hPartyMonIndex]
	ld [wWhichPokemon], a
	inc a
	ld [hPartyMonIndex], a
	call LoadMonData
	pop hl
	push hl
	ld a, [wMenuItemToSwap]
	and a ; is the player swapping pokemon positions?
	jr z, .skipUnfilledRightArrow
; if the player is swapping pokemon positions
	dec a
	ld b, a
	ld a, [wWhichPokemon]
	cp b ; is the player swapping the current pokemon in the list?
	jr nz, .skipUnfilledRightArrow
; the player is swapping the current pokemon in the list
	dec hl
	dec hl
	dec hl
	ld a, "▷" ; unfilled right arrow menu cursor
	ld [hli], a ; place the cursor
	inc hl
	inc hl
.skipUnfilledRightArrow
	ld a, [wPartyMenuTypeOrMessageID] ; menu type
	cp ORIGIN_PLATE_PARTY_MENU
	jp z, .originPlateMenu
	cp TMHM_PARTY_MENU
	jr z, .teachMoveMenu
	cp EVO_STONE_PARTY_MENU
	jp z, .evolutionStoneMenu
	push hl
	ld bc, 14 ; 14 columns to the right
	add hl, bc
	ld de, wLoadedMonStatus
	call PrintStatusCondition
	pop hl
	push hl
	ld bc, SCREEN_WIDTH + 1 ; down 1 row and right 1 column
	ld a, [hFlags_0xFFF6]
	set 0, a
	ld [hFlags_0xFFF6], a
	add hl, bc
	predef DrawHP2 ; draw HP bar and prints current / max HP
	ld a, [hFlags_0xFFF6]
	res 0, a
	ld [hFlags_0xFFF6], a
	call SetPartyMenuHPBarColor ; color the HP bar (on SGB)
	pop hl
	jr .printLevel
.originPlateMenu
	push hl
	ld hl, wLoadedMonSpecies
	ld a, [hli]
	ld [wMonSpeciesTemp], a
	ld a, [hl]
	ld [wMonSpeciesTemp + 1], a
	call GetMonHeader				; read base stats to get the DEX number instead of the species ID, which is always the same for all ARCEUS forms
	ld a, [wMonHIndex]
	ld b, a
	ld a, [wMonHIndex + 1]
	ld c, a
	ld hl, DEX_ARCEUS
	call CompareBCtoHL
	pop hl
	ld c, 1							; indicates the item is compatible
	jr z, .determineWhichString		; if the mon is ARCEUS, jump
	ld c, 0							; indicates the item is not compatible
	jr .determineWhichString
.teachMoveMenu
	push hl
	predef CanLearnTM ; check if the pokemon can learn the move
	pop hl
.determineWhichString
	ld de, .ableToLearnMoveText
	ld a, c
	and a
	jr nz, .placeMoveLearnabilityString
	ld de, .notAbleToLearnMoveText
.placeMoveLearnabilityString
	ld bc, 20 + 9 ; down 1 row and right 9 columns
	push hl
	add hl, bc
	call PlaceString
	pop hl
.printLevel
	ld bc, 10 ; move 10 columns to the right
	add hl, bc
	call PrintLevel
	pop hl
	pop de
	inc de
	inc de						; to handle 2 bytes species IDs
	ld bc, 2 * 20
	add hl, bc
	pop bc
	inc c
	jp .loop
.ableToLearnMoveText
	db "ABLE@"
.notAbleToLearnMoveText
	db "NOT ABLE@"
.evolutionStoneMenu
	push hl
	ld hl, EvosMovesPointerTable
	ld a, [wLoadedMonSpecies]
	ld b, a
	ld a, [wLoadedMonSpecies + 1]
	ld c, a							; to handle 2 bytes species IDs
	dec bc
	add hl, bc
	add hl, bc
	ld de, wEvosMoves
	ld a, BANK(EvosMovesPointerTable)
	ld bc, 2
	call FarCopyData
	ld hl, wEvosMoves
	ld a, [hli]
	ld h, [hl]
	ld l, a
	push hl
; loop through the pokemon's evolution entries
.checkEvolutionsLoop
	ld a, BANK(EvosMovesPointerTable)
	ld de, wEvosMoves
	ld bc, wEvosMoves.end - wEvosMoves
	call FarCopyData
	ld hl, wEvosMoves
	ld de, .notAbleToEvolveText
	ld a, [hli]
	and a ; reached terminator?
	jr z, .placeEvolutionStoneString ; if so, place the "NOT ABLE" string
	cp EV_ITEM
	jr z, .stoneEvoEntry
.nextEvoEntry
	ld a, [hli]
	cp $ff							; skip list of Evolution moves at the end of evolution entry
	jr nz, .nextEvoEntry
	ld bc, wEvosMoves				; we need to advance the cursor in the far bank by however many bytes were read
	ld a, l							; to do that, we need to compute how many bytes were read
	sub c							; so we subtract wEvosMoves from hl and put the result in bc
	ld c, a
	jr nc, .noCarry
	inc b
.noCarry
	ld a, h
	sub b
	ld b, a							; then we must add that value to the saved position in the far bank
	pop hl							; restore the position we were at in the far bank
	add hl, bc						; add the number of bytes that were read during this iteration
	push hl							; save the new position
	jr .checkEvolutionsLoop
.stoneEvoEntry
; if it's a stone evolution entry
	ld b, [hl]
	ld a, [wEvoStoneItemID]			; the stone the player used
	cp b							; does the player's stone match this evolution entry's stone?
	jr nz, .nextEvoEntry
; if it does match
	ld de, .ableToEvolveText
.placeEvolutionStoneString
	pop hl							; just to drain the stack
	ld bc, 20 + 9					; down 1 row and right 9 columns
	pop hl
	push hl
	add hl, bc
	call PlaceString
	pop hl
	jp .printLevel
.ableToEvolveText
	db "ABLE@"
.notAbleToEvolveText
	db "NOT ABLE@"
.afterDrawingMonEntries
	ld b, SET_PAL_PARTY_MENU
	call RunPaletteCommand
.printMessage
	ld hl, wd730
	ld a, [hl]
	push af
	push hl
	set 6, [hl] ; turn off letter printing delay
	ld a, [wPartyMenuTypeOrMessageID] ; message ID
	cp $F0
	jr nc, .printItemUseMessage
	add a
	ld hl, PartyMenuMessagePointers
	ld b, 0
	ld c, a
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call PrintText
.done
	pop hl
	pop af
	ld [hl], a
	ld a, 1
	ld [H_AUTOBGTRANSFERENABLED], a
	call Delay3
	jp GBPalNormal
.printItemUseMessage
	and $0F
	ld hl, PartyMenuItemUseMessagePointers
	add a
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	push hl
	call WaitForSoundToFinish		; need that for VisualBoyAdvance, otherwise it gets stuck in an infinite loop waiting for the 'plink' sound to finish when
									; using a rare candy and the SFX_GET_ITEM_1 plays right after (VBA goes too fast apparently and it messes up the sound engine)
	ld a, [wUsedItemOnWhichPokemon]
	ld hl, wPartyMonNicks
	call GetPartyMonName
	pop hl
	call PrintText
	jr .done

PartyMenuItemUseMessagePointers:
	dw AntidoteText
	dw BurnHealText
	dw IceHealText
	dw AwakeningText
	dw ParlyzHealText
	dw PotionText
	dw FullHealText
	dw ReviveText
	dw RareCandyText

PartyMenuMessagePointers:
	dw PartyMenuNormalText
	dw PartyMenuItemUseText
	dw PartyMenuBattleText
	dw PartyMenuUseTMText
	dw PartyMenuSwapMonText
	dw PartyMenuItemUseText
	dw PartyMenuItemUseText		; for ORIGIN_PLATE menu

PartyMenuNormalText:
	TX_FAR _PartyMenuNormalText
	db "@"

PartyMenuItemUseText:
	TX_FAR _PartyMenuItemUseText
	db "@"

PartyMenuBattleText:
	TX_FAR _PartyMenuBattleText
	db "@"

PartyMenuUseTMText:
	TX_FAR _PartyMenuUseTMText
	db "@"

PartyMenuSwapMonText:
	TX_FAR _PartyMenuSwapMonText
	db "@"

PotionText:
	TX_FAR _PotionText
	db "@"

AntidoteText:
	TX_FAR _AntidoteText
	db "@"

ParlyzHealText:
	TX_FAR _ParlyzHealText
	db "@"

BurnHealText:
	TX_FAR _BurnHealText
	db "@"

IceHealText:
	TX_FAR _IceHealText
	db "@"

AwakeningText:
	TX_FAR _AwakeningText
	db "@"

FullHealText:
	TX_FAR _FullHealText
	db "@"

ReviveText:
	TX_FAR _ReviveText
	db "@"

RareCandyText:
	TX_FAR _RareCandyText
	TX_SFX_ITEM_1 ; probably supposed to play SFX_LEVEL_UP but the wrong music bank is loaded
	TX_BLINK
	db "@"

SetPartyMenuHPBarColor:
	ld hl, wPartyMenuHPBarColors
	ld a, [wWhichPartyMenuHPBar]
	ld c, a
	ld b, 0
	add hl, bc
	call GetHealthBarColor
	ld b, UPDATE_PARTY_MENU_BLK_PACKET
	call RunPaletteCommand
	ld hl, wWhichPartyMenuHPBar
	inc [hl]
	ret
