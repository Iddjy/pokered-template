BattleFacilityShop:
	ld hl, BattleFacilityShopWelcomeText
	call PrintText
	CheckEvent EVENT_BATTLE_FACILITY_INTRO_TEXT	; only display the Battle Facility shop menu once the intro text has been triggered with the receptionnist
	ret z
	ld hl, wd730
	set 6, [hl]						; disable letter-printing delay
	ld hl, BattleFacilityShopItems
	ld a, l
	ld [wListPointer], a
	ld a, h
	ld [wListPointer + 1], a
	call PrintPlayerBPs
	xor a
	ld [wListScrollOffset], a
.menuLoop
	ld hl, WhichItemText
	call PrintText
	ld hl, BattleFacilityShopPrices
	ld a, l
	ld [wItemPrices], a
	ld a, h
	ld [wItemPrices + 1], a
	xor a
	ld [wCurrentMenuItem], a
	ld a, CURRENCY_BATTLE_POINTS
	ld [wPrintItemPrices], a
	ld a, PRICEDITEMLISTMENU
	ld [wListMenuID], a
	call DisplayListMenuID
	jr c, .exit
	ld a, [wCurrentMenuItem]		; offset of the selected item in the list of items currently being displayed
	ld c, a							; eg. in the items menu, only 4 items are displayed at a time, so this goes from 0 to 3
	ld a, [wListScrollOffset]		; offset of the first (ie. top) item currently displayed in the whole list of displayable items
	add c							; add it to the previous offset to obtain the offset of the selected item in the whole list
	ld c, a
	ld a, [wListCount]
	dec a
	cp c							; did the player select Cancel?
	jr c, .exit						; if so, exit the menu
	ld a, c
	call HandleItemChoice
	jr .menuLoop
.exit
	ld hl, wd730
	res 6, [hl]
	ret

BattleFacilityShopWelcomeText:
	TX_FAR _BattleFacilityShopWelcomeText
	TX_WAIT
	db "@"

WhichItemText:
	TX_FAR _WhichItemText
	db "@"

PrintPlayerBPs:
	coord hl, 14, 0
	ld b, 1
	ld c, 4
	call TextBoxBorder
	call UpdateSprites
	coord hl, 15, 0
	ld de, .BPsString
	call PlaceString
	coord hl, 15, 1
	ld de, .FourSpacesString
	call PlaceString
	coord hl, 16, 1
	ld de, wPlayerBattlePoints
	ld c, 3
	ld b, 1
	call PrintNumber
	ret

.BPsString:
	db "BPs@"

.FourSpacesString:
	db "    @"

HasEnoughPoints:
	ld hl, hItemPrice
	ld de, wPlayerBattlePoints
	ld a, [hl]
	ld b, a
	ld a, [de]
	sub b
	ret

HandleItemChoice:
	ld [wWhichPrize], a
	ld d, 0
	ld e, a
	ld a, [wListPointer]
	ld l, a
	ld a, [wListPointer + 1]
	ld h, a
	inc hl
	add hl, de
	ld a, [hl]
	ld [wd11e], a	; for GetItemName
	ld [wcf91], a	; for GetItemPrice
	call GetItemName
	ld hl, SoYouWantText
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem] ; yes/no answer (Y=0, N=1)
	and a
	jp nz, .printOhFineThen
	call GetItemPrice
	call HasEnoughPoints
	jr c, .notEnoughPoints
	ld a, [wd11e]
	ld b, a
	ld a, 1
	ld c, a
	call GiveItem
	jr nc, .bagFull
.subtractPoints
;	call LoadPointsToSubtract
	ld hl, hItemPrice
	ld de, wPlayerBattlePoints
	ld a, [hl]
	ld b, a
	ld a, [de]
	sub b
	ld [de], a
	ld a, SFX_PURCHASE
	call PlaySoundWaitForCurrent
	call WaitForSoundToFinish
	call PrintPlayerBPs
	ld hl, BattleFacilityShopHereYouGoText
	jp PrintText
.bagFull
	ld hl, BattleFailictyShopBagIsFullTextPtr
	jp PrintText
.notEnoughPoints
	ld hl, SorryNeedMoreBattlePointsText
	jp PrintText
.printOhFineThen
	ld hl, BattleFacilityShopOhFineThenText
	jp PrintText

SoYouWantText:
	TX_FAR _SoYouWantText
	db "@"

SorryNeedMoreBattlePointsText:
	TX_FAR _SorryNeedMoreBattlePointsText
	TX_WAIT
	db "@"

BattleFailictyShopBagIsFullTextPtr:
	TX_FAR _OopsYouDontHaveEnoughRoomText
	TX_WAIT
	db "@"

BattleFacilityShopOhFineThenText:
	TX_FAR _OhFineThenText
	TX_WAIT
	db "@"

BattleFacilityShopHereYouGoText:
	TX_FAR _HereYouGoText
	TX_WAIT
	db "@"
