INCLUDE "constants.asm"


SECTION "Sound Effect Headers", ROMX
INCLUDE "audio/headers/sfxheaders.asm"


SECTION "Music Headers", ROMX
INCLUDE "audio/headers/musicheaders.asm"


; this section must appear only once in the whole ROM so that the global label is set only once
SECTION "NoiseWaveChannelPointer", ROMX
NoiseWaveChannelPointer::	; this is needed to mute the Ch6 channel for cries when playing them from this bank
	endchannel

; we can't reuse the global label from the previous section in multiple banks, so we need a section without the label
; all occurrences of this section, the previous one and the next one, must be placed at the same offset in their respective banks
SECTION "LocalNoiseWaveChannelPointer_1", ROMX
	endchannel

; we can't reuse the global label from the previous section in multiple banks, so we need a section without the label
; all occurrences of this section and the previous ones must be placed at the same offset in their respective banks
SECTION "LocalNoiseWaveChannelPointer_2", ROMX
	endchannel

; put all the cries inside dedicated sections
SECTION "Base cries 1", ROMX

INCLUDE "audio/sfx/cry09.asm"
INCLUDE "audio/sfx/cry23.asm"
INCLUDE "audio/sfx/cry24.asm"
INCLUDE "audio/sfx/cry11.asm"
INCLUDE "audio/sfx/cry25.asm"
INCLUDE "audio/sfx/cry03.asm"
INCLUDE "audio/sfx/cry0f.asm"
INCLUDE "audio/sfx/cry10.asm"
INCLUDE "audio/sfx/cry00.asm"
INCLUDE "audio/sfx/cry0e.asm"
INCLUDE "audio/sfx/cry06.asm"
INCLUDE "audio/sfx/cry07.asm"
INCLUDE "audio/sfx/cry05.asm"
INCLUDE "audio/sfx/cry0b.asm"
INCLUDE "audio/sfx/cry0c.asm"
INCLUDE "audio/sfx/cry02.asm"
INCLUDE "audio/sfx/cry0d.asm"
INCLUDE "audio/sfx/cry01.asm"
INCLUDE "audio/sfx/cry0a.asm"
INCLUDE "audio/sfx/cry08.asm"
INCLUDE "audio/sfx/cry04.asm"
INCLUDE "audio/sfx/cry19.asm"
INCLUDE "audio/sfx/cry16.asm"
INCLUDE "audio/sfx/cry1b.asm"
INCLUDE "audio/sfx/cry12.asm"
INCLUDE "audio/sfx/cry13.asm"
INCLUDE "audio/sfx/cry14.asm"
INCLUDE "audio/sfx/cry1e.asm"
INCLUDE "audio/sfx/cry15.asm"
INCLUDE "audio/sfx/cry17.asm"
INCLUDE "audio/sfx/cry1c.asm"
INCLUDE "audio/sfx/cry1a.asm"
INCLUDE "audio/sfx/cry1d.asm"
INCLUDE "audio/sfx/cry18.asm"
INCLUDE "audio/sfx/cry1f.asm"
INCLUDE "audio/sfx/cry20.asm"
INCLUDE "audio/sfx/cry21.asm"
INCLUDE "audio/sfx/cry22.asm"
INCLUDE "audio/sfx/cry26.asm"
INCLUDE "audio/sfx/cry27.asm"
INCLUDE "audio/sfx/cry28.asm"
INCLUDE "audio/sfx/cry29.asm"
INCLUDE "audio/sfx/cry2a.asm"
INCLUDE "audio/sfx/cry2b.asm"
INCLUDE "audio/sfx/cry2c.asm"
INCLUDE "audio/sfx/cry2d.asm"
INCLUDE "audio/sfx/cry2e.asm"
INCLUDE "audio/sfx/cry2f.asm"
INCLUDE "audio/sfx/cry30.asm"
INCLUDE "audio/sfx/cry31.asm"
INCLUDE "audio/sfx/cry32.asm"
INCLUDE "audio/sfx/cry33.asm"
INCLUDE "audio/sfx/cry34.asm"
INCLUDE "audio/sfx/cry35.asm"
INCLUDE "audio/sfx/cry36.asm"
INCLUDE "audio/sfx/cry37.asm"
INCLUDE "audio/sfx/cry38.asm"
INCLUDE "audio/sfx/cry39.asm"
INCLUDE "audio/sfx/cry3a.asm"
INCLUDE "audio/sfx/cry3b.asm"
INCLUDE "audio/sfx/cry3c.asm"
INCLUDE "audio/sfx/cry3d.asm"
INCLUDE "audio/sfx/cry3e.asm"
INCLUDE "audio/sfx/cry3f.asm"
INCLUDE "audio/sfx/cry40.asm"
INCLUDE "audio/sfx/cry41.asm"
INCLUDE "audio/sfx/cry42.asm"
INCLUDE "audio/sfx/cry43.asm"
INCLUDE "audio/sfx/cry44.asm"
INCLUDE "audio/sfx/cry45.asm"
INCLUDE "audio/sfx/cry46.asm"
INCLUDE "audio/sfx/cry47.asm"
INCLUDE "audio/sfx/cry48.asm"
INCLUDE "audio/sfx/cry49.asm"
INCLUDE "audio/sfx/cry4a.asm"
INCLUDE "audio/sfx/cry4b.asm"
INCLUDE "audio/sfx/cry4c.asm"
INCLUDE "audio/sfx/cry4d.asm"
INCLUDE "audio/sfx/cry4e.asm"
INCLUDE "audio/sfx/cry4f.asm"
INCLUDE "audio/sfx/cry50.asm"
INCLUDE "audio/sfx/cry51.asm"
INCLUDE "audio/sfx/cry52.asm"
INCLUDE "audio/sfx/cry53.asm"
INCLUDE "audio/sfx/cry54.asm"
INCLUDE "audio/sfx/cry55.asm"
INCLUDE "audio/sfx/cry56.asm"
INCLUDE "audio/sfx/cry57.asm"
INCLUDE "audio/sfx/cry58.asm"
INCLUDE "audio/sfx/cry59.asm"
INCLUDE "audio/sfx/cry5a.asm"
INCLUDE "audio/sfx/cry5b.asm"
INCLUDE "audio/sfx/cry5c.asm"
INCLUDE "audio/sfx/cry5d.asm"
INCLUDE "audio/sfx/cry5e.asm"
INCLUDE "audio/sfx/cry5f.asm"
INCLUDE "audio/sfx/cry60.asm"
INCLUDE "audio/sfx/cry61.asm"
INCLUDE "audio/sfx/cry62.asm"
INCLUDE "audio/sfx/cry63.asm"
INCLUDE "audio/sfx/cry64.asm"
INCLUDE "audio/sfx/cry65.asm"
INCLUDE "audio/sfx/cry66.asm"
INCLUDE "audio/sfx/cry67.asm"
INCLUDE "audio/sfx/cry68.asm"
INCLUDE "audio/sfx/cry69.asm"
INCLUDE "audio/sfx/cry6a.asm"
INCLUDE "audio/sfx/cry6b.asm"
INCLUDE "audio/sfx/cry6c.asm"
INCLUDE "audio/sfx/cry6d.asm"
INCLUDE "audio/sfx/cry6e.asm"
INCLUDE "audio/sfx/cry6f.asm"
INCLUDE "audio/sfx/cry70.asm"
INCLUDE "audio/sfx/cry71.asm"
INCLUDE "audio/sfx/cry72.asm"
INCLUDE "audio/sfx/cry73.asm"
INCLUDE "audio/sfx/cry74.asm"
INCLUDE "audio/sfx/cry75.asm"
INCLUDE "audio/sfx/cry76.asm"
INCLUDE "audio/sfx/cry77.asm"
INCLUDE "audio/sfx/cry78.asm"
INCLUDE "audio/sfx/cry79.asm"
INCLUDE "audio/sfx/cry7a.asm"
INCLUDE "audio/sfx/cry7b.asm"


