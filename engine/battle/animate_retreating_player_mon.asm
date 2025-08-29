; show 2 stages of the player mon getting smaller before disappearing
; moved out of bank F
AnimateRetreatingPlayerMon:
	coord hl, 1, 5
	lb bc, 7, 7
	call ClearScreenArea
	coord hl, 3, 7
	lb bc, 5, 5
	xor a
	ld [wDownscaledMonSize], a
	ld [hBaseTileID], a
	predef CopyDownscaledMonTiles
	ld c, 4
	call DelayFrames
	call .clearScreenArea
	coord hl, 4, 9
	lb bc, 3, 3
	ld a, 1
	ld [wDownscaledMonSize], a
	xor a
	ld [hBaseTileID], a
	predef CopyDownscaledMonTiles
	call Delay3
	call .clearScreenArea
	ld a, $4c
	Coorda 5, 11
.clearScreenArea
	coord hl, 1, 5
	lb bc, 7, 7
	jp ClearScreenArea