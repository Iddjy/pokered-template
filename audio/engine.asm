Audio_UpdateMusic::
	ld c, Ch0
.loop
	ld b, 0
	ld hl, wChannelSoundIDs
	add hl, bc
	ld a, [hl]
	and a
	jr z, .nextChannel
	ld a, c
	cp Ch4
	jr nc, .applyAffects ; if sfx channel
	ld a, [wMuteAudioAndPauseMusic]
	and a
	jr z, .applyAffects
	bit 7, a
	jr nz, .nextChannel
	set 7, a
	ld [wMuteAudioAndPauseMusic], a
	xor a ; disable all channels' output
	ld [rNR51], a
	ld [rNR30], a
	ld a, $80
	ld [rNR30], a
	jr .nextChannel
.applyAffects
	call Audio_ApplyMusicAffects
.nextChannel
	ld a, c
	inc c ; inc channel number
	cp Ch7
	jr nz, .loop
	ret

; this routine checks flags for music effects currently applied
; to the channel and calls certain functions based on flags.
Audio_ApplyMusicAffects:
	ld b, $0
	ld hl, wChannelNoteDelayCounters ; delay until next note
	add hl, bc
	ld a, [hl]
	cp $1 ; if the delay is 1, play next note
	jp z, Audio_PlayNextNote
	dec a ; otherwise, decrease the delay timer
	ld [hl], a
	ld a, c
	cp Ch4
	jr nc, .startChecks ; if a sfx channel
	ld hl, wChannelSoundIDs + Ch4
	add hl, bc
	ld a, [hl]
	and a
	jr z, .startChecks
	ret
.startChecks
	ld hl, wChannelFlags1
	add hl, bc
	bit BIT_ROTATE_DUTY, [hl]
	jr z, .checkForExecuteMusic
	call Audio_ApplyDutyCycle
.checkForExecuteMusic
	ld b, 0
	ld hl, wChannelFlags2
	add hl, bc
	bit BIT_EXECUTE_MUSIC, [hl]
	jr nz, .checkForPitchBend
	ld hl, wChannelFlags1
	add hl, bc
	bit BIT_NOISE_OR_SFX, [hl]
	jr nz, .skipPitchBendVibrato
.checkForPitchBend
	ld hl, wChannelFlags1
	add hl, bc
	bit BIT_PITCH_BEND_ON, [hl]
	jr z, .checkVibratoDelay
	jp Audio_ApplyPitchBend
.checkVibratoDelay
	ld hl, wChannelVibratoDelayCounters
	add hl, bc
	ld a, [hl]
	and a ; check if delay is over
	jr z, .checkForVibrato
	dec [hl] ; otherwise, dec delay
.skipPitchBendVibrato
	ret
.checkForVibrato
	ld hl, wChannelVibratoExtents
	add hl, bc
	ld a, [hl]
	and a
	jr nz, .vibrato
	ret ; no vibrato
.vibrato
	ld d, a
	ld hl, wChannelVibratoRates
	add hl, bc
	ld a, [hl]
	and $f
	and a
	jr z, .applyVibrato
	dec [hl] ; decrement counter
	ret
.applyVibrato
	ld a, [hl]
	swap [hl]
	or [hl]
	ld [hl], a ; reload the counter
	ld hl, wChannelFrequencyLowBytes
	add hl, bc
	ld e, [hl] ; get note pitch
	ld hl, wChannelFlags1
	add hl, bc
; This is the only code that sets/resets the vibrato direction bit, so it
; continuously alternates which path it takes.
	bit BIT_VIBRATO_DIRECTION, [hl]
	jr z, .unset
	res BIT_VIBRATO_DIRECTION, [hl]
	ld a, d
	and $f
	ld d, a
	ld a, e
	sub d
	jr nc, .noCarry
	ld a, 0
.noCarry
	jr .done
.unset
	set BIT_VIBRATO_DIRECTION, [hl]
	ld a, d
	and $f0
	swap a
	add e
	jr nc, .done
	ld a, $ff
.done
	ld d, a
	ld b, REG_FREQUENCY_LO
	call Audio_GetRegisterPointer
	ld [hl], d
	ret

; this routine executes all music commands that take up no time,
; like tempo changes, duty changes etc. and doesn't return
; until the first note is reached
Audio_PlayNextNote:
; reload the vibrato delay counter
	ld hl, wChannelVibratoDelayCounterReloadValues
	add hl, bc
	ld a, [hl]
	ld hl, wChannelVibratoDelayCounters
	add hl, bc
	ld [hl], a

	ld hl, wChannelFlags1
	add hl, bc
	res BIT_PITCH_BEND_ON, [hl]
	res BIT_PITCH_BEND_DECREASING, [hl]
	ld a, c									; imported this from engine 2
	cp Ch4									; imported this from engine 2
	jr nz, .beginChecks						; imported this from engine 2
	ld a, [wLowHealthAlarm]					; imported this from engine 2
	bit 7, a								; imported this from engine 2
	ret nz									; imported this from engine 2
.beginChecks								; imported this from engine 2
	call Audio_endchannel
	ret

Audio_endchannel:
	call Audio_GetNextMusicByte
	ld d, a
	cp $ff ; is this command an endchannel?
	jp nz, Audio_callchannel ; no
	ld b, 0
	ld hl, wChannelFlags1
	add hl, bc
	bit BIT_CHANNEL_CALL, [hl]
	jr nz, .returnFromCall
	ld a, c
	cp Ch3
	jr nc, .noiseOrSfxChannel
	jr .disableChannelOutput
.noiseOrSfxChannel
	res BIT_NOISE_OR_SFX, [hl]
	ld hl, wChannelFlags2
	add hl, bc
	res BIT_EXECUTE_MUSIC, [hl]
	cp Ch6
	jr nz, .skipSfxChannel3
; restart hardware channel 3 (wave channel) output
	ld a, $0
	ld [rNR30], a
	ld a, $80
	ld [rNR30], a
.skipSfxChannel3
	jr nz, .asm_9222
	ld a, [wDisableChannelOutputWhenSfxEnds]
	and a
	jr z, .asm_9222
	xor a
	ld [wDisableChannelOutputWhenSfxEnds], a
	jr .disableChannelOutput
.asm_9222
	jr .asm_9248
.returnFromCall
	res 1, [hl]
	ld d, $0
	ld a, c
	add a
	ld e, a
	ld hl, wChannelCommandPointers
	add hl, de
	push hl ; store current channel address
	ld hl, wChannelReturnAddresses
	add hl, de
	ld e, l
	ld d, h
	pop hl
	ld a, [de]
	ld [hli], a
	inc de
	ld a, [de]
	ld [hl], a ; loads channel address to return to
	jp Audio_endchannel
.disableChannelOutput
	ld hl, Audio_HWChannelDisableMasks
	add hl, bc
	ld a, [rNR51]
	and [hl]
	ld [rNR51], a
.asm_9248
	call Audio_IsCry					; use function instead of duplicating code
	jr nc, .skipCry
.cry
	ld a, c
	cp Ch4
	jr nz, .skipCry						; no need to keep reading the last endchannel command over and over for channels 5 and 7 during cries...
										; it is useless and it messes with the new way to determine if a sound is a cry when the low health alarm is ringing
.asm_9265
	ld a, [wSavedVolume]
	ld [rNR50], a
	xor a
	ld [wSavedVolume], a
.skipCry
	ld hl, wChannelSoundIDs
	add hl, bc
	ld [hl], b
	ld hl, wChannelFlags2
	add hl, bc
	res BIT_CRY_SFX, [hl]				; reset the cry flag now (at the same time as the sound id)
	ret

Audio_callchannel:
	cp $fd ; is this command a callchannel?
	jp nz, Audio_loopchannel ; no
	call Audio_GetNextMusicByte
	push af
	call Audio_GetNextMusicByte
	ld d, a
	pop af
	ld e, a
	push de ; store pointer
	ld d, $0
	ld a, c
	add a
	ld e, a
	ld hl, wChannelCommandPointers
	add hl, de
	push hl
	ld hl, wChannelReturnAddresses
	add hl, de
	ld e, l
	ld d, h
	pop hl
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hld]
	ld [de], a ; copy current channel address
	pop de
	ld [hl], e
	inc hl
	ld [hl], d ; overwrite current address with pointer
	ld b, $0
	ld hl, wChannelFlags1
	add hl, bc
	set BIT_CHANNEL_CALL, [hl] ; set the call flag
	jp Audio_endchannel

