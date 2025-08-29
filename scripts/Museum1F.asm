Museum1F_Script:
	ld a, $1
	ld [wAutoTextBoxDrawingControl], a
	xor a
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld hl, Museum1F_ScriptPointers
	ld a, [wMuseum1FCurScript]
	jp CallFunctionInTable

Museum1F_ScriptPointers:
	dw Museum1FScript0
	dw Museum1FScript1

Museum1FScript0:
	ld a, [wYCoord]
	cp $4
	ret nz
	ld a, [wXCoord]
	cp $9
	jr z, .asm_5c120
	ld a, [wXCoord]
	cp $a
	ret nz
.asm_5c120
	xor a
	ld [hJoyHeld], a
	ld a, $1
	ld [hSpriteIndexOrTextID], a
	jp DisplayTextID

Museum1FScript1:
	ret

Museum1F_TextPointers:
	dw Museum1FText1
	dw Museum1FText2
	dw Museum1FText3
	dw Museum1FText4
	dw Museum1FText5
	dw Museum1FText6

Museum1FText1:
	TX_ASM
	ld a, [wYCoord]
	cp $4
	jr nz, .asm_8774b
	ld a, [wXCoord]
	cp $d
	jp z, Museum1FScript_5c1f9
	jr .asm_b8709
.asm_8774b
	cp $3
	jr nz, .asm_d49e7
	ld a, [wXCoord]
	cp $c
	jp z, Museum1FScript_5c1f9
.asm_d49e7
	CheckEvent EVENT_BOUGHT_MUSEUM_TICKET
	jr nz, .asm_31a16
	ld hl, Museum1FText_5c23d
	call PrintText
	jp Museum1FScriptEnd
.asm_b8709
	CheckEvent EVENT_BOUGHT_MUSEUM_TICKET
	jr z, .asm_3ded4
.asm_31a16
	ld hl, Museum1FText_5c242
	call PrintText
	jp Museum1FScriptEnd
.asm_3ded4
	CheckEvent EVENT_MADE_DONATION_3
	jr z, .sellTicket
	ld hl, Museum1FFreeEntryText
	call PrintText
	SetEvent EVENT_BOUGHT_MUSEUM_TICKET		; if the player made all the donations, entry is free
	jr .asm_0b094
.sellTicket
	ld a, MONEY_BOX
	ld [wTextBoxID], a
	call DisplayTextBoxID
	xor a
	ld [hJoyHeld], a
	ld hl, Museum1FText_5c21f
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .asm_de133
	xor a
	ld [hMoney], a
	ld [hMoney + 1], a
	ld a, $50
	ld [hMoney + 2], a
	call HasEnoughMoney
	jr nc, .asm_0f3e3
	ld hl, Museum1FText_5c229
	call PrintText
	jp .asm_de133
.asm_0f3e3
	ld hl, Museum1FText_5c224
	call PrintText
	SetEvent EVENT_BOUGHT_MUSEUM_TICKET
	xor a
	ld [wPriceTemp], a
	ld [wPriceTemp + 1], a
	ld a, $50
	ld [wPriceTemp + 2], a
	ld hl, wPriceTemp + 2
	ld de, wPlayerMoney + 2
	ld c, $3
	predef SubBCDPredef
	ld a, MONEY_BOX
	ld [wTextBoxID], a
	call DisplayTextBoxID
	ld a, SFX_PURCHASE
	call PlaySoundWaitForCurrent
	call WaitForSoundToFinish
	jr .asm_0b094
.asm_de133
	ld hl, Museum1FText_5c21a
	call PrintText
	ld a, $1
	ld [wSimulatedJoypadStatesIndex], a
	ld a, D_DOWN
	ld [wSimulatedJoypadStatesEnd], a
	call StartSimulatingJoypadStates
	call UpdateSprites
	jr Museum1FScriptEnd
.asm_0b094
	ld a, $1
	ld [wMuseum1FCurScript], a
	jr Museum1FScriptEnd

Museum1FScript_5c1f9:
	ld hl, Museum1FText_5c22e
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	cp $0
	jr nz, .asm_d1144
	ld hl, Museum1FText_5c233
	call PrintText
	jr Museum1FScriptEnd
