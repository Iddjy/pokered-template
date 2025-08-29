GoToNextPage_:
	ld a, [wItemMenuCurrentPage]
	inc a
	cp NUM_PAGES_ITEMS_MENU + 1
	jr c, .notLooping
	xor a							; if we went over the number of pages, loop back to page zero
.notLooping
	ld [wItemMenuCurrentPage], a
	jr ResetCursorPosition			; might need to turn this into jp if GoToPreviousPage_ becomes too big

GoToPreviousPage_:
	ld a, [wItemMenuCurrentPage]
	and a
	jr nz, .notLooping
	ld a, NUM_PAGES_ITEMS_MENU		; if we're already on page zero, we loop over to last page
	jr .done
.notLooping
	dec a
.done
	ld [wItemMenuCurrentPage], a
;	jr ResetCursorPosition			/!\ unnecessary as long as ResetCursorPosition remains right next to GoToPreviousPage_
; fallthrough

ResetCursorPosition:
	xor a
	ld [wCurrentMenuItem], a			; reset cursor position in current scrolling window
	ld [wListScrollOffset], a			; reset scrolling window position to top of the menu
	ret
	
UpdateListAddress:
	ld a, A_BUTTON | B_BUTTON | SELECT	; default set of buttons to listen to
	ld [wMenuWatchedKeys], a
	ld a, [wListMenuID]
	cp ITEMLISTMENU_NOQUANTITY
	jr z, .do							; if we're already on one of the extra pages, no need to check further
	cp ITEMLISTMENU_NOPAGES				; if we're in an items menu without access to TMs/Key items pages (eg. Sell menu)
	jr nz, .next
	xor a
	ld [wItemMenuCurrentPage], a		; force the current page to zero
	ret
.next
	cp ITEMLISTMENU
	ret nz
.do
	ld a, [wItemMenuCurrentPage]
	ld bc, wNumBagItems
	ld d, ITEMLISTMENU
	ld e, A_BUTTON | B_BUTTON | SELECT | D_RIGHT | D_LEFT
	cp ITEMS_PAGE_NUMBER
	jr z, .update
	ld bc, wTMsListCount
	ld d, ITEMLISTMENU_NOQUANTITY
	ld e, A_BUTTON | B_BUTTON | D_RIGHT | D_LEFT			; disallow select in the TMs page
	cp TM_PAGE_NUMBER
	jr z, .update
	ld bc, wKeyItemsListCount
	ld e, A_BUTTON | B_BUTTON | SELECT | D_RIGHT | D_LEFT
.update
	ld a, e
	ld [wMenuWatchedKeys], a
	ld a, d
	ld [wListMenuID], a
	ld hl, wListPointer
	ld a, c
	ld [hli], a
	ld a, b
	ld [hl], a
	ret

PlacePageName:
	ld a, [wListMenuID]
	cp ITEMLISTMENU_NOQUANTITY
	jr z, .do						; if we're already on one of the extra pages, no need to check further
	cp ITEMLISTMENU
	ret nz							; if we're not in an items menu, don't show page names
.do
	ld a, [wItemMenuCurrentPage]
	ld de, PageOneName
	coord hl, 8, 2					; coordinates of upper left corner of menu text box + 1 tile horizontally
	cp ITEMS_PAGE_NUMBER
	jr z, .displayPageName
	ld de, PageTwoName
	coord hl, 7, 2					; coordinates of upper left corner of menu text box + 1 tile horizontally
	cp TM_PAGE_NUMBER
	jr z, .displayPageName
	ld de, PageThreeName
	coord hl, 8, 2					; coordinates of upper left corner of menu text box + 1 tile horizontally
.displayPageName
	call PlaceString
	ret

PageOneName:
	db "<ITEMS"
	db $ED
	db "@"

PageTwoName:
	db "<TMs/HMs"
	db $ED
	db "@"

PageThreeName:
	db "<KEYS"
	db $ED
	db "@"

; add this function to show TM move under the TM name in the bag:
DisplayTMMove:
	push hl
	push bc
	push de
	push af
	dec de						; de was already incremented to the next TM before this function was called, so we need to decrement it
	ld a, [de]					; get TM id in a
	sub TM_01
	jr nc, .skipAdding
	add NUM_TMS + NUM_HMS		; if item is an HM, add 55
.skipAdding
	inc a
	ld [wd11e], a
	push hl
	predef TMToMove				; get move ID from TM/HM ID
	ld a, [wd11e]
	ld [wMoveNum], a
	callab GetTMMoveType
	ld a, d
	add "<NORMAL>"				; map type id to type symbol character index
	pop hl
	ld bc, 4
	add hl, bc
	ld [hl], "/"
	inc hl
	ld [hl], a
	ld bc, SCREEN_WIDTH - 5		; 1 row down, 5 tiles to the left to get back to the start of the line
	add hl, bc
	push hl
	call GetMoveName			; puts move name in wcd6d
	ld de, wcd6d
	pop hl
	push de
	ld b, 0						; b will be used to count the length of the move name, 
.loopGetNameLength
	ld a, [de]
	cp "@"
	jr z, .gotLength
	inc b
	inc de
	jr .loopGetNameLength
.gotLength
	ld a, MOVE_NAME_LENGTH
	sub b						; calculate number of white spaces of padding needed to make the name right-aligned
.loopPrintLeftPadding
	dec a
	jr z, .printName
	ld [hl], " "
	inc hl
	jr .loopPrintLeftPadding
.printName
	pop de
.loopPrintName
	ld a, [de]
	cp "@"
	jr z, .done
	ld [hli], a
	inc de
	jr .loopPrintName
.done
	pop af
	pop de
	pop bc
	pop hl
	ret