SECTION "Base cries 2", ROMX

INCLUDE "audio/sfx/cry7c.asm"
INCLUDE "audio/sfx/cry7d.asm"
INCLUDE "audio/sfx/cry7e.asm"
INCLUDE "audio/sfx/cry7f.asm"
INCLUDE "audio/sfx/cry80.asm"
INCLUDE "audio/sfx/cry81.asm"
INCLUDE "audio/sfx/cry82.asm"
INCLUDE "audio/sfx/cry83.asm"
INCLUDE "audio/sfx/cry84.asm"
INCLUDE "audio/sfx/cry85.asm"
INCLUDE "audio/sfx/cry86.asm"
INCLUDE "audio/sfx/cry87.asm"
INCLUDE "audio/sfx/cry88.asm"
INCLUDE "audio/sfx/cry89.asm"
INCLUDE "audio/sfx/cry8a.asm"
INCLUDE "audio/sfx/cry8b.asm"
INCLUDE "audio/sfx/cry8c.asm"
INCLUDE "audio/sfx/cry8d.asm"
INCLUDE "audio/sfx/cry8e.asm"
INCLUDE "audio/sfx/cry8f.asm"
INCLUDE "audio/sfx/cry90.asm"
INCLUDE "audio/sfx/cry91.asm"
INCLUDE "audio/sfx/cry92.asm"
INCLUDE "audio/sfx/cry93.asm"
INCLUDE "audio/sfx/cry94.asm"
INCLUDE "audio/sfx/cry95.asm"
INCLUDE "audio/sfx/cry96.asm"
INCLUDE "audio/sfx/cry97.asm"
INCLUDE "audio/sfx/cry98.asm"
INCLUDE "audio/sfx/cry99.asm"
INCLUDE "audio/sfx/cry9a.asm"
INCLUDE "audio/sfx/cry9b.asm"
INCLUDE "audio/sfx/cry9c.asm"
INCLUDE "audio/sfx/cry9d.asm"
INCLUDE "audio/sfx/cry9e.asm"
INCLUDE "audio/sfx/cry9f.asm"
INCLUDE "audio/sfx/crya0.asm"
INCLUDE "audio/sfx/crya1.asm"
INCLUDE "audio/sfx/crya2.asm"
INCLUDE "audio/sfx/crya3.asm"
INCLUDE "audio/sfx/crya4.asm"
INCLUDE "audio/sfx/crya5.asm"
INCLUDE "audio/sfx/crya6.asm"
INCLUDE "audio/sfx/crya7.asm"
INCLUDE "audio/sfx/crya8.asm"
INCLUDE "audio/sfx/crya9.asm"
INCLUDE "audio/sfx/cryaa.asm"
INCLUDE "audio/sfx/cryab.asm"
INCLUDE "audio/sfx/cryac.asm"
INCLUDE "audio/sfx/cryad.asm"
INCLUDE "audio/sfx/cryae.asm"
INCLUDE "audio/sfx/cryaf.asm"
INCLUDE "audio/sfx/cryb0.asm"
INCLUDE "audio/sfx/cryb1.asm"
INCLUDE "audio/sfx/cryb2.asm"
INCLUDE "audio/sfx/cryb3.asm"
INCLUDE "audio/sfx/cryb4.asm"
INCLUDE "audio/sfx/cryb5.asm"
INCLUDE "audio/sfx/cryb6.asm"
INCLUDE "audio/sfx/cryb7.asm"
INCLUDE "audio/sfx/cryb8.asm"
INCLUDE "audio/sfx/cryb9.asm"
INCLUDE "audio/sfx/cryba.asm"
INCLUDE "audio/sfx/crybb.asm"
INCLUDE "audio/sfx/crybc.asm"
INCLUDE "audio/sfx/crybd.asm"
INCLUDE "audio/sfx/crybe.asm"
INCLUDE "audio/sfx/crybf.asm"
INCLUDE "audio/sfx/cryc0.asm"
INCLUDE "audio/sfx/cryc1.asm"
INCLUDE "audio/sfx/cryc2.asm"
INCLUDE "audio/sfx/cryc3.asm"
INCLUDE "audio/sfx/cryc4.asm"
INCLUDE "audio/sfx/cryc5.asm"
INCLUDE "audio/sfx/cryc6.asm"
INCLUDE "audio/sfx/cryc7.asm"
INCLUDE "audio/sfx/cryc8.asm"
INCLUDE "audio/sfx/cryc9.asm"
INCLUDE "audio/sfx/cryca.asm"
INCLUDE "audio/sfx/crycb.asm"
INCLUDE "audio/sfx/crycc.asm"
INCLUDE "audio/sfx/crycd.asm"
INCLUDE "audio/sfx/cryce.asm"
INCLUDE "audio/sfx/crycf.asm"
INCLUDE "audio/sfx/cryd0.asm"
INCLUDE "audio/sfx/cryd1.asm"
INCLUDE "audio/sfx/cryd2.asm"
INCLUDE "audio/sfx/cryd3.asm"
INCLUDE "audio/sfx/cryd4.asm"
INCLUDE "audio/sfx/cryd5.asm"
INCLUDE "audio/sfx/cryd6.asm"
INCLUDE "audio/sfx/cryd7.asm"
INCLUDE "audio/sfx/cryd8.asm"
INCLUDE "audio/sfx/cryd9.asm"
INCLUDE "audio/sfx/cryda.asm"
INCLUDE "audio/sfx/crydb.asm"
INCLUDE "audio/sfx/crydc.asm"
INCLUDE "audio/sfx/crydd.asm"
INCLUDE "audio/sfx/cryde.asm"
INCLUDE "audio/sfx/crydf.asm"
INCLUDE "audio/sfx/crye0.asm"
INCLUDE "audio/sfx/crye1.asm"
INCLUDE "audio/sfx/crye2.asm"
INCLUDE "audio/sfx/crye3.asm"
INCLUDE "audio/sfx/crye4.asm"
INCLUDE "audio/sfx/crye5.asm"
INCLUDE "audio/sfx/crye6.asm"
INCLUDE "audio/sfx/crye7.asm"
INCLUDE "audio/sfx/crye8.asm"
INCLUDE "audio/sfx/crye9.asm"
INCLUDE "audio/sfx/cryea.asm"
INCLUDE "audio/sfx/cryeb.asm"
INCLUDE "audio/sfx/cryec.asm"
INCLUDE "audio/sfx/cryed.asm"
INCLUDE "audio/sfx/cryee.asm"
INCLUDE "audio/sfx/cryef.asm"
INCLUDE "audio/sfx/cryf0.asm"
INCLUDE "audio/sfx/cryf1.asm"
INCLUDE "audio/sfx/cryf2.asm"
INCLUDE "audio/sfx/cryf3.asm"
INCLUDE "audio/sfx/cryf4.asm"


