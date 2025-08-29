ShowPokedexMenu:
	call GBPalWhiteOut
	call ClearScreen
	call UpdateSprites
	ld a, [wListScrollOffset]
	push af
	xor a
	ld [wCurrentMenuItem], a
	ld [wListScrollOffset], a
	ld [wListScrollOffset+1], a				; to handle pokedex with more than 255 entries
	ld [wLastMenuItem], a
	inc a
	ld [wd11e], a
	ld [hJoy7], a
.setUpGraphics
	ld b, SET_PAL_GENERIC
	call RunPaletteCommand
	callab LoadPokedexTilePatterns
.doPokemonListMenu
	ld hl, wTopMenuItemY
	ld a, 3
	ld [hli], a ; top menu item Y
	xor a
	ld [hli], a ; top menu item X
	inc a
	ld [wMenuWatchMovingOutOfBounds], a
	inc hl
	inc hl
	ld a, 6
	ld [hli], a								; max menu item ID
	ld [hl], D_LEFT | D_RIGHT | B_BUTTON | A_BUTTON
	call HandlePokedexListMenu
	jr c, .goToSideMenu						; if the player chose a pokemon from the list
.exitPokedex
	xor a
	ld [wMenuWatchMovingOutOfBounds], a
	ld [wCurrentMenuItem], a
	ld [wLastMenuItem], a
	ld [hJoy7], a
	ld [wWastedByteCD3A], a
	ld [wOverrideSimulatedJoypadStatesMask], a
	pop af
	ld [wListScrollOffset], a
	call GBPalWhiteOutWithDelay3
	call RunDefaultPaletteCommand
	jp ReloadMapData
.goToSideMenu
	call HandlePokedexSideMenu
	dec b
	jr z, .exitPokedex ; if the player chose Quit
	dec b
	jr z, .doPokemonListMenu ; if pokemon not seen or player pressed B button
	jp .setUpGraphics ; if pokemon data or area was shown

; handles the menu on the lower right in the pokedex screen
; OUTPUT:
; b = reason for exiting menu
; 00: showed pokemon data or area
; 01: the player chose Quit
; 02: the pokemon has not been seen yet or the player pressed the B button
HandlePokedexSideMenu:
	call PlaceUnfilledArrowMenuCursor
	ld a, [wCurrentMenuItem]
	push af
	ld e, a								; to handle 2 bytes species IDs
	ld a, [wLastMenuItem]
	push af
	ld a, [wListScrollOffset]
	ld h, a								; to handle 2 bytes species IDs
	ld a, [wListScrollOffset+1]			; to handle 2 bytes species IDs
	ld l, a								; to handle 2 bytes species IDs
	ld d, $00							; to handle 2 bytes species IDs
	add hl, de							; to handle 2 bytes species IDs
	inc hl								; to handle 2 bytes species IDs
	ld a, h								; to handle 2 bytes species IDs
	ld [wMonDexNumber], a				; to handle 2 bytes species IDs
	ld a, l								; to handle 2 bytes species IDs
	ld [wMonDexNumber+1], a				; to handle 2 bytes species IDs
	callab CheckPokedexSeen				; to handle 2 bytes species IDs
	ld b, 2
	jr z, .exitSideMenu
	ld hl, wTopMenuItemY
	ld a, 10
	ld [hli], a ; top menu item Y
	ld a, 15
	ld [hli], a ; top menu item X
	xor a
	ld [hli], a ; current menu item ID
	inc hl
	ld a, 3
	ld [hli], a ; max menu item ID
	;ld a, A_BUTTON | B_BUTTON
	ld [hli], a							; menu watched keys (A button and B button)
	xor a
	ld [hli], a							; old menu item ID
	ld [wMenuWatchMovingOutOfBounds], a
.handleMenuInput
	call HandleMenuInput
	bit 1, a ; was the B button pressed?
	ld b, 2
	jr nz, .buttonBPressed
	ld a, [wCurrentMenuItem]
	and a
	jr z, .choseData
	dec a
	jr z, .choseCry
	dec a
	jr z, .choseArea
.choseQuit
	ld b, 1
.exitSideMenu
	pop af
	ld [wLastMenuItem], a
	pop af
	ld [wCurrentMenuItem], a
	push bc
	coord hl, 0, 3
	ld de, 20
	lb bc, " ", 13
	call DrawTileLine ; cover up the menu cursor in the pokemon list
	pop bc
	ret

