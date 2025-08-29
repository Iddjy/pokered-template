UsedCut:
	xor a
	ld [wActionResultOrTookBattleTurn], a ; initialise to failure value
	ld a, [wCurMapTileset]
	and a ; OVERWORLD
	jr z, .overworld
	cp FOREST
	jr z, .forest
	cp GYM
	jr nz, .nothingToCut
	ld a, [wTileInFrontOfPlayer]
	cp $50 ; gym cut tree
	jr nz, .nothingToCut
	jr .canCut
.forest
	ld a, [wTileInFrontOfPlayer]
	cp $20
	jr nz, .nothingToCut
	jr .canCut
.overworld
	dec a
	ld a, [wTileInFrontOfPlayer]
	cp $3d ; cut tree
	jr z, .canCut
	cp $52 ; grass
	jr z, .canCut
.nothingToCut
	ld hl, .NothingToCutText
	jp PrintText

.NothingToCutText
	TX_FAR _NothingToCutText
	db "@"

.canCut
	ld [wCutTile], a
	ld a, 1
	ld [wActionResultOrTookBattleTurn], a ; used cut
	ld a, [wWhichPokemon]
	ld hl, wPartyMonNicks
	call GetPartyMonName
	ld hl, wd730
	set 6, [hl]
	call GBPalWhiteOutWithDelay3
	call ClearSprites
	call RestoreScreenTilesAndReloadTilePatterns
	ld a, SCREEN_HEIGHT_PIXELS
	ld [hWY], a
	call Delay3
	call LoadGBPal
	call LoadCurrentMapView
	call SaveScreenTilesToBuffer2
	call Delay3
	xor a
	ld [hWY], a
	ld hl, UsedCutText
	call PrintText
	call LoadScreenTilesFromBuffer2
	ld hl, wd730
	res 6, [hl]
	ld a, $ff
	ld [wUpdateSpritesEnabled], a
	call InitCutAnimOAM
	ld de, CutGrassBlockSwapsOverworld	; mapping table for the OVERWORLD tileset
	ld a, [wTileInFrontOfPlayer]
	cp $52								; grass tile in OVERWORLD tileset
	jr z, .replaceBlock
	ld de, CutGrassBlockSwapsForest		; mapping table for the FOREST tileset
	cp $20								; grass tile in FOREST tileset
	jr z, .replaceBlock
	ld de, CutTreeBlockSwaps
.replaceBlock
	call ReplaceTreeTileBlock
	call RedrawMapView
	callba AnimCut
	ld a, $1
	ld [wUpdateSpritesEnabled], a
	ld a, SFX_CUT
	call PlaySound
	ld a, $90
	ld [hWY], a
	call UpdateSprites
	jp RedrawMapView

UsedCutText:
	TX_FAR _UsedCutText
	db "@"

InitCutAnimOAM:
	xor a
	ld [wWhichAnimationOffsets], a
	ld a, %11100100
	ld [rOBP1], a
	ld a, [wCutTile]
	cp $52				; grass tile in overworld tileset
	jr z, .grass
	cp $20				; grass tile in forest tileset
	jr z, .grass
; tree
	ld de, Overworld_GFX + $2d0 ; cuttable tree sprite top row
	ld hl, vChars1 + $7c0
	lb bc, BANK(Overworld_GFX), $02
	call CopyVideoData
	ld de, Overworld_GFX + $3d0 ; cuttable tree sprite bottom row
	ld hl, vChars1 + $7e0
	lb bc, BANK(Overworld_GFX), $02
	call CopyVideoData
	jr WriteCutOrBoulderDustAnimationOAMBlock
.grass
	ld hl, vChars1 + $7c0
	call LoadCutGrassAnimationTilePattern
	ld hl, vChars1 + $7d0
	call LoadCutGrassAnimationTilePattern
	ld hl, vChars1 + $7e0
	call LoadCutGrassAnimationTilePattern
	ld hl, vChars1 + $7f0
	call LoadCutGrassAnimationTilePattern
	call WriteCutOrBoulderDustAnimationOAMBlock
	ld hl, wOAMBuffer + $93
	ld de, 4
	ld a, $30
	ld c, e
.loop
	ld [hl], a
	add hl, de
	xor $60
	dec c
	jr nz, .loop
	ret

LoadCutGrassAnimationTilePattern:
	ld de, AnimationTileset2 + $60 ; tile depicting a leaf
	lb bc, BANK(AnimationTileset2), $01
	jp CopyVideoData

WriteCutOrBoulderDustAnimationOAMBlock:
	call GetCutOrBoulderDustAnimationOffsets
	ld a, $9
	ld de, CutOrBoulderDustAnimationTilesAndAttributes
	jp WriteOAMBlock

CutOrBoulderDustAnimationTilesAndAttributes:
	db $FC,$10,$FD,$10
	db $FE,$10,$FF,$10

