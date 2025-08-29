; use wPrintItemPrices to determine which currency to use
GetItemPrice_:
; Stores item's price as BCD at hItemPrice (3 bytes)
; Input: [wcf91] = item id
	ld hl, wItemPrices
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wPrintItemPrices]
	and a
	jr z, .pokedollars			; wPrintItemPrices = 0 => mart sell menu
	dec a
	jr z, .pokedollars
	dec a
	jr z, .battlepoints
	jr .done					; if unexpected value in wPrintItemPrices, do nothing
.pokedollars
	ld a, [wcf91]				; a contains item id
	; removed the part that checks if the item is an HM/TM since now they're treated like any other item
	ld bc, $3
.loop1
	add hl, bc
	dec a
	jr nz, .loop1
	dec hl
	ld a, [hld]
	ld [hItemPrice + 2], a
	ld a, [hld]
	ld [hItemPrice + 1], a
	ld a, [hl]
	ld [hItemPrice], a
	jr .done
.battlepoints
	ld a, [wcf91]				; a contains item id
	ld b, a
.loop3
	ld a, [hli]
	cp $ff
	jr z, .done
	cp b
	ld a, [hli]
	jr nz, .loop3
	ld [hItemPrice], a
	xor a
	ld [hItemPrice + 1], a
	ld [hItemPrice + 2], a
.done
	ld de, hItemPrice
	ret