.buttonBPressed
	push bc
	coord hl, 15, 10
	ld de, 20
	lb bc, " ", 7
	call DrawTileLine ; cover up the menu cursor in the side menu
	pop bc
	jr .exitSideMenu

.choseData
	call ShowPokedexDataInternal
	ld b, 0
	jr .exitSideMenu

; play pokemon cry
.choseCry
	ld a, [wMonDexNumber]
	ld b, a							; to handle 2 bytes species IDs
	ld a, [wMonDexNumber+1]			; to handle 2 bytes species IDs
	ld c, a							; to handle 2 bytes species IDs
	call PlayCryFromDexNumber		; to handle new cries
	jr .handleMenuInput

.choseArea
	predef LoadTownMap_Nest			; display pokemon areas
	ld b, 0
	jr .exitSideMenu

; handles the list of pokemon on the left of the pokedex screen
; sets carry flag if player presses A, unsets carry flag if player presses B
HandlePokedexListMenu:
	xor a
	ld [H_AUTOBGTRANSFERENABLED], a
; draw the horizontal line separating the seen and owned amounts from the menu
	coord hl, 15, 8
	ld a, "─"
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	coord hl, 14, 0
	ld [hl], $71							; vertical line tile
	coord hl, 14, 1
	call DrawPokedexVerticalLine
	coord hl, 14, 9
	call DrawPokedexVerticalLine
	ld hl, wPokedexSeen
	ld b, wPokedexSeenEnd - wPokedexSeen
	call CountSetBits_16bits				; made a 2 bytes version of this function to count beyond 255
	ld de, wNumSetBits_16bits
	coord hl, 16, 3
	lb bc, 2, 3
	call PrintNumber						; print number of seen pokemon
	ld hl, wPokedexOwned
	ld b, wPokedexOwnedEnd - wPokedexOwned
	call CountSetBits_16bits				; made a 2 bytes version of this function to count beyond 255
	ld de, wNumSetBits_16bits
	coord hl, 16, 6
	lb bc, 2, 3
	call PrintNumber						; print number of owned pokemon
	coord hl, 16, 2
	ld de, PokedexSeenText
	call PlaceString
	coord hl, 16, 5
	ld de, PokedexOwnText
	call PlaceString
	coord hl, 1, 1
	ld de, PokedexContentsText
	call PlaceString
	coord hl, 16, 10
	ld de, PokedexMenuItemsText
	call PlaceString
; find the highest pokedex number among the pokemon the player has seen
	ld hl, wPokedexSeenEnd - 1
	ld bc, (wPokedexSeenEnd - wPokedexSeen) * 8 + 1	; to handle 2 bytes species IDs
.maxSeenPokemonLoop
	ld a, [hld]
	ld d, 8								; to handle 2 bytes species IDs
.maxSeenPokemonInnerLoop
	dec bc								; to handle 2 bytes species IDs
	sla a
	jr c, .storeMaxSeenPokemon
	dec d								; to handle 2 bytes species IDs
	jr nz, .maxSeenPokemonInnerLoop
	jr .maxSeenPokemonLoop

.storeMaxSeenPokemon
	ld a, b
	ld [wDexMaxSeenMon], a
	ld a, c								; to handle 2 bytes species IDs
	ld [wDexMaxSeenMon+1], a			; to handle 2 bytes species IDs
.loop
	xor a
	ld [H_AUTOBGTRANSFERENABLED], a
	coord hl, 4, 2
	lb bc, 14, 10
	call ClearScreenArea
	coord hl, 1, 3
	ld a, [wListScrollOffset]			; to handle 2 bytes species IDs
	ld [wMonDexNumber], a				; to handle 2 bytes species IDs
	ld a, [wListScrollOffset+1]			; to handle 2 bytes species IDs
	ld [wMonDexNumber+1], a				; to handle 2 bytes species IDs
	ld d, 7								; number of entries per page
	ld a, [wDexMaxSeenMon]
	and a								; check high byte of wDexMaxSeenMon
	jr nz, .printPokemonLoop			; if high byte is not null, no need to check low byte
	ld a, [wDexMaxSeenMon+1]			; to handle 2 bytes species IDs
	cp 7
	jr nc, .printPokemonLoop
	ld d, a
	dec a
	ld [wMaxMenuItem], a				; if max dex number of seen mon is <7, set a max item index for the dex menu