.asm_d1144
	ld hl, Museum1FText_5c238
	call PrintText
Museum1FScriptEnd:
	jp TextScriptEnd

Museum1FText_5c21a:
	TX_FAR _Museum1FText_5c21a
	db "@"

Museum1FText_5c21f:
	TX_FAR _Museum1FText_5c21f
	db "@"

Museum1FText_5c224:
	TX_FAR _Museum1FText_5c224
	db "@"

Museum1FText_5c229:
	TX_FAR _Museum1FText_5c229
	db "@"

Museum1FText_5c22e:
	TX_FAR _Museum1FText_5c22e
	db "@"

Museum1FText_5c233:
	TX_FAR _Museum1FText_5c233
	db "@"

Museum1FText_5c238:
	TX_FAR _Museum1FText_5c238
	db "@"

Museum1FText_5c23d:
	TX_FAR _Museum1FText_5c23d
	db "@"

Museum1FText_5c242:
	TX_FAR _Museum1FText_5c242
	db "@"

Museum1FText2:
	TX_ASM
	ld hl, Museum1FText_5c251
	call PrintText
	jp TextScriptEnd

Museum1FText_5c251:
	TX_FAR _Museum1FText_5c251
	db "@"

Museum1FText3:
	TX_ASM
	CheckEvent EVENT_GOT_OLD_AMBER
	jr nz, .asm_5c285
	ld hl, Museum1FText_5c28e
	call PrintText
	lb bc, OLD_AMBER, 1
	call GiveItem
	jr nc, .BagFull
	SetEvent EVENT_GOT_OLD_AMBER
	ld a, HS_OLD_AMBER
	ld [wMissableObjectIndex], a
	predef HideObject
	ld hl, ReceivedOldAmberText
	jr .end
.BagFull
	ld hl, Museum1FText_5c29e
	jr .end
.asm_5c285
	CheckEvent EVENT_GOT_TM74
	jr nz, .alreadyGotTM74
	CheckEvent EVENT_RESURRECTED_OLD_AMBER
	jr z, .didntResurrectOldAmber
	ld hl, ResurrectedOldAmberText
	call PrintText
	lb bc, TM_74, 1
	call GiveItem
	SetEvent EVENT_GOT_TM74
	ld hl, ReceivedTM74Text
	jr .end
.alreadyGotTM74
	ld hl, AlreadyGotTM74Text
	jr .end
.didntResurrectOldAmber
	ld hl, Museum1FText_5c299
.end
	call PrintText
	jp TextScriptEnd

Museum1FText_5c28e:
	TX_FAR _Museum1FText_5c28e
	db "@"

ReceivedOldAmberText:
	TX_FAR _ReceivedOldAmberText
	TX_SFX_ITEM_1
	db "@"

Museum1FText_5c299:
	TX_FAR _Museum1FText_5c299
	db "@"

ResurrectedOldAmberText:
	TX_FAR _ResurrectedOldAmberText
	db "@"

AlreadyGotTM74Text:
	TX_FAR _AlreadyGotTM74Text
	db "@"

ReceivedTM74Text:
	TX_FAR _ReceivedItemText
	TX_SFX_ITEM_1
	db "@"

Museum1FText_5c29e:
	TX_FAR _Museum1FText_5c29e
	db "@"

Museum1FText4:
	TX_ASM
	ld hl, Museum1FText_5c2ad
	call PrintText
	jp TextScriptEnd

Museum1FText_5c2ad:
	TX_FAR _Museum1FText_5c2ad
	db "@"

Museum1FText5:
	TX_ASM
	ld hl, Museum1FText_5c2bc
	call PrintText
	jp TextScriptEnd

Museum1FText_5c2bc:
	TX_FAR _Museum1FText_5c2bc
	db "@"

; souvenir shop
Museum1FText6:
	TX_ASM
	ld a, [wXCoord]
	cp 13
	jp z, .askForDonation
	cp 12
	jp z, .askForDonation
	ld c, 1						; default number of items in the souvenir shop
	CheckEvent EVENT_MADE_DONATION_1
	jr z, .checkOldAmber
	inc c
	inc c
	CheckEvent EVENT_MADE_DONATION_2
	jr z, .checkOldAmber
	inc c
	inc c
	CheckEvent EVENT_MADE_DONATION_3
	jr z, .checkOldAmber
	inc c
	inc c
