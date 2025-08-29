TMShopMenu:
	ld hl, TMmartBuyingGreetingText
	call PrintText
	ld hl, wd730
	set 6, [hl]						; disable letter-printing delay
	ld a, MONEY_BOX
	ld [wTextBoxID], a
	call DisplayTextBoxID
	xor a
	ld [wListScrollOffset], a
.menuLoop
	ld hl, WhichTMTextPtr
	call PrintText
	ld hl, ItemPrices
	ld a, l
	ld [wItemPrices], a
	ld a, h
	ld [wItemPrices + 1], a
	xor a
	ld [wCurrentMenuItem], a
	inc a
	ld [wPrintItemPrices], a
	inc a							; a = 2 (PRICEDITEMLISTMENU)
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
	call HandleTMChoice
	jr .menuLoop
.exit
	ld hl, wd730
	res 6, [hl]
	ret

HandleTMChoice:
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
	push af
	sub TM_01
	inc a
	ld [wd11e], a
	predef TMToMove				; get move ID from TM/HM ID
	ld a, [wd11e]
	ld [wMoveNum], a
	call GetMoveName			; puts move name in wcd6d
	ld hl, wcd6d
	ld de, wTempMoveNameBuffer
	ld bc, MOVE_NAME_LENGTH
	call CopyData				; copy move name to wTempMoveNameBuffer
	pop af
	ld [wd11e], a
	call GetItemName			; put TM name in wcd6d
	ld a, [wTMShopEventFlags]
	ld l, a
	ld a, [wTMShopEventFlags + 1]
	ld h, a
	ld a, [hl]
	ld b, a
	ld a, [wWhichPrize]
	inc a
	ld c, a
.shiftLoop						; this loop is used to look up the bit corresponding to the TM currently selected
	xor a
.readByte
	dec c
	jr z, .gotBit
	srl b
	inc a
	cp $8						; test whether we've overflowed to the next byte
	jr c, .readByte				; if not, continue reading the current byte
	inc hl						; else move to next byte
	ld b, [hl]					; and put it in b
	jr .shiftLoop
.gotBit
	srl b						; shift right and if carry is set, it means the bit was set
	jp c, .alreadyGotThisTM
	ld hl, SoYouWantTMTextPtr
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]	; yes/no answer (Y=0, N=1)
	and a
	ret nz
	call LoadMoneyToSubtract
	call HasEnoughMoney
	jr c, .notEnoughMoney
	ld a, [wd11e]
	ld b, a
	ld a, 1
	ld c, a
	call GiveItem
	jr nc, .bagFull
	ld a, [wTMShopEventFlags]
	ld l, a
	ld a, [wTMShopEventFlags + 1]
	ld h, a
	ld a, [hl]
	ld b, a
	ld a, [wWhichPrize]
	inc a
	ld d, a
.shiftLoop2					; this loop is used to set the bit corresponding to the TM currently selected
	ld c, $1				; init to $1, then shift left with each loop iteration to bring the 1 at the right place in the byte
.readByte2
	dec d
	jr z, .gotBit2
	sla c
	jr nc, .readByte2		; no carry means we're not at the end of the current byte
	inc hl					; if carry was set, that means the 1 has reached the end of the byte, and we must move to the next one
	ld b, [hl]
	jr .shiftLoop2
.gotBit2
	ld a, b					; at this point b contains the current value for the flags byte
	or c					; and c contains 1 at the bit corresponding to the event in this byte, and 0s everywhere else
	ld [hl], a				; 'or'ing them together sets the correct bit
	callab SubtractAmountPaidFromMoney_
	ld a, SFX_PURCHASE
	call PlaySoundWaitForCurrent
	call WaitForSoundToFinish
	ld hl, HereYouGoText
	jp PrintText
.bagFull
	ld hl, TMShopBagIsFullTextPtr
	jp PrintText
.notEnoughMoney
	ld hl, SorryNeedMoreMoneyText
	jp PrintText
.alreadyGotThisTM
	ld hl, AlreadyGotThisTMText
	jp PrintText

HereYouGoText:
	TX_FAR _HereYouGoText
	TX_WAIT
	db "@"

SoYouWantTMTextPtr:
	TX_FAR _SoYouWantTMText
	db "@"

SorryNeedMoreMoneyText:
	TX_FAR _PokemartNotEnoughMoneyText
	db "@"

TMShopBagIsFullTextPtr:
	TX_FAR _OopsYouDontHaveEnoughRoomText
	TX_WAIT
	db "@"

AlreadyGotThisTMText:
	TX_FAR _AlreadyGotThisTMText
	TX_WAIT
	db "@"

TMmartBuyingGreetingText:
	TX_FAR _TMmartBuyingGreetingText
	TX_WAIT
	db "@"

WhichTMTextPtr:
	TX_FAR _WhichTMText
	db "@"

LoadMoneyToSubtract:
	ld a, [wWhichPrize]
	ld d, 0
	ld e, a
	ld a, [wListPointer]
	ld l, a
	ld a, [wListPointer + 1]
	ld h, a
	inc hl
	add hl, de
	ld a, [hl]
	ld [wcf91], a
	call GetItemPrice
	ld hl, hItemPrice + 2
	ld a, [hld]
	ld [hMoney + 2], a
	ld a, [hld]
	ld [hMoney + 1], a
	ld a, [hl]
	ld [hMoney], a
	ret

CeladonMartTMShopEntries:
	TX_TM_MART TM_21, TM_51, TM_52, TM_53, TM_17, TM_73, TM_85, TM_95, TM_09, TM_15

CinnabarLabTMShopEntries:
	TX_TM_MART TM_92, TM_65, TM_80, TM_13, TM_24, TM_66, TM_94, TM_83, TM_70, TM_72