Audio_loopchannel:
	cp $fe ; is this command a loopchannel?
	jp nz, Audio_notetype ; no
	call Audio_GetNextMusicByte
	ld e, a
	and a
	jr z, .infiniteLoop
	ld b, 0
	ld hl, wChannelLoopCounters
	add hl, bc
	ld a, [hl]
	cp e
	jr nz, .loopAgain
	ld a, $1 ; if no more loops to make,
	ld [hl], a
	call Audio_GetNextMusicByte ; skip pointer
	call Audio_GetNextMusicByte
	jp Audio_endchannel
.loopAgain ; inc loop count
	inc a
	ld [hl], a
	; fall through
.infiniteLoop ; overwrite current address with pointer
	call Audio_GetNextMusicByte
	push af
	call Audio_GetNextMusicByte
	ld b, a
	ld d, $0
	ld a, c
	add a
	ld e, a
	ld hl, wChannelCommandPointers
	add hl, de
	pop af
	ld [hli], a
	ld [hl], b
	jp Audio_endchannel

Audio_notetype:
	and $f0
	cp $d0 ; is this command a notetype?
	jp nz, Audio_toggleperfectpitch ; no
	ld a, d
	and $f
	ld b, $0
	ld hl, wChannelNoteSpeeds
	add hl, bc
	ld [hl], a ; store low nibble as speed
	ld a, c
	cp Ch3
	jr z, .noiseChannel ; noise channel has 0 params
	call Audio_GetNextMusicByte
	ld d, a
	ld a, c
	cp Ch2
	jr z, .musicChannel3
	cp Ch6
	jr nz, .skipChannel3
	ld hl, wSfxWaveInstrument
	jr .channel3
.musicChannel3
	ld hl, wMusicWaveInstrument
.channel3
	ld a, d
	and $f
	ld [hl], a ; store low nibble of param as wave instrument
	ld a, d
	and $30
	sla a
	ld d, a
	; fall through

	; if channel 3, store high nibble as volume
	; else, store volume (high nibble) and fade (low nibble)
.skipChannel3
	ld b, 0
	ld hl, wChannelVolumes
	add hl, bc
	ld [hl], d
.noiseChannel
	jp Audio_endchannel

Audio_toggleperfectpitch:
	ld a, d
	cp $e8 ; is this command a toggleperfectpitch?
	jr nz, Audio_vibrato ; no
	ld b, 0
	ld hl, wChannelFlags1
	add hl, bc
	ld a, [hl]
	xor $1
	ld [hl], a ; flip bit 0 of wChannelFlags1
	jp Audio_endchannel

Audio_vibrato:
	cp $ea ; is this command a vibrato?
	jr nz, Audio_pitchbend ; no
	call Audio_GetNextMusicByte
	ld b, 0
	ld hl, wChannelVibratoDelayCounters
	add hl, bc
	ld [hl], a ; store delay
	ld hl, wChannelVibratoDelayCounterReloadValues
	add hl, bc
	ld [hl], a ; store delay
	call Audio_GetNextMusicByte
	ld d, a

; The high nybble of the command byte is the extent of the vibrato.
; Let n be the extent.
; The upper nybble of the channel's byte in the wChannelVibratoExtents
; array will store the extent above the note: (n / 2) + (n % 2).
; The lower nybble will store the extent below the note: (n / 2).
; These two values add to the total extent, n.
	and $f0
	swap a
	ld b, 0
	ld hl, wChannelVibratoExtents
	add hl, bc
	srl a
	ld e, a
	adc b
	swap a
	or e
	ld [hl], a

; The low nybble of the command byte is the rate of the vibrato.
; The high and low nybbles of the channel's byte in the wChannelVibratoRates
; array are both initialised to this value because the high nybble is the
; counter reload value and the low nybble is the counter itself, which should
; start at its value upon reload.
	ld a, d
	and $f
	ld d, a
	ld hl, wChannelVibratoRates
	add hl, bc
	swap a
	or d
	ld [hl], a

	jp Audio_endchannel

Audio_pitchbend:
	cp $eb ; is this command a pitchbend?
	jr nz, Audio_duty ; no
	call Audio_GetNextMusicByte
	ld b, 0
	ld hl, wChannelPitchBendLengthModifiers
	add hl, bc
	ld [hl], a
	call Audio_GetNextMusicByte
	ld d, a
	and $f0
	swap a
	ld b, a
	ld a, d
	and $f
	call Audio_CalculateFrequency
	ld b, 0
	ld hl, wChannelPitchBendTargetFrequencyHighBytes
	add hl, bc
	ld [hl], d
	ld hl, wChannelPitchBendTargetFrequencyLowBytes
	add hl, bc
	ld [hl], e
	ld b, 0
	ld hl, wChannelFlags1
	add hl, bc
	set BIT_PITCH_BEND_ON, [hl]
	call Audio_GetNextMusicByte
	ld d, a
	jp Audio_notelength

Audio_duty:
	cp $ec ; is this command a duty?
	jr nz, Audio_tempo ; no
	call Audio_GetNextMusicByte
	rrca
	rrca
	and $c0
	ld b, 0
	ld hl, wChannelDuties
	add hl, bc
	ld [hl], a ; store duty
	jp Audio_endchannel

Audio_tempo:
	cp $ed ; is this command a tempo?
	jr nz, Audio_stereopanning ; no
	ld a, c
	cp Ch4
	jr nc, .sfxChannel
	call Audio_GetNextMusicByte
	ld [wMusicTempo], a ; store first param
	call Audio_GetNextMusicByte
	ld [wMusicTempo + 1], a ; store second param
	xor a
	ld [wChannelNoteDelayCountersFractionalPart], a ; clear RAM
	ld [wChannelNoteDelayCountersFractionalPart + 1], a
	ld [wChannelNoteDelayCountersFractionalPart + 2], a
	ld [wChannelNoteDelayCountersFractionalPart + 3], a
	jr .musicChannelDone
.sfxChannel
	call Audio_GetNextMusicByte
	ld [wSfxTempo], a ; store first param
	call Audio_GetNextMusicByte
	ld [wSfxTempo + 1], a ; store second param
	xor a
	ld [wChannelNoteDelayCountersFractionalPart + 4], a ; clear RAM
	ld [wChannelNoteDelayCountersFractionalPart + 5], a
	ld [wChannelNoteDelayCountersFractionalPart + 6], a
	ld [wChannelNoteDelayCountersFractionalPart + 7], a
.musicChannelDone
	jp Audio_endchannel

Audio_stereopanning:
	cp $ee ; is this command a stereopanning?
	jr nz, Audio_unknownmusic0xef ; no
	call Audio_GetNextMusicByte
	ld [wStereoPanning], a ; store panning
	jp Audio_endchannel

; this appears to never be used
Audio_unknownmusic0xef:
	cp $ef ; is this command an unknownmusic0xef?
	jr nz, Audio_dutycycle ; no
	call Audio_GetNextMusicByte
	push bc
	call Audio_PlaySound
	pop bc
	ld a, [wDisableChannelOutputWhenSfxEnds]
	and a
	jr nz, .skip
	ld a, [wChannelSoundIDs + Ch7]
	ld [wDisableChannelOutputWhenSfxEnds], a
	xor a
	ld [wChannelSoundIDs + Ch7], a
.skip
	jp Audio_endchannel

Audio_dutycycle:
	cp $fc ; is this command a dutycycle?
	jr nz, Audio_volume ; no
	call Audio_GetNextMusicByte
	ld b, 0
	ld hl, wChannelDutyCycles
	add hl, bc
	ld [hl], a ; store full cycle
	and $c0
	ld hl, wChannelDuties
	add hl, bc
	ld [hl], a ; store first duty
	ld hl, wChannelFlags1
	add hl, bc
	set BIT_ROTATE_DUTY, [hl]
	jp Audio_endchannel

Audio_volume:
	cp $f0 ; is this command a volume?
	jr nz, Audio_executemusic ; no
	call Audio_GetNextMusicByte
	ld [rNR50], a ; store volume
	jp Audio_endchannel

Audio_executemusic:
	cp $f8 ; is this command an executemusic?
	jr nz, Audio_octave ; no
	ld b, $0
	ld hl, wChannelFlags2
	add hl, bc
	set BIT_EXECUTE_MUSIC, [hl]
	jp Audio_endchannel

Audio_octave:
	and $f0
	cp $e0 ; is this command an octave?
	jr nz, Audio_sfxnote ; no
	ld hl, wChannelOctaves
	ld b, 0
	add hl, bc
	ld a, d
	and $f
	ld [hl], a ; store low nibble as octave
	jp Audio_endchannel

