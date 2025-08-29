HPText:
	db "HP@"
	
AttackText:
	db "ATTACK@"

DefenseText:
	db "DEFENSE@"

SpecialAttackText:
	db "SP.ATK@"

SpecialDefenseText:
	db "SP.DEF@"

SpeedText:
	db "SPEED@"

PotentialText:
	db "POTENTIAL@"

EffortText:
	db "EFFORT@"

MaxedText:
	db " MAXED OUT @"

StatsEvaluationText:
	db "STATS EVALUATION@"

StatusScreen3:
	ld a, [hTilesetType]
	push af
	xor a
	ld [hTilesetType], a
	ld [H_AUTOBGTRANSFERENABLED], a
	coord hl, 8, 2
	lb bc, 5, 11
	call ClearScreenArea ; Clear under name
	coord hl, 1, 9
	lb bc, 8, 18
	call ClearScreenArea ; Clear lower part of screen
	coord hl, 10, 3
	ld de, PotentialText
	call PlaceString
	coord hl, 13, 4
	ld a, "->"
	ld [hl], a
	coord hl, 11, 5
	ld de, EffortText
	call PlaceString
	coord hl, 13, 6
	ld a, "=>"
	ld [hl], a
	coord hl, 2, 9
	ld de, StatsEvaluationText
	call PlaceString
	coord hl, 1, 11
	ld de, HPText
	call PlaceString
	ld bc, SCREEN_WIDTH
	add hl, bc
	ld de, AttackText
	call PlaceString
	ld bc, SCREEN_WIDTH
	add hl, bc
	ld de, DefenseText
	call PlaceString
	ld bc, SCREEN_WIDTH
	add hl, bc
	ld de, SpecialAttackText
	call PlaceString
	ld bc, SCREEN_WIDTH
	add hl, bc
	ld de, SpecialDefenseText
	call PlaceString
	ld bc, SCREEN_WIDTH
	add hl, bc
	ld de, SpeedText
	call PlaceString
	ld bc, SCREEN_WIDTH
	add hl, bc
	ld hl, wLoadedMonDVs
	ld a, [hl]
	swap a
	and %00001111
	push hl
	coord hl, 8, 12
	call PlaceDVBar
	pop hl
	ld a, [hli]
	and %00001111
	push hl
	coord hl, 8, 13
	call PlaceDVBar
	pop hl
	ld a, [hl]
	swap a
	and %00001111
	push hl
	coord hl, 8, 16
	call PlaceDVBar
	pop hl
	ld a, [hli]
	and %00001111
	push hl
	coord hl, 8, 11
	call PlaceDVBar
	pop hl
	ld a, [hl]
	swap a
	and %00001111
	push hl
	coord hl, 8, 15
	call PlaceDVBar
	pop hl
	ld a, [hl]
	and %00001111
	coord hl, 8, 14
	call PlaceDVBar
	ld hl, wLoadedMonEVs
	ld a, [hli]
	push hl
	coord hl, 8, 11
	call PlaceEVBar
	pop hl
	ld a, [hli]
	push hl
	coord hl, 8, 12
	call PlaceEVBar
	pop hl
	ld a, [hli]
	push hl
	coord hl, 8, 13
	call PlaceEVBar
	pop hl
	ld a, [hli]
	push hl
	coord hl, 8, 16
	call PlaceEVBar
	pop hl
	ld a, [hli]
	push hl
	coord hl, 8, 14
	call PlaceEVBar
	pop hl
	ld a, [hli]
	coord hl, 8, 15
	call PlaceEVBar
.done
	ld a, $1
	ld [H_AUTOBGTRANSFERENABLED], a
	call Delay3
	call WaitForTextScrollButtonPress ; wait for button
	pop af
	ld [hTilesetType], a
	ld hl, wd72c
	res 1, [hl]
	ld a, $77
	ld [rNR50], a
	call GBPalWhiteOut
	jp ClearScreen

; input: DV value in a, coordinates in hl
PlaceDVBar:
	ld b, 1
	cp 3
	jr c, .gotBarSize
	inc b
	cp 6
	jr c, .gotBarSize
	inc b
	cp 9
	jr c, .gotBarSize
	inc b
	cp 12
	jr c, .gotBarSize
	inc b
	cp 15
	jr c, .gotBarSize
	inc b
.gotBarSize
	ld a, "->"
.loop
	dec b
	ret z
	ld [hli], a
	jr .loop

; input: EV value in a, coordinates in hl
; will move past non-empty coordinates to put the arrows after the DV ones
PlaceEVBar:
	ld b, a
.skipDVs
	ld a, [hli]
	cp " "
	jr nz, .skipDVs
	ld a, b
	dec hl
	ld b, 1
	and a
	jr z, .gotBarSize
	inc b
	cp 40
	jr c, .gotBarSize
	inc b
	cp 80
	jr c, .gotBarSize
	inc b
	cp 120
	jr c, .gotBarSize
	inc b
	cp 160
	jr c, .gotBarSize
	inc b
	cp 200
	jr c, .gotBarSize
	inc b
	cp 252
	jr c, .gotBarSize
	inc b
.gotBarSize
	ld a, "=>"
.loop
	dec b
	ret z
	ld c, a
	ld a, [hl]
	cp "|"
	jr nz, .notMaxed
	ld bc, 9 - SCREEN_WIDTH
	add hl, bc
	ld de, MaxedText
	jp PlaceString
.notMaxed
	ld a, c
	ld [hli], a
	jr .loop
