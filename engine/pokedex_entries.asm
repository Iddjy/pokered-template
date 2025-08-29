; add this to get the species category in de from the dex number in wMonDexNumber/wMonDexNumber+1
; ended up not using it, so it is not included anywhere, keeping it in case I ever need it
GetSpeciesCategory:
	ld hl, wMonDexNumber
	ld a, [hli]
	ld b, a
	ld a, [hl]
	ld c, a
	dec	bc
	ld hl, PokedexEntryPointers
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld c, a
	ld h, [hl]
	ld l, c					; hl now points to the dex entry
.loop
	ld a, [hli]
	ld b, a
	call ToLowerCase
	ld [de], a
	ld a, b
	inc de
	cp "@"
	jr nz, .loop
	ret
