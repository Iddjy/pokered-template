PlayDefaultMusic::
	call WaitForSoundToFinish
	xor a
	ld c, a
	ld d, a
	ld [wLastMusicSoundID], a
	jr PlayDefaultMusicCommon

PlayDefaultMusicFadeOutCurrent::
; Fade out the current music and then play the default music.
	ld c, 10
	ld d, 0
	ld a, [wd72e]
	bit 5, a ; has a battle just ended?
	jr z, PlayDefaultMusicCommon
	xor a
	ld [wLastMusicSoundID], a
	ld c, 8
	ld d, c

PlayDefaultMusicCommon::
	ld a, [wWalkBikeSurfState]
	and a
	jr z, .walking
	cp $2
	jr z, .surfing
	ld a, MUSIC_BIKE_RIDING
	jr .next

.surfing
	ld a, MUSIC_SURFING

.next
	ld b, a
	jr .next2

.walking
	ld a, [wMapMusicSoundID]
	ld b, a

.next2
	ld a, [wLastMusicSoundID]
	cp b ; is the default music already playing?
	ret z ; if so, do nothing
	ld a, c
	ld [wAudioFadeOutControl], a
	ld a, b
	ld [wLastMusicSoundID], a
	ld [wNewSoundID], a
	jp PlaySound

UpdateMusic6Times::
; This is called when entering a map, before fading out the current music and
; playing the default music (i.e. the map's music or biking/surfing music).
	ld a, BANK(Audio_UpdateMusic)	; force usage of first sound engine
	ld b, a
	ld hl, Audio_UpdateMusic
	ld c, 6
.loop
	push bc
	push hl
	call Bankswitch
	pop hl
	pop bc
	dec c
	jr nz, .loop
	ret

; add this entrypoint/wrapper for pokemon cries
PlayCrySound::
	push af
	ld a, c				; cry id second byte
	inc a				; we want the cry page to start at one, since it is used to detect if we're playing a cry
	ld [wPlayingCry], a
	pop af
	call PlaySound
	xor a
	ld [wPlayingCry], a
	ret

PlayMusic::
	ld b, a
	ld [wNewSoundID], a
	xor a
	ld [wAudioFadeOutControl], a
	ld a, b

; plays music specified by a. If value is $ff, music is stopped
PlaySound::
	push hl
	push de
	push bc
	ld b, a
	ld a, [wNewSoundID]
	and a
	jr z, .next
	xor a
	ld [wChannelSoundIDs + Ch4], a
	ld [wChannelSoundIDs + Ch5], a
	ld [wChannelSoundIDs + Ch6], a
	ld [wChannelSoundIDs + Ch7], a
.next
	ld a, [wAudioFadeOutControl]
	and a ; has a fade-out length been specified?
	jr z, .noFadeOut
	ld a, [wNewSoundID]
	and a ; is the new sound ID 0?
	jr z, .done ; if so, do nothing
	xor a
	ld [wNewSoundID], a
	ld a, [wLastMusicSoundID]
	cp $ff ; has the music been stopped?
	jr nz, .fadeOut ; if not, fade out the current music
; If it has been stopped, start playing the new music immediately.
	xor a
	ld [wAudioFadeOutControl], a
.noFadeOut
	xor a
	ld [wNewSoundID], a
	ld a, [H_LOADEDROMBANK]
	ld [hSavedROMBank], a
	ld a, BANK(Audio_PlaySound)	; force usage of the first sound engine
	ld [H_LOADEDROMBANK], a
	ld [MBC1RomBank], a
	ld a, b
	call Audio_PlaySound
	ld a, [hSavedROMBank]
	ld [H_LOADEDROMBANK], a
	ld [MBC1RomBank], a
	jr .done

.fadeOut
	ld a, b
	ld [wLastMusicSoundID], a
	ld a, [wAudioFadeOutControl]
	ld [wAudioFadeOutCounterReloadValue], a
	ld [wAudioFadeOutCounter], a
	ld a, b
	ld [wAudioFadeOutControl], a

.done
	pop bc
	pop de
	pop hl
	ret
