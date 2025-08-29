_DisplayPokedex:
	call GetDexNumberBySpeciesID
	ld hl, wd730
	set 6, [hl]
	predef ShowPokedexData
	ld hl, wd730
	res 6, [hl]
	call ReloadMapData
	ld c, 10
	call DelayFrames
	callab AddToPokedexSeen				; to handle the extended dex
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ret