SECTION "Base cries 3", ROMX

INCLUDE "audio/sfx/cryf5.asm"
INCLUDE "audio/sfx/cryf6.asm"
INCLUDE "audio/sfx/cryf7.asm"
INCLUDE "audio/sfx/cryf8.asm"
INCLUDE "audio/sfx/cryf9.asm"
INCLUDE "audio/sfx/cryfa.asm"
INCLUDE "audio/sfx/cryfb.asm"
INCLUDE "audio/sfx/cryfc.asm"
INCLUDE "audio/sfx/cryfd.asm"
INCLUDE "audio/sfx/cryfe.asm"
INCLUDE "audio/sfx/cryff.asm"
INCLUDE "audio/sfx/cry100.asm"
INCLUDE "audio/sfx/cry101.asm"
INCLUDE "audio/sfx/cry102.asm"
INCLUDE "audio/sfx/cry103.asm"
INCLUDE "audio/sfx/cry104.asm"
INCLUDE "audio/sfx/cry105.asm"
INCLUDE "audio/sfx/cry106.asm"
INCLUDE "audio/sfx/cry107.asm"
INCLUDE "audio/sfx/cry108.asm"
INCLUDE "audio/sfx/cry109.asm"
INCLUDE "audio/sfx/cry10a.asm"
INCLUDE "audio/sfx/cry10b.asm"
INCLUDE "audio/sfx/cry10c.asm"