; sfxnote is either squarenote or noisenote depending on the channel
Audio_sfxnote:
	cp $20 ; is this command a sfxnote?
	jr nz, Audio_pitchenvelope
	ld a, c
	cp Ch3 ; is this a noise or sfx channel?
	jr c, Audio_pitchenvelope ; no
	ld b, 0
	ld hl, wChannelFlags2
	add hl, bc
	bit BIT_EXECUTE_MUSIC, [hl] ; is executemusic being used?
	jr nz, Audio_pitchenvelope ; yes
	call Audio_notelength

; This code seems to do the same thing as what Audio_ApplyDutyAndSoundLength
; does below.
	ld d, a
	ld b, 0
	ld hl, wChannelDuties
	add hl, bc
	ld a, [hl]
	or d
	ld d, a
	ld b, REG_DUTY_SOUND_LEN
	call Audio_GetRegisterPointer
	ld [hl], d

	call Audio_GetNextMusicByte
	ld d, a
	ld b, REG_VOLUME_ENVELOPE
	call Audio_GetRegisterPointer
	ld [hl], d
	call Audio_GetNextMusicByte
	ld e, a
	ld a, c
	cp Ch7
	ld a, 0
	jr z, .skip
; Channels 1 through 3 have 2 registers that control frequency, but the noise
; channel a single register (the polynomial counter) that controls frequency,
; so this command has one less byte on the noise channel.
	push de
	call Audio_GetNextMusicByte
	pop de
.skip
	ld d, a
	push de
	call Audio_ApplyDutyAndSoundLength
	call Audio_EnableChannelOutput
	pop de
	call Audio_ApplyWavePatternAndFrequency
	ret

Audio_pitchenvelope:
	ld a, c
	cp Ch4
	jr c, Audio_note ; if not a sfx
	ld a, d
	cp $10 ; is this command a pitchenvelope?
	jr nz, Audio_note ; no
	ld b, $0
	ld hl, wChannelFlags2
	add hl, bc
	bit BIT_EXECUTE_MUSIC, [hl]
	jr nz, Audio_note ; no
	call Audio_GetNextMusicByte
	ld [rNR10], a
	jp Audio_endchannel

Audio_note:
	ld a, c
	cp Ch3
	jr nz, Audio_notelength ; if not noise channel
	ld a, d
	and $f0
	cp $b0 ; is this command a dnote?
	jr z, Audio_dnote
	jr nc, Audio_notelength ; no
	swap a
	ld b, a
	ld a, d
	and $f
	ld d, a
	ld a, b
	push de
	push bc
	jr asm_94fd

Audio_dnote:
	ld a, d
	and $f
	push af
	push bc
	call Audio_GetNextMusicByte ; get dnote instrument
asm_94fd
	ld d, a
	ld a, [wDisableChannelOutputWhenSfxEnds]
	and a
	jr nz, .asm_9508
	ld a, d
	call Audio_PlaySound
.asm_9508
	pop bc
	pop de

Audio_notelength:
	ld a, d
	push af
	and $f
	inc a
	ld b, 0
	ld e, a  ; store note length (in 16ths)
	ld d, b
	ld hl, wChannelNoteSpeeds
	add hl, bc
	ld a, [hl]
	ld l, b
	call Audio_MultiplyAdd
	ld a, c
	cp Ch4
	jr nc, .sfxChannel
	ld a, [wMusicTempo]
	ld d, a
	ld a, [wMusicTempo + 1]
	ld e, a
	jr .skip
.sfxChannel
	ld d, $1
	ld e, $0
	cp Ch7
	jr z, .skip ; if noise channel
	call Audio_SetSfxTempo
	ld a, [wSfxTempo]
	ld d, a
	ld a, [wSfxTempo + 1]
	ld e, a
.skip
	ld a, l ; a = note_length * note_speed
	ld b, 0
	ld hl, wChannelNoteDelayCountersFractionalPart
	add hl, bc
	ld l, [hl]
	call Audio_MultiplyAdd
	ld e, l
	ld d, h ; de = note_delay_frac_part + (note_length * note_speed * tempo)
	ld hl, wChannelNoteDelayCountersFractionalPart
	add hl, bc
	ld [hl], e
	ld a, d
	ld hl, wChannelNoteDelayCounters
	add hl, bc
	ld [hl], a
	ld hl, wChannelFlags2
	add hl, bc
	bit BIT_EXECUTE_MUSIC, [hl]
	jr nz, Audio_notepitch
	ld hl, wChannelFlags1
	add hl, bc
	bit BIT_NOISE_OR_SFX, [hl]
	jr z, Audio_notepitch
	pop hl
	ret

Audio_notepitch:
	pop af
	and $f0
	cp $c0 ; compare to rest
	jr nz, .notRest
	ld a, c
	cp Ch4
	jr nc, .next
; If this isn't an SFX channel, try the corresponding SFX channel.
	ld hl, wChannelSoundIDs + Ch4
	add hl, bc
	ld a, [hl]
	and a
	jr nz, .done
	; fall through
.next
	ld a, c
	cp Ch2
	jr z, .channel3
	cp Ch6
	jr nz, .notChannel3
.channel3
	ld b, 0
	ld hl, Audio_HWChannelDisableMasks
	add hl, bc
	ld a, [rNR51]
	and [hl]
	ld [rNR51], a ; disable hardware channel 3's output
	jr .done
.notChannel3
	ld b, REG_VOLUME_ENVELOPE
	call Audio_GetRegisterPointer
	ld a, $8 ; fade in sound
	ld [hli], a
	inc hl
	ld a, $80 ; restart sound
	ld [hl], a
.done
	ret
.notRest
	swap a
	ld b, 0
	ld hl, wChannelOctaves
	add hl, bc
	ld b, [hl]
	call Audio_CalculateFrequency
	ld b, 0
	ld hl, wChannelFlags1
	add hl, bc
	bit BIT_PITCH_BEND_ON, [hl]
	jr z, .skipPitchBend
	call Audio_InitPitchBendVars
.skipPitchBend
	push de
	ld a, c
	cp Ch4
	jr nc, .sfxChannel ; if sfx channel
; If this isn't an SFX channel, try the corresponding SFX channel.
	ld hl, wChannelSoundIDs + Ch4
	ld d, 0
	ld e, a
	add hl, de
	ld a, [hl]
	and a
	jr nz, .noSfx
	jr .sfxChannel
.noSfx
	pop de
	ret
.sfxChannel
	ld b, 0
	ld hl, wChannelVolumes
	add hl, bc
	ld d, [hl]
	ld b, REG_VOLUME_ENVELOPE
	call Audio_GetRegisterPointer
	ld [hl], d
	call Audio_ApplyDutyAndSoundLength
	call Audio_EnableChannelOutput
	pop de
	ld b, $0
	ld hl, wChannelFlags1
	add hl, bc
	bit BIT_PERFECT_PITCH, [hl] ; has toggleperfectpitch been used?
	jr z, .skipFrequencyInc
	inc e                       ; if yes, increment the frequency by 1
	jr nc, .skipFrequencyInc
	inc d
.skipFrequencyInc
	ld hl, wChannelFrequencyLowBytes
	add hl, bc
	ld [hl], e
	call Audio_ApplyWavePatternAndFrequency
	ret

Audio_EnableChannelOutput:
	ld b, 0
	ld hl, Audio_HWChannelEnableMasks
	add hl, bc
	ld a, [rNR51]
	or [hl] ; set this channel's bits
	ld d, a
	ld a, c
	cp Ch7
	jr z, .noiseChannelOrNoSfx
	cp Ch4
	jr nc, .skip ; if sfx channel
; If this isn't an SFX channel, try the corresponding SFX channel.
	ld hl, wChannelSoundIDs + Ch4
	add hl, bc
	ld a, [hl]
	and a
	jr nz, .skip
.noiseChannelOrNoSfx
; If this is the SFX noise channel or a music channel whose corresponding
; SFX channel is off, apply stereo panning.
	ld a, [wStereoPanning]
	ld hl, Audio_HWChannelEnableMasks
	add hl, bc
	and [hl]
	ld d, a
	ld a, [rNR51]
	ld hl, Audio_HWChannelDisableMasks
	add hl, bc
	and [hl] ; reset this channel's output bits
	or d ; set this channel's output bits that enabled in [wStereoPanning]
	ld d, a
.skip
	ld a, d
	ld [rNR51], a
	ret

Audio_ApplyDutyAndSoundLength:
	ld b, 0
	ld hl, wChannelNoteDelayCounters ; use the note delay as sound length
	add hl, bc
	ld d, [hl]
	ld a, c
	cp Ch2
	jr z, .skipDuty ; if music channel 3
	cp Ch6
	jr z, .skipDuty ; if sfx channel 3
