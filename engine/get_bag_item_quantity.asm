GetQuantityOfItemInBag:
; In: b = item ID
; Out: b = how many of that item are in the bag
	call GetPredefRegisters
	ld a, [wcf91]					; since this function is called to check for the SILPH SCOPE in pokemon tower,
	push af							; save the value of wcf91 which contains the wild pokemon species id during battle init
	ld a, b
	ld [wcf91], a					; input for next function
	call IsKeyItem					; check if item is a key item
	pop af
	ld [wcf91], a					; restore the value of wcf91
	ld a, [wIsKeyItem]
	and a							; is the item a key item?
	ld hl, wNumBagItems
	jr z, .loopQuantifiableItem
	ld hl, wKeyItemsList			; if we're checking for a Key Item, use the Key Items page
	jr .loopUnquantifiableItem
.loopQuantifiableItem
	inc hl
	ld a, [hli]						; read item id
	cp $ff							; if it's $ff, it means we're at the end of the list
	jr z, .notInBag
	cp b							; compare it to the item id we're checking for
	jr nz, .loopQuantifiableItem
	ld a, [hl]						; read item quantity
	ld b, a
	ret
.loopUnquantifiableItem				; this loop is for key items, which don't have a quantity attached to them
	ld a, [hli]
	cp $ff
	jr z, .notInBag
	cp b
	jr nz, .loopUnquantifiableItem
	ld b, 1
	ret
.notInBag
	ld b, 0
	ret