; loop to print pokemon pokedex numbers and names
; if the player has owned the pokemon, it puts a pokeball beside the name
.printPokemonLoop
	ld a, [wMonDexNumber]				; to handle 2 bytes species IDs
	ld b, a								; to handle 2 bytes species IDs
	ld a, [wMonDexNumber+1]				; to handle 2 bytes species IDs
	ld c, a								; to handle 2 bytes species IDs
	inc bc								; to handle 2 bytes species IDs
	ld a, b								; to handle 2 bytes species IDs
	ld [wMonDexNumber], a				; to handle 2 bytes species IDs
	ld a, c								; to handle 2 bytes species IDs
	ld [wMonDexNumber+1], a				; to handle 2 bytes species IDs
	push de
	push hl
	ld de, -SCREEN_WIDTH
	add hl, de
	ld de, wMonDexNumber
	lb bc, LEADING_ZEROES | 2, 3
	call PrintNumber					; print the pokedex number
	ld de, SCREEN_WIDTH
	add hl, de
	dec hl
	push hl
	callab CheckPokedexOwned			; to handle 2 bytes species IDs
	pop hl
	ld a, " "
	jr z, .writeTile
	ld a, $72							; pokeball tile
.writeTile
	ld [hl], a							; put a pokeball next to pokemon that the player has owned
	push hl
	callab CheckPokedexSeen				; to handle 2 bytes species IDs
	jr nz, .getPokemonName				; if the player has seen the pokemon
	ld de, .dashedLine					; print a dashed line in place of the name if the player hasn't seen the pokemon
	jr .skipGettingName
.dashedLine								; for unseen pokemon in the list
	db "----------@"
.getPokemonName
	call GetMonNameByDexNumber
.skipGettingName
	pop hl
	inc hl
	call PlaceString
	pop hl
	ld bc, 2 * SCREEN_WIDTH
	add hl, bc
	pop de
	dec d								; here d contains the number of entries left to process for this page/loop
	jr nz, .printPokemonLoop
	ld a, 01
	ld [H_AUTOBGTRANSFERENABLED], a
	call Delay3
	call GBPalNormal
	call HandleMenuInput
	bit 1, a							; was the B button pressed?
	jp nz, .buttonBPressed
	bit BIT_D_UP, a
	jr z, .checkIfDownPressed
.upPressed								; scroll up one row
	ld a, [wListScrollOffset]
	ld b, a								; to handle the fact that we use 2 bytes for this variable here
	ld a, [wListScrollOffset+1]			; to handle the fact that we use 2 bytes for this variable here
	ld c, a								; to handle the fact that we use 2 bytes for this variable here
	or b								; to handle the fact that we use 2 bytes for this variable here
	jp z, .loop
	dec bc								; to handle the fact that we use 2 bytes for this variable here
	ld a, b								; to handle the fact that we use 2 bytes for this variable here
	ld [wListScrollOffset], a
	ld a, c								; to handle the fact that we use 2 bytes for this variable here
	ld [wListScrollOffset+1], a			; to handle the fact that we use 2 bytes for this variable here
	jp .loop
.checkIfDownPressed
	bit BIT_D_DOWN, a
	jr z, .checkIfRightPressed
.downPressed							; scroll down one row
	push hl								; to handle 2 bytes species IDs
	ld a, [wDexMaxSeenMon]
	ld h, a								; to handle 2 bytes species IDs
	ld a, [wDexMaxSeenMon+1]			; to handle 2 bytes species IDs
	ld l, a								; to handle 2 bytes species IDs
	ld de, -6							; only subtract 6 because now we check for no carry, so equality also passes
	add hl, de							; to handle 2 bytes species IDs
	ld b, h								; to handle 2 bytes species IDs
	ld c, l								; to handle 2 bytes species IDs
	pop hl								; to handle 2 bytes species IDs
	jp nc, .loop						; if list is shorter than 7, can't scroll down
	dec bc								; we need to subtract one more to get to wDexMaxSeenMon -7
	push hl								; to handle 2 bytes species IDs
	ld a, [wListScrollOffset]
	ld h, a								; to handle 2 bytes species IDs
	ld a, [wListScrollOffset+1]			; to handle 2 bytes species IDs
	ld l, a								; to handle 2 bytes species IDs
	call CompareBCtoHL					; to handle 2 bytes species IDs
	ld d, h								; to handle 2 bytes species IDs
	ld e, l								; to handle 2 bytes species IDs
	pop hl								; to handle 2 bytes species IDs
	jp z, .loop
	inc de								; to handle 2 bytes species IDs
	ld a, d								; to handle 2 bytes species IDs
	ld [wListScrollOffset], a
	ld a, e								; to handle 2 bytes species IDs
	ld [wListScrollOffset+1], a			; to handle 2 bytes species IDs
	jp .loop