; put the SFX instruments together
SECTION "Instruments", ROMX

INCLUDE "audio/sfx/snare1.asm"
INCLUDE "audio/sfx/snare2.asm"
INCLUDE "audio/sfx/snare3.asm"
INCLUDE "audio/sfx/snare4.asm"
INCLUDE "audio/sfx/snare5.asm"
INCLUDE "audio/sfx/triangle1.asm"
INCLUDE "audio/sfx/triangle2.asm"
INCLUDE "audio/sfx/snare6.asm"
INCLUDE "audio/sfx/snare7.asm"
INCLUDE "audio/sfx/snare8.asm"
INCLUDE "audio/sfx/snare9.asm"
INCLUDE "audio/sfx/cymbal1.asm"
INCLUDE "audio/sfx/cymbal2.asm"
INCLUDE "audio/sfx/cymbal3.asm"
INCLUDE "audio/sfx/muted_snare1.asm"
INCLUDE "audio/sfx/triangle3.asm"
INCLUDE "audio/sfx/muted_snare2.asm"
INCLUDE "audio/sfx/muted_snare3.asm"
INCLUDE "audio/sfx/muted_snare4.asm"

Audio_WavePointers:: INCLUDE "audio/wave_instruments.asm"


; split Sound Effects 2 into 2 sections
SECTION "Generic Sound Effects", ROMX

