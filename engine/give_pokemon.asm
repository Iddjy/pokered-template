_GivePokemon:
; returns success in carry
; and whether the mon was added to the party in [wAddedToParty]
	call EnableAutoTextBoxDrawing
	xor a
	ld [wAddedToParty], a
	ld a, [wPartyCount]
	cp PARTY_LENGTH
	jr c, .addToParty
	ld a, [wNumInBox]
	cp MONS_PER_BOX
	jr nc, .boxFull
; add to box
	call LoadMon
	call SetPokedexOwnedFlag
	callab SendNewMonToBox
	ld hl, wcf4b
	ld a, [wCurrentBoxNum]
	and $7f
	cp 9
	jr c, .singleDigitBoxNum
	sub 9
	ld [hl], "1"
	inc hl
	add "0"
	jr .next
.singleDigitBoxNum
	add "1"
.next
	ld [hli], a
	ld [hl], "@"
	ld hl, SetToBoxText
	call PrintText
	scf
	ret
.boxFull
	ld hl, BoxIsFullText
	call PrintText
	and a
	ret
.addToParty
	call LoadMon
	call SetPokedexOwnedFlag
	call AddPartyMon
	ld a, 1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld [wAddedToParty], a
	scf
	ret

; mutualize this part
LoadMon:
	xor a
	ld [wEnemyBattleStatus3], a
	ld a, [wMonSpeciesTemp]				; to handle 2 bytes species IDs
	ld [wEnemyMonSpecies2], a
	ld a, [wMonSpeciesTemp + 1]			; to handle 2 bytes species IDs
	ld [wEnemyMonSpecies2 + 1], a		; to handle 2 bytes species IDs
	jpab LoadEnemyMonData

SetPokedexOwnedFlag:
	call GetDexNumberBySpeciesID
	call GetMonName
	ld hl, GotMonText
	call PrintText
	callab CheckPokedexOwned
	ret nz
	callab AddToPokedexOwned			; uses wMonDexNumber and wMonDexNumber + 1 as input
	ld hl, NewDexDataAddedText2
	call PrintText
	predef ShowPokedexData
	call ReloadMapData
	jpab AddToPokedexOwned				; to handle 2 bytes species IDs

GotMonText:
	TX_FAR _GotMonText
	TX_SFX_ITEM_1
	db "@"

SetToBoxText:
	TX_FAR _SetToBoxText
	db "@"

BoxIsFullText:
	TX_FAR _BoxIsFullText
	db "@"

; added
NewDexDataAddedText2:
	TX_FAR _ItemUseBallText06
	TX_SFX_DEX_PAGE_ADDED
	TX_BLINK
	db "@"
