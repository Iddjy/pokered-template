DisplayDexRating:
	ld hl, wPokedexSeen
	ld b, wPokedexSeenEnd - wPokedexSeen
	call CountSetBits_16bits							; to handle extended dex
	ld hl, wNumSetBits_16bits							; to handle extended dex
	ld a, [hli]											; to handle extended dex
	ld [hDexRatingNumMonsSeenHigh], a
	ld a, [hl]											; to handle extended dex
	ld [hDexRatingNumMonsSeenLow], a					; to handle extended dex
	ld hl, wPokedexOwned
	ld b, wPokedexOwnedEnd - wPokedexOwned
	call CountSetBits_16bits							; to handle extended dex
	ld hl, wNumSetBits_16bits							; to handle extended dex
	ld a, [hli]											; to handle extended dex
	ld [hDexRatingNumMonsOwnedHigh], a
	ld a, [hl]											; to handle extended dex
	ld [hDexRatingNumMonsOwnedLow], a					; to handle extended dex
	ld hl, DexRatingsTable
.findRating
	ld a, [hli]											; to handle extended dex
	ld c, a
	ld a, [hli]											; to handle extended dex
	ld b, a												; to handle extended dex
	push hl												; to handle extended dex
	ld a, [hDexRatingNumMonsOwnedHigh]
	ld h, a												; to handle extended dex
	ld a, [hDexRatingNumMonsOwnedLow]					; to handle extended dex
	ld l, a												; to handle extended dex
	inc hl
	call CompareBCtoHL									; to handle extended dex
	pop hl												; to handle extended dex
	jr nc, .foundRating
	inc hl
	inc hl
	jr .findRating
.foundRating
	ld a, [hli]
	ld h, [hl]
	ld l, a												; load text pointer into hl
	CheckAndResetEventA EVENT_HALL_OF_FAME_DEX_RATING
	jr nz, .hallOfFame
	push hl
	ld hl, PokedexRatingText_441cc
	call PrintText
	pop hl
	call PrintText
	callba PlayPokedexRatingSfx
	jp WaitForTextScrollButtonPress
.hallOfFame
	ld de, wDexRatingNumMonsSeen
	ld a, [hDexRatingNumMonsSeenHigh]					; to handle extended dex
	ld [de], a
	inc de
	ld a, [hDexRatingNumMonsSeenLow]					; to handle extended dex
	ld [de], a											; to handle extended dex
	inc de												; to handle extended dex
	ld a, [hDexRatingNumMonsOwnedHigh]					; to handle extended dex
	ld [de], a
	inc de
	ld a, [hDexRatingNumMonsOwnedLow]					; to handle extended dex
	ld [de], a											; to handle extended dex
	inc de												; to handle extended dex
.copyRatingTextLoop
	ld a, [hli]
	cp "@"
	jr z, .doneCopying
	ld [de], a
	inc de
	jr .copyRatingTextLoop
.doneCopying
	ld [de], a
	ret

PokedexRatingText_441cc:
	TX_FAR _OaksLabText_441cc
	db "@"

DexRatingsTable:
	dw 10
	dw PokedexRatingText_44201 ; you still have lots to do
	dw 20
	dw PokedexRatingText_44206 ; get a FLASH HM from my aide
	dw 30
	dw PokedexRatingText_4420b ; you still need more #MON
	dw 40
	dw PokedexRatingText_44210 ; get an itemfinder from my aide
	dw 50
	dw PokedexRatingText_44215 ; go find my aide when you get 50
	dw 60
	dw PokedexRatingText_4421a ; you finally got at least 50 species
	dw 70
	dw PokedexRatingText_NotBad
	dw 80
	dw PokedexRatingText_Interesting
	dw 90
	dw PokedexRatingText_4421f ; Ho! this is getting even better
	dw 100
	dw PokedexRatingText_44224 ; very good! go fish for some marine #MON
	dw 120
	dw PokedexRatingText_44233 ; You finally got at least 100 species!
	dw 140
	dw PokedexRatingText_44229 ; wonderful! do you like to collect things?
	dw 160
	dw PokedexRatingText_4422e ; I'm impressed! It must have been difficult to do
	dw 180
	dw PokedexRatingText_Marvelous
	dw 200
	dw PokedexRatingText_4423d ; Excellent! trade with friends to get some more
	dw 220
	dw PokedexRatingText_200
	dw 240
	dw PokedexRatingText_44238 ; you even have the evolved forms of #MON! Super!
	dw 260
	dw PokedexRatingText_44242 ; Outstanding! You've become a real pro at this
	dw 280
	dw PokedexRatingText_Fantastic
	dw 300
	dw PokedexRatingText_Incredible
	dw 320
	dw PokedexRatingText_Wow
	dw 340
	dw PokedexRatingText_Astounding
	dw 360
	dw PokedexRatingText_Extraordinary
	dw 380
	dw PokedexRatingText_Surpass
	dw 400
	dw PokedexRatingText_44247 ; I have nothing left to say! You're the authority now
	dw $ffff
	dw PokedexRatingText_4424c ; Your Pokedex is entirely complete! Congratulations!