; include duty (except on channel 3 which doesn't have it)
	ld a, d
	and $3f
	ld d, a
	ld hl, wChannelDuties
	add hl, bc
	ld a, [hl]
	or d
	ld d, a
.skipDuty
	ld b, REG_DUTY_SOUND_LEN
	call Audio_GetRegisterPointer
	ld [hl], d
	ret

Audio_ApplyWavePatternAndFrequency:
	ld a, c
	cp Ch2
	jr z, .channel3
	cp Ch6
	jr nz, .notChannel3
	; fall through
.channel3
	push de
	ld de, wMusicWaveInstrument
	cp Ch2
	jr z, .next
	ld de, wSfxWaveInstrument
.next
	ld a, [de]
	add a
	ld d, 0
	ld e, a
	ld hl, Audio_WavePointers
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, $ff30 ; wave pattern RAM
	ld b, $f
	ld a, $0 ; stop hardware channel 3
	ld [rNR30], a
.loop
	ld a, [de]
	inc de
	ld [hli], a
	ld a, b
	dec b
	and a
	jr nz, .loop
	ld a, $80 ; start hardware channel 3
	ld [rNR30], a
	pop de
.notChannel3
	ld a, d
	or $80 ; use counter mode (i.e. disable output when the counter reaches 0)
	and $c7 ; zero the unused bits in the register
	ld d, a
	ld b, REG_FREQUENCY_LO
	call Audio_GetRegisterPointer
	ld [hl], e ; store frequency low byte
	inc hl
	ld [hl], d ; store frequency high byte
	ld a, c									; imported from engine 2
	cp Ch4									; imported from engine 2
	jr c, .musicChannel						; imported from engine 2
	call Audio_ApplyFrequencyModifier
.musicChannel								; imported from engine 2
	ret

Audio_SetSfxTempo:
	call Audio_IsCry
	jr c, .cry
	call Audio_IsBattleSfx					; imported from engine 2
	jr nc, .notCry							; imported from engine 2
	ld a, [wIsInBattle]
	and a
	jr z, .notCry
	ld d, $0								; imported from engine 2
	jr .sfx									; imported from engine 2
.cry
	ld a, [wTempoModifier + 1]				; use 2 bytes tempo modifier
	ld d, a									; use 2 bytes tempo modifier
.sfx
	ld a, [wTempoModifier]
	add $80
	jr nc, .noCarry
	inc d
.noCarry
	ld [wSfxTempo + 1], a
	ld a, d
	ld [wSfxTempo], a
	jr .done
.notCry
	xor a
	ld [wSfxTempo + 1], a
	ld a, $1
	ld [wSfxTempo], a
.done
	ret

Audio_ApplyFrequencyModifier:
	call Audio_IsCry
	jr c, .cry
	call Audio_IsBattleSfx					; imported from engine 2
	jr nc, .done							; imported from engine 2
	ld a, [wIsInBattle]
	and a
	ret z
; if playing a cry, add the cry's frequency modifier
.cry
	ld a, [wFrequencyModifier]
	add e
	ld e, a									; use 2 bytes frequency modifier
	ld a, [wFrequencyModifier + 1]			; use 2 bytes frequency modifier
	adc d									; use 2 bytes frequency modifier
	ld d, a									; use 2 bytes frequency modifier
	dec hl
	ld [hl], e
	inc hl
	ld [hl], d
.done
	ret

Audio_IsCry:
; Returns whether the currently playing audio is a cry in carry.
	ld a, [wChannelFlags2 + Ch4]	; use new flag instead of sound id
	bit BIT_CRY_SFX, a
	jr nz, .yes
.no
	scf
	ccf
	ret
.yes
	scf
	ret

; imported from engine 2
Audio_IsBattleSfx:
	ld a, [wChannelSoundIDs + Ch7]
	ld b, a
	ld a, [wChannelSoundIDs + Ch4]
	or b
	cp BATTLE_SFX_START
	jr nc, .maybe
	jr .no
.maybe
	cp MAX_SFX_ID + 1
	jr z, .no
	jr c, .yes
.no
	scf
	ccf
	ret
.yes
	scf
	ret

Audio_ApplyPitchBend:
	ld hl, wChannelFlags1
	add hl, bc
	bit BIT_PITCH_BEND_DECREASING, [hl]
	jp nz, .frequencyDecreasing
; frequency increasing
	ld hl, wChannelPitchBendCurrentFrequencyLowBytes
	add hl, bc
	ld e, [hl]
	ld hl, wChannelPitchBendCurrentFrequencyHighBytes
	add hl, bc
	ld d, [hl]
	ld hl, wChannelPitchBendFrequencySteps
	add hl, bc
	ld l, [hl]
	ld h, b
	add hl, de
	ld d, h
	ld e, l
	ld hl, wChannelPitchBendCurrentFrequencyFractionalPart
	add hl, bc
	push hl
	ld hl, wChannelPitchBendFrequencyStepsFractionalPart
	add hl, bc
	ld a, [hl]
	pop hl
	add [hl]
	ld [hl], a
	ld a, 0
	adc e
	ld e, a
	ld a, 0
	adc d
	ld d, a
	ld hl, wChannelPitchBendTargetFrequencyHighBytes
	add hl, bc
	ld a, [hl]
	cp d
	jp c, .reachedTargetFrequency
	jr nz, .applyUpdatedFrequency
	ld hl, wChannelPitchBendTargetFrequencyLowBytes
	add hl, bc
	ld a, [hl]
	cp e
	jp c, .reachedTargetFrequency
	jr .applyUpdatedFrequency
.frequencyDecreasing
	ld hl, wChannelPitchBendCurrentFrequencyLowBytes
	add hl, bc
	ld a, [hl]
	ld hl, wChannelPitchBendCurrentFrequencyHighBytes
	add hl, bc
	ld d, [hl]
	ld hl, wChannelPitchBendFrequencySteps
	add hl, bc
	ld e, [hl]
	sub e
	ld e, a
	ld a, d
	sbc b
	ld d, a
	ld hl, wChannelPitchBendFrequencyStepsFractionalPart
	add hl, bc
	ld a, [hl]
	add a
	ld [hl], a
	ld a, e
	sbc b
	ld e, a
	ld a, d
	sbc b
	ld d, a
	ld hl, wChannelPitchBendTargetFrequencyHighBytes
	add hl, bc
	ld a, d
	cp [hl]
	jr c, .reachedTargetFrequency
	jr nz, .applyUpdatedFrequency
	ld hl, wChannelPitchBendTargetFrequencyLowBytes
	add hl, bc
	ld a, e
	cp [hl]
	jr c, .reachedTargetFrequency
.applyUpdatedFrequency
	ld hl, wChannelPitchBendCurrentFrequencyLowBytes
	add hl, bc
	ld [hl], e
	ld hl, wChannelPitchBendCurrentFrequencyHighBytes
	add hl, bc
	ld [hl], d
	ld b, REG_FREQUENCY_LO
	call Audio_GetRegisterPointer
	ld a, e
	ld [hli], a
	ld [hl], d
	ret
.reachedTargetFrequency
; Turn off pitch bend when the target frequency has been reached.
	ld hl, wChannelFlags1
	add hl, bc
	res BIT_PITCH_BEND_ON, [hl]
	res BIT_PITCH_BEND_DECREASING, [hl]
	ret

Audio_InitPitchBendVars:
	ld hl, wChannelPitchBendCurrentFrequencyHighBytes
	add hl, bc
	ld [hl], d
	ld hl, wChannelPitchBendCurrentFrequencyLowBytes
	add hl, bc
	ld [hl], e
	ld hl, wChannelNoteDelayCounters
	add hl, bc
	ld a, [hl]
	ld hl, wChannelPitchBendLengthModifiers
	add hl, bc
	sub [hl]
	jr nc, .next
	ld a, 1
.next
	ld [hl], a
	ld hl, wChannelPitchBendTargetFrequencyLowBytes
	add hl, bc
	ld a, e
	sub [hl]
	ld e, a
	ld a, d
	sbc b
	ld hl, wChannelPitchBendTargetFrequencyHighBytes
	add hl, bc
	sub [hl]
	jr c, .targetFrequencyGreater
	ld d, a
	ld b, 0
	ld hl, wChannelFlags1
	add hl, bc
	set BIT_PITCH_BEND_DECREASING, [hl]
	jr .next2
.targetFrequencyGreater
; If the target frequency is greater, subtract the current frequency from
; the target frequency to get the absolute difference.
	ld hl, wChannelPitchBendCurrentFrequencyHighBytes
	add hl, bc
	ld d, [hl]
	ld hl, wChannelPitchBendCurrentFrequencyLowBytes
	add hl, bc
	ld e, [hl]
	ld hl, wChannelPitchBendTargetFrequencyLowBytes
	add hl, bc
	ld a, [hl]
	sub e
	ld e, a

; Bug. Instead of borrowing from the high byte of the target frequency as it
; should, it borrows from the high byte of the current frequency instead.
; This means that the result will be 0x200 greater than it should be if the
; low byte of the current frequency is greater than the low byte of the
; target frequency.
	ld a, d
	sbc b
	ld d, a

	ld hl, wChannelPitchBendTargetFrequencyHighBytes
	add hl, bc
	ld a, [hl]
	sub d
	ld d, a
	ld b, 0
	ld hl, wChannelFlags1
	add hl, bc
	res BIT_PITCH_BEND_DECREASING, [hl]

.next2
	ld hl, wChannelPitchBendLengthModifiers
	add hl, bc
.divideLoop
	inc b
	ld a, e
	sub [hl]
	ld e, a
	jr nc, .divideLoop
	ld a, d
	and a
	jr z, .doneDividing
	dec a
	ld d, a
	jr .divideLoop
.doneDividing
	ld a, e ; a = remainder - dividend
	add [hl]
	ld d, b ; d = quotient + 1
	ld b, 0
	ld hl, wChannelPitchBendFrequencySteps
	add hl, bc
	ld [hl], d ; store quotient + 1
	ld hl, wChannelPitchBendFrequencyStepsFractionalPart
	add hl, bc
	ld [hl], a ; store remainder - dividend
	ld hl, wChannelPitchBendCurrentFrequencyFractionalPart
	add hl, bc
	ld [hl], a ; store remainder - dividend
	ret

Audio_ApplyDutyCycle:
	ld b, 0
	ld hl, wChannelDutyCycles
	add hl, bc
	ld a, [hl]
	rlca
	rlca
	ld [hl], a
	and $c0
	ld d, a
	ld b, REG_DUTY_SOUND_LEN
	call Audio_GetRegisterPointer
	ld a, [hl]
	and $3f
	or d
	ld [hl], a
	ret

; input: channel number in c
; output: next music byte in a
; sets the address of the next byte in wChannelCommandPointers
Audio_GetNextMusicByte:
	ld d, 0
	ld a, c
	add a							; double channel number since command pointers are 2 bytes
	ld e, a
	ld hl, wChannelCommandPointers
	add hl, de						; make hl point to pointer to current byte for input channel
	ld a, [hli]
	ld e, a
	ld a, [hld]
	ld d, a
	push hl
	push bc
	ld hl, wChannelFlags2
	ld b, 0
	add hl, bc
	bit BIT_CRY_SFX, [hl]				; use new flag instead of relying on the sound id
	pop bc
	pop hl
	jr z, .notCry
	ld a, [wCryBank]					; cries have their own variable because of a race condition with the low health alarm
	jr .gotBank
.notCry
	push hl
	push bc
	ld hl, wChannelSoundIDs
	ld b, 0
	add hl, bc
	ld a, [hl]							; get sound id currently playing on this channel
	pop bc
	pop hl
	cp MAX_SFX_ID + 1					; check if it's a music
	jr nc, .music
	cp MAX_INSTRUMENT_ID + 1			; check if it's an instrument
	jr c, .instrument
	ld a, [wSfxBank]					; else it's a standard sfx
	jr .gotBank
.music
	ld a, [wMusicBank]
	jr .gotBank
.instrument
	ld a, [wInstrumentBank]				; instruments have to use a dedicated variable to store the bank, else it would clash with standard sfx
.gotBank
	call LoadMusicByte					; call the routine that will fetch the byte from the target bank
	ld a, [wCurMusicByte]
	inc de
	ld [hl], e ; store address of next command
	inc hl
	ld [hl], d
	ret

Audio_GetRegisterPointer:
; hl = address of hardware sound register b for software channel c
	ld a, c
	ld hl, Audio_HWChannelBaseAddresses
	add l
	jr nc, .noCarry
	inc h
.noCarry
	ld l, a
	ld a, [hl]
	add b
	ld l, a
	ld h, $ff
	ret

Audio_MultiplyAdd:
; hl = l + (a * de)
	ld h, 0
.loop
	srl a
	jr nc, .skipAdd
	add hl, de
.skipAdd
	sla e
	rl d
	and a
	jr z, .done
	jr .loop
.done
	ret

Audio_CalculateFrequency:
; return the frequency for note a, octave b in de
	ld h, 0
	ld l, a
	add hl, hl
	ld d, h
	ld e, l
	ld hl, Audio_Pitches
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld a, b
.loop
	cp 7
	jr z, .done
	sra d
	rr e
	inc a
	jr .loop
.done
	ld a, 8
	add d
	ld d, a
	ret

Audio_PlaySound::
	ld [wSoundID], a
	cp $ff
	jp z, .stopAllAudio
	ld a, [wPlayingCry]
	and a
	ld a, [wSoundID]
	jp nz, .playSfx						; check if we're playing a cry
	cp MAX_SFX_ID
	jp z, .playSfx
	jp c, .playSfx

.playMusic
	ld l, a
	ld h, 0
	add hl, hl							; double the sound id since pointers are 2 bytes
	ld de, Audio_HeadersPointerTable	; use the new pointer table instead of adding 3 times the sound id
	add hl, de
	ld a, [hli]							; read the pointer to the header
	ld h, [hl]							; read the pointer to the header
	ld l, a								; read the pointer to the header
	ld a, [hl]							; read the added byte containing the bank
	ld [wMusicBank], a					; store the bank in wMusicBank
	xor a
	ld [wUnusedC000], a
	ld [wDisableChannelOutputWhenSfxEnds], a
	ld [wMusicTempo + 1], a
	ld [wMusicWaveInstrument], a
	ld [wSfxWaveInstrument], a
	ld d, $8
	ld hl, wChannelReturnAddresses
	call .FillMem
	ld hl, wChannelCommandPointers
	call .FillMem
	ld d, $4
	ld hl, wChannelSoundIDs
	call .FillMem
	ld hl, wChannelFlags1
	call .FillMem
	ld hl, wChannelDuties
	call .FillMem
	ld hl, wChannelDutyCycles
	call .FillMem
	ld hl, wChannelVibratoDelayCounters
	call .FillMem
	ld hl, wChannelVibratoExtents
	call .FillMem
	ld hl, wChannelVibratoRates
	call .FillMem
	ld hl, wChannelFrequencyLowBytes
	call .FillMem
	ld hl, wChannelVibratoDelayCounterReloadValues
	call .FillMem
	ld hl, wChannelFlags2
	call .FillMem
	ld hl, wChannelPitchBendLengthModifiers
	call .FillMem
	ld hl, wChannelPitchBendFrequencySteps
	call .FillMem
	ld hl, wChannelPitchBendFrequencyStepsFractionalPart
	call .FillMem
	ld hl, wChannelPitchBendCurrentFrequencyFractionalPart
	call .FillMem
	ld hl, wChannelPitchBendCurrentFrequencyHighBytes
	call .FillMem
	ld hl, wChannelPitchBendCurrentFrequencyLowBytes
	call .FillMem
	ld hl, wChannelPitchBendTargetFrequencyHighBytes
	call .FillMem
	ld hl, wChannelPitchBendTargetFrequencyLowBytes
	call .FillMem
	ld a, $1
	ld hl, wChannelLoopCounters
	call .FillMem
	ld hl, wChannelNoteDelayCounters
	call .FillMem
	ld hl, wChannelNoteSpeeds
	call .FillMem
	ld [wMusicTempo], a
	ld a, $ff
	ld [wStereoPanning], a
	xor a
	ld [rNR50], a
	ld a, $8
	ld [rNR10], a
	ld a, 0
	ld [rNR51], a
	xor a
	ld [rNR30], a
	ld a, $80
	ld [rNR30], a
	ld a, $77
	ld [rNR50], a
	jp .playSoundCommon

.playSfx
	ld l, a
	ld h, 0
	add hl, hl								; double the sound id since pointers are 2 bytes
	ld a, [wPlayingCry]
	and a
	ld de, Audio_HeadersPointerTable		; use the new pointer table instead of adding 3 times the sound id
	jr z, .gotPointerTable
	ld de, Audio_CryHeadersPointerTable
	dec a
	jr z, .gotPointerTable
	ld de, Audio_CryHeadersPointerTable2
.gotPointerTable
	add hl, de
	ld a, [hli]							; read the pointer to the header
	ld h, [hl]							; read the pointer to the header
	ld l, a								; read the pointer to the header
	ld a, h
	ld [wSfxHeaderPointer], a
	ld a, l
	ld [wSfxHeaderPointer + 1], a
	ld a, [wPlayingCry]					; use variable instead of sound id to determine if we're playing a cry
	and a
	ld de, wCryBank						; use dedicated variable for cries, to avoid problems with the low health alarm
	jr nz, .loadBank					; if playing a cry, we have the correct bank
	ld a, [wSoundID]					; if we're not playing a cry, check for type of sfx
	cp MAX_INSTRUMENT_ID + 1			; instruments (sfx played in songs) use their own variable to store the bank
	jr nc, .notInstrument				; otherwise it would conflict with the bank for other sfx that need to be played at the same time
	ld de, wInstrumentBank
	jr .loadBank
.notInstrument
	ld de, wSfxBank
.loadBank
	ld a, [hli]							; read the added byte containing the bank
	ld [de], a							; store the bank in wCryBank, wSfxBank or wInstrumentBank according to sound type and id
	ld a, [hl]
	and $c0
	rlca
	rlca
	ld c, a
.sfxChannelLoop
	ld d, c
	ld a, c
	add a
	add c
	ld c, a
	ld b, 0
	ld a, [wSfxHeaderPointer]
	ld h, a
	ld a, [wSfxHeaderPointer + 1]
	ld l, a
	add hl, bc
	inc hl								; skip the added byte containing the bank
	ld c, d
	ld a, [hl]
	and $f
	ld e, a ; software channel ID
	ld d, 0
	ld hl, wChannelSoundIDs
	add hl, de
	ld a, [hl]
	and a
	jr z, .asm_99a3
	ld a, [wPlayingCry]
	and a
	jr nz, .asm_99a3					; if playing a cry, skip the tests below
	ld a, e
	cp Ch7
	jr nz, .asm_999a
	ld a, [wSoundID]
	cp MAX_INSTRUMENT_ID + 1
	jr nc, .asm_9993
	ret									; if sound id to play is an instrument and current channel is Ch7, don't do the rest of the routine
.asm_9993
	ld a, [hl]
	cp MAX_INSTRUMENT_ID				; if sound id currently playing for this channel is an instrument, do the rest of the routine
	jr z, .asm_99a3						; also jump for the first cry (bug?)
	jr c, .asm_99a3
.asm_999a
	ld a, [wSoundID]					; if it's not channel 7, compare the sound to play to the sound currently playing
	cp [hl]								; if sound id to play is <= to the sound id currently playing, do the rest of the routine
	jr z, .asm_99a3
	jr c, .asm_99a3
	ret
.asm_99a3
	xor a
	push de
	ld h, d
	ld l, e
	add hl, hl
	ld d, h
	ld e, l
	ld hl, wChannelReturnAddresses
	add hl, de
	ld [hli], a
	ld [hl], a
	ld hl, wChannelCommandPointers
	add hl, de
	ld [hli], a
	ld [hl], a
	pop de
	ld hl, wChannelSoundIDs
	add hl, de
	ld [hl], a
	ld hl, wChannelFlags1
	add hl, de
	ld [hl], a
	ld hl, wChannelDuties
	add hl, de
	ld [hl], a
	ld hl, wChannelDutyCycles
	add hl, de
	ld [hl], a
	ld hl, wChannelVibratoDelayCounters
	add hl, de
	ld [hl], a
	ld hl, wChannelVibratoExtents
	add hl, de
	ld [hl], a
	ld hl, wChannelVibratoRates
	add hl, de
	ld [hl], a
	ld hl, wChannelFrequencyLowBytes
	add hl, de
	ld [hl], a
	ld hl, wChannelVibratoDelayCounterReloadValues
	add hl, de
	ld [hl], a
	ld hl, wChannelPitchBendLengthModifiers
	add hl, de
	ld [hl], a
	ld hl, wChannelPitchBendFrequencySteps
	add hl, de
	ld [hl], a
	ld hl, wChannelPitchBendFrequencyStepsFractionalPart
	add hl, de
	ld [hl], a
	ld hl, wChannelPitchBendCurrentFrequencyFractionalPart
	add hl, de
	ld [hl], a
	ld hl, wChannelPitchBendCurrentFrequencyHighBytes
	add hl, de
	ld [hl], a
	ld hl, wChannelPitchBendCurrentFrequencyLowBytes
	add hl, de
	ld [hl], a
	ld hl, wChannelPitchBendTargetFrequencyHighBytes
	add hl, de
	ld [hl], a
	ld hl, wChannelPitchBendTargetFrequencyLowBytes
	add hl, de
	ld [hl], a
	ld hl, wChannelFlags2
	add hl, de
	ld [hl], a
	ld a, $1
	ld hl, wChannelLoopCounters
	add hl, de
	ld [hl], a
	ld hl, wChannelNoteDelayCounters
	add hl, de
	ld [hl], a
	ld hl, wChannelNoteSpeeds
	add hl, de
	ld [hl], a
	ld a, e
	cp Ch4
	jr nz, .asm_9a2b
	ld a, $8
	ld [rNR10], a ; sweep off
.asm_9a2b
	ld a, c
	and a
	jp z, .playSoundCommon
	dec c
	jp .sfxChannelLoop

.stopAllAudio
	ld a, $80
	ld [rNR52], a ; sound hardware on
	ld [rNR30], a ; wave playback on
	xor a
	ld [rNR51], a ; no sound output
	ld [rNR32], a ; mute channel 3 (wave channel)
	ld a, $8
	ld [rNR10], a ; sweep off
	ld [rNR12], a ; mute channel 1 (pulse channel 1)
	ld [rNR22], a ; mute channel 2 (pulse channel 2)
	ld [rNR42], a ; mute channel 4 (noise channel)
	ld a, $40
	ld [rNR14], a ; counter mode
	ld [rNR24], a
	ld [rNR44], a
	ld a, $77
	ld [rNR50], a ; full volume
	xor a
	ld [wUnusedC000], a
	ld [wDisableChannelOutputWhenSfxEnds], a
	ld [wMuteAudioAndPauseMusic], a
	ld [wMusicTempo + 1], a
	ld [wSfxTempo + 1], a
	ld [wMusicWaveInstrument], a
	ld [wSfxWaveInstrument], a
	ld d, $a0
	ld hl, wChannelCommandPointers
	call .FillMem
	ld a, $1
	ld d, $18
	ld hl, wChannelNoteDelayCounters
	call .FillMem
	ld [wMusicTempo], a
	ld [wSfxTempo], a
	ld a, $ff
	ld [wStereoPanning], a
	ret

; fills d bytes at hl with a
.FillMem
	ld b, d
.loop
	ld [hli], a
	dec b
	jr nz, .loop
	ret

.playSoundCommon
	ld a, [wSoundID]
	ld l, a
	ld h, 0
	add hl, hl								; double the sound id since pointers are 2 bytes
	ld a, [wPlayingCry]
	and a
	ld de, Audio_HeadersPointerTable		; use the new pointer table instead of adding 3 times the sound id
	jr z, .gotPointerTable2
	ld de, Audio_CryHeadersPointerTable
	dec a
	jr z, .gotPointerTable2
	ld de, Audio_CryHeadersPointerTable2
.gotPointerTable2
	add hl, de								; add the sound id (times 2) to the base offset to get to the correct pointer
	ld a, [hli]								; read the pointer to the header
	ld h, [hl]								; read the pointer to the header
	ld l, a									; read the pointer to the header
	ld e, l
	ld d, h
	ld hl, wChannelCommandPointers
	inc de									; skip the added byte containing the bank
	ld a, [de]								; get channel number
	ld b, a
	rlca
	rlca
	and $3
	ld c, a
	ld a, b
	and $f
	ld b, c
	inc b
	inc de
	ld c, 0
.commandPointerLoop
	cp c
	jr z, .next
	inc c
	inc hl
	inc hl
	jr .commandPointerLoop
.next
	push hl
	push bc
	push af
	ld b, 0
	ld c, a
	ld hl, wChannelSoundIDs
	add hl, bc
	ld a, [wSoundID]
	ld [hl], a
	pop af
	cp Ch3
	jr c, .skipSettingFlag
	ld hl, wChannelFlags1
	add hl, bc
	set BIT_NOISE_OR_SFX, [hl]
.skipSettingFlag
	ld a, [wPlayingCry]
	and a
	jr z, .notPlayingCry
	ld hl, wChannelFlags2			; when playing a cry, set the corresponding flag
	add hl, bc
	set BIT_CRY_SFX, [hl]
.notPlayingCry
	pop bc
	pop hl
	ld a, [de] ; get channel pointer
	ld [hli], a
	inc de
	ld a, [de]
	ld [hli], a
	inc de
	inc c
	dec b
	ld a, b
	and a
	ld a, [de]
	inc de
	jr nz, .commandPointerLoop
	ld a, [wPlayingCry]
	and a										; use variable instead of the sound id
	ret z
	ld hl, wChannelCommandPointers + Ch6 * 2	; sfx wave channel pointer
	ld de, NoiseWaveChannelPointer				; use pointer from the bank where cries are stored
	ld [hl], e
	inc hl
	ld [hl], d									; overwrite pointer to point to endchannel
	ld a, [wSavedVolume]
	and a
	ret nz										; simplification
	ld a, [rNR50]
	ld [wSavedVolume], a
	ld a, $77
	ld [rNR50], a								; full volume
	ret

Audio_HWChannelBaseAddresses:
; the low bytes of each HW channel's base address
	db HW_CH1_BASE, HW_CH2_BASE, HW_CH3_BASE, HW_CH4_BASE ; channels 0-3
	db HW_CH1_BASE, HW_CH2_BASE, HW_CH3_BASE, HW_CH4_BASE ; channels 4-7

Audio_HWChannelDisableMasks:
	db HW_CH1_DISABLE_MASK, HW_CH2_DISABLE_MASK, HW_CH3_DISABLE_MASK, HW_CH4_DISABLE_MASK ; channels 0-3
	db HW_CH1_DISABLE_MASK, HW_CH2_DISABLE_MASK, HW_CH3_DISABLE_MASK, HW_CH4_DISABLE_MASK ; channels 4-7

Audio_HWChannelEnableMasks:
	db HW_CH1_ENABLE_MASK, HW_CH2_ENABLE_MASK, HW_CH3_ENABLE_MASK, HW_CH4_ENABLE_MASK ; channels 0-3
	db HW_CH1_ENABLE_MASK, HW_CH2_ENABLE_MASK, HW_CH3_ENABLE_MASK, HW_CH4_ENABLE_MASK ; channels 4-7

Audio_Pitches:
	dw $F82C ; C_
	dw $F89D ; C#
	dw $F907 ; D_
	dw $F96B ; D#
	dw $F9CA ; E_
	dw $FA23 ; F_
	dw $FA77 ; F#
	dw $FAC7 ; G_
	dw $FB12 ; G#
	dw $FB58 ; A_
	dw $FB9B ; A#
	dw $FBDA ; B_

Audio_HeadersPointerTable:
	dw SFX_Headers
	dw SFX_Snare1
	dw SFX_Snare2
	dw SFX_Snare3
	dw SFX_Snare4
	dw SFX_Snare5
	dw SFX_Triangle1
	dw SFX_Triangle2
	dw SFX_Snare6
	dw SFX_Snare7
	dw SFX_Snare8
	dw SFX_Snare9
	dw SFX_Cymbal1
	dw SFX_Cymbal2
	dw SFX_Cymbal3
	dw SFX_Muted_Snare1
	dw SFX_Triangle3
	dw SFX_Muted_Snare2
	dw SFX_Muted_Snare3
	dw SFX_Muted_Snare4
	dw SFX_Get_Item2
	dw SFX_Tink
	dw SFX_Heal_HP
	dw SFX_Heal_Ailment
	dw SFX_Start_Menu
	dw SFX_Press_AB
	dw SFX_Get_Item1
	dw SFX_Pokedex_Rating
	dw SFX_Get_Key_Item
	dw SFX_Poisoned
	dw SFX_Trade_Machine
	dw SFX_Turn_On_PC
	dw SFX_Turn_Off_PC
	dw SFX_Enter_PC
	dw SFX_Shrink
	dw SFX_Switch
	dw SFX_Healing_Machine
	dw SFX_Teleport_Exit1
	dw SFX_Teleport_Enter1
	dw SFX_Teleport_Exit2
	dw SFX_Ledge
	dw SFX_Teleport_Enter2
	dw SFX_Fly
	dw SFX_Denied
	dw SFX_Arrow_Tiles
	dw SFX_Push_Boulder
	dw SFX_SS_Anne_Horn
	dw SFX_Withdraw_Deposit
	dw SFX_Cut
	dw SFX_Go_Inside
	dw SFX_Swap
	dw SFX_PokeFluteShort
	dw SFX_Purchase
	dw SFX_Collision
	dw SFX_Go_Outside
	dw SFX_Save
	dw SFX_Pokeflute
	dw SFX_Safari_Zone_PA
	dw SFX_Level_Up
	dw SFX_Ball_Toss
	dw SFX_Ball_Poof
	dw SFX_Faint_Thud
	dw SFX_Run
	dw SFX_Dex_Page_Added
	dw SFX_Caught_Mon
	dw SFX_Peck
	dw SFX_Faint_Fall
	dw SFX_Battle_09
	dw SFX_Pound
	dw SFX_Battle_0B
	dw SFX_Battle_0C
	dw SFX_Battle_0D
	dw SFX_Battle_0E
	dw SFX_Battle_0F
	dw SFX_Damage
	dw SFX_Not_Very_Effective
	dw SFX_Battle_12
	dw SFX_Battle_13
	dw SFX_Battle_14
	dw SFX_Vine_Whip
	dw SFX_Battle_16
	dw SFX_Battle_17
	dw SFX_Battle_18
	dw SFX_Battle_19
	dw SFX_Super_Effective
	dw SFX_Battle_1B
	dw SFX_Battle_1C
	dw SFX_Doubleslap
	dw SFX_Battle_1E
	dw SFX_Horn_Drill
	dw SFX_Battle_20
	dw SFX_Battle_21
	dw SFX_Battle_22
	dw SFX_Battle_23
	dw SFX_Battle_24
	dw SFX_Battle_25
	dw SFX_Battle_26
	dw SFX_Battle_27
	dw SFX_Battle_28
	dw SFX_Battle_29
	dw SFX_Battle_2A
	dw SFX_Battle_2B
	dw SFX_Battle_2C
	dw SFX_Psybeam
	dw SFX_Battle_2E
	dw SFX_Battle_2F
	dw SFX_Psychic_M
	dw SFX_Battle_31
	dw SFX_Battle_32
	dw SFX_Battle_33
	dw SFX_Battle_34
	dw SFX_Battle_35
	dw SFX_Battle_36
	dw SFX_Silph_Scope
	dw SFX_Intro_Lunge
	dw SFX_Intro_Hip
	dw SFX_Intro_Hop
	dw SFX_Intro_Raise
	dw SFX_Intro_Crash
	dw SFX_Intro_Whoosh
	dw SFX_Slots_Stop_Wheel
	dw SFX_Slots_Reward
	dw SFX_Slots_New_Spin
	dw SFX_Shooting_Star
	dw Music_PalletTown
	dw Music_Pokecenter
	dw Music_Gym
	dw Music_Cities1
	dw Music_Cities2
	dw Music_Celadon
	dw Music_Cinnabar
	dw Music_Vermilion
	dw Music_Lavender
	dw Music_SSAnne
	dw Music_MeetProfOak
	dw Music_MeetRival
	dw Music_MuseumGuy
	dw Music_SafariZone
	dw Music_PkmnHealed
	dw Music_Routes1
	dw Music_Routes2
	dw Music_Routes3
	dw Music_Routes4
	dw Music_IndigoPlateau
	dw Music_GymLeaderBattle
	dw Music_TrainerBattle
	dw Music_WildBattle
	dw Music_FinalBattle
	dw Music_DefeatedTrainer
	dw Music_DefeatedWildMon
	dw Music_DefeatedGymLeader
	dw Music_TitleScreen
	dw Music_Credits
	dw Music_HallOfFame
	dw Music_OaksLab
	dw Music_JigglypuffSong
	dw Music_BikeRiding
	dw Music_Surfing
	dw Music_GameCorner
	dw Music_IntroBattle
	dw Music_Dungeon1
	dw Music_Dungeon2
	dw Music_Dungeon3
	dw Music_CinnabarMansion
	dw Music_PokemonTower
	dw Music_SilphCo
	dw Music_MeetEvilTrainer
	dw Music_MeetFemaleTrainer
	dw Music_MeetMaleTrainer

; dedicated pointer table for cries since they now have their own set of ids
Audio_CryHeadersPointerTable:
	dw $0000					; padding for cry id 0 which we cannot use as a sound id since it has special meaning
	dw SFX_Cry00
	dw SFX_Cry01
	dw SFX_Cry02
	dw SFX_Cry03
	dw SFX_Cry04
	dw SFX_Cry05
	dw SFX_Cry06
	dw SFX_Cry07
	dw SFX_Cry08
	dw SFX_Cry09
	dw SFX_Cry0A
	dw SFX_Cry0B
	dw SFX_Cry0C
	dw SFX_Cry0D
	dw SFX_Cry0E
	dw SFX_Cry0F
	dw SFX_Cry10
	dw SFX_Cry11
	dw SFX_Cry12
	dw SFX_Cry13
	dw SFX_Cry14
	dw SFX_Cry15
	dw SFX_Cry16
	dw SFX_Cry17
	dw SFX_Cry18
	dw SFX_Cry19
	dw SFX_Cry1A
	dw SFX_Cry1B
	dw SFX_Cry1C
	dw SFX_Cry1D
	dw SFX_Cry1E
	dw SFX_Cry1F
	dw SFX_Cry20
	dw SFX_Cry21
	dw SFX_Cry22
	dw SFX_Cry23
	dw SFX_Cry24
	dw SFX_Cry25
	dw SFX_Cry26
	dw SFX_Cry27
	dw SFX_Cry28
	dw SFX_Cry29
	dw SFX_Cry2A
	dw SFX_Cry2B
	dw SFX_Cry2C
	dw SFX_Cry2D
	dw SFX_Cry2E
	dw SFX_Cry2F
	dw SFX_Cry30
	dw SFX_Cry31
	dw SFX_Cry32
	dw SFX_Cry33
	dw SFX_Cry34
	dw SFX_Cry35
	dw SFX_Cry36
	dw SFX_Cry37
	dw SFX_Cry38
	dw SFX_Cry39
	dw SFX_Cry3A
	dw SFX_Cry3B
	dw SFX_Cry3C
	dw SFX_Cry3D
	dw SFX_Cry3E
	dw SFX_Cry3F
	dw SFX_Cry40
	dw SFX_Cry41
	dw SFX_Cry42
	dw SFX_Cry43
	dw SFX_Cry44
	dw SFX_Cry45
	dw SFX_Cry46
	dw SFX_Cry47
	dw SFX_Cry48
	dw SFX_Cry49
	dw SFX_Cry4A
	dw SFX_Cry4B
	dw SFX_Cry4C
	dw SFX_Cry4D
	dw SFX_Cry4E
	dw SFX_Cry4F
	dw SFX_Cry50
	dw SFX_Cry51
	dw SFX_Cry52
	dw SFX_Cry53
	dw SFX_Cry54
	dw SFX_Cry55
	dw SFX_Cry56
	dw SFX_Cry57
	dw SFX_Cry58
	dw SFX_Cry59
	dw SFX_Cry5A
	dw SFX_Cry5B
	dw SFX_Cry5C
	dw SFX_Cry5D
	dw SFX_Cry5E
	dw SFX_Cry5F
	dw SFX_Cry60
	dw SFX_Cry61
	dw SFX_Cry62
	dw SFX_Cry63
	dw SFX_Cry64
	dw SFX_Cry65
	dw SFX_Cry66
	dw SFX_Cry67
	dw SFX_Cry68
	dw SFX_Cry69
	dw SFX_Cry6A
	dw SFX_Cry6B
	dw SFX_Cry6C
	dw SFX_Cry6D
	dw SFX_Cry6E
	dw SFX_Cry6F
	dw SFX_Cry70
	dw SFX_Cry71
	dw SFX_Cry72
	dw SFX_Cry73
	dw SFX_Cry74
	dw SFX_Cry75
	dw SFX_Cry76
	dw SFX_Cry77
	dw SFX_Cry78
	dw SFX_Cry79
	dw SFX_Cry7A
	dw SFX_Cry7B
	dw SFX_Cry7C
	dw SFX_Cry7D
	dw SFX_Cry7E
	dw SFX_Cry7F
	dw SFX_Cry80
	dw SFX_Cry81
	dw SFX_Cry82
	dw SFX_Cry83
	dw SFX_Cry84
	dw SFX_Cry85
	dw SFX_Cry86
	dw SFX_Cry87
	dw SFX_Cry88
	dw SFX_Cry89
	dw SFX_Cry8A
	dw SFX_Cry8B
	dw SFX_Cry8C
	dw SFX_Cry8D
	dw SFX_Cry8E
	dw SFX_Cry8F
	dw SFX_Cry90
	dw SFX_Cry91
	dw SFX_Cry92
	dw SFX_Cry93
	dw SFX_Cry94
	dw SFX_Cry95
	dw SFX_Cry96
	dw SFX_Cry97
	dw SFX_Cry98
	dw SFX_Cry99
	dw SFX_Cry9A
	dw SFX_Cry9B
	dw SFX_Cry9C
	dw SFX_Cry9D
	dw SFX_Cry9E
	dw SFX_Cry9F
	dw SFX_CryA0
	dw SFX_CryA1
	dw SFX_CryA2
	dw SFX_CryA3
	dw SFX_CryA4
	dw SFX_CryA5
	dw SFX_CryA6
	dw SFX_CryA7
	dw SFX_CryA8
	dw SFX_CryA9
	dw SFX_CryAA
	dw SFX_CryAB
	dw SFX_CryAC
	dw SFX_CryAD
	dw SFX_CryAE
	dw SFX_CryAF
	dw SFX_CryB0
	dw SFX_CryB1
	dw SFX_CryB2
	dw SFX_CryB3
	dw SFX_CryB4
	dw SFX_CryB5
	dw SFX_CryB6
	dw SFX_CryB7
	dw SFX_CryB8
	dw SFX_CryB9
	dw SFX_CryBA
	dw SFX_CryBB
	dw SFX_CryBC
	dw SFX_CryBD
	dw SFX_CryBE
	dw SFX_CryBF
	dw SFX_CryC0
	dw SFX_CryC1
	dw SFX_CryC2
	dw SFX_CryC3
	dw SFX_CryC4
	dw SFX_CryC5
	dw SFX_CryC6
	dw SFX_CryC7
	dw SFX_CryC8
	dw SFX_CryC9
	dw SFX_CryCA
	dw SFX_CryCB
	dw SFX_CryCC
	dw SFX_CryCD
	dw SFX_CryCE
	dw SFX_CryCF
	dw SFX_CryD0
	dw SFX_CryD1
	dw SFX_CryD2
	dw SFX_CryD3
	dw SFX_CryD4
	dw SFX_CryD5
	dw SFX_CryD6
	dw SFX_CryD7
	dw SFX_CryD8
	dw SFX_CryD9
	dw SFX_CryDA
	dw SFX_CryDB
	dw SFX_CryDC
	dw SFX_CryDD
	dw SFX_CryDE
	dw SFX_CryDF
	dw SFX_CryE0
	dw SFX_CryE1
	dw SFX_CryE2
	dw SFX_CryE3
	dw SFX_CryE4
	dw SFX_CryE5
	dw SFX_CryE6
	dw SFX_CryE7
	dw SFX_CryE8
	dw SFX_CryE9
	dw SFX_CryEA
	dw SFX_CryEB
	dw SFX_CryEC
	dw SFX_CryED
	dw SFX_CryEE
	dw SFX_CryEF
	dw SFX_CryF0
	dw SFX_CryF1
	dw SFX_CryF2
	dw SFX_CryF3
	dw SFX_CryF4
	dw SFX_CryF5
	dw SFX_CryF6
	dw SFX_CryF7
	dw SFX_CryF8
	dw SFX_CryF9
	dw SFX_CryFA
	dw SFX_CryFB
	dw SFX_CryFC
	dw SFX_CryFD

Audio_CryHeadersPointerTable2:
	dw $0000					; padding for cry id 0 which we cannot use as a sound id since it has special meaning
	dw SFX_CryFE
	dw SFX_CryFF
	dw SFX_Cry100
	dw SFX_Cry101
	dw SFX_Cry102
	dw SFX_Cry103
	dw SFX_Cry104
	dw SFX_Cry105
	dw SFX_Cry106
	dw SFX_Cry107
	dw SFX_Cry108
	dw SFX_Cry109
	dw SFX_Cry10A
	dw SFX_Cry10B
	dw SFX_Cry10C
	dw SFX_Cry10D
	dw SFX_Cry10E
