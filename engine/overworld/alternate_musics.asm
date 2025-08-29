; add this to allow some maps to have alternate musics under certain circumstances
CheckAlternateMusic:
	ld a, [wCurMap]
	ld b, a
	ld hl, AlternateMapSongs
.loop
	ld a, [hli]
	cp $ff
	ret z
	cp b
	ld a, [hli]
	jr z, .foundMatch
	inc hl
	jr .loop
.foundMatch
	ld h, [hl]
	ld l, a
	jp hl

AlternateMapSongs:
	dbw SILPH_CO_1F, SilphCoAlternateMusic
	dbw SILPH_CO_2F, SilphCoAlternateMusic
	dbw SILPH_CO_3F, SilphCoAlternateMusic
	dbw SILPH_CO_4F, SilphCoAlternateMusic
	dbw SILPH_CO_5F, SilphCoAlternateMusic
	dbw SILPH_CO_6F, SilphCoAlternateMusic
	dbw SILPH_CO_7F, SilphCoAlternateMusic
	dbw SILPH_CO_8F, SilphCoAlternateMusic
	dbw SILPH_CO_9F, SilphCoAlternateMusic
	dbw SILPH_CO_10F, SilphCoAlternateMusic
	dbw SILPH_CO_11F, SilphCoAlternateMusic
	dbw SILPH_CO_ELEVATOR, SilphCoAlternateMusic
	db $FF

; use Saffron City music after Team Rocket is gone
SilphCoAlternateMusic:
	CheckEvent EVENT_SILPH_CO_ALTERNATE_MUSIC
	ret z
	ld a, MUSIC_CITIES1
	ld [wMapMusicSoundID], a
	ret
