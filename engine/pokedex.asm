; advances hl by (dex number ID)/8, with the dex number stored in [wMonDexNumber]/[wMonDexNumber + 1]
SeekToSpeciesByte:
	ld a, [wMonDexNumber]
	ld b, a
	ld a, [wMonDexNumber + 1]
	ld c, a
	dec bc
	push bc
	srl b
	rr c
	srl b
	rr c
	srl b
	rr c
	add hl, bc
	pop bc
	ret

; input: [wMonDexNumber]/[wMonDexNumber + 1] = dex number
AddToPokedexSeen:
	ld hl, wPokedexSeen
	jr AddToPokedex

; input: [wMonDexNumber]/[wMonDexNumber + 1] = dex number
AddToPokedexOwned:
	ld hl, wPokedexOwned
AddToPokedex:
	call SeekToSpeciesByte
	ld a, c
	and $07
	jr nz, .notBitZero
	set 0, [hl]
	ret
.notBitZero
	dec a
	jr nz, .notBitOne
	set 1, [hl]
	ret
.notBitOne
	dec a
	jr nz, .notBitTwo
	set 2, [hl]
	ret
.notBitTwo
	dec a
	jr nz, .notBitThree
	set 3, [hl]
	ret
.notBitThree
	dec a
	jr nz, .notBitFour
	set 4, [hl]
	ret
.notBitFour
	dec a
	jr nz, .notBitFive
	set 5, [hl]
	ret
.notBitFive
	dec a
	jr nz, .notBitSix
	set 6, [hl]
	ret
.notBitSix
	set 7, [hl]
	ret

; input: [wMonDexNumber]/[wMonDexNumber + 1] = dex number
CheckPokedexSeen:
	ld hl, wPokedexSeen
	jr CheckPokedex

; input: [wMonDexNumber]/[wMonDexNumber + 1] = dex number
CheckPokedexOwned:
	ld hl, wPokedexOwned
CheckPokedex:
	call SeekToSpeciesByte
	ld a, c
	and $07
	jr nz, .notBitZero
	bit 0, [hl]
	ret
.notBitZero
	dec a
	jr nz, .notBitOne
	bit 1, [hl]
	ret
.notBitOne
	dec a
	jr nz, .notBitTwo
	bit 2, [hl]
	ret
.notBitTwo
	dec a
	jr nz, .notBitThree
	bit 3, [hl]
	ret
.notBitThree
	dec a
	jr nz, .notBitFour
	bit 4, [hl]
	ret
.notBitFour
	dec a
	jr nz, .notBitFive
	bit 5, [hl]
	ret
.notBitFive
	dec a
	jr nz, .notBitSix
	bit 6, [hl]
	ret
.notBitSix
	bit 7, [hl]
	ret


; input: [wMonDexNumber]/[wMonDexNumber + 1] = dex number
RemoveFromPokedexSeen:
	ld hl, wPokedexSeen
	jr RemoveFromPokedex

; input: [wMonDexNumber]/[wMonDexNumber + 1] = dex number
RemoveFromPokedexOwned:
	ld hl, wPokedexOwned
RemoveFromPokedex:
	call SeekToSpeciesByte
	ld a, c
	and $07
	jr nz, .notBitZero
	res 0, [hl]
	ret
.notBitZero
	dec a
	jr nz, .notBitOne
	res 1, [hl]
	ret
.notBitOne
	dec a
	jr nz, .notBitTwo
	res 2, [hl]
	ret
.notBitTwo
	dec a
	jr nz, .notBitThree
	res 3, [hl]
	ret
.notBitThree
	dec a
	jr nz, .notBitFour
	res 4, [hl]
	ret
.notBitFour
	dec a
	jr nz, .notBitFive
	res 5, [hl]
	ret
.notBitFive
	dec a
	jr nz, .notBitSix
	res 6, [hl]
	ret
.notBitSix
	res 7, [hl]
	ret

; input: [wMonSpeciesTemp]/[wMonSpeciesTemp + 1] = species ID
CheckPokedexOwnedBySpeciesID:
	call GetDexNumberBySpeciesID
	jp CheckPokedexOwned

; input: [wMonSpeciesTemp]/[wMonSpeciesTemp + 1] = species ID
CheckPokedexSeenBySpeciesID:
	call GetDexNumberBySpeciesID
	jp CheckPokedexSeen

; input: [wMonSpeciesTemp]/[wMonSpeciesTemp + 1] = species ID
AddToPokedexOwnedBySpeciesID:
	call GetDexNumberBySpeciesID
	jp AddToPokedexOwned

; input: [wMonSpeciesTemp]/[wMonSpeciesTemp + 1] = species ID
AddToPokedexSeenBySpeciesID:
	call GetDexNumberBySpeciesID
	jp AddToPokedexSeen

; input: [wMonSpeciesTemp]/[wMonSpeciesTemp + 1] = species ID
RemoveFromPokedexOwnedBySpeciesID:
	call GetDexNumberBySpeciesID
	jp RemoveFromPokedexOwned

; input: [wMonSpeciesTemp]/[wMonSpeciesTemp + 1] = species ID
RemoveFromPokedexSeenBySpeciesID:
	call GetDexNumberBySpeciesID
	jp RemoveFromPokedexSeen