INCLUDE "audio/sfx/start_menu.asm"
INCLUDE "audio/sfx/pokeflute.asm"
INCLUDE "audio/sfx/pokeflute_short.asm"
INCLUDE "audio/sfx/cut.asm"
INCLUDE "audio/sfx/go_inside.asm"
INCLUDE "audio/sfx/swap.asm"
INCLUDE "audio/sfx/tink.asm"
INCLUDE "audio/sfx/59.asm"
INCLUDE "audio/sfx/purchase.asm"
INCLUDE "audio/sfx/collision.asm"
INCLUDE "audio/sfx/go_outside.asm"
INCLUDE "audio/sfx/press_ab.asm"
INCLUDE "audio/sfx/save.asm"
INCLUDE "audio/sfx/heal_hp.asm"
INCLUDE "audio/sfx/poisoned.asm"
INCLUDE "audio/sfx/heal_ailment.asm"
INCLUDE "audio/sfx/trade_machine.asm"
INCLUDE "audio/sfx/turn_on_pc.asm"
INCLUDE "audio/sfx/turn_off_pc.asm"
INCLUDE "audio/sfx/enter_pc.asm"
INCLUDE "audio/sfx/shrink.asm"
INCLUDE "audio/sfx/switch.asm"
INCLUDE "audio/sfx/healing_machine.asm"
INCLUDE "audio/sfx/teleport_exit1.asm"
INCLUDE "audio/sfx/teleport_enter1.asm"
INCLUDE "audio/sfx/teleport_exit2.asm"
INCLUDE "audio/sfx/ledge.asm"
INCLUDE "audio/sfx/teleport_enter2.asm"
INCLUDE "audio/sfx/fly.asm"
INCLUDE "audio/sfx/denied.asm"
INCLUDE "audio/sfx/arrow_tiles.asm"
INCLUDE "audio/sfx/push_boulder.asm"
INCLUDE "audio/sfx/ss_anne_horn.asm"
INCLUDE "audio/sfx/withdraw_deposit.asm"
INCLUDE "audio/sfx/safari_zone_pa.asm"
INCLUDE "audio/sfx/unused.asm"
INCLUDE "audio/sfx/pokedex_rating.asm"			; moved from music bank 1
INCLUDE "audio/sfx/get_item1.asm"				; moved from music bank 1
INCLUDE "audio/sfx/get_item2.asm"				; moved from music bank 1
INCLUDE "audio/sfx/get_key_item.asm"			; moved from music bank 1
INCLUDE "audio/sfx/slots_stop_wheel.asm"		; moved from section Sound Effects 3
INCLUDE "audio/sfx/slots_reward.asm"			; moved from section Sound Effects 3
INCLUDE "audio/sfx/slots_new_spin.asm"			; moved from section Sound Effects 3
INCLUDE "audio/sfx/intro_lunge.asm"				; moved from section Sound Effects 3
INCLUDE "audio/sfx/intro_hip.asm"				; moved from section Sound Effects 3
INCLUDE "audio/sfx/intro_hop.asm"				; moved from section Sound Effects 3
INCLUDE "audio/sfx/intro_raise.asm"				; moved from section Sound Effects 3
INCLUDE "audio/sfx/intro_crash.asm"				; moved from section Sound Effects 3
INCLUDE "audio/sfx/intro_whoosh.asm"			; moved from section Sound Effects 3
INCLUDE "audio/sfx/shooting_star.asm"			; moved from section Sound Effects 3