.checkIfRightPressed
	bit BIT_D_RIGHT, a
	jr z, .checkIfLeftPressed
.rightPressed							; scroll down 7 rows
	push hl								; to handle 2 bytes species IDs
	ld a, [wDexMaxSeenMon]
	ld h, a								; to handle 2 bytes species IDs
	ld a, [wDexMaxSeenMon+1]			; to handle 2 bytes species IDs
	ld l, a								; to handle 2 bytes species IDs
	ld de, -6							; only subtract 6 because now we check for no carry, so equality also passes
	add hl, de							; to handle 2 bytes species IDs
	ld b, h								; to handle 2 bytes species IDs
	ld c, l								; to handle 2 bytes species IDs
	pop hl								; to handle 2 bytes species IDs
	jp nc, .loop						; if list is shorter than 7, can't scroll down
	dec bc								; to handle 2 bytes species IDs
	push hl								; to handle 2 bytes species IDs
	ld a, [wListScrollOffset]
	ld h, a								; to handle 2 bytes species IDs
	ld a, [wListScrollOffset+1]			; to handle 2 bytes species IDs
	ld l, a								; to handle 2 bytes species IDs
	ld de, $0007						; to handle 2 bytes species IDs
	add hl, de							; to handle 2 bytes species IDs
	ld a, h								; to handle 2 bytes species IDs
	ld [wListScrollOffset], a
	ld a, l								; to handle 2 bytes species IDs
	ld [wListScrollOffset+1], a			; to handle 2 bytes species IDs
	call CompareBCtoHL					; to handle 2 bytes species IDs
	pop hl								; to handle 2 bytes species IDs
	jp nc, .loop
	ld a, b
	ld [wListScrollOffset], a
	ld a, c								; to handle 2 bytes species IDs
	ld [wListScrollOffset+1], a			; to handle 2 bytes species IDs
	jp .loop
.checkIfLeftPressed						; scroll up 7 rows
	bit BIT_D_LEFT, a
	jr z, .buttonAPressed
.leftPressed
	push hl								; to handle 2 bytes species IDs
	ld a, [wListScrollOffset]
	ld h, a								; to handle the fact that we use 2 bytes for this variable here
	ld a, [wListScrollOffset+1]			; to handle the fact that we use 2 bytes for this variable here
	ld l, a								; to handle the fact that we use 2 bytes for this variable here
	ld de, -7							; to handle the fact that we use 2 bytes for this variable here
	add hl, de							; to handle the fact that we use 2 bytes for this variable here
	ld b, h								; to handle the fact that we use 2 bytes for this variable here
	ld c, l								; to handle the fact that we use 2 bytes for this variable here
	pop hl								; to handle the fact that we use 2 bytes for this variable here
	ld a, b								; to handle the fact that we use 2 bytes for this variable here
	ld [wListScrollOffset], a
	ld a, c								; to handle the fact that we use 2 bytes for this variable here
	ld [wListScrollOffset+1], a			; to handle the fact that we use 2 bytes for this variable here
	jp c, .loop							; since we're doing an addition instead of a subtraction now, we need to reverse the carry check
	xor a
	ld [wListScrollOffset], a
	ld [wListScrollOffset+1], a			; to handle the fact that we use 2 bytes for this variable here
	jp .loop
.buttonAPressed
	scf
	ret
.buttonBPressed
	and a
	ret

DrawPokedexVerticalLine:
	ld c, 9 ; height of line
	ld de, SCREEN_WIDTH
	ld a, $71 ; vertical line tile
.loop
	ld [hl], a
	add hl, de
	xor 1 ; toggle between vertical line tile and box tile
	dec c
	jr nz, .loop
	ret

PokedexSeenText:
	db "SEEN@"

PokedexOwnText:
	db "OWN@"

PokedexContentsText:
	db "CONTENTS@"

PokedexMenuItemsText:
	db   "DATA"
	next "CRY"
	next "AREA"
	next "QUIT@"

