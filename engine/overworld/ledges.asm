HandleLedges:
	ld a, [wd736]
	bit 6, a ; already jumping down ledge
	ret nz
	ld hl, OverworldLedgeTiles
	ld a, [wCurMapTileset]
	and a ; OVERWORLD
	jr z, .mapHasLedges
	cp CAVERN								; allow Cavern tileset to have ledges
	ret nz
	ld hl, CavernLedgeTiles
.mapHasLedges
	ld a, [wSpriteStateData1 + 9]
	ld b, a
	aCoord 8, 9
	ld c, a
	ld a, [wTileInFrontOfPlayer]
	ld d, a
.loop
	ld a, [hli]
	cp $ff
	ret z
	cp b
	jr nz, .nextLedgeTile1
	ld a, [hli]
	cp c
	jr nz, .nextLedgeTile2
	ld a, [hli]
	cp d
	jr nz, .nextLedgeTile3
	ld a, [hl]
	ld e, a
	jr .foundMatch
.nextLedgeTile1
	inc hl
.nextLedgeTile2
	inc hl
.nextLedgeTile3
	inc hl
	jr .loop
.foundMatch
	ld a, e
	and a				; add zero as a special value to allow for directional collisions between certain tiles
	jr nz, .ledge
	ld hl, wd736
	set 3, [hl]			; previously unused bit is now used to signal this type of collision
	ret
.ledge
	ld a, [hJoyHeld]
	and e
	ret z
	ld a, $ff
	ld [wJoyIgnore], a
	ld hl, wd736
	set 6, [hl] ; jumping down ledge
	call StartSimulatingJoypadStates
	ld a, e
	ld [wSimulatedJoypadStatesEnd], a
	ld [wSimulatedJoypadStatesEnd + 1], a
	ld a, $2
	ld [wSimulatedJoypadStatesIndex], a
	call LoadHoppingShadowOAM
	ld a, SFX_LEDGE
	call PlaySound
	ret

	; (player direction) (tile player standing on) (ledge tile) (input required)
OverworldLedgeTiles:
	db SPRITE_FACING_DOWN, $2C,$37,D_DOWN
	db SPRITE_FACING_DOWN, $39,$36,D_DOWN
	db SPRITE_FACING_DOWN, $39,$37,D_DOWN
	db SPRITE_FACING_LEFT, $2C,$27,D_LEFT
	db SPRITE_FACING_LEFT, $39,$27,D_LEFT
	db SPRITE_FACING_RIGHT,$2C,$0D,D_RIGHT
	db SPRITE_FACING_RIGHT,$2C,$1D,D_RIGHT
	db SPRITE_FACING_RIGHT,$39,$0D,D_RIGHT
	db $FF

; added to allow ledges in Cavern tileset
; added 0 as special value to indicate a directional collision (collision only if the player is facing the corresponding direction)
CavernLedgeTiles:
	db SPRITE_FACING_DOWN,	$20,$10,D_DOWN
	db SPRITE_FACING_LEFT,	$20,$31,D_LEFT
	db SPRITE_FACING_RIGHT,	$20,$3A,D_RIGHT
	db SPRITE_FACING_DOWN,	$05,$41,0
	db SPRITE_FACING_UP,	$41,$05,0
	db SPRITE_FACING_DOWN,	$18,$41,0		; for the ladder tile that goes one level deeper
	db SPRITE_FACING_UP,	$41,$18,0		; for the ladder tile that goes one level deeper
	db $FF

LoadHoppingShadowOAM:
	ld hl, vChars1 + $7f0
	ld de, LedgeHoppingShadow
	lb bc, BANK(LedgeHoppingShadow), (LedgeHoppingShadowEnd - LedgeHoppingShadow) / $8
	call CopyVideoDataDouble
	ld a, $9
	lb bc, $54, $48 ; b, c = y, x coordinates of shadow
	ld de, LedgeHoppingShadowOAM
	call WriteOAMBlock
	ret

LedgeHoppingShadow:
	INCBIN "gfx/ledge_hopping_shadow.1bpp"
LedgeHoppingShadowEnd:

LedgeHoppingShadowOAM:
	db $FF,$10,$FF,$20
	db $FF,$40,$FF,$60