; split Sound Effects 2 into 2 sections
SECTION "Battle Sound Effects", ROMX

INCLUDE "audio/sfx/silph_scope.asm"
INCLUDE "audio/sfx/ball_toss.asm"
INCLUDE "audio/sfx/ball_poof.asm"
INCLUDE "audio/sfx/faint_thud.asm"
INCLUDE "audio/sfx/run.asm"
INCLUDE "audio/sfx/dex_page_added.asm"
INCLUDE "audio/sfx/peck.asm"
INCLUDE "audio/sfx/faint_fall.asm"
INCLUDE "audio/sfx/battle_09.asm"
INCLUDE "audio/sfx/pound.asm"
INCLUDE "audio/sfx/battle_0b.asm"
INCLUDE "audio/sfx/battle_0c.asm"
INCLUDE "audio/sfx/battle_0d.asm"
INCLUDE "audio/sfx/battle_0e.asm"
INCLUDE "audio/sfx/battle_0f.asm"
INCLUDE "audio/sfx/damage.asm"
INCLUDE "audio/sfx/not_very_effective.asm"
INCLUDE "audio/sfx/battle_12.asm"
INCLUDE "audio/sfx/battle_13.asm"
INCLUDE "audio/sfx/battle_14.asm"
INCLUDE "audio/sfx/vine_whip.asm"
INCLUDE "audio/sfx/battle_16.asm"
INCLUDE "audio/sfx/battle_17.asm"
INCLUDE "audio/sfx/battle_18.asm"
INCLUDE "audio/sfx/battle_19.asm"
INCLUDE "audio/sfx/super_effective.asm"
INCLUDE "audio/sfx/battle_1b.asm"
INCLUDE "audio/sfx/battle_1c.asm"
INCLUDE "audio/sfx/doubleslap.asm"
INCLUDE "audio/sfx/battle_1e.asm"
INCLUDE "audio/sfx/horn_drill.asm"
INCLUDE "audio/sfx/battle_20.asm"
INCLUDE "audio/sfx/battle_21.asm"
INCLUDE "audio/sfx/battle_22.asm"
INCLUDE "audio/sfx/battle_23.asm"
INCLUDE "audio/sfx/battle_24.asm"
INCLUDE "audio/sfx/battle_25.asm"
INCLUDE "audio/sfx/battle_26.asm"
INCLUDE "audio/sfx/battle_27.asm"
INCLUDE "audio/sfx/battle_28.asm"
INCLUDE "audio/sfx/battle_29.asm"
INCLUDE "audio/sfx/battle_2a.asm"
INCLUDE "audio/sfx/battle_2b.asm"
INCLUDE "audio/sfx/battle_2c.asm"
INCLUDE "audio/sfx/psybeam.asm"
INCLUDE "audio/sfx/battle_2e.asm"
INCLUDE "audio/sfx/battle_2f.asm"
INCLUDE "audio/sfx/psychic_m.asm"
INCLUDE "audio/sfx/battle_31.asm"
INCLUDE "audio/sfx/battle_32.asm"
INCLUDE "audio/sfx/battle_33.asm"
INCLUDE "audio/sfx/battle_34.asm"
INCLUDE "audio/sfx/battle_35.asm"
INCLUDE "audio/sfx/battle_36.asm"
INCLUDE "audio/sfx/level_up.asm"		; moved from music bank 2
INCLUDE "audio/sfx/caught_mon.asm"		; moved from music bank 2
INCLUDE "audio/sfx/unused2.asm"			; moved from music bank 2


SECTION "Audio Engine", ROMX

PlayBattleMusic::
	xor a
	ld [wAudioFadeOutControl], a
	ld [wLowHealthAlarm], a
	dec a
	ld [wNewSoundID], a
	call PlaySound ; stop music
	call DelayFrame
	ld a, [wGymLeaderNo]
	and a
	jr z, .notGymLeaderBattle
	ld a, MUSIC_GYM_LEADER_BATTLE
	jr .playSong