; function to display pokedex data from outside the pokedex
ShowPokedexData:
	call GBPalWhiteOutWithDelay3
	call ClearScreen
	call UpdateSprites
	callab LoadPokedexTilePatterns ; load pokedex tiles

; function to display pokedex data from inside the pokedex
ShowPokedexDataInternal:
	ld hl, wd72c
	set 1, [hl]
	ld a, $33 ; 3/7 volume
	ld [rNR50], a
	call GBPalWhiteOut ; zero all palettes
	call ClearScreen
	ld b, SET_PAL_POKEDEX
	call RunPaletteCommand

	ld a, [hTilesetType]
	push af
	xor a
	ld [hTilesetType], a

	coord hl, 0, 0
	ld de, 1
	lb bc, $64, SCREEN_WIDTH
	call DrawTileLine ; draw top border

	coord hl, 0, 17
	ld b, $6f
	call DrawTileLine ; draw bottom border

	coord hl, 0, 1
	ld de, 20
	lb bc, $66, $10
	call DrawTileLine ; draw left border

	coord hl, 19, 1
	ld b, $67
	call DrawTileLine ; draw right border

	ld a, $63 ; upper left corner tile
	Coorda 0, 0
	ld a, $65 ; upper right corner tile
	Coorda 19, 0
	ld a, $6c ; lower left corner tile
	Coorda 0, 17
	ld a, $6e ; lower right corner tile
	Coorda 19, 17

	coord hl, 0, 9
	ld de, PokedexDataDividerLine
	call PlaceString ; draw horizontal divider line

	coord hl, 9, 6
	ld de, HeightWeightText
	call PlaceString

	call GetMonNameByDexNumber
	coord hl, 9, 2
	call PlaceString

	ld hl, PokedexEntryPointers
	ld a, [wMonDexNumber]				; to handle 2 bytes species IDs
	ld d, a								; to handle 2 bytes species IDs
	ld a, [wMonDexNumber + 1]			; to handle 2 bytes species IDs
	ld e, a								; to handle 2 bytes species IDs
	dec de								; to handle 2 bytes species IDs
	add hl, de
	add hl, de
	ld a, [hli]
	ld e, a
	ld d, [hl] ; de = address of pokedex entry

	coord hl, 9, 4
	call PlaceString ; print species name

	ld h, b
	ld l, c
	push de

	coord hl, 2, 8
	ld a, "№"
	ld [hli], a
	ld a, "⠄"
	ld [hli], a
	ld de, wMonDexNumber			; to handle 2 bytes species IDs
	lb bc, LEADING_ZEROES | 2, 3	; to handle 2 bytes species IDs
	call PrintNumber ; print pokedex number

	pop de

	push af
	push bc
	push de
	push hl

	call Delay3
	call GBPalNormal
	ld a, [wMonDexNumber]
	ld h, a
	ld a, [wMonDexNumber + 1]
	ld l, a
	dec hl
	add hl, hl
	ld d, h
	ld e, l
	callab GetSpeciesIDFromDexNumber
	call GetMonHeader
	coord hl, 1, 1
	call LoadFlippedFrontSpriteByMonIndex ; draw pokemon picture
	ld a, [wMonDexNumber]				; to handle 2 bytes species IDs
	ld b, a								; to handle 2 bytes species IDs
	ld a, [wMonDexNumber + 1]			; to handle 2 bytes species IDs
	ld c, a								; to handle 2 bytes species IDs
	call PlayCryFromDexNumber			; to handle species with multiple forms

	pop hl
	pop de
	pop bc
	pop af

	push de
	callab CheckPokedexOwned		; to handle 2 bytes species IDs
	pop de
	jp z, .waitForButtonPress ; if the pokemon has not been owned, don't print the height, weight, or description
	inc de ; de = address of feet (height)
	ld a, [de] ; reads feet, but a is overwritten without being used
	coord hl, 12, 6
	lb bc, 1, 2
	call PrintNumber ; print feet (height)
	ld a, $60 ; feet symbol tile (one tick)
	ld [hl], a
	inc de
	inc de ; de = address of inches (height)
	coord hl, 15, 6
	lb bc, LEADING_ZEROES | 1, 2
	call PrintNumber ; print inches (height)
	ld a, $61 ; inches symbol tile (two ticks)
	ld [hl], a