.checkOldAmber
	CheckEvent EVENT_RESURRECTED_OLD_AMBER
	jr z, .checkHoF
	inc c
.checkHoF
	ld a, [wNumHoFTeams]
	and a
	jr z, .checkOddKeystone
	inc c
.checkOddKeystone
	CheckEvent EVENT_GOT_ODD_KEYSTONE
	jr z, .computeItemList
	inc c
.computeItemList
	ld hl, wBuffer
	ld a, c
	ld [hli], a
	ld a, MOON_STONE
	ld [hli], a
	ld a, [wNumHoFTeams]
	and a
	jr z, .afterKingsRock
	ld a, KINGS_ROCK
	ld [hli], a
.afterKingsRock
	CheckEvent EVENT_GOT_ODD_KEYSTONE
	jr z, .afterOddKeystone
	ld a, ODD_KEYSTONE
	ld [hli], a
.afterOddKeystone
	CheckEvent EVENT_RESURRECTED_OLD_AMBER
	jr z, .afterOldAmber
	ld a, OLD_AMBER
	ld [hli], a
.afterOldAmber
	CheckEvent EVENT_MADE_DONATION_1
	jr z, .finish
	ld a, HELIX_FOSSIL
	ld [hli], a
	ld a, DOME_FOSSIL
	ld [hli], a
	CheckEvent EVENT_MADE_DONATION_2
	jr z, .finish
	ld a, SKULL_FOSSIL
	ld [hli], a
	ld a, ARMOR_FOSSIL
	ld [hli], a
	CheckEvent EVENT_MADE_DONATION_3
	jr z, .finish
	ld a, JAW_FOSSIL
	ld [hli], a
	ld a, SAIL_FOSSIL
	ld [hli], a
.finish
	ld a, $FF
	ld [hl], a
	ld hl, wBuffer
	call LoadItemList
	ld b, GIFT_CARD
	call IsItemInBag
	ld hl, SouvenirShopGreetingText
	jr z, .noGiftCard
	ld hl, SouvenirShopGiftCardText
.noGiftCard
	call PrintText
	ld a, 1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld [wLetterPrintingDelayFlags], a
	ld a, PRICEDITEMLISTMENU
	ld [wListMenuID], a
	ld b, GIFT_CARD
	call IsItemInBag
	jp z, .displayMartDialog
	call SaveScreenTilesToBuffer1
.giftCardLoop
	ld a, [wListScrollOffset]
	ld [wSavedListScrollOffset], a
	call UpdateSprites
	xor a
	ld [wBoughtOrSoldItemInMart], a
	ld [wListScrollOffset], a
	ld [wCurrentMenuItem], a
	ld [wPlayerMonNumber], a
	inc a
	ld [wPrintItemPrices], a
	ld a, INIT_OTHER_ITEM_LIST
	ld [wInitListType], a
	callab InitList
	call DisplayListMenuID
	jr c, .giftCardMenuDone
	ld a, [wcf91] ; item ID
	ld [wd11e], a ; store item ID for GetItemName
	call GetItemName
	call CopyStringToCF4B ; copy name to wcf4b
	ld hl, SouvenirShopExchangeGiftCardText
	call PrintText
	coord hl, 14, 7
	lb bc, 8, 15
	ld a, TWO_OPTION_MENU
	ld [wTextBoxID], a
	call DisplayTextBoxID
	ld a, [wMenuExitMethod]
	cp CHOSE_SECOND_ITEM
	jr z, .giftCardLoop ; if the player chose No or pressed the B button
	ld hl, wNumBagItems
	ld a, 1
	ld [wItemQuantity], a
	call AddItemToInventory
	jr nc, .bagFull
	ld a, SFX_PURCHASE
	call PlaySoundWaitForCurrent
	call WaitForSoundToFinish
	ld a, GIFT_CARD
	ld [hItemToRemoveID], a
	callab RemoveItemByID