.notGymLeaderBattle
	ld a, [wEngagedTrainerClass]
	and a
	jr z, .wildBattle					; if it's null, it means this is a wild battle (random encounter)
	cp STATIC_MON
	jr z, .wildBattle					; if it's STATIC_MON, it means this is a wild battle (static mon)
	cp SONY3
	jr z, .finalBattle
	cp LANCE
	jr nz, .normalTrainerBattle
	ld a, MUSIC_GYM_LEADER_BATTLE ; lance also plays gym leader theme
	jr .playSong
.normalTrainerBattle
	ld a, MUSIC_TRAINER_BATTLE
	jr .playSong
.finalBattle
	ld a, MUSIC_FINAL_BATTLE
	jr .playSong
.wildBattle
	ld a, MUSIC_WILD_BATTLE
.playSong
	jp PlayMusic


INCLUDE "audio/engine.asm"

INCLUDE "engine/menu/bills_pc.asm"

; an alternate start for MeetRival which has a different first measure
Music_RivalAlternateStart::
	ld a, MUSIC_MEET_RIVAL
	call PlayMusic
	ld hl, wChannelCommandPointers
	ld de, Music_MeetRival_branch_b1a2
	call Audio_OverwriteChannelPointer
	ld de, Music_MeetRival_branch_b21d
	call Audio_OverwriteChannelPointer
	ld de, Music_MeetRival_branch_b2b5

Audio_OverwriteChannelPointer:
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
	ret

; an alternate tempo for MeetRival which is slightly slower
Music_RivalAlternateTempo::
	ld a, MUSIC_MEET_RIVAL
	call PlayMusic
	ld hl, wChannelCommandPointers
	ld de, Music_MeetRival_branch_b119
	jp Audio_OverwriteChannelPointer

; applies both the alternate start and alternate tempo
Music_RivalAlternateStartAndTempo::
	call Music_RivalAlternateStart
	ld hl, wChannelCommandPointers
	ld de, Music_MeetRival_branch_b19b
	jp Audio_OverwriteChannelPointer

; an alternate tempo for Cities1 which is used for the Hall of Fame room
Music_Cities1AlternateTempo::
	ld a, 10
	ld [wAudioFadeOutCounterReloadValue], a
	ld [wAudioFadeOutCounter], a
	ld a, $ff ; stop playing music after the fade-out is finished
	ld [wAudioFadeOutControl], a
	ld c, 100
	call DelayFrames ; wait for the fade-out to finish
	ld a, MUSIC_CITIES1
	call PlayMusic
	ld hl, wChannelCommandPointers
	ld de, Music_Cities1_branch_aa6f
	jp Audio_OverwriteChannelPointer

Music_IsCryPlaying:
	and a							; here a contains the frame counter for the alarm
	ret z							; if the counter is zero, return with carry flag unset to avoid decrementing it
	ld a, [wChannelFlags2 + Ch4]
	bit BIT_CRY_SFX, a
	jr nz, .yes
	ld a, [wChannelFlags2 + Ch5]
	bit BIT_CRY_SFX, a
	jr nz, .yes
	ld a, [wChannelFlags2 + Ch6]
	bit BIT_CRY_SFX, a
	jr nz, .yes
	ld a, [wChannelFlags2 + Ch7]
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
Music_DoLowHealthAlarm::
	ld a, [wLowHealthAlarm]
	cp $ff
	jr z, .disableAlarm

	bit 7, a  ;alarm enabled?
	ret z     ;nope

	and $7f					;low 7 bits are the timer.
	ld d, a
	call Music_IsCryPlaying	; inspired by pokecrystal audio engine, this prevents cries from being deformed by low health alarm
	jr c, .decrement		; since this engine decrements the counter instead of incrementing it like pokecrystal, previous function must check if counter is zero

	ld a, d
	and a
	jr nz, .asm_21383		;if timer > 0, play low tone.

	call .playToneHi
	ld a, 30 ;keep this tone for 30 frames.
	jr .asm_21395 ;reset the timer.

.asm_21383
	cp 20
	jr nz, .asm_2138a ;if timer == 20,
	call .playToneLo  ;actually set the sound registers.