GetCutOrBoulderDustAnimationOffsets:
	ld hl, wSpriteStateData1 + 4
	ld a, [hli] ; player's sprite screen Y position
	ld b, a
	inc hl
	ld a, [hli] ; player's sprite screen X position
	ld c, a ; bc holds ypos/xpos of player's sprite
	inc hl
	inc hl
	ld a, [hl] ; a holds direction of player (00: down, 04: up, 08: left, 0C: right)
	srl a
	ld e, a
	ld d, $0 ; de holds direction (00: down, 02: up, 04: left, 06: right)
	ld a, [wWhichAnimationOffsets]
	and a
	ld hl, CutAnimationOffsets
	jr z, .next
	ld hl, BoulderDustAnimationOffsets
.next
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld a, b
	add d
	ld b, a
	ld a, c
	add e
	ld c, a
	ret

CutAnimationOffsets:
; Each pair represents the x and y pixels offsets from the player of where the cut tree animation should be drawn
	db  8, 36 ; player is facing down
	db  8,  4 ; player is facing up
	db -8, 20 ; player is facing left
	db 24, 20 ; player is facing right

BoulderDustAnimationOffsets:
; Each pair represents the x and y pixels offsets from the player of where the cut tree animation should be drawn
; These offsets represent 2 blocks away from the player
	db  8,  52 ; player is facing down
	db  8, -12 ; player is facing up
	db -24, 20 ; player is facing left
	db 40,  20 ; player is facing right

ReplaceTreeTileBlock:
; Determine the address of the tile block that contains the tile in front of the
; player (i.e. where the tree is) and replace it with the corresponding tile
; block that doesn't have the tree.
	push de
	ld a, [wCurMapWidth]
	add 6
	ld c, a
	ld b, 0
	ld d, 0
	ld hl, wCurrentTileBlockMapViewPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	add hl, bc
	ld a, [wSpriteStateData1 + 9] ; player sprite's facing direction
	and a
	jr z, .down
	cp SPRITE_FACING_UP
	jr z, .up
	cp SPRITE_FACING_LEFT
	jr z, .left
; right
	ld a, [wXBlockCoord]
	and a
	jr z, .centerTileBlock
	jr .rightOfCenter
.down
	ld a, [wYBlockCoord]
	and a
	jr z, .centerTileBlock
	jr .belowCenter
.up
	ld a, [wYBlockCoord]
	and a
	jr z, .aboveCenter
	jr .centerTileBlock
.left
	ld a, [wXBlockCoord]
	and a
	jr z, .leftOfCenter
	jr .centerTileBlock
.belowCenter
	add hl, bc
.centerTileBlock
	add hl, bc
.aboveCenter
	ld e, $2
	add hl, de
	jr .next
.leftOfCenter
	ld e, $1
	add hl, bc
	add hl, de
	jr .next
.rightOfCenter
	ld e, $3
	add hl, bc
	add hl, de
.next
	pop de
	ld a, [hl]
	ld c, a
.loop ; find the matching tile block in the array
	ld a, [de]
	inc de
	inc de
	cp $ff
	ret z
	cp c
	jr nz, .loop
	dec de
	ld a, [de] ; replacement tile block from matching array entry
	ld [hl], a
	ret

CutTreeBlockSwaps:
; first byte = tileset block containing the cut tree/grass
; second byte = corresponding tileset block after the cut animation happens
	db $32, $6D
	db $33, $6C
	db $34, $6F
	db $35, $4C
	db $60, $6E
	db $3C, $35
	db $3F, $35
	db $3D, $36
	db $FF ; list terminator

; mapping between blocks with grass tiles and corresponding blocks without grass in OVERWORLD tileset
CutGrassBlockSwapsOverworld:
	db $0B, $0A
	db $04, $53					; duplicate grass block turns into stairs block (allows for hidden entrances)
	db $FF

; mapping between blocks with grass tiles and corresponding blocks without grass in FOREST tileset
CutGrassBlockSwapsForest:
	db $01, $1B	; grass block
	db $2F, $1B	; duplicate grass block
	db $04, $35	; grass and stumps block
	db $05, $39	; grass and stumps block
	db $06, $37	; grass and stumps block
	db $07, $3B	; grass and stumps block
	db $08, $48	; grass and stumps block
	db $09, $49	; grass and stumps block
	db $0A, $4C	; grass and stumps block
	db $0B, $4D	; grass and stumps block
	db $0C, $36	; grass and stumps block
	db $0D, $34	; grass and stumps block
	db $0E, $3A	; grass and stumps block
	db $0F, $38	; grass and stumps block
	db $16, $21	; grass and sign block
	db $22, $1B	; partial grass block
	db $23, $1B	; partial grass block
	db $24, $1B	; partial grass block
	db $25, $1B	; partial grass block
	db $10, $68	; grass and shrub block
	db $11, $69	; grass and shrub block
	db $12, $6A	; grass and shrub block
	db $13, $6B	; grass and shrub block
	db $30, $71	; grass and water block
	db $32, $72	; grass and water block
	db $FF