PokedexRatingText_44201:
	TX_FAR _OaksLabText_44201
	db "@"

PokedexRatingText_44206:
	TX_FAR _OaksLabText_44206
	db "@"

PokedexRatingText_4420b:
	TX_FAR _OaksLabText_4420b
	db "@"

PokedexRatingText_44210:
	TX_FAR _OaksLabText_44210
	db "@"

PokedexRatingText_44215:
	TX_FAR _OaksLabText_44215
	db "@"

PokedexRatingText_4421a:
	TX_FAR _OaksLabText_4421a
	db "@"

PokedexRatingText_NotBad:
	TX_FAR _OaksLabText_NotBad
	db "@"

PokedexRatingText_Interesting:
	TX_FAR _OaksLabText_Interesting
	db "@"

PokedexRatingText_4421f:
	TX_FAR _OaksLabText_4421f
	db "@"

PokedexRatingText_44224:
	TX_FAR _OaksLabText_44224
	db "@"

PokedexRatingText_44229:
	TX_FAR _OaksLabText_44229
	db "@"

PokedexRatingText_4422e:
	TX_FAR _OaksLabText_4422e
	db "@"

PokedexRatingText_Marvelous:
	TX_FAR _OaksLabText_Marvelous
	db "@"

PokedexRatingText_44233:
	TX_FAR _OaksLabText_44233
	db "@"

PokedexRatingText_44238:
	TX_FAR _OaksLabText_44238
	db "@"

PokedexRatingText_4423d:
	TX_FAR _OaksLabText_4423d
	db "@"

PokedexRatingText_44242:
	TX_FAR _OaksLabText_44242
	db "@"

PokedexRatingText_44247:
	TX_FAR _OaksLabText_44247
	db "@"

PokedexRatingText_4424c:
	TX_FAR _OaksLabText_4424c
	db "@"

PokedexRatingText_200:
	TX_FAR _OaksLabText_200
	db "@"

PokedexRatingText_Fantastic:
	TX_FAR _OaksLabText_Fantastic
	db "@"

PokedexRatingText_Incredible
	TX_FAR _OaksLabText_Incredible
	db "@"

PokedexRatingText_Wow
	TX_FAR _OaksLabText_Wow
	db "@"

PokedexRatingText_Astounding
	TX_FAR _OaksLabText_Astounding
	db "@"

PokedexRatingText_Extraordinary
	TX_FAR _OaksLabText_Extraordinary
	db "@"

PokedexRatingText_Surpass
	TX_FAR _OaksLabText_Surpass
	db "@"

; moved from bank 1F
PlayPokedexRatingSfx::
	ld a, [hDexRatingNumMonsOwnedHigh]
	ld b, a									; to handle extended dex
	ld a, [hDexRatingNumMonsOwnedLow]		; to handle extended dex
	ld c, a									; to handle extended dex
	ld e, $0								; need to use bc for 2 bytes comparison, so switched to e here
	ld hl, OwnedMonValues
.getSfxPointer
	push hl									; to handle extended dex
	ld a, [hli]								; to handle extended dex
	ld h, [hl]								; to handle extended dex
	ld l, a									; to handle extended dex
	call CompareBCtoHL						; to handle extended dex
	pop hl									; to handle extended dex
	jr c, .gotSfxPointer
	inc e									;  needed to use bc earlier, so switched to e here
	inc hl
	inc hl									; to handle extended dex
	jr .getSfxPointer
.gotSfxPointer
	push de									; needed to use bc earlier, so switched to de here
	ld a, $ff
	ld [wNewSoundID], a
	call PlaySoundWaitForCurrent
	pop de									; needed to use bc earlier, so switched to de here
	ld d, $0								; here e contains the index of the pointer, so put zero in d then add de to hl
	ld hl, PokedexRatingSfxPointers
	add hl, de								; needed to use bc earlier, so switched to de here
	ld a, [hl]								; read sfx id in a
	call PlayMusic
	jp PlayDefaultMusic

PokedexRatingSfxPointers:
	db SFX_DENIED
	db SFX_POKEDEX_RATING
	db SFX_GET_ITEM_1
	db SFX_CAUGHT_MON
	db SFX_LEVEL_UP
	db SFX_GET_KEY_ITEM
	db SFX_GET_ITEM_2

OwnedMonValues:
	dw 10, 50, 100, 200, 300, 400, $ffff	; to handle extended dex