.asm_2138a
	ld a, SFX_GET_ITEM_2
	ld [wChannelSoundIDs + Ch4], a
.decrement
	ld a, [wLowHealthAlarm]
	and $7f ;decrement alarm timer.
	dec a

.asm_21395
	; reset the timer and enable flag.
	set 7, a
	ld [wLowHealthAlarm], a
	ret

.disableAlarm
	xor a
	ld [wLowHealthAlarm], a  ;disable alarm
	ld [wChannelSoundIDs + Ch4], a
	ld de, .toneDataSilence
	jr .playTone

;update the sound registers to change the frequency.
;the tone set here stays until we change it.
.playToneHi
	ld de, .toneDataHi
	jr .playTone

.playToneLo
	ld de, .toneDataLo

;update sound channel 1 to play the alarm, overriding all other sounds.
.playTone
	ld hl, rNR10 ;channel 1 sound register
	ld c, $5
	xor a

.copyLoop
	ld [hli], a
	ld a, [de]
	inc de
	dec c
	jr nz, .copyLoop
	ret

;bytes to write to sound channel 1 registers for health alarm.
;starting at FF11 (FF10 is always zeroed), so these bytes are:
;length, envelope, freq lo, freq hi
.toneDataHi
	db $A0,$E2,$50,$87

.toneDataLo
	db $B0,$E2,$EE,$86

;written to stop the alarm
.toneDataSilence
	db $00,$00,$00,$80

Music_PokeFluteInBattle::
	ld a, SFX_POKEFLUTE_SHORT		; just play the SFX directly (no idea why they went to all this trouble originally)
	jp PlaySoundWaitForCurrent


SECTION "Music 1", ROMX

INCLUDE "audio/music/pkmnhealed.asm"
INCLUDE "audio/music/routes1.asm"
INCLUDE "audio/music/routes2.asm"
INCLUDE "audio/music/routes3.asm"
INCLUDE "audio/music/routes4.asm"
INCLUDE "audio/music/indigoplateau.asm"
INCLUDE "audio/music/pallettown.asm"
INCLUDE "audio/music/cities1.asm"
INCLUDE "audio/music/museumguy.asm"
INCLUDE "audio/music/meetprofoak.asm"
INCLUDE "audio/music/meetrival.asm"
INCLUDE "audio/music/ssanne.asm"
INCLUDE "audio/music/cities2.asm"
INCLUDE "audio/music/celadon.asm"
INCLUDE "audio/music/cinnabar.asm"
INCLUDE "audio/music/vermilion.asm"
INCLUDE "audio/music/lavender.asm"
INCLUDE "audio/music/safarizone.asm"
INCLUDE "audio/music/gym.asm"
INCLUDE "audio/music/pokecenter.asm"


SECTION "Music 2", ROMX

INCLUDE "audio/music/gymleaderbattle.asm"
INCLUDE "audio/music/trainerbattle.asm"
INCLUDE "audio/music/wildbattle.asm"
INCLUDE "audio/music/finalbattle.asm"
INCLUDE "audio/music/defeatedtrainer.asm"
INCLUDE "audio/music/defeatedwildmon.asm"
INCLUDE "audio/music/defeatedgymleader.asm"


SECTION "Music 3", ROMX

INCLUDE "audio/music/bikeriding.asm"
INCLUDE "audio/music/dungeon1.asm"
INCLUDE "audio/music/gamecorner.asm"
INCLUDE "audio/music/titlescreen.asm"
INCLUDE "audio/music/dungeon2.asm"
INCLUDE "audio/music/dungeon3.asm"
INCLUDE "audio/music/cinnabarmansion.asm"
INCLUDE "audio/music/oakslab.asm"
INCLUDE "audio/music/pokemontower.asm"
INCLUDE "audio/music/silphco.asm"
INCLUDE "audio/music/meeteviltrainer.asm"
INCLUDE "audio/music/meetfemaletrainer.asm"
INCLUDE "audio/music/meetmaletrainer.asm"
INCLUDE "audio/music/introbattle.asm"
INCLUDE "audio/music/surfing.asm"
INCLUDE "audio/music/jigglypuffsong.asm"
INCLUDE "audio/music/halloffame.asm"
INCLUDE "audio/music/credits.asm"