.giftCardMenuDone
	call LoadScreenTilesFromBuffer1
	ld hl, SouvenirShopComeAgainText
	call PrintText
	jr .afterDialog
.displayMartDialog
	callab DisplayPokemartDialogue_
.afterDialog
	xor a
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	jp TextScriptEnd
.bagFull
	call LoadScreenTilesFromBuffer1
	ld hl, SouvenirShopItemBagFullText
	jp .printText
.askForDonation
	CheckEvent EVENT_PENDING_GIFT_CARD
	jp nz, .giveGiftCard
	CheckEvent EVENT_MADE_DONATION_3
	ld hl, MuseumSouvenirShopThankYouText
	jp nz, .printText
	ld a, MONEY_BOX
	ld [wTextBoxID], a
	call DisplayTextBoxID
	ld hl, MuseumSouvenirShopText1
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	ld hl, MuseumSouvenirShopText2
	jr nz, .printText
	xor a
	ld [hMoney + 2], a
	ld [hMoney + 1], a
	ld a, $1
	ld [hMoney], a
	call HasEnoughMoney
	jr nc, .madeDonation
	ld hl, MuseumSouvenirShopText3
	jr .printText
.madeDonation
	CheckEvent EVENT_MADE_DONATION_1
	jr nz, .checkDonation2
	SetEvent EVENT_MADE_DONATION_1
	jr .applyDonation
.checkDonation2
	CheckEvent EVENT_MADE_DONATION_2
	jr nz, .donation3
	SetEvent EVENT_MADE_DONATION_2
	jr .applyDonation
.donation3
	SetEvent EVENT_MADE_DONATION_3
.applyDonation
	xor a
	ld [wPriceTemp + 1], a
	ld [wPriceTemp + 2], a
	ld a, $1
	ld [wPriceTemp], a
	ld hl, wPriceTemp + 2
	ld de, wPlayerMoney + 2
	ld c, $3
	predef SubBCDPredef
	ld a, MONEY_BOX
	ld [wTextBoxID], a
	call DisplayTextBoxID
	ld a, SFX_PURCHASE
	call PlaySoundWaitForCurrent
	call WaitForSoundToFinish
.giveGiftCard
	ld hl, MuseumSouvenirShopText4
	call PrintText
	lb bc, GIFT_CARD, 1
	call GiveItem
	jr nc, .noRoom
	ResetEvent EVENT_PENDING_GIFT_CARD
	ld hl, MuseumSouvenirShopText5
	jr .printText
.noRoom
	SetEvent EVENT_PENDING_GIFT_CARD
	ld hl, MuseumSouvenirShopText7
.printText
	call PrintText
	jp TextScriptEnd

SouvenirShopGreetingText::
	TX_FAR _SouvenirShopGreetingText
	db "@"

MuseumSouvenirShopText1:
	TX_FAR _MuseumSouvenirShopText1
	db "@"

MuseumSouvenirShopText2:
	TX_FAR _MuseumSouvenirShopText2
	db "@"

MuseumSouvenirShopText3:
	TX_FAR _MuseumSouvenirShopText3
	db "@"

MuseumSouvenirShopText4:
	TX_FAR _MuseumSouvenirShopText4
	db "@"

MuseumSouvenirShopText5:
	TX_FAR _MuseumSouvenirShopText5
	TX_SFX_ITEM_1
	TX_FAR _MuseumSouvenirShopText6
	db "@"

MuseumSouvenirShopText7:
	TX_FAR _MuseumSouvenirShopText7
	db "@"

MuseumSouvenirShopThankYouText:
	TX_FAR _MuseumSouvenirShopThankYouText
	db "@"

Museum1FFreeEntryText:
	TX_FAR _Museum1FFreeEntryText
	db "@"

SouvenirShopGiftCardText:
	TX_FAR _SouvenirShopGiftCardText
	db "@"

SouvenirShopExchangeGiftCardText:
	TX_FAR _SouvenirShopExchangeGiftCardText
	db "@"

SouvenirShopItemBagFullText:
	TX_FAR _MuseumSouvenirShopText7
	TX_BLINK
	db "@"

SouvenirShopComeAgainText:
	TX_FAR _SouvenirShopComeAgainText
	db "@"
