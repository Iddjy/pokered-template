CheckIfPCBoxWasFilledUp:
	ld a, [wPCBoxWasFilledUp]
	and a
	ret z
.boxWasFilledUp
	call EnableAutoTextBoxDrawing
	xor a
	ld [wAudioFadeOutControl], a
	ld [wPCBoxWasFilledUp], a
	dec a
	call PlaySound
	ld a, SFX_SAFARI_ZONE_PA
	call PlayMusic
.waitForMusicToPlay
	ld a, [wChannelSoundIDs + Ch4]
	cp SFX_SAFARI_ZONE_PA
	jr nz, .waitForMusicToPlay
	call PlayDefaultMusic
	ld a, TEXT_PCBOX_FULL
	ld [hSpriteIndexOrTextID], a
	call DisplayTextID
	ret

PrintPCBoxFullText:
	ld hl, PCBoxFullText
	jp PrintText

PCBoxFullText:
	TX_FAR _PCBoxFullText
	db "@"