; now print the weight (note that weight is stored in tenths of pounds internally)
	inc de
	inc de
	inc de ; de = address of upper byte of weight
	push de
; put weight in big-endian order at hDexWeight
	ld hl, hDexWeight
	ld a, [hl] ; save existing value of [hDexWeight]
	push af
	ld a, [de] ; a = upper byte of weight
	ld [hli], a ; store upper byte of weight in [hDexWeight]
	ld a, [hl] ; save existing value of [hDexWeight + 1]
	push af
	dec de
	ld a, [de] ; a = lower byte of weight
	ld [hl], a ; store lower byte of weight in [hDexWeight + 1]
	ld de, hDexWeight
	coord hl, 11, 8
	lb bc, 2, 5 ; 2 bytes, 5 digits
	call PrintNumber ; print weight
	coord hl, 14, 8
	ld a, [hDexWeight + 1]
	sub 10
	ld a, [hDexWeight]
	sbc 0
	jr nc, .next
	ld [hl], "0" ; if the weight is less than 10, put a 0 before the decimal point
.next
	inc hl
	ld a, [hli]
	ld [hld], a ; make space for the decimal point by moving the last digit forward one tile
	ld [hl], "⠄" ; decimal point tile
	pop af
	ld [hDexWeight + 1], a ; restore original value of [hDexWeight + 1]
	pop af
	ld [hDexWeight], a ; restore original value of [hDexWeight]
	pop hl
	inc hl ; hl = address of pokedex description text
	coord bc, 1, 11
	ld a, 2
	ld [$fff4], a
	call TextCommandProcessor ; print pokedex description text
	xor a
	ld [$fff4], a
.waitForButtonPress
	call JoypadLowSensitivity
	ld a, [hJoy5]
	and A_BUTTON | B_BUTTON
	jr z, .waitForButtonPress
	pop af
	ld [hTilesetType], a
	call GBPalWhiteOut
	call ClearScreen
	call RunDefaultPaletteCommand
	call LoadTextBoxTilePatterns
	call GBPalNormal
	ld hl, wd72c
	res 1, [hl]
	ld a, $77 ; max volume
	ld [rNR50], a
	ret

HeightWeightText:
	db   "HT  ?",$60,"??",$61
	next "WT   ???lb@"

; XXX does anything point to this?
PokeText:
	db "#@"

; horizontal line that divides the pokedex text description from the rest of the data
PokedexDataDividerLine:
	db $68,$69,$6B,$69,$6B
	db $69,$6B,$69,$6B,$6B
	db $6B,$6B,$69,$6B,$69
	db $6B,$69,$6B,$69,$6A
	db "@"

; draws a line of tiles
; INPUT:
; b = tile ID
; c = number of tile ID's to write
; de = amount to destination address after each tile (1 for horizontal, 20 for vertical)
; hl = destination address
DrawTileLine:
	push bc
	push de
.loop
	ld [hl], b
	add hl, de
	dec c
	jr nz, .loop
	pop de
	pop bc
	ret

INCLUDE "data/pokedex_entries.asm"

; function to count how many bits are set in a string of bytes
; with output on 2 bytes to count beyond 255
; INPUT:
; hl = address of string of bytes
; b = length of string of bytes
; OUTPUT:
; [wNumSetBits_16bits]/[wNumSetBits_16bits + 1] = number of set bits (high byte first)
CountSetBits_16bits:
	xor a
	ld c, a
	ld [wNumSetBits_16bits], a
.loop
	ld a, [hli]
	ld e, a
	ld d, 8
.innerLoop ; count how many bits are set in the current byte
	srl e
	ld a, 0
	adc c
	jr nc, .noCarry
	ld a, [wNumSetBits_16bits]
	inc a
	ld [wNumSetBits_16bits], a
	xor a
.noCarry
	ld c, a
	dec d
	jr nz, .innerLoop
	dec b
	jr nz, .loop
	ld a, c
	ld [wNumSetBits_16bits + 1], a
	ret

INCLUDE "data/dex_palettes.asm"		; list of palettes per dex number

; used inside the dex to get the palette according to the dex number instead of the species ID
DeterminePaletteIDWithinPokedex:
	ld a, [wMonDexNumber]
	ld d, a
	ld a, [wMonDexNumber + 1]
	ld e, a
	ld hl, DexPalettes
	add hl, de
	ld d, [hl]
	ret
