BattleCore:

; These are move effects (second value from the Moves table in bank $E).
ResidualEffects1:
; most non-side effects
	db CONVERSION_EFFECT
	db HAZE_EFFECT
	db EJECT_EFFECT
	db TELEPORT_EFFECT
	db MIST_EFFECT
	db FOCUS_ENERGY_EFFECT
	db CONFUSION_EFFECT
	db HEAL_EFFECT
	db TRANSFORM_EFFECT
	db LIGHT_SCREEN_EFFECT
	db REFLECT_EFFECT
	db POISON_EFFECT
	db PARALYZE_EFFECT
	db SUBSTITUTE_EFFECT
	db MIMIC_EFFECT
	db LEECH_SEED_EFFECT
	db SPLASH_EFFECT
	db BAD_POISON_EFFECT
	db ATTACK_DEFENSE_UP_EFFECT
	db ATTACK_SPEED_UP_EFFECT
	db ATTACK_SPECIAL_ATTACK_UP_EFFECT
	db ATTACK_SPECIAL_DEFENSE_UP_EFFECT
	db ATTACK_ACCURACY_UP_EFFECT
	db ATTACK_EVASION_UP_EFFECT
	db DEFENSE_SPEED_UP_EFFECT
	db DEFENSE_SPECIAL_ATTACK_UP_EFFECT
	db DEFENSE_SPECIAL_DEFENSE_UP_EFFECT
	db DEFENSE_ACCURACY_UP_EFFECT
	db DEFENSE_EVASION_UP_EFFECT
	db SPEED_SPECIAL_ATTACK_UP_EFFECT
	db SPEED_SPECIAL_DEFENSE_UP_EFFECT
	db SPEED_ACCURACY_UP_EFFECT
	db SPEED_EVASION_UP_EFFECT
	db SPECIAL_ATTACK_SPECIAL_DEFENSE_UP_EFFECT
	db SPECIAL_ATTACK_ACCURACY_UP_EFFECT
	db SPECIAL_ATTACK_EVASION_UP_EFFECT
	db SPECIAL_DEFENSE_ACCURACY_UP_EFFECT
	db SPECIAL_DEFENSE_EVASION_UP_EFFECT
	db ACCURACY_EVASION_UP_EFFECT
	db QUIVER_DANCE_EFFECT
	db BURN_EFFECT
	db TRAPPING_EFFECT
	db TRICK_ROOM_EFFECT
	db REST_EFFECT
	db -1
SetDamageEffects:
; moves that do damage but not through normal calculations
; e.g., Super Fang, Psywave
	db SUPER_FANG_EFFECT
	db LEVEL_DAMAGE_EFFECT
	db FIXED_DAMAGE_EFFECT
	db PSYWAVE_EFFECT
	db -1
ResidualEffects2:
; non-side effects not included in ResidualEffects1
; stat-affecting moves, sleep-inflicting moves, and Bide
; e.g., Meditate, Bide, Hypnosis
	db ATTACK_UP1_EFFECT
	db DEFENSE_UP1_EFFECT
	db SPEED_UP1_EFFECT
	db SPECIAL_ATTACK_UP1_EFFECT
	db SPECIAL_DEFENSE_UP1_EFFECT
	db ACCURACY_UP1_EFFECT
	db EVASION_UP1_EFFECT
	db ATTACK_DOWN1_EFFECT
	db DEFENSE_DOWN1_EFFECT
	db SPEED_DOWN1_EFFECT
	db SPECIAL_ATTACK_DOWN1_EFFECT
	db SPECIAL_DEFENSE_DOWN1_EFFECT
	db ACCURACY_DOWN1_EFFECT
	db EVASION_DOWN1_EFFECT
	db BIDE_EFFECT
	db SLEEP_EFFECT
	db ATTACK_UP2_EFFECT
	db DEFENSE_UP2_EFFECT
	db SPEED_UP2_EFFECT
	db SPECIAL_ATTACK_UP2_EFFECT
	db SPECIAL_DEFENSE_UP2_EFFECT
	db ACCURACY_UP2_EFFECT
	db EVASION_UP2_EFFECT
	db ATTACK_DOWN2_EFFECT
	db DEFENSE_DOWN2_EFFECT
	db SPEED_DOWN2_EFFECT
	db SPECIAL_ATTACK_DOWN2_EFFECT
	db SPECIAL_DEFENSE_DOWN2_EFFECT
	db ACCURACY_DOWN2_EFFECT
	db EVASION_DOWN2_EFFECT
	db DISABLE_EFFECT							; add this to prevent Disable from building the rage counter
	db -1
AlwaysHappenSideEffects:
; Attacks that aren't finished after they faint the opponent.
	db DRAIN_HP_EFFECT
	db DRAIN_HP_EFFECT2
	db EXPLODE_EFFECT
	db DREAM_EATER_EFFECT
	db PAY_DAY_EFFECT
	db TWO_TO_FIVE_ATTACKS_EFFECT
	db UNUSED_EFFECT_1E
	db ATTACK_TWICE_EFFECT
	db RECOIL_EFFECT
	db TWINEEDLE_EFFECT
	db HYPER_BEAM_EFFECT									; add this to correct the hyper beam bug (no recharge when fainting target)
	db RAGE_EFFECT
	db STRUGGLE_EFFECT										; add this since we created a dedicated effect for Struggle
	db ATTACK_UP_SIDE_EFFECT
	db DEFENSE_UP_SIDE_EFFECT
	db SPEED_UP_SIDE_EFFECT
	db SPECIAL_ATTACK_UP_SIDE_EFFECT
	db SPECIAL_DEFENSE_UP_SIDE_EFFECT
	db ACCURACY_UP_SIDE_EFFECT
	db EVASION_UP_SIDE_EFFECT
	db ATTACK_UP_SIDE_EFFECT2
	db DEFENSE_UP_SIDE_EFFECT2
	db SPEED_UP_SIDE_EFFECT2
	db SPECIAL_ATTACK_UP_SIDE_EFFECT2
	db SPECIAL_DEFENSE_UP_SIDE_EFFECT2
	db ACCURACY_UP_SIDE_EFFECT2
	db EVASION_UP_SIDE_EFFECT2
	db ATTACK_UP_SIDE_EFFECT3
	db DEFENSE_UP_SIDE_EFFECT3
	db SPEED_UP_SIDE_EFFECT3
	db SPECIAL_ATTACK_UP_SIDE_EFFECT3
	db SPECIAL_DEFENSE_UP_SIDE_EFFECT3
	db ACCURACY_UP_SIDE_EFFECT3
	db EVASION_UP_SIDE_EFFECT3
	db ATTACK_UP_SIDE_EFFECT4
	db DEFENSE_UP_SIDE_EFFECT4
	db SPEED_UP_SIDE_EFFECT4
	db SPECIAL_ATTACK_UP_SIDE_EFFECT4
	db SPECIAL_DEFENSE_UP_SIDE_EFFECT4
	db ACCURACY_UP_SIDE_EFFECT4
	db EVASION_UP_SIDE_EFFECT4
	db ATTACK_DOWN2_RECOIL_EFFECT
	db DEFENSE_DOWN2_RECOIL_EFFECT
	db SPEED_DOWN2_RECOIL_EFFECT
	db SPECIAL_ATTACK_DOWN2_RECOIL_EFFECT
	db SPECIAL_DEFENSE_DOWN2_RECOIL_EFFECT
	db ACCURACY_DOWN2_RECOIL_EFFECT
	db EVASION_DOWN2_RECOIL_EFFECT
	db ATTACK_DEFENSE_DOWN_RECOIL_EFFECT
	db ATTACK_SPEED_DOWN_RECOIL_EFFECT
	db ATTACK_SPECIAL_ATTACK_DOWN_RECOIL_EFFECT
	db ATTACK_SPECIAL_DEFENSE_DOWN_RECOIL_EFFECT
	db ATTACK_ACCURACY_DOWN_RECOIL_EFFECT
	db ATTACK_EVASION_DOWN_RECOIL_EFFECT
	db DEFENSE_SPEED_DOWN_RECOIL_EFFECT
	db DEFENSE_SPECIAL_ATTACK_DOWN_RECOIL_EFFECT
	db DEFENSE_SPECIAL_DEFENSE_DOWN_RECOIL_EFFECT
	db DEFENSE_ACCURACY_DOWN_RECOIL_EFFECT
	db DEFENSE_EVASION_DOWN_RECOIL_EFFECT
	db SPEED_SPECIAL_ATTACK_DOWN_RECOIL_EFFECT
	db SPEED_SPECIAL_DEFENSE_DOWN_RECOIL_EFFECT
	db SPEED_ACCURACY_DOWN_RECOIL_EFFECT
	db SPEED_EVASION_DOWN_RECOIL_EFFECT
	db SPECIAL_ATTACK_SPECIAL_DEFENSE_DOWN_RECOIL_EFFECT
	db SPECIAL_ATTACK_ACCURACY_DOWN_RECOIL_EFFECT
	db SPECIAL_ATTACK_EVASION_DOWN_RECOIL_EFFECT
	db SPECIAL_DEFENSE_ACCURACY_DOWN_RECOIL_EFFECT
	db SPECIAL_DEFENSE_EVASION_DOWN_RECOIL_EFFECT
	db ACCURACY_EVASION_DOWN_RECOIL_EFFECT
	db ALL_STATS_UP_EFFECT
	db RECOIL_EFFECT2
	db RECOIL_EFFECT3
	db FLARE_BLITZ_EFFECT
	db BRICK_BREAK_EFFECT
	db ATTACK_DOWN_RECOIL_EFFECT
	db DEFENSE_DOWN_RECOIL_EFFECT
	db SPEED_DOWN_RECOIL_EFFECT
	db SPECIAL_ATTACK_DOWN_RECOIL_EFFECT
	db SPECIAL_DEFENSE_DOWN_RECOIL_EFFECT
	db ACCURACY_DOWN_RECOIL_EFFECT
	db EVASION_DOWN_RECOIL_EFFECT
	db -1
SpecialEffects:
; Includes all effects that do not need to be called at the end of
; ExecutePlayerMove (or ExecuteEnemyMove), because they have already been handled
	db DRAIN_HP_EFFECT
	db DRAIN_HP_EFFECT2
	db EXPLODE_EFFECT
	db DREAM_EATER_EFFECT
	db PAY_DAY_EFFECT
	db ALWAYS_HIT_EFFECT
	db TWO_TO_FIVE_ATTACKS_EFFECT
	db UNUSED_EFFECT_1E
	db CHARGE_EFFECT
	db SKULL_BASH_EFFECT
	db SUPER_FANG_EFFECT
	db LEVEL_DAMAGE_EFFECT
	db FIXED_DAMAGE_EFFECT
	db PSYWAVE_EFFECT
	db INVULNERABLE_EFFECT
	db ATTACK_TWICE_EFFECT
	db JUMP_KICK_EFFECT
	db RECOIL_EFFECT
	db STRUGGLE_EFFECT
	db RAGE_EFFECT											; to skip the Rage handler since it's already in AlwaysHappenSideEffects
	db COUNTER_EFFECT										; to skip the Counter handler since it doesn't exist
	db WEIGHT_DAMAGE_EFFECT
	db ATTACK_UP_SIDE_EFFECT
	db DEFENSE_UP_SIDE_EFFECT
	db SPEED_UP_SIDE_EFFECT
	db SPECIAL_ATTACK_UP_SIDE_EFFECT
	db SPECIAL_DEFENSE_UP_SIDE_EFFECT
	db ACCURACY_UP_SIDE_EFFECT
	db EVASION_UP_SIDE_EFFECT
	db ATTACK_UP_SIDE_EFFECT2
	db DEFENSE_UP_SIDE_EFFECT2
	db SPEED_UP_SIDE_EFFECT2
	db SPECIAL_ATTACK_UP_SIDE_EFFECT2
	db SPECIAL_DEFENSE_UP_SIDE_EFFECT2
	db ACCURACY_UP_SIDE_EFFECT2
	db EVASION_UP_SIDE_EFFECT2
	db ATTACK_UP_SIDE_EFFECT3
	db DEFENSE_UP_SIDE_EFFECT3
	db SPEED_UP_SIDE_EFFECT3
	db SPECIAL_ATTACK_UP_SIDE_EFFECT3
	db SPECIAL_DEFENSE_UP_SIDE_EFFECT3
	db ACCURACY_UP_SIDE_EFFECT3
	db EVASION_UP_SIDE_EFFECT3
	db ATTACK_UP_SIDE_EFFECT4
	db DEFENSE_UP_SIDE_EFFECT4
	db SPEED_UP_SIDE_EFFECT4
	db SPECIAL_ATTACK_UP_SIDE_EFFECT4
	db SPECIAL_DEFENSE_UP_SIDE_EFFECT4
	db ACCURACY_UP_SIDE_EFFECT4
	db EVASION_UP_SIDE_EFFECT4
	db ATTACK_DOWN2_RECOIL_EFFECT
	db DEFENSE_DOWN2_RECOIL_EFFECT
	db SPEED_DOWN2_RECOIL_EFFECT
	db SPECIAL_ATTACK_DOWN2_RECOIL_EFFECT
	db SPECIAL_DEFENSE_DOWN2_RECOIL_EFFECT
	db ACCURACY_DOWN2_RECOIL_EFFECT
	db EVASION_DOWN2_RECOIL_EFFECT
	db ATTACK_DEFENSE_DOWN_RECOIL_EFFECT
	db ATTACK_SPEED_DOWN_RECOIL_EFFECT
	db ATTACK_SPECIAL_ATTACK_DOWN_RECOIL_EFFECT
	db ATTACK_SPECIAL_DEFENSE_DOWN_RECOIL_EFFECT
	db ATTACK_ACCURACY_DOWN_RECOIL_EFFECT
	db ATTACK_EVASION_DOWN_RECOIL_EFFECT
	db DEFENSE_SPEED_DOWN_RECOIL_EFFECT
	db DEFENSE_SPECIAL_ATTACK_DOWN_RECOIL_EFFECT
	db DEFENSE_SPECIAL_DEFENSE_DOWN_RECOIL_EFFECT
	db DEFENSE_ACCURACY_DOWN_RECOIL_EFFECT
	db DEFENSE_EVASION_DOWN_RECOIL_EFFECT
	db SPEED_SPECIAL_ATTACK_DOWN_RECOIL_EFFECT
	db SPEED_SPECIAL_DEFENSE_DOWN_RECOIL_EFFECT
	db SPEED_ACCURACY_DOWN_RECOIL_EFFECT
	db SPEED_EVASION_DOWN_RECOIL_EFFECT
	db SPECIAL_ATTACK_SPECIAL_DEFENSE_DOWN_RECOIL_EFFECT
	db SPECIAL_ATTACK_ACCURACY_DOWN_RECOIL_EFFECT
	db SPECIAL_ATTACK_EVASION_DOWN_RECOIL_EFFECT
	db SPECIAL_DEFENSE_ACCURACY_DOWN_RECOIL_EFFECT
	db SPECIAL_DEFENSE_EVASION_DOWN_RECOIL_EFFECT
	db ACCURACY_EVASION_DOWN_RECOIL_EFFECT
	db ALL_STATS_UP_EFFECT
	db REVENGE_EFFECT
	db RECOIL_EFFECT2
	db RECOIL_EFFECT3
	db FLARE_BLITZ_EFFECT
	db BRICK_BREAK_EFFECT
	db PSYSHOCK_EFFECT
	db HEX_EFFECT
	db VENOSHOCK_EFFECT
	db WEIGHT_DIFFERENCE_EFFECT
	db JUDGMENT_EFFECT
	db SUCKER_PUNCH_EFFECT
	db ATTACK_DOWN_RECOIL_EFFECT
	db DEFENSE_DOWN_RECOIL_EFFECT
	db SPEED_DOWN_RECOIL_EFFECT
	db SPECIAL_ATTACK_DOWN_RECOIL_EFFECT
	db SPECIAL_DEFENSE_DOWN_RECOIL_EFFECT
	db ACCURACY_DOWN_RECOIL_EFFECT
	db EVASION_DOWN_RECOIL_EFFECT
	; fallthrough to Next EffectsArray
SpecialEffectsCont:
; damaging moves whose effect is executed prior to damage calculation
	db THRASH_PETAL_DANCE_EFFECT
	db -1

SlidePlayerAndEnemySilhouettesOnScreen:
	call LoadPlayerBackPic
	ld a, MESSAGE_BOX ; the usual text box at the bottom of the screen
	ld [wTextBoxID], a
	call DisplayTextBoxID
	coord hl, 1, 5
	lb bc, 3, 7
	call ClearScreenArea
	call DisableLCD
	call LoadFontTilePatterns
	call LoadHudAndHpBarAndStatusTilePatterns
	ld hl, vBGMap0
	ld bc, $400
.clearBackgroundLoop
	ld a, " "
	ld [hli], a
	dec bc
	ld a, b
	or c
	jr nz, .clearBackgroundLoop
; copy the work RAM tile map to VRAM
	coord hl, 0, 0
	ld de, vBGMap0
	ld b, 18 ; number of rows
.copyRowLoop
	ld c, 20 ; number of columns
.copyColumnLoop
	ld a, [hli]
	ld [de], a
	inc e
	dec c
	jr nz, .copyColumnLoop
	ld a, 12 ; number of off screen tiles to the right of screen in VRAM
	add e ; skip the off screen tiles
	ld e, a
	jr nc, .noCarry
	inc d
.noCarry
	dec b
	jr nz, .copyRowLoop
	call EnableLCD
	ld a, $90
	ld [hWY], a
	ld [rWY], a
	xor a
	ld [hTilesetType], a
	ld [hSCY], a
	dec a
	ld [wUpdateSpritesEnabled], a
	call Delay3
	xor a
	ld [H_AUTOBGTRANSFERENABLED], a
	ld b, $70
	ld c, $90
	ld a, c
	ld [hSCX], a
	call DelayFrame
	ld a, %11100100 ; inverted palette for silhouette effect
	ld [rBGP], a
	ld [rOBP0], a
	ld [rOBP1], a
.slideSilhouettesLoop ; slide silhouettes of the player's pic and the enemy's pic onto the screen
	ld h, b
	ld l, $40
	call SetScrollXForSlidingPlayerBodyLeft ; begin background scrolling on line $40
	inc b
	inc b
	ld h, $0
	ld l, $60
	call SetScrollXForSlidingPlayerBodyLeft ; end background scrolling on line $60
	call SlidePlayerHeadLeft
	ld a, c
	ld [hSCX], a
	dec c
	dec c
	jr nz, .slideSilhouettesLoop
	ld a, $1
	ld [H_AUTOBGTRANSFERENABLED], a
	ld a, $31
	ld [hStartTileID], a
	coord hl, 1, 5
	predef CopyUncompressedPicToTilemap
	xor a
	ld [hWY], a
	ld [rWY], a
	inc a
	ld [H_AUTOBGTRANSFERENABLED], a
	call Delay3
	ld b, SET_PAL_BATTLE
	call RunPaletteCommand
	call HideSprites
	jpab PrintBeginningBattleText

; when a battle is starting, silhouettes of the player's pic and the enemy's pic are slid onto the screen
; the lower of the player's pic (his body) is part of the background, but his head is a sprite
; the reason for this is that it shares Y coordinates with the lower part of the enemy pic, so background scrolling wouldn't work for both pics
; instead, the enemy pic is part of the background and uses the scroll register, while the player's head is a sprite and is slid by changing its X coordinates in a loop
SlidePlayerHeadLeft:
	push bc
	ld hl, wOAMBuffer + $01
	ld c, $15 ; number of OAM entries
	ld de, $4 ; size of OAM entry
.loop
	dec [hl] ; decrement X
	dec [hl] ; decrement X
	add hl, de ; next OAM entry
	dec c
	jr nz, .loop
	pop bc
	ret

SetScrollXForSlidingPlayerBodyLeft:
	ld a, [rLY]
	cp l
	jr nz, SetScrollXForSlidingPlayerBodyLeft
	ld a, h
	ld [rSCX], a
.loop
	ld a, [rLY]
	cp h
	jr z, .loop
	ret

StartBattle:
	xor a
	ld [wPartyGainExpFlags], a
	ld [wPartyFoughtCurrentEnemyFlags], a
	ld [wActionResultOrTookBattleTurn], a
	ld [wSuccessfulCapture], a					; since we don't reset it immediately after a catch, we need to reset it here to avoid it carrying over from a previous catch
	ld [wNewBattleFlags], a						; reinitialize this variable at the start of every battle
	inc a
	ld [wFirstMonsNotOutYet], a
	ld hl, wEnemyMon1HP
	ld bc, wEnemyMon2 - wEnemyMon1 - 1
	ld d, $3
.findFirstAliveEnemyMonLoop
	inc d
	ld a, [hli]
	or [hl]
	jr nz, .foundFirstAliveEnemyMon
	add hl, bc
	jr .findFirstAliveEnemyMonLoop
.foundFirstAliveEnemyMon
	ld a, d
	ld [wSerialExchangeNybbleReceiveData], a
	ld a, [wIsInBattle]
	dec a ; is it a trainer battle?
	call nz, EnemySendOutFirstMon ; if it is a trainer battle, send out enemy mon
	ld c, 40
	call DelayFrames
	call SaveScreenTilesToBuffer1
.checkAnyPartyAlive
	call AnyPartyAlive
	ld a, d
	and a
	jp z, HandlePlayerBlackOut ; jump if no mon is alive
	call LoadScreenTilesFromBuffer1
	ld a, [wBattleType]
	and a ; is it a normal battle?
	jp z, .playerSendOutFirstMon ; if so, send out player mon
	cp BATTLE_TYPE_FACILITY
	jp z, .playerSendOutFirstMon
; safari zone battle
.displaySafariZoneBattleMenu
	call DisplayBattleMenu
	ret c ; return if the player ran from battle
	ld a, [wActionResultOrTookBattleTurn]
	and a ; was the item used successfully?
	jr z, .displaySafariZoneBattleMenu ; if not, display the menu again; XXX does this ever jump?
	ld a, [wNumSafariBalls]
	and a
	jr nz, .notOutOfSafariBalls
	call LoadScreenTilesFromBuffer1
	ld hl, .outOfSafariBallsText
	jp PrintText
.notOutOfSafariBalls
	callab PrintSafariZoneBattleText
	ld a, [wEnemyMonSpeed + 1]
	add a
	ld b, a ; init b (which is later compared with random value) to (enemy speed % 256) * 2
	jp c, EnemyRan ; if (enemy speed % 256) > 127, the enemy runs
	ld a, [wSafariBaitFactor]
	and a ; is bait factor 0?
	jr z, .checkEscapeFactor
; bait factor is not 0
; divide b by 4 (making the mon less likely to run)
	srl b
	srl b
.checkEscapeFactor
	ld a, [wSafariEscapeFactor]
	and a ; is escape factor 0?
	jr z, .compareWithRandomValue
; escape factor is not 0
; multiply b by 2 (making the mon more likely to run)
	sla b
	jr nc, .compareWithRandomValue
; cap b at 255
	ld b, $ff
.compareWithRandomValue
	call Random
	cp b
	jr nc, .checkAnyPartyAlive
	jr EnemyRan ; if b was greater than the random value, the enemy runs

.outOfSafariBallsText
	TX_FAR _OutOfSafariBallsText
	db "@"

.playerSendOutFirstMon
	xor a
	ld [wWhichPokemon], a
	dec a								; add this to initialize last move used to $ff
	ld [wEnemyLastMoveListIndex], a		; add this to initialize last move used to $ff
.findFirstAliveMonLoop
	call HasMonFainted
	jr nz, .foundFirstAliveMon
; fainted, go to the next one
	ld hl, wWhichPokemon
	inc [hl]
	jr .findFirstAliveMonLoop
.foundFirstAliveMon
	ld a, [wWhichPokemon]
	ld [wPlayerMonNumber], a
	ld hl, wPartySpecies
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc							; to handle 2 bytes species ID
	ld a, [hli]							; to handle 2 bytes species ID
	ld [wBattleMonSpecies2], a
	ld a, [hl]							; to handle 2 bytes species ID
	ld [wBattleMonSpecies2 + 1], a		; to handle 2 bytes species ID
	call LoadScreenTilesFromBuffer1
	coord hl, 1, 5
	ld a, $9
	call SlideTrainerPicOffScreen
	call SaveScreenTilesToBuffer1
	ld a, [wWhichPokemon]
	ld c, a
	ld b, FLAG_SET
	push bc
	ld hl, wPartyGainExpFlags
	predef FlagActionPredef
	ld hl, wPartyFoughtCurrentEnemyFlags
	pop bc
	predef FlagActionPredef
	call LoadBattleMonFromParty
	call LoadScreenTilesFromBuffer1
	xor a
	ld hl, wPlayerReflectCounter	; initialize counters for Reflect, Light Screen and Mist for player and enemy
	ld [hli], a						; initialize counters for Reflect, Light Screen and Mist for player and enemy
	ld [hli], a						; initialize counters for Reflect, Light Screen and Mist for player and enemy
	ld [hli], a						; initialize counters for Reflect, Light Screen and Mist for player and enemy
	ld [hli], a						; initialize counters for Reflect, Light Screen and Mist for player and enemy
	ld [hli], a						; initialize counters for Reflect, Light Screen and Mist for player and enemy
	ld [hli], a						; initialize counters for Reflect, Light Screen and Mist for player and enemy
	ld [hli], a						; initialize last attack received by the player (for Mirror Move)
	ld [hli], a						; initialize last attack received by the enemy (for Mirror Move)
	ld [hli], a						; initialize trapping counter for the player
	ld [hl], a						; initialize trapping counter for the enemy
	ld hl, wDamage
	ld [hli], a						; zero the damage
	ld [hl], a						; zero the damage
	call SendOutMon
	jr MainInBattleLoop_FirstTurn	; jump to first turn initialization routine

; wild mon or link battle enemy ran from battle
EnemyRan:
	call LoadScreenTilesFromBuffer1
	ld a, [wLinkState]
	cp LINK_STATE_BATTLING
	ld hl, WildRanText
	jr nz, .printText
; link battle
	xor a
	ld [wBattleResult], a
	ld hl, EnemyRanText
.printText
	call PrintText
	ld a, SFX_RUN
	call PlaySoundWaitForCurrent
	xor a
	ld [H_WHOSETURN], a
	jpab AnimationSlideEnemyMonOff

WildRanText:
	TX_FAR _WildRanText
	db "@"

EnemyRanText:
	TX_FAR _EnemyRanText
	db "@"

MainInBattleLoop:
	ld hl, wNewBattleFlags					; bit 0 of this variable is used as a switch to alternate which pokemon
											; gets the effects of Between Turns Events (BTEs) first
	res USING_SIGNATURE_MOVE, [hl]			; to avoid problems when getting the names of trapping moves during BTEs
	ld a, [hl]
	xor (1 << ALTERNATING_BIT)				; flip bit 0, leave the others unchanged
	ld [hl], a								; update flags variable with the flipped bit
	bit ALTERNATING_BIT, [hl]				; test bit 0 : serves to alternate each turn which pokemon undergoes between turn events first
	jr z, .playerFirst
	call ApplyBetweenTurnsEventsToEnemy
	jp z, TrainerBattleVictory				; if the last mon died to recurring damage, jump to TrainerBattleVictory
	call ApplyBetweenTurnsEventsToPlayer
	jp z, HandlePlayerBlackOut				; if the last mon died to recurring damage, jump to HandlePlayerBlackOut
	jr .betweenTurnsEventsDone
.playerFirst
	call ApplyBetweenTurnsEventsToPlayer
	jp z, HandlePlayerBlackOut				; if the last mon died to recurring damage, jump to HandlePlayerBlackOut
	call ApplyBetweenTurnsEventsToEnemy
	jp z, TrainerBattleVictory				; if the last mon died to recurring damage, jump to TrainerBattleVictory
.betweenTurnsEventsDone
	ld hl, wNewBattleFlags
	ld a, [hl]
	and (1 << ALTERNATING_BIT | 1 << ENEMY_SIGNATURE_MOVE | 1 << PLAYER_SIGNATURE_MOVE )		; reset all flags except bits 0, 2, 3 and 6 in wNewBattleFlags
	ld [hl], a
	ld hl, wPlayerBattleStatus3
	res BETWEEN_TURNS_PHASE_DONE, [hl]
	ld hl, wEnemyBattleStatus3
	res BETWEEN_TURNS_PHASE_DONE, [hl]
	callab BetweenTurnsEvents 				; reinitialize damage, decrement counters for passive effects that last several turns (Light Screen etc.), bring substitutes back on screen
	jr MainInBattleLoop_NewTurn
MainInBattleLoop_FirstTurn:
	call BattleRandom
	and (1 << ALTERNATING_BIT)
	ld [wNewBattleFlags], a					; initialize variable holding alternating flag for BTEs in bit 0
MainInBattleLoop_NewTurn:
	call CopyPlayerMonCurHPAndStatusFromBattleToParty
	ld hl, wBattleMonHP
	ld a, [hli]
	or [hl]							; is battle mon HP 0?
	jp z, HandlePlayerMonFainted	; if battle mon HP is 0, jump
	ld hl, wEnemyMonHP
	ld a, [hli]
	or [hl]							; is enemy mon HP 0?
	jp z, HandleEnemyMonFainted		; if enemy mon HP is 0, jump
	call SaveScreenTilesToBuffer1
	xor a
	ld [wFirstMonsNotOutYet], a
	call AISelectEnemyMove				; moved from right after .getLinkData (formerly called .selectEnemyMove)
										; to make the AI choose its move before knowing what the player does (no more mind reading)
	ld hl, wEnemyBattleStatus1			; moved these above the NEEDS_TO_RECHARGE test so that the correct message is displayed when a flinch move is used on a recharging mon
	res FLINCHED, [hl]
	inc hl
	inc hl
	res CANT_BE_SUCKER_PUNCHED, [hl]
	res SUICIDED, [hl]
	ld hl, wPlayerBattleStatus3
	res CANT_BE_SUCKER_PUNCHED, [hl]
	res SUICIDED, [hl]
	dec hl
	dec hl
	res FLINCHED, [hl]
	ld a, [hl]
	and (1 << THRASHING_ABOUT) | (1 << CHARGING_UP)	; check if the player is thrashing about or charging for an attack
	jr nz, .getLinkData								; if so, jump
; the player is neither thrashing about nor charging for an attack
	ld a, [wPlayerBattleStatus2]
	and (1 << NEEDS_TO_RECHARGE)
	jr nz, .getLinkData
; the player doesn't need to recharge
	call DisplayBattleMenu							; show battle menu
	ret c											; return if player ran from battle
	ld a, [wEscapedFromBattle]
	and a
	ret nz											; return if pokedoll was used to escape from battle
	ld a, [wPlayerBattleStatus1]
	bit STORING_ENERGY, a							; removed multiturn moves check (check player is using Bide)
	jr nz, .getLinkData								; if so, jump
.selectPlayerMove
	ld a, [wActionResultOrTookBattleTurn]
	and a										; has the player already used the turn (e.g. by using an item, trying to run or switching pokemon)
	jr nz, .getLinkData
	ld [wMoveMenuType], a
	inc a
	ld [wAnimationID], a
	xor a
	ld [wMenuItemToSwap], a
	call MoveSelectionMenu
	push af
	call LoadScreenTilesFromBuffer1
	call DrawHUDsAndHPBars
	pop af
	jp nz, MainInBattleLoop_NewTurn			; if the player didn't select a move, jump
.getLinkData
	ld a, [wLinkState]
	cp LINK_STATE_BATTLING
	jr nz, .noLinkBattle
; link battle
	call GetEnemyMoveInLinkBattle			; in link battles, this is the right moment for fetching the opponent's action
	ld a, [wSerialExchangeNybbleReceiveData]
	cp LINKBATTLE_RUN
	jp z, EnemyRan
	cp LINKBATTLE_STRUGGLE
	jr z, .noLinkBattle
	cp LINKBATTLE_NO_ACTION
	jr z, .noLinkBattle
	sub 4
	jr c, .noLinkBattle
; the link battle enemy has switched mons
	callab SwitchEnemyMon
.noLinkBattle
	ld a, $1
	ld [H_WHOSETURN], a
	callab TrainerAI				; make the AI switch or use items at the start of the turn instead of when they would attack
	jr c, .AIActionUsedEnemyFirst
	ld a, [wEnemyMoveExtra]
	and $f0							; zero the low half-byte of wEnemyMoveExtra to isolate the move priority
	ld b, a							; store enemy move's priority in b
	ld a, [wPlayerMoveExtra]
	and $f0
	cp b							; compare them
	jr z, .compareSpeed				; if they're equal, compare the pokemon's speeds
	jr c, .enemyMovesFirst			; if enemy move's priority is higher than the player move's priority, enemy attacks first
	jp .playerMovesFirst			; else player attacks first
.compareSpeed
	ld a, [wTrickRoomCounter]
	and a							; test if trick room counter is still > 0
	ld de, wBattleMonSpeed			; player speed value
	ld hl, wEnemyMonSpeed			; enemy speed value
	ld c, $2
	jr nz, .trickRoomActive			; if trick room is still active, jump
	call StringCmp					; compare speed values
	jr z, .speedEqual
	jr nc, .playerMovesFirst		; if player is faster
	jr .enemyMovesFirst				; if enemy is faster
.trickRoomActive					; if trick room is active, reverse the result of the speed comparison
	call StringCmp					; compare speed values
	jr z, .speedEqual
	jr nc, .enemyMovesFirst			; if player is faster
	jr .playerMovesFirst			; if enemy is faster
.speedEqual							; 50/50 chance for both players
	ld a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK
	jr z, .invertOutcome
	call BattleRandom
	cp FIFTY_PERCENT
	jr c, .playerMovesFirst
	jr .enemyMovesFirst
.invertOutcome
	call BattleRandom
	cp FIFTY_PERCENT
	jr c, .enemyMovesFirst
	jr .playerMovesFirst
.enemyMovesFirst
	ld hl, wEnemyBattleStatus3
	set CANT_BE_SUCKER_PUNCHED, [hl]	; Sucker Punch fails when the target moves first
	call CallHideSubstituteShowMonAnim
	call ExecuteEnemyMove
	push bc
	call CallReshowSubstituteAnim
	pop bc
	ld a, [wEscapedFromBattle]
	and a							; was Teleport, Road, or Whirlwind used to escape from battle?
	ret nz							; if so, return
	ld a, b
	and a
	jr nz, .playerMonSurvives
	call RemoveFaintedPlayerMon
	jp z, HandlePlayerBlackOut		; if it was the last mon, previous call set the z flag
	call IsUserFainted				; check whether the user fainted after its attack
	call z, FaintEnemyPokemon
	jp z, TrainerBattleVictory
	jp MainInBattleLoop 
.playerMonSurvives
	call RoarUsedFirst				; check whether a forced switch move was used first
.AIActionUsedEnemyFirst
	call IsUserFainted				; check whether the user fainted after its attack
	call z, FaintEnemyPokemon
	jp z, TrainerBattleVictory
	call ExecutePlayerMove
	ld a, [wEscapedFromBattle]
	and a							; was Teleport, Road, or Whirlwind used to escape from battle?
	ret nz							; if so, return
	ld a, b
	and a
	call z, FaintEnemyPokemon
	jp z, TrainerBattleVictory
	call IsUserFainted				; check whether the user fainted after its attack
	call z, RemoveFaintedPlayerMon
	jp z, HandlePlayerBlackOut		; if it was the last mon, previous call set the z flag
	jp MainInBattleLoop
.playerMovesFirst
	ld hl, wPlayerBattleStatus3
	set CANT_BE_SUCKER_PUNCHED, [hl]	; Sucker Punch fails when the target moves first
	call ExecutePlayerMove
	push bc
	call CallReshowSubstituteAnim
	pop bc
	ld a, [wEscapedFromBattle]
	and a							; was Teleport, Road, or Whirlwind used to escape from battle?
	ret nz							; if so, return
	ld a, b
	and a
	jr nz, .enemyMonSurvives
	call FaintEnemyPokemon
	jp z, TrainerBattleVictory
	call IsUserFainted				; check whether the user fainted after its attack
	call z, RemoveFaintedPlayerMon
	jp z, HandlePlayerBlackOut		; if it was the last mon, previous call set the z flag
	jp MainInBattleLoop
.enemyMonSurvives
	call RoarUsedFirst				; check whether a forced switch move was used first
	call IsUserFainted				; check whether the user fainted after its attack
	call z, RemoveFaintedPlayerMon
	jp z, HandlePlayerBlackOut		; if it was the last mon, previous call set the z flag
	ld a, $1
	ld [H_WHOSETURN], a
	call CallHideSubstituteShowMonAnim
	call ExecuteEnemyMove
	ld a, [wEscapedFromBattle]
	and a							; was Teleport, Road, or Whirlwind used to escape from battle?
	ret nz							; if so, return
	ld a, b
	and a
	call z, RemoveFaintedPlayerMon
	jp z, HandlePlayerBlackOut		; if it was the last mon, previous call set the z flag
.AIActionUsedPlayerFirst
	call IsUserFainted				; check whether the user fainted after its attack
	call z, FaintEnemyPokemon
	jp z, TrainerBattleVictory
	jp MainInBattleLoop

; this function now also handles trapping moves damage over time
; (all between turns damage are handled here)
HandlePoisonBurnLeechSeed:
	ld hl, wBattleMonHP
	ld de, wBattleMonStatus
	ld a, [H_WHOSETURN]
	and a
	jr z, .playersTurn
	ld hl, wEnemyMonHP
	ld de, wEnemyMonStatus
.playersTurn
	ld a, [de]
	and (1 << BRN) | (1 << PSN)
	jr z, .notBurnedOrPoisoned
	push hl
	push de
	call CallHideSubstituteShowMonAnim	; move substitute offscreen if needed
	pop de
	ld hl, HurtByPoisonText
	ld a, [de]
	and 1 << BRN
	jr z, .poisoned
	ld hl, HurtByBurnText
.poisoned
	call PrintText
	xor a
	ld [wAnimationType], a
	ld a, BURN_PSN_ANIM
	call PlaySpecialAnimation   ; play burn/poison animation
	pop hl
	ld d, CAN_BE_TOXIC		; add this to correct the Toxic/Leech Seed bug
	call HandlePoisonBurnLeechSeed_DecreaseOwnHP
	call TestIfFainted	; add this to check whether the mon fainted due to Poison/Burn damage
	ret z				; return if the mon fainted
.notBurnedOrPoisoned
	ld de, wPlayerBattleStatus2
	ld a, [H_WHOSETURN]
	and a
	jr z, .playersTurn2
	ld de, wEnemyBattleStatus2
.playersTurn2
	ld a, [de]
	bit SEEDED, a
	jr z, .notLeechSeeded
	push hl
	call CallHideSubstituteShowMonAnim	; move substitute offscreen if needed
	ld a, [H_WHOSETURN]
	push af
	xor $1
	ld [H_WHOSETURN], a
	call IsUserFainted
	call nz, CallHideSubstituteShowMonAnim	; hide substitute for recepient of Leech Seed drain if not fainted
	xor a
	ld [wAnimationType], a
	ld a, ABSORB
	call PlaySpecialAnimation		; play leech seed animation (from opposing mon)
	pop af
	ld [H_WHOSETURN], a
	pop hl
	ld d, CANNOT_BE_TOXIC		; add this to prevent Leech Seed from using the Toxic counter
	call HandlePoisonBurnLeechSeed_DecreaseOwnHP
	call HandlePoisonBurnLeechSeed_IncreaseEnemyHP
	push hl
	ld hl, HurtByLeechSeedText
	call PrintText
	pop hl
	call TestIfFainted	; add this to check whether the mon fainted due to Leech Seed damage
	ret z				; return if the mon fainted
.notLeechSeeded
	call HandleTrappingMoves		; add this to inflict trapping move damage, if any
TestIfFainted:
	ld a, [hli]
	or [hl]
	dec hl
	ret nz          			; return if not fainted
	ld a, [H_WHOSETURN]
	and a
	jr z, .playersTurn3
	call DrawEnemyHUDAndHPBar	; if we draw both HUDs and HP bars, it makes fainted mon's HUD reappear 
	jr .finish					; when a mon dies from poison after killing the opponent, so we must be
.playersTurn3					; more selective and redraw only the HUD of the mon that just fainted
	call DrawPlayerHUDAndHPBar	; from poison (or any other damage over time)
.finish
	ld c, 20
	call DelayFrames
	xor a
	ret

HurtByPoisonText:
	TX_FAR _HurtByPoisonText
	db "@"

HurtByBurnText:
	TX_FAR _HurtByBurnText
	db "@"

HurtByLeechSeedText:
	TX_FAR _HurtByLeechSeedText
	db "@"

; hl: HP pointer
; bc (out): total damage
HandlePoisonBurnLeechSeed_DecreaseOwnHP:
	push hl
	push hl
	ld bc, wBattleMonMaxHP - wBattleMonHP      ; skip to max HP
	add hl, bc
	ld a, [hli]    ; load max HP
	ld [wHPBarMaxHP+1], a
	ld b, a
	ld a, [hl]
	ld [wHPBarMaxHP], a
	ld c, a
	srl b
	rr c
	srl b
	rr c
	srl c
	ld a, c
	and a
	jr nz, .nonZeroDamage1
	inc c			; damage is at least 1
.nonZeroDamage1
	ld a, d
	cp CAN_BE_TOXIC
	jr nz, .noToxic	; if these are not potential Toxic damage, don't use toxic counter
	ld hl, wBattleMonStatus
	ld de, wPlayerToxicCounter
	ld a, [H_WHOSETURN]
	and a
	jr z, .playersTurn
	ld hl, wEnemyMonStatus
	ld de, wEnemyToxicCounter
.playersTurn
	bit BADLY_POISONED, [hl]
	jr z, .noToxic			; if target is not badly poisoned, don't use Toxic counter
	srl c					; add this to make bad poison start at max HP/16 instead of max HP/8 like normal poison
	ld a, c					; check whether calculated damage is zero
	and a					; check whether calculated damage is zero
	jr nz, .nonZeroDamage2	; if calculated damage is not zero, no need to increment it
	inc c					; if calculated damage is zero, increment it by one
.nonZeroDamage2
	ld a, [de]		; increment toxic counter
	inc a
	ld [de], a
	ld hl, $0000
.toxicTicksLoop
	add hl, bc
	dec a
	jr nz, .toxicTicksLoop
	ld b, h       ; bc = damage * toxic counter
	ld c, l
.noToxic
	pop hl
	inc hl
	ld a, [hl]    ; subtract total damage from current HP
	ld [wHPBarOldHP], a
	sub c
	ld [hld], a
	ld [wHPBarNewHP], a
	ld a, [hl]
	ld [wHPBarOldHP+1], a
	sbc b
	ld [hl], a
	ld [wHPBarNewHP+1], a
	jr nc, .noOverkill
	xor a						; overkill: zero HP
	ld [hli], a
	ld [hl], a
	ld [wHPBarNewHP], a
	ld [wHPBarNewHP+1], a
	ld a, [wHPBarOldHP]			; cap damage to remaining HP
	ld c, a						; cap damage to remaining HP
	ld a, [wHPBarOldHP+1]		; cap damage to remaining HP
	ld b, a						; cap damage to remaining HP
.noOverkill
	call UpdateCurMonHPBar
	pop hl
	ret

; adds bc to enemy HP
; bc isn't updated if HP subtracted was capped to prevent overkill
HandlePoisonBurnLeechSeed_IncreaseEnemyHP:
	push hl
	ld hl, wEnemyMonMaxHP
	ld a, [H_WHOSETURN]
	and a
	jr z, .playersTurn
	ld hl, wBattleMonMaxHP
.playersTurn
	ld a, [hli]
	ld [wHPBarMaxHP+1], a
	ld a, [hl]
	ld [wHPBarMaxHP], a
	ld de, wBattleMonHP - wBattleMonMaxHP
	add hl, de					; skip back from max hp to current hp
	ld a, [hld]
	ld d, a
	ld a, [hli]
	or d
	jr z, .done					; if opponent's HP is zero, don't heal them
	ld a, [hl]
	ld [wHPBarOldHP], a			; add bc to current HP
	add c
	ld [hld], a
	ld [wHPBarNewHP], a
	ld a, [hl]
	ld [wHPBarOldHP+1], a
	adc b
	ld [hli], a
	ld [wHPBarNewHP+1], a
	ld a, [wHPBarMaxHP]
	ld c, a
	ld a, [hld]
	sub c
	ld a, [wHPBarMaxHP+1]
	ld b, a
	ld a, [hl]
	sbc b
	jr c, .noOverfullHeal
	ld a, b                ; overfull heal, set HP to max HP
	ld [hli], a
	ld [wHPBarNewHP+1], a
	ld a, c
	ld [hl], a
	ld [wHPBarNewHP], a
.noOverfullHeal
	ld a, [H_WHOSETURN]
	xor $1
	ld [H_WHOSETURN], a
	call UpdateCurMonHPBar
	ld a, [H_WHOSETURN]
	xor $1
	ld [H_WHOSETURN], a
.done
	pop hl
	ret

UpdateCurMonHPBar:
	coord hl, 10, 9    ; tile pointer to player HP bar
	ld a, [H_WHOSETURN]
	and a
	ld a, $1
	jr z, .playersTurn
	coord hl, 2, 2    ; tile pointer to enemy HP bar
	xor a
.playersTurn
	push bc
	ld [wHPBarType], a
	predef UpdateHPBar2
	pop bc
	ret

HandleEnemyMonFainted:
	call AnyPartyAlive
	ld a, d
	and a
	jp z, HandlePlayerBlackOut			; if no party mons are alive, the player blacks out
	ld hl, wBattleMonHP
	ld a, [hli]
	or [hl]								; is battle mon HP zero?
	call nz, DrawPlayerHUDAndHPBar		; if battle mon HP is not zero, draw player HUD and HP bar
	ld a, [wIsInBattle]
	dec a
	ret z								; end the battle if it's a wild battle
	call AnyEnemyPokemonAliveCheck
	jp z, TrainerBattleVictory
	ld hl, wBattleMonHP
	ld a, [hli]
	or [hl]								; does battle mon have 0 HP?
	jr nz, .skipReplacingBattleMon		; if not, skip replacing battle mon
	call ChooseNextMon
.skipReplacingBattleMon
	ld a, $1
	ld [wActionResultOrTookBattleTurn], a
	call ReplaceFaintedEnemyMon
	jp z, EnemyRan
	xor a
	ld [wActionResultOrTookBattleTurn], a
	jp MainInBattleLoop_NewTurn

FaintEnemyPokemon:
	call CopyPlayerMonCurHPAndStatusFromBattleToParty
	ld a, [wIsInBattle]
	dec a
	jr z, .wild
	ld a, [wEnemyMonPartyPos]
	ld hl, wEnemyMon1HP
	ld bc, wEnemyMon2 - wEnemyMon1
	call AddNTimes
	xor a
	ld [hli], a
	ld [hl], a
.wild
	ld hl, wPlayerBattleStatus1
	res ATTACKING_MULTIPLE_TIMES, [hl]
; Bug. This only zeroes the high byte of the player's accumulated damage,
; setting the accumulated damage to itself mod 256 instead of 0 as was probably
; intended. That alone is problematic, but this mistake has another more severe
; effect. This function's counterpart for when the player mon faints,
; RemoveFaintedPlayerMon, zeroes both the high byte and the low byte. In a link
; battle, the other player's Game Boy will call that function in response to
; the enemy mon (the player mon from the other side's perspective) fainting,
; and the states of the two Game Boys will go out of sync unless the damage
; was congruent to 0 modulo 256.
	xor a
	ld hl, wPlayerBideAccumulatedDamage	; correct the bug described above
	ld [hli], a							; correct the bug described above
	ld [hl], a							; correct the bug described above
	ld hl, wEnemyMimicSlot
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld [wEnemyDisabledMove], a
	ld [wEnemyDisabledMoveNumber], a
	ld [wEnemyMonMinimized], a
	ld hl, wPlayerUsedMove
	ld [hli], a
	ld [hl], a
	ld a, [wEnemyMonSpecies]			; to handle 2 bytes species ID
	ld b, a								; to handle 2 bytes species ID
	ld a, [wEnemyMonSpecies + 1]		; to handle 2 bytes species ID
	ld c, a								; to handle 2 bytes species ID
	call PlayCry						; play the enemy pokemon's cry when it faints
	coord hl, 12, 5
	coord de, 12, 6
	call SlideDownFaintedMonPic
	coord hl, 0, 0
	lb bc, 4, 11
	call ClearScreenArea
	ld hl, wLowHealthAlarm
	bit 7, [hl]
	jr nz, .printFaintedText		; if low health alarm is on, don't play fainting sounds to avoid audio glitches (stuck notes)
	xor a
	ld [wFrequencyModifier], a
	ld [wTempoModifier], a
	ld a, SFX_FAINT_FALL
	call PlaySoundWaitForCurrent
.sfxwait
	ld a, [wChannelSoundIDs + Ch4]
	cp SFX_FAINT_FALL
	jr z, .sfxwait
	ld a, SFX_FAINT_THUD
	call PlaySound
	call WaitForSoundToFinish
.printFaintedText
	ld hl, EnemyMonFaintedText
	ld a, [wIsInBattle]
	dec a
	jr nz, .trainerBattle			; skip wild mon victory fanfare in trainer battles
	call AnyPartyAlive				; check to see if the player blacks out
	ld a, d
	and a
	jr z, .displayText
	call EndLowHealthAlarm
	ld a, MUSIC_DEFEATED_WILD_MON
	call PlayBattleVictoryMusic
.displayText
	ld hl, WildMonFaintedText
.trainerBattle
	call PrintText
	call PrintEmptyString
	ld a, [wBattleType]
	cp BATTLE_TYPE_FACILITY
	jr nz, .notBattleFacility
	ld a, [wPlayerBattleStatus3]
	bit SUICIDED, a
	jr z, .skipAliveCheck
.notBattleFacility
	call AnyPartyAlive				; check to see if the player blacks out
	ld a, d
	and a
	jp z, .doneIgnoreVictory		; if player has no more pokemon after killing the mon, black out
.skipAliveCheck
	call SaveScreenTilesToBuffer1
	xor a
	ld [wBattleResult], a
	ld [wBoostExpByExpAll], a
	ld a, [wPartyGainExpFlags]
	ld b, a
	push bc							; save wPartyGainExpFlags since GainExperience clears it and we need it afterwards
	callab GainExperience			; give all exp to all the mons that actually fought (without dividing)
	pop bc							; restore wPartyGainExpFlags in b to know which mon already got exp without EXP. SHARE
	ld hl, wOptions
	bit EXP_SHARE_STATE, [hl]		; use flag stored in wOptions instead of checking presence of EXP. SHARE in bag
	jr z, .done						; jump if no exp share
	ld a, b							; here b contains [wPartyGainExpFlags]
	xor $3f							; flip 6 right-most bits so that mons that didn't get exp will get it now and vice-versa
	ld [wPartyGainExpFlags], a
	ld a, $1
	ld [wBoostExpByExpAll], a
	ld hl, wEnemyMonBaseExp			; halve experience for exp share beneficiaries
	srl [hl]
	callab GainExperience
.done
	ld a, [wIsInBattle]
	dec a
	jp z, CheckItemDrop
	call AnyEnemyPokemonAliveCheck
	ret
.doneIgnoreVictory
	or $1								; unset the z flag
	ret

EnemyMonFaintedText:
	TX_FAR _EnemyMonFaintedText
	db "@"

; add this
WildMonFaintedText:
	TX_FAR _WildMonFaintedText
	db "@"

; add this function to handle item drops from wild mons
CheckItemDrop:
	callab CheckItemDrop_
	and 0					; set z flag before returning to indicate this is the end of a wild battle
	ret

EndLowHealthAlarm:
; This function is called when the player has the won the battle. It turns off
; the low health alarm and prevents it from reactivating until the next battle.
	xor a
	ld [wLowHealthAlarm], a ; turn off low health alarm
	ld [wChannelSoundIDs + Ch4], a
	inc a
	ld [wLowHealthAlarmDisabled], a ; prevent it from reactivating
	ret

AnyEnemyPokemonAliveCheck:
	ld a, [wEnemyPartyCount]
	ld b, a
	xor a
	ld hl, wEnemyMon1HP
	ld de, wEnemyMon2 - wEnemyMon1
.nextPokemon
	or [hl]
	inc hl
	or [hl]
	dec hl
	add hl, de
	dec b
	jr nz, .nextPokemon
	and a
	ret

; stores whether enemy ran in Z flag
ReplaceFaintedEnemyMon:
	ld hl, wEnemyHPBarColor
	ld e, 0								; to make the balls use the red palette
	call GetBattleHealthBarColor
	callab DrawEnemyPokeballs
	ld a, [wLinkState]
	cp LINK_STATE_BATTLING
	jr nz, .notLinkBattle
; link battle
	call LinkBattleExchangeData
	ld a, [wSerialExchangeNybbleReceiveData]
	cp LINKBATTLE_RUN
	ret z
	call LoadScreenTilesFromBuffer1
.notLinkBattle
	call EnemySendOut
	xor a
	ld [wEnemyMoveNum], a
	ld [wActionResultOrTookBattleTurn], a
	ld [wAILayer2Encouragement], a
	inc a ; reset Z flag
	ret

TrainerBattleVictory:
	ld a, [wIsInBattle]			; add a check to see if it's a wild battle
	dec a						; since now this is also called during wild battles
	ret z
	ld a, [wBattleType]
	cp BATTLE_TYPE_FACILITY
	jr nz, .notBattleFacility
	ld a, [wPlayerBattleStatus3]
	bit SUICIDED, a
	jr z, .victory
.notBattleFacility
	call AnyPartyAlive			; check if the player still has mon alive before declaring them victorious
	ld a, d
	and a
	jp z, HandlePlayerBlackOut	; in case both trainers lose their last mon at the same time, player black out is prioritized
.victory
	call EndLowHealthAlarm
	ld b, MUSIC_DEFEATED_GYM_LEADER
	ld a, [wGymLeaderNo]
	and a
	jr nz, .gymleader
	ld b, MUSIC_DEFEATED_TRAINER
.gymleader
	ld a, [wTrainerClass]
	cp SONY3 ; final battle against rival
	jr nz, .notrival
	ld b, MUSIC_DEFEATED_GYM_LEADER
	ld hl, wFlags_D733
	set 1, [hl]
.notrival
	ld a, [wLinkState]
	cp LINK_STATE_BATTLING
	ld a, b
	call nz, PlayBattleVictoryMusic
	ld hl, TrainerDefeatedText
	call PrintText
	ld a, [wLinkState]
	cp LINK_STATE_BATTLING
	ret z
	call ScrollTrainerPicAfterBattle
	ld c, 40
	call DelayFrames
	call PrintEndBattleText
	ld a, [wBattleType]
	cp BATTLE_TYPE_FACILITY
	ret z								; skip money gain in Battle Facility
; win money
	ld hl, MoneyForWinningText
	call PrintText
	ld de, wPlayerMoney + 2
	ld hl, wAmountMoneyWon + 2
	ld c, $3
	predef_jump AddBCDPredef

MoneyForWinningText:
	TX_FAR _MoneyForWinningText
	db "@"

TrainerDefeatedText:
	TX_FAR _TrainerDefeatedText
	db "@"

PlayBattleVictoryMusic:
	push af
	ld a, $ff
	ld [wNewSoundID], a
	call PlaySoundWaitForCurrent
	pop af
	call PlayMusic
	jp Delay3

HandlePlayerMonFainted:
	call AnyPartyAlive						; test if any more mons are alive
	ld a, d
	and a
	jp z, HandlePlayerBlackOut
	ld hl, wEnemyMonHP
	ld a, [hli]
	or [hl]									; is enemy mon's HP 0?
	jr nz, .doUseNextMonDialogue			; if not, jump
; the enemy mon has 0 HP
	ld a, [wIsInBattle]
	dec a
	ret z									; if wild encounter, battle is over
	call AnyEnemyPokemonAliveCheck
	jp z, TrainerBattleVictory
.doUseNextMonDialogue
	call DoUseNextMonDialogue
	ret c									; return if the player ran from battle
	call ChooseNextMon
	jp nz, MainInBattleLoop_NewTurn			; if the enemy mon has more than 0 HP, go back to battle loop
; the enemy mon has 0 HP
	ld a, $1
	ld [wActionResultOrTookBattleTurn], a
	call ReplaceFaintedEnemyMon
	jp z, EnemyRan							; if enemy ran from battle rather than sending out another mon, jump
	xor a
	ld [wActionResultOrTookBattleTurn], a
	jp MainInBattleLoop_NewTurn

; resets flags, slides mon's pic down, plays cry, and prints fainted message
RemoveFaintedPlayerMon:
	ld a, [wPlayerMonNumber]
	ld c, a
	ld hl, wPartyGainExpFlags
	ld b, FLAG_RESET
	predef FlagActionPredef				; clear gain exp flag for fainted mon
	ld hl, wEnemyBattleStatus1
	res ATTACKING_MULTIPLE_TIMES, [hl]	; reset "attacking multiple times" flag
	ld a, [wLowHealthAlarm]
	bit 7, a							; skip sound flag (red bar (?))
	jr z, .skipWaitForSound
	ld a, $ff
	ld [wLowHealthAlarm], a				; disable low health alarm
	call WaitForSoundToFinish
.skipWaitForSound
; a is 0, so this zeroes the enemy's accumulated damage.
	ld hl, wEnemyBideAccumulatedDamage
	ld [hli], a
	ld [hl], a
	ld [wBattleMonStatus], a
	call CopyPlayerMonCurHPAndStatusFromBattleToParty
	coord hl, 9, 7
	lb bc, 5, 11
	call ClearScreenArea
	coord hl, 1, 10
	coord de, 1, 11
	call SlideDownFaintedMonPic
	ld a, $1
	ld [wBattleResult], a
	ld a, [wBattleMonSpecies]		; to handle 2 bytes species ID
	ld b, a							; to handle 2 bytes species ID
	ld a, [wBattleMonSpecies + 1]	; to handle 2 bytes species ID
	ld c, a							; to handle 2 bytes species ID	
	call PlayCry
	ld hl, PlayerMonFaintedText
	call PrintText
	call AnyPartyAlive				; check to see if the player blacks out
	ld a, d
	and a
	ret

PlayerMonFaintedText:
	TX_FAR _PlayerMonFaintedText
	db "@"

; asks if you want to use next mon
; stores whether you ran in C flag
DoUseNextMonDialogue:
	call PrintEmptyString
	call SaveScreenTilesToBuffer1
	ld a, [wIsInBattle]
	and a
	dec a
	ret nz ; return if it's a trainer battle
	ld hl, UseNextMonText
	call PrintText
.displayYesNoBox
	coord hl, 13, 9
	lb bc, 10, 14
	ld a, TWO_OPTION_MENU
	ld [wTextBoxID], a
	call DisplayTextBoxID
	ld a, [wMenuExitMethod]
	cp CHOSE_SECOND_ITEM ; did the player choose NO?
	jr z, .tryRunning ; if the player chose NO, try running
	and a ; reset carry
	ret
.tryRunning
	ld a, [wCurrentMenuItem]
	and a
	jr z, .displayYesNoBox ; xxx when does this happen?
	ld hl, wPartyMon1Speed
	ld de, wEnemyMonSpeed
	jp TryRunningFromBattle

UseNextMonText:
	TX_FAR _UseNextMonText
	db "@"

; choose next player mon to send out
; stores whether enemy mon has no HP left in Z flag
ChooseNextMon:
	ld a, BATTLE_PARTY_MENU
	ld [wPartyMenuTypeOrMessageID], a
	call DisplayPartyMenu
.checkIfMonChosen
	jr nc, .monChosen
.goBackToPartyMenu
	call GoBackToPartyMenu
	jr .checkIfMonChosen
.monChosen
	call HasMonFainted
	jr z, .goBackToPartyMenu ; if mon fainted, you have to choose another
	ld hl, wPlayerMonNumber
	ld a, [wWhichPokemon]
	cp [hl]
	jr nz, .notAlreadyOut		; Teleport uses this function to make the switch
	ld hl, AlreadyOutText		; so we need to check if the chosen mon is already out
	call PrintText				; in case this is called via Teleport (otherwise it's not needed)
	jr .goBackToPartyMenu		; When called after a mon has fainted, this will not run since the
.notAlreadyOut					; check on the mon's HP is done before this one
	ld a, [wLinkState]
	cp LINK_STATE_BATTLING
	jr nz, .notLinkBattle
	inc a
	ld [wActionResultOrTookBattleTurn], a
	call LinkBattleExchangeData
.notLinkBattle
	xor a
	ld [wActionResultOrTookBattleTurn], a
	call ClearSprites
	ld a, [wWhichPokemon]
	ld [wPlayerMonNumber], a
	ld c, a
	ld hl, wPartyGainExpFlags
	ld b, FLAG_SET
	push bc
	predef FlagActionPredef
	pop bc
	ld hl, wPartyFoughtCurrentEnemyFlags
	predef FlagActionPredef
	call LoadBattleMonFromParty
	call GBPalWhiteOut
	call LoadHudTilePatterns
	call LoadScreenTilesFromBuffer1
	call RunDefaultPaletteCommand
	call GBPalNormal
	call SendOutMon
	ld hl, wEnemyMonHP
	ld a, [hli]
	or [hl]
	ret

; called when player is out of usable mons.
; prints appropriate lose message, sets carry flag if player blacked out (special case for initial rival fight)
HandlePlayerBlackOut:
	ld a, [wBattleType]
	cp BATTLE_TYPE_FACILITY
	jp z, HandleBattleFacilityDefeat		; don't black out in the Battle Facility
	ld a, [wLinkState]
	cp LINK_STATE_BATTLING
	jr z, .notSony1Battle
	ld a, [wEngagedTrainerClass]
	cp SONY1
	jr nz, .notSony1Battle
	coord hl, 0, 0  ; sony 1 battle
	lb bc, 8, 21
	call ClearScreenArea
	call ScrollTrainerPicAfterBattle
	ld c, 40
	call DelayFrames
	ld hl, Sony1WinText
	call PrintText
	ld a, [wCurMap]
	cp OAKS_LAB
	ret z            ; starter battle in oak's lab: don't black out
.notSony1Battle
	ld b, SET_PAL_BATTLE_BLACK
	call RunPaletteCommand
	ld hl, PlayerBlackedOutText2
	ld a, [wLinkState]
	cp LINK_STATE_BATTLING
	jr nz, .noLinkBattle
	ld hl, LinkBattleLostText
.noLinkBattle
	call PrintText
	ld a, [wd732]
	res 5, a
	ld [wd732], a
	call ClearScreen
	scf
	ret

Sony1WinText:
	TX_FAR _Sony1WinText
	db "@"

PlayerBlackedOutText2:
	TX_FAR _PlayerBlackedOutText2
	db "@"

LinkBattleLostText:
	TX_FAR _LinkBattleLostText
	db "@"

; add this for the Battle Facility
HandleBattleFacilityDefeat:
	jpab _HandleBattleFacilityDefeat

; slides pic of fainted mon downwards until it disappears
; bug: when this is called, [H_AUTOBGTRANSFERENABLED] is non-zero, so there is screen tearing
SlideDownFaintedMonPic:
	ld a, [wd730]
	push af
	set 6, a
	ld [wd730], a
	ld b, 7 ; number of times to slide
.slideStepLoop ; each iteration, the mon is slid down one row
	push bc
	push de
	push hl
	ld b, 6 ; number of rows
.rowLoop
	push bc
	push hl
	push de
	ld bc, $7
	call CopyData
	pop de
	pop hl
	ld bc, -SCREEN_WIDTH
	add hl, bc
	push hl
	ld h, d
	ld l, e
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	pop bc
	dec b
	jr nz, .rowLoop
	ld bc, SCREEN_WIDTH
	add hl, bc
	ld de, SevenSpacesText
	call PlaceString
	ld c, 2
	call DelayFrames
	pop hl
	pop de
	pop bc
	dec b
	jr nz, .slideStepLoop
	pop af
	ld [wd730], a
	ret

SevenSpacesText:
	db "       @"

; slides the player or enemy trainer off screen
; a is the number of tiles to slide it horizontally (always 9 for the player trainer or 8 for the enemy trainer)
; if a is 8, the slide is to the right, else it is to the left
; bug: when this is called, [H_AUTOBGTRANSFERENABLED] is non-zero, so there is screen tearing
SlideTrainerPicOffScreen:
	ld [hSlideAmount], a
	ld c, a
.slideStepLoop ; each iteration, the trainer pic is slid one tile left/right
	push bc
	push hl
	ld b, 7 ; number of rows
.rowLoop
	push hl
	ld a, [hSlideAmount]
	ld c, a
.columnLoop
	ld a, [hSlideAmount]
	cp 8
	jr z, .slideRight
.slideLeft ; slide player sprite off screen
	ld a, [hld]
	ld [hli], a
	inc hl
	jr .nextColumn
.slideRight ; slide enemy trainer sprite off screen
	ld a, [hli]
	ld [hld], a
	dec hl
.nextColumn
	dec c
	jr nz, .columnLoop
	pop hl
	ld de, 20
	add hl, de
	dec b
	jr nz, .rowLoop
	ld c, 2
	call DelayFrames
	pop hl
	pop bc
	dec c
	jr nz, .slideStepLoop
	ret

; send out a trainer's mon
EnemySendOut:
	ld hl, wPartyGainExpFlags
	xor a
	ld [hl], a
	ld a, [wPlayerMonNumber]
	ld c, a
	ld b, FLAG_SET
	push bc
	predef FlagActionPredef
	ld hl, wPartyFoughtCurrentEnemyFlags
	xor a
	ld [hl], a
	pop bc
	predef FlagActionPredef
	; fallthrough

; don't change wPartyGainExpFlags or wPartyFoughtCurrentEnemyFlags
EnemySendOutFirstMon:
	xor a
	ld hl, wEnemyMimicSlot
	ld [hli], a							; wEnemyMimicSlot
	ld [hli], a							; wEnemyStatsToHalve
	ld [hli], a							; wEnemyBattleStatus1
	ld [hli], a							; wEnemyBattleStatus2
	ld [hl], a							; wEnemyBattleStatus3
	set CANT_BE_SUCKER_PUNCHED, [hl]	; Sucker Punch fails when the target was just sent out
	ld hl, wEnemyToxicCounter			; reinitialize toxic counter whenever a pokemon is sent out
	ld [hli], a							; reinitialize toxic counter whenever a pokemon is sent out
	ld [hl], a							; reinitialize disabled move whenever a pokemon is sent out (like before)
	ld hl, wPlayerLastAttackReceived	; reinitialize last attack received by the player
	ld [hli], a							; reinitialize last attack received by the player
	ld [hli], a							; reinitialize last attack received by the enemy
	ld [hli], a							; reinitialize trapping counter for the player
	ld [hl], a							; reinitialize trapping counter for the enemy
	ld [wEnemyDisabledMoveNumber], a
	ld hl, wTransformedEnemyMonOriginalSpecies	; reinitialize transformed mon original species
	ld [hli], a
	ld [hl], a									; species ID are now on 2 bytes
	ld hl, wPlayerUsedMove
	ld [hli], a
	ld [hli], a
	ld [hl], a
	dec a
	ld [wAICount], a
	ld [wEnemyLastMoveListIndex], a		; initialize the last move used to $ff
	ld hl, wPlayerBattleStatus1
	res USING_TRAPPING_MOVE, [hl]
	inc hl
	inc hl								; move hl to wPlayerBattleStatus3
	res TRAPPED, [hl]					; the opponent is no longer trapped by Mean Look
	coord hl, 18, 0
	ld a, 8
	call SlideTrainerPicOffScreen
	call PrintEmptyString
	call SaveScreenTilesToBuffer1
	ld hl, wNewBattleFlags
	res ENEMY_SIGNATURE_MOVE, [hl]
	res PLAYER_SIGNATURE_MOVE, [hl]
	ld a, [hl]							; check if this is a forced switch
	bit FORCED_SWITCH_OCCURRED, a		; check if this is a forced switch
	jr nz, .next3						; if it is, skip the part that sets the new pokemon
	ld a, [wLinkState]
	cp LINK_STATE_BATTLING
	jr nz, .next
	ld a, [wSerialExchangeNybbleReceiveData]
	sub 4
	ld [wWhichPokemon], a
	jr .next3
.next
	ld b, $FF
.next2										; this loop checks every party member in order until
	inc b									; it finds the first non-fainted mon in the enemy party (except the one that was out just now)
	ld a, [wEnemyMonPartyPos]				; position of the currently battling mon in the enemy party
	cp b
	jr z, .next2							; don't resend the same pokemon that was already out just now
	ld hl, wEnemyMon1
	ld a, b
	ld [wWhichPokemon], a
	push bc
	ld bc, wEnemyMon2 - wEnemyMon1
	call AddNTimes							; make hl point to the next party member
	pop bc
	inc hl									; skip the species byte
	inc hl									; skip the second species byte
	ld a, [hli]
	ld c, a
	ld a, [hl]
	or c
	jr z, .next2
.next3
	ld a, [wWhichPokemon]
	ld hl, wEnemyMon1Level
	ld bc, wEnemyMon2 - wEnemyMon1
	call AddNTimes
	ld a, [hl]
	ld [wCurEnemyLVL], a
	ld a, [wWhichPokemon]
	ld hl, wEnemyPartyMons				; start directly at wEnemyPartyMons instead of adding 1 to a and starting at wEnemyPartyMons - 1
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc										; species are now 2 bytes long
	ld a, [hli]										; species are now 2 bytes long
	ld [wEnemyMonSpecies2], a
	ld a, [hl]
	ld [wEnemyMonSpecies2 + 1], a
	call LoadEnemyMonData
	call ApplyBurnAndParalysisPenaltiesToEnemy		; apply stats nerfs on incoming pokemon
	ld hl, wEnemyMonHP
	ld a, [hli]
	ld [wLastSwitchInEnemyMonHP], a
	ld a, [hl]
	ld [wLastSwitchInEnemyMonHP + 1], a
	ld a, 1
	ld [wCurrentMenuItem], a
	ld a, [wFirstMonsNotOutYet]
	dec a
	jr z, .next4
	ld a, [wPartyCount]
	dec a
	jr z, .next4
	ld a, [wLinkState]
	cp LINK_STATE_BATTLING
	jr z, .next4
	ld a, [wOptions]
	bit BATTLE_STYLE, a
	jr nz, .next4					; if battle style is Set, don't ask the player if they want to switch pokemon
	ld hl, TrainerAboutToUseText
	call PrintText
	coord hl, 0, 7
	lb bc, 8, 1
	ld a, TWO_OPTION_MENU
	ld [wTextBoxID], a
	call DisplayTextBoxID
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .next4
	ld a, BATTLE_PARTY_MENU
	ld [wPartyMenuTypeOrMessageID], a
	call DisplayPartyMenu
.next9
	ld a, 1
	ld [wCurrentMenuItem], a
	jr c, .next7
	ld hl, wPlayerMonNumber
	ld a, [wWhichPokemon]
	cp [hl]
	jr nz, .next6
	ld hl, AlreadyOutText
	call PrintText
.next8
	call GoBackToPartyMenu
	jr .next9
.next6
	call HasMonFainted
	jr z, .next8
	xor a
	ld [wCurrentMenuItem], a
.next7
	call GBPalWhiteOut
	call LoadHudTilePatterns
	call LoadScreenTilesFromBuffer1
.next4
	call ClearSprites
	coord hl, 0, 0
	lb bc, 4, 11
	call ClearScreenArea
	ld b, SET_PAL_BATTLE
	call RunPaletteCommand
	call GBPalNormal
	ld hl, TrainerSentOutText
	ld a, [wNewBattleFlags]			; check for forced switch
	bit FORCED_SWITCH_OCCURRED, a	; check for forced switch
	call z, PrintText				; if it isn't a forced switch, print the text
	ld a, [wEnemyMonSpecies2]
	ld [wMonSpeciesTemp], a			; to handle 2 bytes species IDs
	ld a, [wEnemyMonSpecies2 + 1]	; to handle 2 bytes species IDs
	ld [wMonSpeciesTemp + 1], a		; to handle 2 bytes species IDs
	call GetMonHeader
	ld de, vFrontPic
	call LoadMonFrontSprite
	ld a, -$31
	ld [hStartTileID], a
	coord hl, 15, 6
	predef AnimateSendingOutMon
	ld a, [wEnemyMonSpecies2]			; to handle 2 bytes species ID
	ld b, a								; to handle 2 bytes species ID
	ld a, [wEnemyMonSpecies2 + 1]		; to handle 2 bytes species ID
	ld c, a								; to handle 2 bytes species ID
	call PlayCry
	call DrawEnemyHUDAndHPBar
	ld a, [wCurrentMenuItem]
	and a
	ret nz
	xor a
	ld [wPartyGainExpFlags], a
	ld [wPartyFoughtCurrentEnemyFlags], a
	call SaveScreenTilesToBuffer1
	jp SwitchPlayerMon

TrainerAboutToUseText:
	TX_FAR _TrainerAboutToUseText
	db "@"

TrainerSentOutText:
	TX_FAR _TrainerSentOutText
	db "@"

; tests if the player has any pokemon that are not fainted
; sets d = 0 if all fainted, d != 0 if some mons are still alive
; moved out of bank $F
AnyPartyAlive:
	jpab _AnyPartyAlive

; tests if player mon has fainted
; stores whether mon has fainted in Z flag
; moved out of bank $F
HasMonFainted:
	jpab _HasMonFainted

; try to run from battle (hl = player speed, de = enemy speed)
; stores whether the attempt was successful in carry flag
TryRunningFromBattle:
	call IsGhostBattle
	jp z, .canEscape ; jump if it's a ghost battle
	ld a, [wBattleType]
	cp BATTLE_TYPE_SAFARI
	jp z, .canEscape ; jump if it's a safari battle
	cp BATTLE_TYPE_FACILITY
	jr nz, .notBattleFacility
	callab PlayerTriesRunningFromBattleFacility	; handle it in the Battle Facility bank
	ret z										; if the player chose NO, don't forfeit
	scf											; else set carry flag
	ret
.notBattleFacility
	ld a, [wLinkState]
	cp LINK_STATE_BATTLING
	jp z, .canEscape
	ld a, [wIsInBattle]
	dec a
	jr nz, .trainerBattle			; jump if it's a trainer battle
	push hl
	call CheckPlayerSwitchAllowed	; check if player is trapped by Wrap or Mean Look
	pop hl
	jr nz, .cantEscapeNoTurnLoss	; if player's pokemon is trapped by opponent, always fail
	ld a, [wNumRunAttempts]
	inc a
	ld [wNumRunAttempts], a
	ld a, [hli]
	ld [H_MULTIPLICAND + 1], a
	ld a, [hl]
	ld [H_MULTIPLICAND + 2], a
	ld a, [de]
	ld [hEnemySpeed], a
	inc de
	ld a, [de]
	ld [hEnemySpeed + 1], a
	call LoadScreenTilesFromBuffer1
	ld de, H_MULTIPLICAND + 1
	ld hl, hEnemySpeed
	ld c, 2
	call StringCmp
	jr nc, .canEscape ; jump if player speed greater than enemy speed
	xor a
	ld [H_MULTIPLICAND], a
	ld a, 32
	ld [H_MULTIPLIER], a
	call Multiply ; multiply player speed by 32
	ld a, [H_PRODUCT + 2]
	ld [H_DIVIDEND], a
	ld a, [H_PRODUCT + 3]
	ld [H_DIVIDEND + 1], a
	ld a, [hEnemySpeed]
	ld b, a
	ld a, [hEnemySpeed + 1]
; divide enemy speed by 4
	srl b
	rr a
	srl b
	rr a
	and a
	jr z, .canEscape ; jump if enemy speed divided by 4, mod 256 is 0
	ld [H_DIVISOR], a ; ((enemy speed / 4) % 256)
	ld b, $2
	call Divide ; divide (player speed * 32) by ((enemy speed / 4) % 256)
	ld a, [H_QUOTIENT + 2]
	and a ; is the quotient greater than 256?
	jr nz, .canEscape ; if so, the player can escape
	ld a, [wNumRunAttempts]
	ld c, a
; add 30 to the quotient for each run attempt
.loop
	dec c
	jr z, .compareWithRandomValue
	ld b, 30
	ld a, [H_QUOTIENT + 3]
	add b
	ld [H_QUOTIENT + 3], a
	jr c, .canEscape
	jr .loop
.compareWithRandomValue
	call BattleRandom
	ld b, a
	ld a, [H_QUOTIENT + 3]
	cp b
	jr nc, .canEscape	; if the random value was less than or equal to the quotient
						; plus 30 times the number of attempts, the player can escape
.cantEscape				; add this label for when the player is trapped by Wrap or similar
	ld a, $1
	ld [wActionResultOrTookBattleTurn], a ; you lose your turn when you can't escape
.cantEscapeNoTurnLoss
	ld hl, CantEscapeText
	jr .printCantEscapeOrNoRunningText
.trainerBattle
	ld hl, NoRunningText
.printCantEscapeOrNoRunningText
	call PrintText
	ld a, 1
	ld [wForcePlayerToChooseMon], a
	call SaveScreenTilesToBuffer1
	and a ; reset carry
	ret
.canEscape
	ld a, [wLinkState]
	cp LINK_STATE_BATTLING
	ld a, $2
	jr nz, .playSound
; link battle
	call SaveScreenTilesToBuffer1
	xor a
	ld [wActionResultOrTookBattleTurn], a
	ld a, LINKBATTLE_RUN
	ld [wPlayerMoveListIndex], a
	call LinkBattleExchangeData
	call LoadScreenTilesFromBuffer1
	ld a, [wSerialExchangeNybbleReceiveData]
	cp LINKBATTLE_RUN
	ld a, $2
	jr z, .playSound
	dec a
.playSound
	ld [wBattleResult], a
	ld a, SFX_RUN
	call PlaySoundWaitForCurrent
	ld hl, GotAwayText
	call PrintText
	call WaitForSoundToFinish
	call SaveScreenTilesToBuffer1
	scf ; set carry
	ret

CantEscapeText:
	TX_FAR _CantEscapeText
	db "@"

NoRunningText:
	TX_FAR _NoRunningText
	db "@"

GotAwayText:
	TX_FAR _GotAwayText
	db "@"

; copies from party data to battle mon data when sending out a new player mon
LoadBattleMonFromParty:
	ld a, [wWhichPokemon]
	ld bc, wPartyMon2 - wPartyMon1
	ld hl, wPartyMon1Species
	call AddNTimes
	ld de, wBattleMonSpecies
	ld bc, wBattleMonDVs - wBattleMonSpecies
	call CopyData
	ld bc, wPartyMon1DVs - wPartyMon1OTID		; this needs to make hl point to the first DV
	add hl, bc
	ld de, wBattleMonDVs
	ld bc, NUM_DVS
	call CopyData
	ld de, wBattleMonPP
	ld bc, NUM_MOVES
	call CopyData
	ld de, wBattleMonLevel
	ld bc, wBattleMonPP - wBattleMonLevel
	call CopyData
	ld a, [wBattleMonSpecies2]
	ld [wMonSpeciesTemp], a						; to handle 2 bytes species IDs
	ld a, [wBattleMonSpecies2 + 1]				; to handle 2 bytes species IDs
	ld [wMonSpeciesTemp + 1], a					; to handle 2 bytes species IDs
	call GetMonHeader
	ld hl, wPartyMonNicks
	ld a, [wPlayerMonNumber]
	call SkipFixedLengthTextEntries
	ld de, wBattleMonNick
	ld bc, NAME_LENGTH
	call CopyData
	ld hl, wBattleMonLevel
	ld de, wPlayerMonUnmodifiedLevel ; block of memory used for unmodified stats
	ld bc, 1 + NUM_STATS * 2
	call CopyData
	call ApplyBurnAndParalysisPenaltiesToPlayer
	call ApplyBadgeStatBoosts
	ld a, STAT_MODIFIER_DEFAULT ; default stat modifier
	ld b, NUM_STAT_MODS
	ld hl, wPlayerMonAttackMod
.statModLoop
	ld [hli], a
	dec b
	jr nz, .statModLoop
	ret

; copies from enemy party data to current enemy mon data when sending out a new enemy mon
LoadEnemyMonFromParty:
	ld a, [wWhichPokemon]
	ld bc, wEnemyMon2 - wEnemyMon1
	ld hl, wEnemyMons
	call AddNTimes
	ld de, wEnemyMonSpecies
	ld bc, wEnemyMonDVs - wEnemyMonSpecies
	call CopyData
	ld bc, wEnemyMon1DVs - wEnemyMon1OTID			; this needs to make hl point to the first DV
	add hl, bc
	ld de, wEnemyMonDVs
	ld bc, NUM_DVS
	call CopyData
	ld de, wEnemyMonPP
	ld bc, NUM_MOVES
	call CopyData
	ld de, wEnemyMonLevel
	ld bc, wEnemyMonPP - wEnemyMonLevel
	call CopyData
	ld a, [wEnemyMonSpecies]
	ld [wMonSpeciesTemp], a						; to handle 2 bytes species IDs
	ld a, [wEnemyMonSpecies + 1]				; to handle 2 bytes species IDs
	ld [wMonSpeciesTemp + 1], a					; to handle 2 bytes species IDs
	call GetMonHeader
	ld hl, wEnemyMonNicks
	ld a, [wWhichPokemon]
	call SkipFixedLengthTextEntries
	ld de, wEnemyMonNick
	ld bc, NAME_LENGTH
	call CopyData
	ld hl, wEnemyMonLevel
	ld de, wEnemyMonUnmodifiedLevel ; block of memory used for unmodified stats
	ld bc, 1 + NUM_STATS * 2
	call CopyData
	call ApplyBurnAndParalysisPenaltiesToEnemy
	ld hl, wMonHBaseStats
	ld de, wEnemyMonBaseStats
	ld b, NUM_STATS
.copyBaseStatsLoop
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .copyBaseStatsLoop
	ld a, STAT_MODIFIER_DEFAULT ; default stat modifier
	ld b, NUM_STAT_MODS
	ld hl, wEnemyMonStatMods
.statModLoop
	ld [hli], a
	dec b
	jr nz, .statModLoop
	ld a, [wWhichPokemon]
	ld [wEnemyMonPartyPos], a
	ret

SendOutMon:
	ld a, [wNewBattleFlags]			; check if this is a forced switch
	bit FORCED_SWITCH_OCCURRED, a	; check if this is a forced switch
	jr nz, .noTextToDisplay			; if it is, don't display any text
	callab PrintSendOutMonMessage
.noTextToDisplay
	ld hl, wEnemyMonHP
	ld a, [hli]
	or [hl] ; is enemy mon HP zero?
	jp z, .skipDrawingEnemyHUDAndHPBar; if HP is zero, skip drawing the HUD and HP bar
	call DrawEnemyHUDAndHPBar
.skipDrawingEnemyHUDAndHPBar
	call DrawPlayerHUDAndHPBar
	predef LoadMonBackPic
	xor a
	ld [wAILayer2Encouragement], a		; reinitialize this also when the player changes mon
	ld [hStartTileID], a
	ld hl, wBattleAndStartSavedMenuItem
	ld [hli], a
	ld [hl], a
	ld [wBoostExpByExpAll], a
	ld [wDamageMultipliers], a
	ld [wPlayerMoveNum], a
	ld hl, wPlayerUsedMove
	ld [hli], a
	ld [hl], a
	ld hl, wPlayerMimicSlot
	ld [hli], a							; wPlayerMimicSlot
	ld [hli], a							; wPlayerStatsToHalve
	ld [hli], a							; wPlayerBattleStatus1
	ld [hli], a							; wPlayerBattleStatus2
	ld [hl], a							; wPlayerBattleStatus3
	ld hl, wPlayerToxicCounter			; reinitialize toxic counter whenever a pokemon is sent out
	ld [hli], a							; reinitialize toxic counter whenever a pokemon is sent out
	ld [hl], a							; reinitialize disabled move whenever a pokemon is sent out (like before)
	ld [wPlayerDisabledMoveNumber], a
	ld [wPlayerMonMinimized], a
	ld hl, wPlayerLastAttackReceived	; reinitialize last attack received by the player
	ld [hli], a							; reinitialize last attack received by the player
	ld [hli], a							; reinitialize last attack received by the enemy
	ld [hli], a							; reinitialize trapping counter for the player
	ld [hl], a							; reinitialize trapping counter for the enemy
	dec a								; initialize the last move used to $ff
	ld [wPlayerLastMoveListIndex], a	; initialize the last move used to $ff
	ld hl, wNewBattleFlags
	res ENEMY_SIGNATURE_MOVE, [hl]
	res PLAYER_SIGNATURE_MOVE, [hl]
	ld b, SET_PAL_BATTLE
	call RunPaletteCommand
	ld hl, wEnemyBattleStatus1
	res USING_TRAPPING_MOVE, [hl]
	inc hl
	inc hl								; move hl to wEnemyBattleStatus3
	res TRAPPED, [hl]					; enemy is no longer trapped by Mean Look
	ld a, $1
	ld [H_WHOSETURN], a
	ld a, POOF_ANIM
	call PlaySpecialAnimation
	coord hl, 4, 11
	predef AnimateSendingOutMon
	ld a, [wBattleMonSpecies2]
	ld b, a								; put species ID in bc as input for PlayCry
	ld a, [wBattleMonSpecies2 + 1]
	ld c, a
	call PlayCry
	call PrintEmptyString
	jp SaveScreenTilesToBuffer1

; reads player's current mon's HP into wBattleMonHP
; renamed it from ReadPlayerMonCurHPAndStatus
; maybe moved out of bank $F
CopyPlayerMonCurHPAndStatusFromBattleToParty:
	jpab _CopyPlayerMonCurHPAndStatusFromBattleToParty

DrawHUDsAndHPBars:
	call DrawPlayerHUDAndHPBar
	jp DrawEnemyHUDAndHPBar

DrawPlayerHUDAndHPBar:
	xor a
	ld [H_AUTOBGTRANSFERENABLED], a
	coord hl, 9, 7
	lb bc, 5, 11
	call ClearScreenArea
	callab PlacePlayerHUDTiles
	coord hl, 18, 9
	ld [hl], $73
	ld de, wBattleMonNick
	coord hl, 10, 7
	call CenterMonName
	call PlaceString
	ld hl, wBattleMonSpecies
	ld de, wLoadedMon
	ld bc, wBattleMonDVs - wBattleMonSpecies
	call CopyData
	ld hl, wBattleMonLevel
	ld de, wLoadedMonLevel
	ld bc, wBattleMonPP - wBattleMonLevel
	call CopyData
	coord hl, 14, 8
	push hl
	inc hl
	ld de, wLoadedMonStatus
	call PrintStatusConditionNotFainted
	pop hl
	jr nz, .doNotPrintLevel
	call PrintLevel
.doNotPrintLevel
	coord hl, 10, 9
	predef DrawHP
	ld a, $1
	ld [H_AUTOBGTRANSFERENABLED], a
	ld hl, wPlayerHPBarColor
	call GetBattleHealthBarColor
	ld hl, wBattleMonHP
	ld a, [hli]
	or [hl]
	jr z, .fainted
	ld a, [wLowHealthAlarmDisabled]
	and a ; has the alarm been disabled because the player has already won?
	ret nz ; if so, return
	ld a, [wPlayerHPBarColor]
	cp HP_BAR_RED
	jr z, .setLowHealthAlarm
.fainted
	ld hl, wLowHealthAlarm
	bit 7, [hl] ;low health alarm enabled?
	ld [hl], $0
	ret z
	xor a
	ld [wChannelSoundIDs + Ch4], a
	ret
.setLowHealthAlarm
	ld hl, wLowHealthAlarm
	set 7, [hl] ;enable low health alarm
	ret

DrawEnemyHUDAndHPBar:
	xor a
	ld [H_AUTOBGTRANSFERENABLED], a
	coord hl, 0, 0
	lb bc, 4, 12
	call ClearScreenArea
	callab PlaceEnemyHUDTiles
	call IsGhostBattle
	call nz, PlacePokeballIcon_			; place a ball icon for caught species in wild battles
	ld de, wEnemyMonNick
	coord hl, 1, 0
	call CenterMonName
	call PlaceString
	coord hl, 4, 1
	push hl
	inc hl
	ld de, wEnemyMonStatus
	call PrintStatusConditionNotFainted
	pop hl
	jr nz, .skipPrintLevel ; if the mon has a status condition, skip printing the level
	ld a, [wEnemyMonLevel]
	ld [wLoadedMonLevel], a
	call PrintLevel
.skipPrintLevel
	ld hl, wEnemyMonHP
	ld a, [hli]
	ld [H_MULTIPLICAND + 1], a
	ld a, [hld]
	ld [H_MULTIPLICAND + 2], a
	or [hl] ; is current HP zero?
	jr nz, .hpNonzero
; current HP is 0
; set variables for DrawHPBar
	ld c, a
	ld e, a
	ld d, $6
	jp .drawHPBar
.hpNonzero
	xor a
	ld [H_MULTIPLICAND], a
	ld a, 48
	ld [H_MULTIPLIER], a
	call Multiply ; multiply current HP by 48
	ld hl, wEnemyMonMaxHP
	ld a, [hli]
	ld b, a
	ld a, [hl]
	ld [H_DIVISOR], a
	ld a, b
	and a ; is max HP > 255?
	jr z, .doDivide
; if max HP > 255, scale both (current HP * 48) and max HP by dividing by 4 so that max HP fits in one byte
; (it needs to be one byte so it can be used as the divisor for the Divide function)
	ld a, [H_DIVISOR]
	srl b
	rr a
	srl b
	rr a
	ld [H_DIVISOR], a
	ld a, [H_PRODUCT + 2]
	ld b, a
	srl b
	ld a, [H_PRODUCT + 3]
	rr a
	srl b
	rr a
	ld [H_PRODUCT + 3], a
	ld a, b
	ld [H_PRODUCT + 2], a
.doDivide
	ld a, [H_PRODUCT + 2]
	ld [H_DIVIDEND], a
	ld a, [H_PRODUCT + 3]
	ld [H_DIVIDEND + 1], a
	ld a, $2
	ld b, a
	call Divide ; divide (current HP * 48) by max HP
	ld a, [H_QUOTIENT + 3]
; set variables for DrawHPBar
	ld e, a
	ld a, $6
	ld d, a
	ld c, a
.drawHPBar
	xor a
	ld [wHPBarType], a
	coord hl, 2, 2
	call DrawHPBar
	ld a, $1
	ld [H_AUTOBGTRANSFERENABLED], a
	ld hl, wEnemyHPBarColor

GetBattleHealthBarColor:
	ld b, [hl]
	call GetHealthBarColor
	ld a, [hl]
	cp b
	ret z
	ld b, SET_PAL_BATTLE
	jp RunPaletteCommand

; centers mon's name on the battle screen
; if the name is 1 or 2 letters long, it is printed 2 spaces more to the right than usual
; (i.e. for names longer than 4 letters)
; if the name is 3 or 4 letters long, it is printed 1 space more to the right than usual
; (i.e. for names longer than 4 letters)
CenterMonName:
	push de
	inc hl
	inc hl
	ld b, $2
.loop
	inc de
	ld a, [de]
	cp "@"
	jr z, .done
	inc de
	ld a, [de]
	cp "@"
	jr z, .done
	dec hl
	dec b
	jr nz, .loop
.done
	pop de
	ret

DisplayBattleMenu:
	call LoadScreenTilesFromBuffer1 ; restore saved screen
	ld a, [wBattleType]
	cp BATTLE_TYPE_FACILITY
	jr z, .next
	and a
	jr nz, .nonstandardbattle
.next
	call DrawHUDsAndHPBars
	call PrintEmptyString
	call SaveScreenTilesToBuffer1
.nonstandardbattle
	ld a, [wBattleType]
	cp BATTLE_TYPE_SAFARI
	ld a, BATTLE_MENU_TEMPLATE
	jr nz, .menuselected
	ld a, SAFARI_BATTLE_MENU_TEMPLATE
.menuselected
	ld [wTextBoxID], a
	call DisplayTextBoxID
	ld a, [wBattleType]
	dec a
	jp nz, .handleBattleMenuInput ; handle menu input if it's not the old man tutorial
; the following happens for the old man tutorial
	ld hl, wPlayerName
	ld de, wGrassRate
	ld bc, NAME_LENGTH
	call CopyData  ; temporarily save the player name in unused space,
	               ; which is supposed to get overwritten when entering a
	               ; map with wild Pokémon. Due to an oversight, the data
	               ; may not get overwritten (cinnabar) and the infamous
	               ; Missingno. glitch can show up.
	ld hl, .oldManName
	ld de, wPlayerName
	ld bc, NAME_LENGTH
	call CopyData
; the following simulates the keystrokes by drawing menus on screen
	coord hl, 9, 14
	ld [hl], "▶"
	ld c, 80
	call DelayFrames
	ld [hl], " "
	coord hl, 9, 16
	ld [hl], "▶"
	ld c, 50
	call DelayFrames
	ld [hl], "▷"
	ld a, $2 ; select the "ITEM" menu
	jp .upperLeftMenuItemWasNotSelected
.oldManName
	db "OLD MAN@"
.handleBattleMenuInput
	ld a, [wBattleAndStartSavedMenuItem]
	ld [wCurrentMenuItem], a
	ld [wLastMenuItem], a
	sub 2 ; check if the cursor is in the left column
	jr c, .leftColumn
; cursor is in the right column
	ld [wCurrentMenuItem], a
	ld [wLastMenuItem], a
	jr .rightColumn
.leftColumn ; put cursor in left column of menu
	ld a, [wBattleType]
	cp BATTLE_TYPE_SAFARI
	ld a, " "
	jr z, .safariLeftColumn
; put cursor in left column for normal battle menu (i.e. when it's not a Safari battle)
	Coorda 15, 14 ; clear upper cursor position in right column
	Coorda 15, 16 ; clear lower cursor position in right column
	ld b, $9 ; top menu item X
	jr .leftColumn_WaitForInput
.safariLeftColumn
	Coorda 13, 14
	Coorda 13, 16
	coord hl, 7, 14
	ld de, wNumSafariBalls
	lb bc, 1, 2
	call PrintNumber
	ld b, $1 ; top menu item X
.leftColumn_WaitForInput
	ld hl, wTopMenuItemY
	ld a, $e
	ld [hli], a ; wTopMenuItemY
	ld a, b
	ld [hli], a ; wTopMenuItemX
	inc hl
	inc hl
	ld a, $1
	ld [hli], a ; wMaxMenuItem
	ld [hl], D_RIGHT | A_BUTTON ; wMenuWatchedKeys
	call HandleMenuInput
	bit 4, a ; check if right was pressed
	jr nz, .rightColumn
	jr .AButtonPressed ; the A button was pressed
.rightColumn ; put cursor in right column of menu
	ld a, [wBattleType]
	cp BATTLE_TYPE_SAFARI
	ld a, " "
	jr z, .safariRightColumn
; put cursor in right column for normal battle menu (i.e. when it's not a Safari battle)
	Coorda 9, 14 ; clear upper cursor position in left column
	Coorda 9, 16 ; clear lower cursor position in left column
	ld b, $f ; top menu item X
	jr .rightColumn_WaitForInput
.safariRightColumn
	Coorda 1, 14 ; clear upper cursor position in left column
	Coorda 1, 16 ; clear lower cursor position in left column
	coord hl, 7, 14
	ld de, wNumSafariBalls
	lb bc, 1, 2
	call PrintNumber
	ld b, $d ; top menu item X
.rightColumn_WaitForInput
	ld hl, wTopMenuItemY
	ld a, $e
	ld [hli], a ; wTopMenuItemY
	ld a, b
	ld [hli], a ; wTopMenuItemX
	inc hl
	inc hl
	ld a, $1
	ld [hli], a ; wMaxMenuItem
	ld a, D_LEFT | A_BUTTON
	ld [hli], a ; wMenuWatchedKeys
	call HandleMenuInput
	bit 5, a ; check if left was pressed
	jr nz, .leftColumn ; if left was pressed, jump
	ld a, [wCurrentMenuItem]
	add $2 ; if we're in the right column, the actual id is +2
	ld [wCurrentMenuItem], a
.AButtonPressed
	call PlaceUnfilledArrowMenuCursor
	ld a, [wBattleType]
	cp BATTLE_TYPE_SAFARI
	ld a, [wCurrentMenuItem]
	ld [wBattleAndStartSavedMenuItem], a
	jr z, .handleMenuSelection
; not Safari battle
; swap the IDs of the item menu and party menu (this is probably because they swapped the positions
; of these menu items in first generation English versions)
	cp $1 ; was the item menu selected?
	jr nz, .notItemMenu
; item menu was selected
	inc a ; increment a to 2
	jr .handleMenuSelection
.notItemMenu
	cp $2 ; was the party menu selected?
	jr nz, .handleMenuSelection
; party menu selected
	dec a ; decrement a to 1
.handleMenuSelection
	and a
	jr nz, .upperLeftMenuItemWasNotSelected
; the upper left menu item was selected
	ld a, [wBattleType]
	cp BATTLE_TYPE_SAFARI
	jr z, .throwSafariBallWasSelected
; the "FIGHT" menu was selected
	xor a
	ld [wNumRunAttempts], a
	jp LoadScreenTilesFromBuffer1 ; restore saved screen and return
.throwSafariBallWasSelected
	ld a, SAFARI_BALL
	ld [wcf91], a
	jr UseBagItem

.upperLeftMenuItemWasNotSelected ; a menu item other than the upper left item was selected
	cp $2
	jp nz, PartyMenuOrRockOrRun

; either the bag (normal battle) or bait (safari battle) was selected
	ld a, [wBattleType]
	cp BATTLE_TYPE_FACILITY
	jr z, .itemsCantBeUsed
	ld a, [wLinkState]
	cp LINK_STATE_BATTLING
	jr nz, .notLinkBattle

; can't use items in link battles
.itemsCantBeUsed
	ld hl, ItemsCantBeUsedHereText
	call PrintText
	jp DisplayBattleMenu

.notLinkBattle
	call SaveScreenTilesToBuffer2
	ld a, [wBattleType]
	cp BATTLE_TYPE_SAFARI
	jr nz, BagWasSelected

; bait was selected
	ld a, SAFARI_BAIT
	ld [wcf91], a
	jr UseBagItem

BagWasSelected:
	call LoadScreenTilesFromBuffer1
	ld a, [wBattleType]
	and a ; is it a normal battle?
	jr nz, .next

; normal battle
	call DrawHUDsAndHPBars
.next
	ld a, [wBattleType]
	dec a ; is it the old man tutorial?
	jr nz, DisplayPlayerBag ; no, it is a normal battle
	ld hl, OldManItemList
	ld a, l
	ld [wListPointer], a
	ld a, h
	ld [wListPointer + 1], a
	jr DisplayBagMenu

OldManItemList:
	db 1 ; # items
	db POKE_BALL, 50
	db -1

DisplayPlayerBag:
	; get the pointer to player's bag when in a normal battle
	ld hl, wNumBagItems
	ld a, l
	ld [wListPointer], a
	ld a, h
	ld [wListPointer + 1], a

DisplayBagMenu:
	xor a
	ld [wPrintItemPrices], a
	ld a, ITEMLISTMENU
	ld [wListMenuID], a
	ld a, [wBagSavedMenuItem]
	ld [wCurrentMenuItem], a
	call DisplayListMenuID
	ld a, [wCurrentMenuItem]
	ld [wBagSavedMenuItem], a
	ld a, $0
	ld [wMenuWatchMovingOutOfBounds], a
	ld [wMenuItemToSwap], a
	jp c, DisplayBattleMenu ; go back to battle menu if an item was not selected

UseBagItem:
	; either use an item from the bag or use a safari zone item
	ld a, [wcf91]
	ld [wd11e], a
	call GetItemName
	call CopyStringToCF4B ; copy name
	xor a
	ld [wPseudoItemID], a
	call UseItem
	call LoadHudTilePatterns
	call ClearSprites
	xor a
	ld [wCurrentMenuItem], a
	ld a, [wBattleType]
	cp BATTLE_TYPE_SAFARI
	jr z, .checkIfMonCaptured

	ld a, [wActionResultOrTookBattleTurn]
	and a ; was the item used successfully?
	jp z, BagWasSelected ; if not, go back to the bag menu

.checkIfMonCaptured
	ld a, [wSuccessfulCapture]
	and a ; was the enemy mon captured with a ball?
	jr nz, .returnAfterCapturingMon

	ld a, [wBattleType]
	cp BATTLE_TYPE_SAFARI
	jr z, .returnAfterUsingItem_NoCapture
; not a safari battle
	call LoadScreenTilesFromBuffer1
	call DrawHUDsAndHPBars
	call Delay3
.returnAfterUsingItem_NoCapture

	call GBPalNormal
	and a ; reset carry
	ret

.returnAfterCapturingMon
	call GBPalNormal
	ld a, $2
	ld [wBattleResult], a
	scf ; set carry
	ret

ItemsCantBeUsedHereText:
	TX_FAR _ItemsCantBeUsedHereText
	db "@"

PartyMenuOrRockOrRun:
	dec a ; was Run selected?
	jp nz, BattleMenu_RunWasSelected
; party menu or rock was selected
	call SaveScreenTilesToBuffer2
	ld a, [wBattleType]
	cp BATTLE_TYPE_SAFARI
	jr nz, .partyMenuWasSelected
; safari battle
	ld a, SAFARI_ROCK
	ld [wcf91], a
	jp UseBagItem
.partyMenuWasSelected
	call LoadScreenTilesFromBuffer1
	xor a ; NORMAL_PARTY_MENU
	ld [wPartyMenuTypeOrMessageID], a
	ld [wMenuItemToSwap], a
	call DisplayPartyMenu
.checkIfPartyMonWasSelected
	jp nc, .partyMonWasSelected ; if a party mon was selected, jump, else we quit the party menu
.quitPartyMenu
	call ClearSprites
	call GBPalWhiteOut
	call LoadHudTilePatterns
	call LoadScreenTilesFromBuffer2
	call RunDefaultPaletteCommand
	call GBPalNormal
	jp DisplayBattleMenu
.partyMonDeselected
	coord hl, 11, 11
	ld bc, 6 * SCREEN_WIDTH + 9
	ld a, " "
	call FillMemory
	xor a ; NORMAL_PARTY_MENU
	ld [wPartyMenuTypeOrMessageID], a
	call GoBackToPartyMenu
	jr .checkIfPartyMonWasSelected
.partyMonWasSelected
	ld a, SWITCH_STATS_CANCEL_MENU_TEMPLATE
	ld [wTextBoxID], a
	call DisplayTextBoxID
	ld hl, wTopMenuItemY
	ld a, $c
	ld [hli], a ; wTopMenuItemY
	ld [hli], a ; wTopMenuItemX
	xor a
	ld [hli], a ; wCurrentMenuItem
	inc hl
	ld a, $2
	ld [hli], a ; wMaxMenuItem
	ld a, B_BUTTON | A_BUTTON
	ld [hli], a ; wMenuWatchedKeys
	xor a
	ld [hl], a ; wLastMenuItem
	call HandleMenuInput
	bit 1, a ; was A pressed?
	jr nz, .partyMonDeselected ; if B was pressed, jump
; A was pressed
	call PlaceUnfilledArrowMenuCursor
	ld a, [wCurrentMenuItem]
	cp $2 ; was Cancel selected?
	jr z, .quitPartyMenu ; if so, quit the party menu entirely
	and a ; was Switch selected?
	jr z, .switchMon ; if so, jump
; Stats was selected
	xor a ; PLAYER_PARTY_DATA
	ld [wMonDataLocation], a
	ld hl, wPartyMon1
	call ClearSprites
; display the two status screens
	predef StatusScreen
	predef StatusScreen2
	predef StatusScreen3				; 3rd page with DVs/EVs
; now we need to reload the enemy mon pic
	ld a, [wEnemyBattleStatus2]
	bit HAS_SUBSTITUTE_UP, a ; does the enemy mon have a substitute?
	ld hl, AnimationSubstitute
	jr nz, .doEnemyMonAnimation
; enemy mon doesn't have substitute
	ld a, [wEnemyMonMinimized]
	and a ; has the enemy mon used Minimise?
	ld hl, AnimationMinimizeMon
	jr nz, .doEnemyMonAnimation
; enemy mon is not minimised
	ld a, [wEnemyMonSpecies]
	ld [wMonSpeciesTemp], a			; to handle 2 bytes species IDs
	ld a, [wEnemyMonSpecies + 1]	; to handle 2 bytes species IDs
	ld [wMonSpeciesTemp + 1], a		; to handle 2 bytes species IDs
	call GetMonHeader
	ld de, vFrontPic
	call LoadMonFrontSprite
	jr .enemyMonPicReloaded
.doEnemyMonAnimation
	ld b, BANK(AnimationSubstitute)
	call Bankswitch
.enemyMonPicReloaded 				; enemy mon pic has been reloaded, so return to the party menu
	jp .partyMenuWasSelected
.switchMon
	ld a, [wPlayerMonNumber]
	ld d, a
	call CheckPlayerSwitchAllowed	; check if pokemon is trapped by Wrap or Mean Look
	jr z, .notTrapped				; if player is not trapped, continue checks
	ld hl, CantSwitchText
	jr .cantSwitch
.notTrapped
	ld a, [wWhichPokemon]
	cp d							; check if the mon to switch to is already out
	jr nz, .notAlreadyOut
; mon is already out
	ld hl, AlreadyOutText
.cantSwitch
	call PrintText
	jp .partyMonDeselected
.notAlreadyOut
	call HasMonFainted
	jp z, .partyMonDeselected ; can't switch to fainted mon
	ld a, $1
	ld [wActionResultOrTookBattleTurn], a
	call GBPalWhiteOut
	call ClearSprites
	call LoadHudTilePatterns
	call LoadScreenTilesFromBuffer1
	call RunDefaultPaletteCommand
	call GBPalNormal
; fall through to SwitchPlayerMon

SwitchPlayerMon:
	callab RetreatMon
	ld c, 50
	call DelayFrames
PlayerSendOutMon:
	call CopyPlayerMonCurHPAndStatusFromBattleToParty	; update party data before changing mon
	ld a, [wNewBattleFlags]								; test if it's a forced switch
	bit FORCED_SWITCH_OCCURRED, a
	jr nz, .forcedSwitch
	callab AnimateRetreatingPlayerMon					; if it's not a forced switch, animate the pokemon retreating and skip forced switch text
.forcedSwitch
	ld a, [wWhichPokemon]
	ld [wPlayerMonNumber], a
	ld c, a
	ld b, FLAG_SET
	push bc
	ld hl, wPartyGainExpFlags
	predef FlagActionPredef
	pop bc
	ld hl, wPartyFoughtCurrentEnemyFlags
	predef FlagActionPredef
	call LoadBattleMonFromParty
	call SendOutMon
	call SaveScreenTilesToBuffer1
	ld a, $2
	ld [wCurrentMenuItem], a
	ld hl, wAILayer2Encouragement
	dec [hl]								; SendOutMon sets it to zero, decrement it here to compensate the increment that will happen at the end of the turn
	and a
	ret

AlreadyOutText:
	TX_FAR _AlreadyOutText
	db "@"

BattleMenu_RunWasSelected:
	call LoadScreenTilesFromBuffer1
	ld a, $3
	ld [wCurrentMenuItem], a
	ld hl, wBattleMonSpeed
	ld de, wEnemyMonSpeed
	call TryRunningFromBattle
	ld a, 0
	ld [wForcePlayerToChooseMon], a
	ret c
	ld a, [wActionResultOrTookBattleTurn]
	and a
	ret nz ; return if the player couldn't escape
	jp DisplayBattleMenu

MoveSelectionMenu:
	ld a, [wMoveMenuType]
	dec a
	jr z, .relearnmenu
	jr .regularmenu

.loadmoves
	ld de, wMoves
	ld bc, NUM_MOVES
	call CopyData
	callab FormatMovesString
	ret

.writemoves
	ld de, wMovesString
	ld a, [hFlags_0xFFF6]
	set 2, a
	ld [hFlags_0xFFF6], a
	call PlaceString
	ld a, [hFlags_0xFFF6]
	res 2, a
	ld [hFlags_0xFFF6], a
	ret

.regularmenu
	call AnyMoveToSelect
	ret z
	xor a
	ld [H_WHOSETURN], a			; force the turn to the player's for getting move names right
	ld hl, wBattleMonSpecies
	ld a, [hli]
	ld [wMonSpeciesTemp], a
	ld a, [hl]
	ld [wMonSpeciesTemp + 1], a
	ld hl, wBattleMonMoves
	call .loadmoves
	coord hl, 4, 12
	ld b, 4
	ld c, 14
    di ; out of pure coincidence, it is possible for vblank to occur between the di and ei
	   ; so it is necessary to put the di ei block to not cause tearing
	call TextBoxBorder
	coord hl, 4, 12
	ld [hl], $7a
	coord hl, 10, 12
	ld [hl], $7e
	ei
	coord hl, 6, 13
	call .writemoves
	ld b, $5
	ld a, $c
	jr .menuset
.relearnmenu
	ld a, [wWhichPokemon]
	ld hl, wPartyMon1Moves
	ld bc, wPartyMon2 - wPartyMon1
	call AddNTimes
	call .loadmoves
	coord hl, 4, 7
	ld b, 4
	ld c, 14
	call TextBoxBorder
	coord hl, 6, 8
	call .writemoves
	ld b, $5
	ld a, $7
.menuset
	ld hl, wTopMenuItemY
	ld [hli], a ; wTopMenuItemY
	ld a, b
	ld [hli], a ; wTopMenuItemX
	ld a, [wMoveMenuType]
	and a
	ld a, $1
	jr nz, .selectedmoveknown
	ld a, [wPlayerMoveListIndex]
	inc a
.selectedmoveknown
	ld [hli], a ; wCurrentMenuItem
	inc hl ; wTileBehindCursor untouched
	ld a, [wNumMovesMinusOne]
	inc a
	inc a
	ld [hli], a ; wMaxMenuItem
	ld a, [wMoveMenuType]
	dec a
	ld b, D_UP | D_DOWN | A_BUTTON | B_BUTTON
	jr z, .matchedkeyspicked
	ld a, [wLinkState]
	cp LINK_STATE_BATTLING
	jr z, .matchedkeyspicked
	ld b, $ff
.matchedkeyspicked
	ld a, b
	ld [hli], a ; wMenuWatchedKeys
	ld a, [wPlayerMoveListIndex]
	inc a
.movelistindex1
	ld [hl], a
; fallthrough

SelectMenuItem:
	ld a, [wCurrentMenuItem]
	dec a							; update wPlayerMoveListIndex every time the cursor moves
	ld [wPlayerMoveListIndex], a	; necessary to avoid bug with Mimicked signature moves
	ld a, [wMoveMenuType]
	and a
	jr nz, .select
.battleselect
	call PrintMenuItem
	ld a, [wMenuItemToSwap]
	and a
	jr z, .select
	coord hl, 5, 13
	dec a
	ld bc, SCREEN_WIDTH
	call AddNTimes
	ld [hl], "▷"
.select
	ld hl, hFlags_0xFFF6
	set 1, [hl]
	call HandleMenuInput
	ld hl, hFlags_0xFFF6
	res 1, [hl]
	bit BIT_D_UP, a
	jp nz, SelectMenuItem_CursorUp		; up
	bit BIT_D_DOWN, a
	jp nz, SelectMenuItem_CursorDown	; down
	bit BIT_SELECT, a
	jp nz, SwapMovesInMenu				; select
	bit BIT_B_BUTTON, a 				; B, but was it reset above?
	push af
	xor a
	ld [wMenuItemToSwap], a
	ld a, [wCurrentMenuItem]
	dec a
	ld [wCurrentMenuItem], a
	ld b, a
	ld a, [wMoveMenuType]
	dec a
	ld a, b
	ld [wPlayerMoveListIndex], a
	jr nz, .moveselected
	pop af
	ret
.moveselected
	pop af
	ret nz
	ld hl, wBattleMonPP
	ld a, [wCurrentMenuItem]
	ld c, a
	ld b, $0
	add hl, bc
	ld a, [hl]
	and $3f
	jr z, .noPP
	ld a, [wPlayerDisabledMove]
	swap a
	and $f
	dec a
	cp c
	jr z, .disabled
	ld a, [wCurrentMenuItem]
	ld hl, wBattleMonMoves
	ld c, a
	ld b, $0
	add hl, bc
	ld a, [hl]
	ld [wPlayerSelectedMove], a
	xor a
	ret
.disabled
	ld hl, MoveDisabledText
	jr .print
.noPP
	ld hl, MoveNoPPText
.print
	call PrintText
	call LoadScreenTilesFromBuffer1
	jp MoveSelectionMenu

MoveNoPPText:
	TX_FAR _MoveNoPPText
	db "@"

MoveDisabledText:
	TX_FAR _MoveDisabledText
	db "@"

WhichTechniqueString:
	db "WHICH TECHNIQUE?@"

SelectMenuItem_CursorUp:
	ld a, [wCurrentMenuItem]
	and a
	jp nz, SelectMenuItem
	call EraseMenuCursor
	ld a, [wNumMovesMinusOne]
	inc a
	ld [wCurrentMenuItem], a
	jp SelectMenuItem

SelectMenuItem_CursorDown:
	ld a, [wCurrentMenuItem]
	ld b, a
	ld a, [wNumMovesMinusOne]
	inc a
	inc a
	cp b
	jp nz, SelectMenuItem
	call EraseMenuCursor
	ld a, $1
	ld [wCurrentMenuItem], a
	jp SelectMenuItem

AnyMoveToSelect:
; return z and Struggle as the selected move if all moves have 0 PP and/or are disabled
	ld a, STRUGGLE
	ld [wPlayerSelectedMove], a
	ld a, [wPlayerDisabledMove]
	and a
	ld hl, wBattleMonPP
	jr nz, .handleDisabledMove
	ld a, [hli]
	or [hl]
	inc hl
	or [hl]
	inc hl
	or [hl]
	and $3f
	ret nz
	jr .noMovesLeft
.handleDisabledMove
	swap a
	and $f ; get disabled move
	ld b, a
	ld d, NUM_MOVES + 1
	xor a
.handleDisabledMovePPLoop
	dec d
	jr z, .allMovesChecked
	ld c, [hl] ; get move PP
	inc hl
	dec b ; is this the disabled move?
	jr z, .handleDisabledMovePPLoop ; if so, ignore its PP value
	or c
	jr .handleDisabledMovePPLoop
.allMovesChecked
	and a ; any PP left?
	ret nz ; return if a move has PP left
.noMovesLeft
	ld hl, NoMovesLeftText
	call PrintText
	ld c, 60
	call DelayFrames
	xor a
	ret

NoMovesLeftText:
	TX_FAR _NoMovesLeftText
	db "@"

SwapMovesInMenu:
	ld a, [wMenuItemToSwap]
	and a
	jp z, .noMenuItemSelected
	ld hl, wBattleMonMoves
	call .swapBytes ; swap moves
	ld hl, wBattleMonPP
	call .swapBytes ; swap move PP
	ld hl, wPlayerMimicSlot		; update the wPlayerMimicSlot variable if it's non-zero
	ld a, [hl]
	and a
	jr z, .updateDisabledSlot
	ld b, a
	ld a, [wMenuItemToSwap]
	cp b						; check if source slot matches wPlayerMimicSlot
	jr nz, .checkTargetSlot
	ld a, [wCurrentMenuItem]
	ld [hl], a					; update wPlayerMimicSlot with target slot
	jr .updateDisabledSlot
.checkTargetSlot
	ld a, [wCurrentMenuItem]	; check if target slot matches wPlayerMimicSlot
	cp b
	jr nz, .updateDisabledSlot
	ld a, [wMenuItemToSwap]
	ld [hl], a					; update wPlayerMimicSlot with source slot	
.updateDisabledSlot
; update the index of the disabled move if necessary
	ld hl, wPlayerDisabledMove
	ld a, [hl]
	swap a
	and $f
	ld b, a
	ld a, [wCurrentMenuItem]
	cp b
	jr nz, .next
	ld a, [hl]
	and $f
	ld b, a
	ld a, [wMenuItemToSwap]
	swap a
	add b
	ld [hl], a
	jr .swapMovesInPartyMon
.next
	ld a, [wMenuItemToSwap]
	cp b
	jr nz, .swapMovesInPartyMon
	ld a, [hl]
	and $f
	ld b, a
	ld a, [wCurrentMenuItem]
	swap a
	add b
	ld [hl], a
.swapMovesInPartyMon
	ld hl, wPlayerBattleStatus3
	bit TRANSFORMED, [hl]
	jr nz, .finish						; if player mon is transformed, don't act on the party data
	ld hl, wPartyMon1Moves
	ld a, [wPlayerMonNumber]
	ld bc, wPartyMon2 - wPartyMon1
	call AddNTimes
	push hl
	call .swapBytes ; swap moves
	pop hl
	ld bc, wPartyMon1PP - wPartyMon1Moves
	add hl, bc
	call .swapBytes ; swap move PP
.finish
	xor a
	ld [wMenuItemToSwap], a ; deselect the item
	jp MoveSelectionMenu
.swapBytes
	push hl
	ld a, [wMenuItemToSwap]
	dec a
	ld c, a
	ld b, 0
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	ld a, [wCurrentMenuItem]
	dec a
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [de]
	ld b, [hl]
	ld [hl], a
	ld a, b
	ld [de], a
	ret
.noMenuItemSelected
	ld a, [wCurrentMenuItem]
	ld [wMenuItemToSwap], a ; select the current menu item for swapping
	jp MoveSelectionMenu

PrintMenuItem:
	xor a
	ld [H_AUTOBGTRANSFERENABLED], a
	coord hl, 0, 8
	ld b, 3
	ld c, 9
	call TextBoxBorder
	ld a, [wPlayerDisabledMove]
	and a
	jr z, .notDisabled
	swap a
	and $f
	ld b, a
	ld a, [wCurrentMenuItem]
	cp b
	jr nz, .notDisabled
	coord hl, 1, 10
	ld de, DisabledText
	call PlaceString
	jr .moveDisabled
.notDisabled
	ld hl, wCurrentMenuItem
	dec [hl]
	xor a
	ld [H_WHOSETURN], a
	ld hl, wBattleMonMoves
	ld a, [wCurrentMenuItem]
	ld c, a
	ld b, $0 ; which item in the menu is the cursor pointing to? (0-3)
	add hl, bc ; point to the item (move) in memory
	ld a, [hl]
	ld [wPlayerSelectedMove], a ; update wPlayerSelectedMove even if the move
	                            ; isn't actually selected (just pointed to by the cursor)
	ld a, [wPlayerMimicSlot]		; check if wPlayerMimicSlot is non-zero
	and a
	jr z, .next
	dec a							; if it is, check if current move slot +1 is equal to it
	cp c
	jr nz, .next
	ld hl, wNewBattleFlags			; if it is, set USING_SIGNATURE_MOVE in wNewBattleFlags before calling GetMoveName
	set USING_SIGNATURE_MOVE, [hl]
.next
	ld a, [wPlayerMonNumber]
	ld [wWhichPokemon], a
	ld a, BATTLE_MON_DATA
	ld [wMonDataLocation], a
	callab GetMaxPP
	ld hl, wCurrentMenuItem
	ld c, [hl]
	inc [hl]
	ld b, $0
	ld hl, wBattleMonPP
	add hl, bc
	ld a, [hl]
	and $3f
	ld [wcd6d], a
; print type, category and <curPP>/<maxPP>
	coord hl, 7, 11
	ld [hl], "/"
	coord hl, 5, 11
	ld de, wcd6d
	lb bc, 1, 2
	call PrintNumber
	coord hl, 8, 11
	ld de, wMaxPP
	lb bc, 1, 2
	call PrintNumber
	call GetCurrentMove
	coord hl, 1, 10					; move it one tile to the left to make room for the type symbol
	predef PrintMoveType
	callab PrintMoveCategory
	ld hl, wNewBattleFlags
	res USING_SIGNATURE_MOVE, [hl]
.moveDisabled
	ld a, $1
	ld [H_AUTOBGTRANSFERENABLED], a
	jp Delay3

DisabledText:
	db "disabled!@"

TypeText:
	db "TYPE@"

; add this function to distinguish AI trainer battles from Link battles
; this is needed because we need to call each function at a different place in the main loop
; must only be called during a link battle (it does not check itself)
GetEnemyMoveInLinkBattle:
	call SaveScreenTilesToBuffer1
	call LinkBattleExchangeData
	call LoadScreenTilesFromBuffer1
	ld a, [wSerialExchangeNybbleReceiveData]
	cp LINKBATTLE_STRUGGLE
	jr nz, .notStruggling
	ld a, STRUGGLE
	jr .done
.notStruggling
	cp LINKBATTLE_NO_ACTION
	jr nz, .notUnableToSelectMove
	ld a, $ff
	jr .done
.notUnableToSelectMove
	cp 4
	ret nc
	ld [wEnemyMoveListIndex], a
	ld c, a
	ld hl, wEnemyMonMoves
	ld b, 0
	add hl, bc
	ld a, [hl]
.done
	ld [wEnemySelectedMove], a
	ld a, $1					; force the turn to the enemy's for next function call
	ld [H_WHOSETURN], a
	call GetCurrentMove			; add this to have access to move's priority before deciding who goes first in MainInBattleLoop
	ret
	
AISelectEnemyMove:
	ld a, [wLinkState]
	sub LINK_STATE_BATTLING
	ret z
	ld a, [wEnemyBattleStatus2]
	and (1 << NEEDS_TO_RECHARGE)
	ret nz
	ld hl, wEnemyBattleStatus1
	ld a, [hl]
	and (1 << CHARGING_UP) | (1 << THRASHING_ABOUT) ; using a charging move or thrash/petal dance
	ret nz
	ld a, [wEnemyBattleStatus1]
	bit STORING_ENERGY, a		; don't check for USING_TRAPPING_MOVE anymore, just bide
	jr z, .canSelectMove
	ret							; if Biding, can't select move
.unableToSelectMove
	ld a, $ff
	jr .done
.canSelectMove
	ld a, [wEnemyDisabledMove]
	swap a
	and $f
	ld b, a							; store the index of the disabled move in b (starting at 1)
	ld c, NUM_MOVES					; loop counter
	call CheckEnemyAllPPExhausted
	jr z, .opponentUsedStruggle		; use Struggle
	ld hl, wEnemyMonMoves			; 1st enemy move
.atLeastTwoMovesAvailable
	ld a, [wIsInBattle]
	dec a
	jr z, .chooseRandomMove ; wild encounter
	callab AIEnemyTrainerChooseMoves
.chooseRandomMove
	push hl
	call BattleRandom
	ld b, $1
	cp TWENTY_FIVE_PERCENT
	jr c, .moveChosen
	inc hl
	inc b
	cp FIFTY_PERCENT
	jr c, .moveChosen
	inc hl
	inc b
	cp SEVENTY_FIVE_PERCENT
	jr c, .moveChosen
	inc hl
	inc b						; select move 4, [SEVENTY_FIVE_PERCENT,ff] (64/256 chance)
.moveChosen
	ld a, b
	dec a
	ld [wEnemyMoveListIndex], a
	call CheckEnemyPP				; check if the enemy has PP left for the chosen move
	jr z, .noPPLeft					; if no PP left, try again
	ld a, [wEnemyDisabledMove]
	swap a
	and $f
	cp b
	ld a, [hl]
.noPPLeft
	pop hl
	jr z, .chooseRandomMove ; move disabled or has no PP left, try again
	and a
	jr z, .chooseRandomMove ; move non-existant, try again
.done
	ld [wEnemySelectedMove], a
	ld a, $1						; force the turn to the enemy's for next function call
	ld [H_WHOSETURN], a
	call GetCurrentMove				; add this to have access to move's priority before deciding who goes first in MainInBattleLoop
	ret
.opponentUsedStruggle
	ld a, STRUGGLE
	jr .done

; this appears to exchange data with the other gameboy during link battles
LinkBattleExchangeData:
	ld a, $ff
	ld [wSerialExchangeNybbleReceiveData], a
	ld a, [wPlayerMoveListIndex]
	cp LINKBATTLE_RUN ; is the player running from battle?
	jr z, .doExchange
	ld a, [wActionResultOrTookBattleTurn]
	and a ; is the player switching in another mon?
	jr nz, .switching
; the player used a move
	ld a, [wPlayerSelectedMove]
	cp STRUGGLE
	ld b, LINKBATTLE_STRUGGLE
	jr z, .next
	dec b ; LINKBATTLE_NO_ACTION
	inc a ; does move equal -1 (i.e. no action)?
	jr z, .next
	ld a, [wPlayerMoveListIndex]
	jr .doExchange
.switching
	ld a, [wWhichPokemon]
	add 4
	ld b, a
.next
	ld a, b
.doExchange
	ld [wSerialExchangeNybbleSendData], a
	callab PrintWaitingText
.syncLoop1
	call Serial_ExchangeNybble
	call DelayFrame
	ld a, [wSerialExchangeNybbleReceiveData]
	inc a
	jr z, .syncLoop1
	ld b, 10
.syncLoop2
	call DelayFrame
	call Serial_ExchangeNybble
	dec b
	jr nz, .syncLoop2
	ld b, 10
.syncLoop3
	call DelayFrame
	call Serial_SendZeroByte
	dec b
	jr nz, .syncLoop3
	ret

ExecutePlayerMove:
	ld hl, wNewBattleFlags
	res USING_SIGNATURE_MOVE, [hl]
	xor a
	ld [H_WHOSETURN], a
	ld a, [wPlayerSelectedMove]
	inc a
	jp z, ExecutePlayerMoveDone				; for selected move = FF, skip most of player's turn
	xor a
	ld [wMoveMissed], a
	ld [wMonIsDisobedient], a
	ld [wMoveDidntMiss], a
	ld a, [wActionResultOrTookBattleTurn]
	and a									; has the player already used the turn (e.g. by using an item, trying to run or switching pokemon)
	jp nz, ExecutePlayerMoveDone
	call PrintGhostText
	jp z, ExecutePlayerMoveDone
	call CallHideSubstituteShowMonAnim
	call CheckPlayerStatusConditions
	jr nz, .playerHasNoSpecialCondition
	jp hl
.playerHasNoSpecialCondition
	ld a, [wPlayerMimicSlot]
	ld b, a
	ld a, [wPlayerMoveListIndex]
	inc a
	cp b
	jr nz, .afterMimicTest
	ld hl, wNewBattleFlags
	set USING_SIGNATURE_MOVE, [hl]
	set PLAYER_SIGNATURE_MOVE, [hl]
.afterMimicTest
	call GetCurrentMove
	ld hl, wPlayerBattleStatus1
	bit CHARGING_UP, [hl]					; charging up for attack
	jr nz, PlayerCanExecuteChargingMove
	call CheckForDisobedience
	jp z, ExecutePlayerMoveDone

CheckIfPlayerNeedsToChargeUp:
	ld a, [wPlayerMoveEffect]
	cp CHARGE_EFFECT
	jp z, ChargeEffect				; jump directly to the handler for charging moves
	cp SKY_ATTACK_EFFECT
	jp z, ChargeEffect				; jump directly to the handler for charging moves
	cp SKULL_BASH_EFFECT
	jp z, ChargeEffect				; jump directly to the handler for charging moves
	cp INVULNERABLE_EFFECT
	jp z, ChargeEffect				; jump directly to the handler for charging moves
	jr PlayerCanExecuteMove

; in-battle stuff
PlayerCanExecuteChargingMove:
	ld hl, wPlayerBattleStatus1
	res CHARGING_UP, [hl]
	res INVULNERABLE, [hl]
PlayerCanExecuteMove:
	call PrintMonName1Text
	ld hl, DecrementPP
	ld de, wPlayerSelectedMove				; pointer to the move just used
	ld b, BANK(DecrementPP)
	call Bankswitch
	ld a, [wPlayerMoveListIndex]			; get the move index in the moveset
	ld [wPlayerLastMoveListIndex], a		; store it in the variable holding the last used move index
	callab StoreEnemyLastAttackReceived		; store the ID of the move used by the player in the enemy's memory
	ld a, [wPlayerMoveEffect]				; effect of the move just used
	ld hl, ResidualEffects1
	ld de, 1
	call IsInArray
	jr nc, .notInResidualEffects1	; zero the damage when player uses a non-damaging move (so that Bide has the correct damage count)
	call CalculateDamage 			; zero the damage when player uses a non-damaging move (so that Bide has the correct damage count)
	jp JumpMoveEffect
									; ResidualEffects1 moves skip damage calculation and accuracy tests
									; unless executed as part of their exclusive effect functions
.notInResidualEffects1:
	ld a, [wPlayerMoveEffect]
	cp THRASH_PETAL_DANCE_EFFECT	; since this effect is now the only one in SpecialEffectsCont, just test it directly
	call z, JumpMoveEffect			; execute the effect of moves like Thrash but don't skip anything
	call HandleCounterMove			; moved here from after call CriticalHitTest to avoid testing for critical hits with Counter
	jr z, handleIfPlayerMoveMissed	; moved here from after call CriticalHitTest to avoid testing for critical hits with Counter
PlayerCalcMoveDamage:
	call MoveHitTest				; moved here from after call RandomizeDamage
	ld a, [wPlayerMoveEffect]
	ld hl, SetDamageEffects
	ld de, 1
	call IsInArray
	jr nc, PlayerDamageCalculation	; if effect isn't in SetDamageEffects array, jump
	call ApplyImmunities			; apply type immunities only (not weaknesses or resistances)
	jp handleIfPlayerMoveMissed		; SetDamageEffects moves (e.g. Seismic Toss and Super Fang) skip damage calculation
PlayerDamageCalculation:
	call MoveAttributesModifications
	call CriticalHitTest
	call GetDamageVarsForPlayerAttack
	call CalculateDamage
	jp z, playerCheckIfFlyOrChargeEffect	; for moves with 0 BP, skip any further damage calculation and, for now, skip MoveHitTest
											; for these moves, accuracy tests will only occur if they are called as part of the effect itself
	call AdjustDamageForMoveType
	call RandomizeDamage
	call ApplyOtherModificators				; general function to apply damage modifications that apply to final damage value
	
handleIfPlayerMoveMissed:
	ld a, [wMoveMissed]
	and a
	jr z, getPlayerAnimationType
	ld a, [wPlayerMoveEffect]
	sub EXPLODE_EFFECT
	jr z, playPlayerMoveAnimation ; don't play any animation if the move missed, unless it was EXPLODE_EFFECT
	jr playerCheckIfFlyOrChargeEffect
getPlayerAnimationType:
	ld a, [wPlayerMoveEffect]
	and a
	ld a, 4 ; move has no effect other than dealing damage
	jr z, playPlayerMoveAnimation
	ld a, 5 ; move has effect
playPlayerMoveAnimation:
	ld [wAnimationType], a
	ld a, [wPlayerMoveNum]
	call PlayMoveAnimation
	call HandleExplodingAnimation
	call DrawPlayerHUDAndHPBar
	jr MirrorMoveCheck
playerCheckIfFlyOrChargeEffect:
	ld c, 30
	call DelayFrames
	ld a, [wPlayerMoveEffect]
	cp INVULNERABLE_EFFECT
	jr z, .playAnim
	cp CHARGE_EFFECT
	jr z, .playAnim
	cp SKY_ATTACK_EFFECT
	jr z, .playAnim
	cp SKULL_BASH_EFFECT
	jr z, .playAnim
	jr MirrorMoveCheck
.playAnim
	xor a
	ld [wAnimationType], a
	ld a, STATUS_AFFECTED_ANIM
	call PlaySpecialAnimation
MirrorMoveCheck:
	ld a, [wPlayerMoveEffect]
	cp MIRROR_MOVE_EFFECT
	jr nz, .metronomeCheck
	call MirrorMoveCopyMove
	jp z, ExecutePlayerMoveDone
	xor a
	ld [wMonIsDisobedient], a
	ld [wMoveMissed], a				; needed to prevent swift from missing when it's called via mirror move
	jp CheckIfPlayerNeedsToChargeUp ; if Mirror Move was successful go back to damage calculation for copied move
.metronomeCheck
	cp METRONOME_EFFECT
	jr nz, .next
	call MetronomePickMove
	xor a
	ld [wMoveMissed], a				; needed to prevent swift from missing when it's called via metronome
	jp CheckIfPlayerNeedsToChargeUp ; Go back to damage calculation for the move picked by Metronome
.next
	ld a, [wPlayerMoveEffect]
	ld hl, ResidualEffects2
	ld de, 1
	call IsInArray
	jp c, JumpMoveEffect ; done here after executing effects of ResidualEffects2
	ld a, [wMoveMissed]
	and a
	jr z, .moveDidNotMiss
	call PrintMoveFailureText
	ld a, [wPlayerMoveEffect]
	cp EXPLODE_EFFECT				; even if Explosion or Selfdestruct missed, its effect still needs to be activated
	jr z, .notDone
	ld a, [wPlayerNumAttacksLeft]
	dec a
	jr z, .lastThrashingTurn		; if it was the last turn of thrashing move, don't disrupt it
	ld hl, wPlayerBattleStatus1
	res THRASHING_ABOUT, [hl]		; if move missed, disrupt thrashing moves
.lastThrashingTurn
	jp ExecutePlayerMoveDone		; otherwise, we're done if the move missed
.moveDidNotMiss
	call ApplyAttackToEnemyPokemon
	call PrintCriticalOHKOText
	callab DisplayEffectiveness
	ld a, 1
	ld [wMoveDidntMiss], a
.notDone
	ld a, [wPlayerMoveEffect]
	ld hl, AlwaysHappenSideEffects
	ld de, 1
	call IsInArray
	call c, JumpMoveEffect			; not done after executing effects of AlwaysHappenSideEffects
	ld a, [wMoveMissed]
	and a							; in case of suicide move miss, don't check the target's HP
	jp nz, ExecutePlayerMoveDone
	ld hl, wEnemyMonHP
	ld a, [hli]
	ld b, [hl]
	or b
	jr nz, .targetNotFainted
	call ExecutePlayerMoveDone		; if the target fainted, still decrement thrash counter
	ld b, 0							; have to reset b to zero for the KO to register (b is set to 1 in ExecuteEnemyMoveDone)
	ret								; if the target fainted, don't do anything else
.targetNotFainted
	call HandleBuildingRage
	ld hl, wPlayerBattleStatus1
	bit ATTACKING_MULTIPLE_TIMES, [hl]
	jr z, .executeOtherEffects
	ld a, [wPlayerNumAttacksLeft]
	dec a
	ld [wPlayerNumAttacksLeft], a
	jp nz, PlayerDamageCalculation		; jump a bit further back to recalcultate the damage and critical hit chance for each individual hit
	res ATTACKING_MULTIPLE_TIMES, [hl]	; clear attacking multiple times status when all attacks are over
	ld hl, MultiHitText
	call PrintText
	xor a
	ld [wPlayerNumHits], a
.executeOtherEffects
	ld a, [wPlayerMoveEffect]
	and a
	jp z, ExecutePlayerMoveDone
	ld hl, SpecialEffects
	ld de, 1
	call IsInArray
	call nc, JumpMoveEffect ; move effects not included in SpecialEffects or in either of the ResidualEffect arrays,
	; which are the effects not covered yet. Rage effect will be executed for a second time (though it's irrelevant).
	; Includes side effects that only need to be called if the target didn't faint.
	; Responsible for executing Twineedle's second side effect (poison).
	jp ExecutePlayerMoveDone

MultiHitText:
	TX_FAR _MultiHitText
	db "@"

ExecutePlayerMoveDone:
	ld hl, wPlayerBattleStatus1
	bit THRASHING_ABOUT, [hl]
	jr z, .notThrashingAbout
	ld hl, wPlayerNumAttacksLeft
	dec [hl]							; did Thrashing About counter hit 0?
	jp nz, .notThrashingAbout
	ld hl, wPlayerBattleStatus1
	res THRASHING_ABOUT, [hl]			; mon is no longer using thrash or petal dance
	bit CONFUSED, [hl]
	jr nz, .notThrashingAbout			; if the mon is already confused, don't reconfuse it
	set CONFUSED, [hl]					; mon is now confused
	call BattleRandom
	and 3
	inc a
	inc a								; confused for 2-4 turns
	ld [wPlayerConfusedCounter], a
	xor a
	ld [wAnimationType], a
	ld a, CONFUSED_PLAYER
	call PlaySpecialAnimation
	ld hl, ConfusedDueToFatigueText
	call PrintText
.notThrashingAbout
	xor a
	ld [wActionResultOrTookBattleTurn], a
	ld b, 1
	ret

PrintGhostText:
	jpab _PrintGhostText

IsGhostBattle:
	ld a, [wIsInBattle]
	dec a
	ret nz						; Trainer battles can't be GHOST battles
	ld a, [wCurOpponent]
	ld b, a
	ld a, [wCurOpponent + 1]
	ld c, a						; for wild battles, wCurOpponent is zero except against GHOST MAROWAK, Static mons, and fishing rod mons
	ld hl, GHOST_MAROWAK		; use dedicated species id for GHOST_MAROWAK, which uses the same base stats as normal MAROWAK
	call CompareBCtoHL			; this avoids any possible mix up with an actual wild MAROWAK (be it from fishing, a static mon, or anything else)
	jr z, .checkSilphScope
	ld a, [wEnemyMonType1]
	cp GHOST
	jr z, .checkSilphScope
	ld a, [wEnemyMonType2]
	cp GHOST
	jr nz, .noGhost
.checkSilphScope
	ld b, SILPH_SCOPE
	call IsItemInBag
	ret z
.noGhost
	ld a, 1
	and a
	ret

PlacePokeballIcon_:
	jpab PlacePokeballIcon

; checks for various status conditions affecting the player mon
; stores whether the mon cannot use a move this turn in Z flag
CheckPlayerStatusConditions:
	ld hl, wBattleMonStatus
	ld a, [hl]
	and SLP ; sleep mask
	jr z, .FrozenCheck
; sleeping
	dec a
	ld [wBattleMonStatus], a ; decrement number of turns left
	and a
	jr nz, .FastAsleep			; if the number of turns is not 0, sleep on
	ld hl, WokeUpText			; else print waking up text 
	call PrintText				; print waking up text
	call DrawPlayerHUDAndHPBar	; redraw player's status
	jr .FlinchedCheck			; then continue checks
.FastAsleep
	xor a
	ld [wAnimationType], a
	ld a, SLP_ANIM - 1
	call PlaySpecialAnimation
	ld hl, FastAsleepText
	call PrintText
.sleepDone
	xor a
	ld [wPlayerUsedMove], a
	ld hl, ExecutePlayerMoveDone ; player can't move this turn
	jp .returnToHL

.FrozenCheck
	bit FRZ, [hl] ; frozen?
	jr z, .FlinchedCheck
	call ThawingOutChance
	jr z, .FlinchedCheck		; if z flag is set by previous call, it means the pokemon thawed out, so keep checking
	xor a
	ld [wPlayerUsedMove], a
	ld hl, ExecutePlayerMoveDone ; player can't move this turn
	jp .returnToHL

.FlinchedCheck
	ld hl, wPlayerBattleStatus1
	bit FLINCHED, [hl]
	jp z, .HyperBeamCheck
	res FLINCHED, [hl]			; reset player's flinch status
	res THRASHING_ABOUT, [hl]	; disrupt thrashing moves
	inc hl
	res NEEDS_TO_RECHARGE, [hl] ; clear "must recharge" flag
	ld hl, FlinchedText
	call PrintText
	ld hl, ExecutePlayerMoveDone ; player can't move this turn
	jp .returnToHL

.HyperBeamCheck
	ld hl, wPlayerBattleStatus2
	bit NEEDS_TO_RECHARGE, [hl]
	jr z, .AnyMoveDisabledCheck
	res NEEDS_TO_RECHARGE, [hl] ; reset player's recharge status
	ld hl, MustRechargeText
	call PrintText
	ld hl, ExecutePlayerMoveDone ; player can't move this turn
	jp .returnToHL

.AnyMoveDisabledCheck
	ld hl, wPlayerDisabledMove
	ld a, [hl]
	and a
	jr z, .ConfusedCheck
	dec a
	ld [hl], a
	and $f ; did Disable counter hit 0?
	jr nz, .ConfusedCheck
	ld [hl], a
	ld [wPlayerDisabledMoveNumber], a
	ld hl, DisabledNoMoreText
	call PrintText

.ConfusedCheck
	ld a, [wPlayerBattleStatus1]
	add a ; is player confused?
	jr nc, .TriedToUseDisabledMoveCheck
	ld hl, wPlayerConfusedCounter
	dec [hl]
	jr nz, .IsConfused
	ld hl, wPlayerBattleStatus1
	res CONFUSED, [hl] ; if confused counter hit 0, reset confusion status
	ld hl, ConfusedNoMoreText
	call PrintText
	jr .TriedToUseDisabledMoveCheck
.IsConfused
	ld hl, IsConfusedText
	call PrintText
	xor a
	ld [wAnimationType], a
	ld a, CONFUSED_PLAYER
	call PlaySpecialAnimation
	call BattleRandom
	cp TWO_OUT_OF_THREE
	jr c, .TriedToUseDisabledMoveCheck
	ld hl, wPlayerBattleStatus1
	ld a, [hl]
	and ((1 << CONFUSED) | (1 << USING_TRAPPING_MOVE))
	ld [hl], a
	call HandleSelfConfusionDamage
	jr .MonHurtItselfOrFullyParalysed

.TriedToUseDisabledMoveCheck
; prevents a disabled move that was selected before being disabled from being used
	ld a, [wPlayerDisabledMoveNumber]
	and a
	jr z, .ParalysisCheck
	ld hl, wPlayerSelectedMove
	cp [hl]
	jr nz, .ParalysisCheck
	call PrintMoveIsDisabledText
	ld hl, ExecutePlayerMoveDone ; if a disabled move was somehow selected, player can't move this turn
	jp .returnToHL

.ParalysisCheck
	ld hl, wBattleMonStatus
	bit PAR, [hl]
	jr z, .BideCheck
	call BattleRandom
	cp TWENTY_FIVE_PERCENT+1
	jr nc, .BideCheck
	ld hl, FullyParalyzedText
	call PrintText

.MonHurtItselfOrFullyParalysed
	ld hl, wPlayerBattleStatus1
	ld a, [hl]
	; clear bide, thrashing, charging up, invulnerable
	and $ff ^ ((1 << STORING_ENERGY) | (1 << THRASHING_ABOUT) | (1 << CHARGING_UP) | (1 << INVULNERABLE))
	; added INVULNERABLE to correct the bug of mid-Fly or mid-Dig paralysis making the Pokemon invulnerable indefinitely
	; removed USING_TRAPPING_MOVE to let trapping continue even when the mon using it loses a turn to paralysis
	ld [hl], a
	ld a, [wPlayerMoveEffect]
	cp INVULNERABLE_EFFECT
	jr z, .FlyOrChargeEffect
	cp CHARGE_EFFECT
	jr z, .FlyOrChargeEffect
	cp SKY_ATTACK_EFFECT
	jr z, .FlyOrChargeEffect
	jr .NotFlyOrChargeEffect

.FlyOrChargeEffect
	xor a
	ld [wAnimationType], a
	ld a, STATUS_AFFECTED_ANIM
	call PlaySpecialAnimation
.NotFlyOrChargeEffect
	ld hl, ExecutePlayerMoveDone
	jp .returnToHL ; if using a two-turn move, we need to recharge the first turn

.BideCheck
	ld hl, wPlayerBattleStatus1
	bit STORING_ENERGY, [hl] ; is mon using bide?
	jr z, .ThrashingAboutCheck
	xor a
	ld [wPlayerMoveNum], a
	ld hl, wPlayerBidingTurnsLeft
	dec [hl] ; did Bide counter hit 0?
	jr z, .UnleashEnergy
	ld hl, StoringEnergyText		; display text saying the pokemon is storing energy
	call PrintText					; display text saying the pokemon is storing energy
	ld hl, ExecutePlayerMoveDone
	jp .returnToHL ; unless mon unleashes energy, can't move this turn
.UnleashEnergy
	ld hl, wPlayerBattleStatus1
	res STORING_ENERGY, [hl] ; not using bide any more
	ld hl, UnleashedEnergyText
	call PrintText
	ld a, 1
	ld [wPlayerMovePower], a
	ld hl, wPlayerBideAccumulatedDamage + 1
	ld a, [hld]
	add a
	ld b, a
	ld [wDamage + 1], a
	ld a, [hl]
	rl a ; double the damage
	ld [wDamage], a
	or b
	jr nz, .next
	ld a, 1
	ld [wMoveMissed], a
.next
	push hl
	call ApplyImmunities			; make Bide ineffective against Ghost types
	pop hl
	xor a
	ld [hli], a
	ld [hl], a
	ld a, BIDE
	ld [wPlayerMoveNum], a
	ld hl, handleIfPlayerMoveMissed ; skip damage calculation, DecrementPP and MoveHitTest
	jp .returnToHL

.ThrashingAboutCheck
	bit THRASHING_ABOUT, [hl] ; is mon using thrash or petal dance?
	jr z, .RageCheck
	ld hl, ThrashingAboutText
	call PrintText
	ld hl, PlayerCalcMoveDamage		; skip DecrementPP
	jp .returnToHL

.RageCheck
	ld a, [wPlayerMoveEffect]
	cp RAGE_EFFECT							; test if move effect = Rage
	jp z, .checkPlayerStatusConditionsDone	; if so, don't reset the Rage flag
	ld hl, wPlayerBattleStatus2
	res USING_RAGE, [hl]					; reset the Rage flag
	jp .checkPlayerStatusConditionsDone

.returnToHL
	xor a
	ret

.checkPlayerStatusConditionsDone
	ld a, $1
	and a
	ret

FastAsleepText:
	TX_FAR _FastAsleepText
	db "@"

WokeUpText:
	TX_FAR _WokeUpText
	db "@"

IsFrozenText:
	TX_FAR _IsFrozenText
	db "@"

FullyParalyzedText:
	TX_FAR _FullyParalyzedText
	db "@"

FlinchedText:
	TX_FAR _FlinchedText
	db "@"

MustRechargeText:
	TX_FAR _MustRechargeText
	db "@"

DisabledNoMoreText:
	TX_FAR _DisabledNoMoreText
	db "@"

IsConfusedText:
	TX_FAR _IsConfusedText
	db "@"

HurtItselfText:
	TX_FAR _HurtItselfText
	db "@"

ConfusedNoMoreText:
	TX_FAR _ConfusedNoMoreText
	db "@"

SavingEnergyText:
	TX_FAR _SavingEnergyText
	db "@"

StoringEnergyText:
	TX_FAR _StoringEnergyText
	db "@"
	
UnleashedEnergyText:
	TX_FAR _UnleashedEnergyText
	db "@"

ThrashingAboutText:
	TX_FAR _ThrashingAboutText
	db "@"

AttackContinuesText:
	TX_FAR _AttackContinuesText
	db "@"

CantMoveText:
	TX_FAR _CantMoveText
	db "@"

PrintMoveIsDisabledText:
	ld hl, wPlayerSelectedMove
	ld de, wPlayerBattleStatus1
	ld a, [H_WHOSETURN]
	and a
	jr z, .removeChargingUp
	inc hl
	ld de, wEnemyBattleStatus1
.removeChargingUp
	ld a, [de]
	and ((1 << STORING_ENERGY) | (1 << THRASHING_ABOUT) | (1 << CHARGING_UP))		; reset Bide, thrashing moves and charging moves flags
	ld [de], a
	ld a, [hl]
	ld [wd11e], a
	call GetAttackerMoveName		; to handle signature moves
	ld hl, MoveIsDisabledText
	jp PrintText

MoveIsDisabledText:
	TX_FAR _MoveIsDisabledText
	db "@"

; Function that determines whether a frozen pokemon thaws out or not
; if the pokemon thaws out, displays a text message indicating that it thaws out, then clears its status
; sets the z flag if the pokemon thaws out, unsets it otherwise
ThawingOutChance:
	ld hl, wPartyMon1Status		; status of first player monster in their roster
	ld bc, wBattleMonStatus
	ld de, wPlayerMoveEffect
	ld a, [H_WHOSETURN]
	and a
	jr z, .main
	ld hl, wEnemyMon1Status		; status of first opponent monster in their roster
	ld bc, wEnemyMonStatus
	ld de, wEnemyMoveEffect
.main:
	ld a, [de]
	push hl
	push bc
	ld de, $0001
	ld hl, AutoDefrostEffects
	call IsInArray
	jr nc, .notAutoDefrostEffect
	ld hl, WasDefrostedText
	jr .print
.notAutoDefrostEffect
	call BattleRandom
	cp TWENTY_PERCENT + 1
	jr nc, .notDefrosted
	ld hl, ThawingOutText
.print
	call PrintText					; display message to indicate that the pokemon thawed out
	pop bc
	pop hl
	xor a
	ld [bc],a						; defrost pokemon
	dec bc							; makes bc point to the pokemon number in the party
	ld a, [bc]
	ld bc, wPartyMon2 - wPartyMon1	; size of roster entry
	call AddNTimes					; makes hl point to the status of the monster in their roster
	xor a
	ld [hl], a						; clear status in roster
	call DrawHUDsAndHPBars			; redraw the status of both pokemon
	ret								; the z flag was set by the xor a
.notDefrosted:
	ld hl, IsFrozenText
	call PrintText
	pop bc
	pop hl
	or $1							; this unsets the z flag, since the result is always at least 1
	ret

; thawing out text
ThawingOutText:
	TX_FAR _ThawingOutText
	db "@"

; add this list for move effects that defrost the user
AutoDefrostEffects:
	db AUTODEFROST_BURN_SIDE_EFFECT1
	db AUTODEFROST_BURN_SIDE_EFFECT2
	db $FF

; defrosted text
WasDefrostedText:
	TX_FAR _WasDefrostedText
	db "@"

HandleSelfConfusionDamage:
	ld hl, HurtItselfText
	call PrintText
	ld hl, wEnemyMonDefense
	ld a, [hli]
	push af
	ld a, [hld]
	push af
	ld a, [wBattleMonDefense]
	ld [hli], a
	ld a, [wBattleMonDefense + 1]
	ld [hl], a
	ld hl, wPlayerMoveEffect
	push hl
	ld a, [hl]
	push af
	xor a
	ld [hli], a
	ld [wCriticalHitOrOHKO], a	; self-inflicted confusion damage can't be a Critical Hit
	ld a, 40					; 40 base power
	ld [hli], a
	ld a, TYPELESS					; make self-confusion damage typeless instead of normal
	ld [hli], a						; replaced ld [hl] with ld [hli]
	inc hl							; skip accuracy
	inc hl							; skip PP
	ld [hl], (PRIORITY_NORMAL << 4)|(NOT_SOUND_BASED << 3)|(CONTACT << 2)|(CATEGORY_STATUS)	; set wPlayerMoveExtra so that the pseudo move has normal priority and is considered a status move so that Counter or Mirror Coat can't counter it and that physical stats get used to calculate damage
	call GetDamageVarsForPlayerAttack
	call CalculateDamage ; ignores AdjustDamageForMoveType (type-less damage), RandomizeDamage,
	                     ; and MoveHitTest (always hits)
	pop af
	pop hl
	ld [hl], a
	ld hl, wEnemyMonDefense + 1
	pop af
	ld [hld], a
	pop af
	ld [hl], a
	xor a
	ld [wAnimationType], a
	inc a
	ld [H_WHOSETURN], a
	call PlayMoveAnimation
	call DrawPlayerHUDAndHPBar
	call ApplyDamageToPlayerPokemon_main	; call this before swapping the turn back to normal
											; so that damage are inflicted to the player's substitute if they have one
	xor a
	ld [H_WHOSETURN], a
	ret

PrintMonName1Text:
	ld hl, MonName1Text
	jp PrintText

; this function wastes time calling DetermineExclamationPointTextNum
; and choosing between Used1Text and Used2Text, even though
; those text strings are identical and both continue at PrintInsteadText
; this likely had to do with Japanese grammar that got translated,
; but the functionality didn't get removed
MonName1Text:
	TX_FAR _MonName1Text
	TX_ASM
	ld a, [H_WHOSETURN]
	and a
	ld a, [wPlayerMoveNum]
	ld hl, wPlayerUsedMove
	jr z, .playerTurn
	ld a, [wEnemyMoveNum]
	ld hl, wEnemyUsedMove
.playerTurn
	ld [hl], a
	ld [wd11e], a
	ld hl, UsedText
	ret

UsedText:
	TX_FAR _UsedText
	TX_ASM
	ld a, [wMonIsDisobedient]
	and a
	ld hl, PrintMoveName
	ret z
	ld hl, InsteadText
	ret

; simplified the whole mess with different _ExclamationPointXText blocks that were all pointing to the same string
InsteadText:
	TX_FAR _InsteadText
	; fallthrough
	
; removed the whole part about _ExclamationPointXText
PrintMoveName:
	TX_FAR _CF4BText
	TX_FAR _ExclamationPointText
	db "@"

PrintMoveFailureText:
	ld de, wPlayerMoveEffect
	ld bc, wBattleMonMaxHP			; used for jump kick recoil damage calculation
	ld a, [H_WHOSETURN]
	and a
	jr z, .playersTurn
	ld de, wEnemyMoveEffect
	ld bc, wEnemyMonMaxHP			; used for jump kick recoil damage calculation
.playersTurn
	ld hl, DoesntAffectMonText
	ld a, [wDamageMultipliers]
	and $7f
	jr z, .gotTextToPrint
	ld hl, AttackMissedText
	ld a, [wCriticalHitOrOHKO]
	cp $ff
	jr nz, .gotTextToPrint
	ld hl, UnaffectedText
.gotTextToPrint
	push de
	push bc
	call PrintText
	pop bc
	xor a
	ld [wCriticalHitOrOHKO], a
	pop de
	ld a, [de]
	cp JUMP_KICK_EFFECT
	ret nz
	; if you get here, the mon used jump kick or hi jump kick and missed
	ld hl, wDamage
	ld a, [bc]						; load user's maxHP low byte in a
	inc bc
	ld d, a							; store low byte in d
	ld a, [bc]						; load user's maxHP high byte in a
	ld e, a							; store high byte in e
	srl d							; halve the max HP
	rr e							; halve the max HP
	ld [hl], d						; store the result in wDamage
	inc hl							; store the result in wDamage
	ld [hl], e						; store the result in wDamage
	ld hl, KeptGoingAndCrashedText
	call PrintText
	ld b, $4
	predef PredefShakeScreenHorizontally
	ld a, [H_WHOSETURN]
	and a
	jr nz, .enemyTurn
	jp ApplyDamageToPlayerPokemon_main
.enemyTurn
	jp ApplyDamageToEnemyPokemon_main

AttackMissedText:
	TX_FAR _AttackMissedText
	db "@"

KeptGoingAndCrashedText:
	TX_FAR _KeptGoingAndCrashedText
	db "@"

UnaffectedText:
	TX_FAR _UnaffectedText
	db "@"

PrintDoesntAffectText:
	ld hl, DoesntAffectMonText
	jp PrintText

DoesntAffectMonText:
	TX_FAR _DoesntAffectMonText
	db "@"

; if there was a critical hit or an OHKO was successful, print the corresponding text
PrintCriticalOHKOText:
	ld a, [wCriticalHitOrOHKO]
	and a
	jr z, .done ; do nothing if there was no critical hit or successful OHKO
	dec a
	add a
	ld hl, CriticalOHKOTextPointers
	ld b, $0
	ld c, a
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call PrintText
	xor a
	ld [wCriticalHitOrOHKO], a
.done
	ld c, 20
	jp DelayFrames

CriticalOHKOTextPointers:
	dw CriticalHitText
	dw OHKOText

CriticalHitText:
	TX_FAR _CriticalHitText
	db "@"

OHKOText:
	TX_FAR _OHKOText
	db "@"

; checks if a traded mon will disobey due to lack of badges
; stores whether the mon will use a move in Z flag
CheckForDisobedience:
	xor a
	ld [wMonIsDisobedient], a
	ld a, [wLinkState]
	cp LINK_STATE_BATTLING
	jr nz, .checkIfMonIsTraded
	ld a, $1
	and a
	ret
; compare the mon's original trainer ID with the player's ID to see if it was traded
.checkIfMonIsTraded
	ld hl, wPartyMon1OTID
	ld bc, wPartyMon2 - wPartyMon1
	ld a, [wPlayerMonNumber]
	call AddNTimes
	ld a, [wPlayerID]
	cp [hl]
	jr nz, .monIsTraded
	inc hl
	ld a, [wPlayerID + 1]
	cp [hl]
	jp z, .canUseMove
; it was traded
.monIsTraded
; what level might disobey?
	ld hl, wObtainedBadges
	bit EARTH_BADGE, [hl]
	ld a, 101
	jr nz, .next
	bit MARSH_BADGE, [hl]
	ld a, 70
	jr nz, .next
	bit RAINBOW_BADGE, [hl]
	ld a, 50
	jr nz, .next
	bit CASCADE_BADGE, [hl]
	ld a, 30
	jr nz, .next
	ld a, 10
.next
	ld b, a
	ld c, a
	ld a, [wBattleMonLevel]
	ld d, a
	add b
	ld b, a						; set b equal to mon's level + max level the player can control
	jr nc, .noCarry
	ld b, $ff ; cap b at $ff
.noCarry
	ld a, c
	cp d
	jp nc, .canUseMove			; if mon's level <= max level the player can control, the mon obeys
.loop1
	call BattleRandom
	swap a
	cp b
	jr nc, .loop1				; roll a number until we get one that is < mon's level + max level the player can control
	cp c						; check this number against the max level the player can control
	jp c, .canUseMove			; if it is lower, the mon obeys
.loop2							; else the mon disobeys
	call BattleRandom
	cp b
	jr nc, .loop2
	cp c
	jr c, .useRandomMove
	ld a, d
	sub c
	ld b, a
	call BattleRandom
	swap a
	sub b
	jr c, .monNaps
	cp b
	jr nc, .monDoesNothing
	ld hl, WontObeyText
	call PrintText
	call HandleSelfConfusionDamage
	jp .cannotUseMove
.monNaps
	call BattleRandom
	add a
	swap a
	and $3			; make it at least 2 turns of sleep
	inc a			; like a usual sleep effect
	inc a			; to take into account that wake-up turns are no longer wasted
	ld [wBattleMonStatus], a
	ld hl, wPlayerBattleStatus1
	res STORING_ENERGY, [hl]	; disrupt Bide
	res THRASHING_ABOUT, [hl]	; disrupt thrashing moves
	ld hl, BeganToNapText
	jr .printText
.monDoesNothing
	call BattleRandom
	and $3
	ld hl, LoafingAroundText
	and a
	jr z, .printText
	ld hl, WontObeyText
	dec a
	jr z, .printText
	ld hl, TurnedAwayText
	dec a
	jr z, .printText
	ld hl, IgnoredOrdersText
.printText
	call PrintText
	call DrawPlayerHUDAndHPBar			; update status on screen in case the mon starts a nap
	jp .cannotUseMove
.useRandomMove
	ld a, [wBattleMonMoves + 1]
	and a ; is the second move slot empty?
	jr z, .monDoesNothing ; mon will not use move if it only knows one move
	ld a, [wPlayerDisabledMoveNumber]
	and a
	jr nz, .monDoesNothing
	ld a, [wPlayerSelectedMove]
	cp STRUGGLE
	jr z, .monDoesNothing ; mon will not use move if struggling
; check if only one move has remaining PP
	ld hl, wBattleMonPP
	push hl
	ld a, [hli]
	and $3f
	ld b, a
	ld a, [hli]
	and $3f
	add b
	ld b, a
	ld a, [hli]
	and $3f
	add b
	ld b, a
	ld a, [hl]
	and $3f
	add b
	pop hl
	push af
	ld a, [wCurrentMenuItem]
	ld c, a
	ld b, $0
	add hl, bc
	ld a, [hl]
	and $3f
	ld b, a
	pop af
	cp b
	jr z, .monDoesNothing ; mon will not use move if only one move has remaining PP
	ld a, [wCurrentMenuItem]
	ld c, a
.chooseMove
	call BattleRandom
	and NUM_MOVES - 1
	cp c
	jr z, .chooseMove ; if the random number matches the move the player selected, choose another
	ld [wCurrentMenuItem], a
	ld hl, wBattleMonPP
	ld e, a
	ld d, $0
	add hl, de
	ld a, [hl]
	and a									; does the move have any PP left?
	jr z, .chooseMove						; if the move has no PP left, choose another (also excludes empty slots which have zero PP)
	ld a, [wCurrentMenuItem]
	ld c, a
	inc a							; wCurrentMenuItem starts at zero, and zero in wMonIsDisobedient means the mon obeys, so we need to add one
	ld [wMonIsDisobedient], a		; store the move slot the mon actually used (+ 1) instead of 1, so that we have the info for DecrementPP later
	ld a, [wPlayerMoveListIndex]
	ld b, a
	push bc							; save the movelist index of the move the player actually selected
	ld a, c
	ld [wPlayerMoveListIndex], a	; needed to make Mimicked signature moves work
	ld a, [wPlayerMimicSlot]
	dec a
	ld hl, wNewBattleFlags
	res USING_SIGNATURE_MOVE, [hl]	; reset it here in case the move the player actually chose is a Mimicked signature move
	cp c
	jr nz, .notMimicSlot
	set USING_SIGNATURE_MOVE, [hl]	; if the move randomly used by the disobedient mon is a Mimicked signature move
.notMimicSlot
	ld b, $0
	ld hl, wBattleMonMoves
	add hl, bc
	ld a, [hl]
	ld [wPlayerSelectedMove], a
	call GetCurrentMove
	pop bc
	ld a, b
	ld [wCurrentMenuItem], a		; restore the menu item index of the move the player actually selected
	ld [wPlayerMoveListIndex], a	; restore the movelist index of the move the player actually selected
.canUseMove
	ld a, $1
	and a; clear Z flag
	ret
.cannotUseMove
	xor a ; set Z flag
	ret

LoafingAroundText:
	TX_FAR _LoafingAroundText
	db "@"

BeganToNapText:
	TX_FAR _BeganToNapText
	db "@"

WontObeyText:
	TX_FAR _WontObeyText
	db "@"

TurnedAwayText:
	TX_FAR _TurnedAwayText
	db "@"

IgnoredOrdersText:
	TX_FAR _IgnoredOrdersText
	db "@"

; sets b, c, d, and e for the CalculateDamage routine in the case of an attack by the player mon
GetDamageVarsForPlayerAttack:
	xor a
	ld hl, wDamage ; damage to eventually inflict, initialise to zero
	ldi [hl], a
	ld [hl], a
	ld hl, wPlayerMovePower
	ld a, [hli]
	and a
	ld d, a 					; d = move power
	ret z 						; return if move power is zero
	ld a, [wPlayerMoveExtra]	; add this part to distinguish between physical and special moves based on move properties instead of type
	bit IS_SPECIAL_MOVE, a		; add this part to distinguish between physical and special moves based on move properties instead of type
	jr nz, .specialAttack		; add this part to distinguish between physical and special moves based on move properties instead of type
.physicalAttack
	ld bc, wEnemyMonDefense			; opponent defense
	ld hl, wBattleMonAttack			; attack pointer
	ld a, [hli]
	ld l, [hl]
	ld h, a      					; *HL = attacker attack
	ld a, [wEnemyReflectCounter]	; check the counter instead of the flag
	and a							; if counter is not zero, double enemy's defense
	jr z, .physicalAttackCritCheck
; if the enemy has used Reflect, halve the player's attack
	srl h							; halve player's attack instead of doubling enemy's defense
	rr l							; halve player's attack instead of doubling enemy's defense
.physicalAttackCritCheck
	ld a, [wCriticalHitOrOHKO]
	and a							; check for critical hit
	jr z, .loadDefensiveStat
; in the case of a critical hit, reset the player's attack and the enemy's defense to their base values
	ld c, DEFENSE_STAT
	call GetEnemyMonStat
	call ApplyDefReductions2		; in case of critical hit, apply defense modifier to target only if it's advantageous for the attacker
	push bc
	ld hl, wPartyMon1Attack
	ld a, [wPlayerMonNumber]
	ld bc, wPartyMon2 - wPartyMon1
	call AddNTimes
	call ApplyAttackMods			; in case of critical hit, apply attack modifier to attacker only if it's advantageous for them
	pop bc
	jr .scaleStats
.specialAttack
	ld bc, wEnemyMonSpecialDefense		; opponent special defense
	ld a, [wPlayerMoveEffect]
	cp PSYSHOCK_EFFECT
	jr nz, .loadAttackingStat
	ld bc, wEnemyMonDefense				; if move effect is PSYSHOCK_EFFECT, use defender's physical defense instead of special defense
.loadAttackingStat
	ld hl, wBattleMonSpecialAttack
	ld a, [hli]
	ld l, [hl]
	ld h, a								; *HL = attacker attack
	ld a, [wEnemyLightScreenCounter]	; check the counter instead of the flag
	and a								; if the counter is not zero, then double enemy's special
	jr z, .specialAttackCritCheck
; if the enemy has used Light Screen, halve the player's special
	srl h								; halve player's special attack instead of doubling enemy's special defense
	rr l								; halve player's special attack instead of doubling enemy's special defense
.specialAttackCritCheck
	ld a, [wCriticalHitOrOHKO]
	and a								; check for critical hit
	jr z, .loadDefensiveStat
; in the case of a critical hit, reset the player's and enemy's specials to their base values
	ld a, [wPlayerMoveEffect]
	cp PSYSHOCK_EFFECT
	jr nz, .loadUnmodifiedSpecialDefense
	ld c, DEFENSE_STAT					; if move effect is PSYSHOCK_EFFECT, use physical defense instead of special defense
	call GetEnemyMonStat
	call ApplyDefReductions2			; in case of critical hit, apply defense modifier to target only if it's advantageous for the attacker
	jr .loadUnmodifiedSpecialAttack
.loadUnmodifiedSpecialDefense
	ld c, SPECIAL_DEFENSE_STAT
	call GetEnemyMonStat
	call ApplySpecialReductions2	; in case of critical hit, apply special modifier to target only if it's advantageous for the attacker
.loadUnmodifiedSpecialAttack
	push bc
	ld hl, wPartyMon1SpecialAttack
	ld a, [wPlayerMonNumber]
	ld bc, wPartyMon2 - wPartyMon1
	call AddNTimes
	call ApplySpecialBoosts			; in case of critical hit, apply special modifier to attacker only if it's advantageous for them
	pop bc
	jr .scaleStats					; defensive stat is already loaded, so skip that part
.loadDefensiveStat
	ld a, [bc]						; at this point bc points to defense
	inc bc
	ld e, a
	ld a, [bc]
	ld c, a
	ld b, e							; bc is now defense value
; if either the offensive or defensive stat is too large to store in a byte, scale both stats by dividing them by 4
; this allows values with up to 10 bits (values up to 1023) to be handled
; anything larger will wrap around
.scaleStats
	ld a, b
	or h							; is either attack or defense high byte nonzero?
	jr z, .minimumAttack			; if not, we don't need to scale
; bc /= 4 (scale enemy's defensive stat)
	srl b
	rr c
	srl b
	rr c
; hl /= 4 (scale player's offensive stat)
	srl h
	rr l
	srl h
	rr l
.minimumAttack
	ld b, l						; *B = attack [possibly scaled] [C contains defense]
	ld a, b
	and a
	jr nz, .minimumDefense
	inc b						; if attack is zero, set it to 1
.minimumDefense
	ld a, c
	and a
	jr nz, .applyCriticalHit
	inc c						; if defense is zero, set it to one
.applyCriticalHit
	ld a, [wBattleMonLevel]
	ld e, a							; e = level
	ld a, [wCriticalHitOrOHKO]
	and a							; check for critical hit
	jr z, .done
	ld a, e							; put level in a
	srl e							; halve level
	add e							; add level/2 to level
	ld e, a							; put 1.5*level in e (critical hits now do *1.5 damage instead of double damage)
.done
	or $1
	ret

; sets b, c, d, and e for the CalculateDamage routine in the case of an attack by the enemy mon
GetDamageVarsForEnemyAttack:
	ld hl, wDamage ; damage to eventually inflict, initialise to zero
	xor a
	ld [hli], a
	ld [hl], a
	ld hl, wEnemyMovePower
	ld a, [hli]
	ld d, a 				; d = move power
	and a
	ret z 					; return if move power is zero
	ld a, [wEnemyMoveExtra]	; add this part to distinguish between physical and special moves based on move properties instead of type
	bit IS_SPECIAL_MOVE, a	; add this part to distinguish between physical and special moves based on move properties instead of type
	jr nz, .specialAttack	; add this part to distinguish between physical and special moves based on move properties instead of type
.physicalAttack
	ld bc, wBattleMonDefense
	ld hl, wEnemyMonAttack
	ld a, [hli]
	ld l, [hl]
	ld h, a							; hl now holds enemy attack
	ld a, [wPlayerReflectCounter]	; check the counter instead of the flag
	and a							; if the counter is not zero, halve the enemy's attack
	jr z, .physicalAttackCritCheck
	srl h							; halve enemy attack instead of doubling player defense
	rr l							; halve enemy attack instead of doubling player defense
.physicalAttackCritCheck
	ld a, [wCriticalHitOrOHKO]
	and a							; check for critical hit
	jr z, .loadDefensiveStat
; in the case of a critical hit, reset the player's defense and the enemy's attack to their base values
	ld hl, wPartyMon1Defense
	ld a, [wPlayerMonNumber]
	ld bc, wPartyMon2 - wPartyMon1
	call AddNTimes
	call ApplyDefReductions			; in case of critical hit, apply defense modifier to target only if it's advantageous for the attacker
	push bc
	ld c, ATTACK_STAT
	call GetEnemyMonStat
	call ApplyAttackMods2			; in case of critical hit, apply attack modifiers to attacker only if it's advantageous for them
	pop bc
	jr .scaleStats
.specialAttack
	ld bc, wBattleMonSpecialDefense
	ld a, [wEnemyMoveEffect]
	cp PSYSHOCK_EFFECT
	jr nz, .loadAttackingStat
	ld bc, wBattleMonDefense			; if move effect is PSYSHOCK_EFFECT, use defender's physical defense instead of special defense
.loadAttackingStat
	ld hl, wEnemyMonSpecialAttack
	ld a, [hli]
	ld l, [hl]
	ld h, a								; hl now holds the enemy's special
	ld a, [wPlayerLightScreenCounter]	; check the counter instead of the flag
	and a								; if the counter is not zero, halve the enemy's special
	jr z, .specialAttackCritCheck
	srl h								; halve the enemy's special instead of doubling the player's special
	rr l								; halve the enemy's special instead of doubling the player's special
.specialAttackCritCheck
	ld a, [wCriticalHitOrOHKO]
	and a								; check for critical hit
	jr z, .loadDefensiveStat
; in the case of a critical hit, reset the player's and enemy's specials to their base values
	ld bc, wPartyMon2 - wPartyMon1
	ld a, [wPlayerMoveEffect]
	cp PSYSHOCK_EFFECT
	ld a, [wPlayerMonNumber]
	jr nz, .loadUnmodifiedSpecialDefense
	ld hl, wPartyMon1Defense
	call AddNTimes
	call ApplyDefReductions			; in case of critical hit, apply defense modifier to target only if it's advantageous for the attacker
	jr .loadUnmodifiedSpecialAttack
.loadUnmodifiedSpecialDefense
	ld hl, wPartyMon1SpecialDefense
	call AddNTimes
	call ApplySpecialReductions		 ; in case of critical hit, apply special modifier to target only if it's advantageous for the attacker
.loadUnmodifiedSpecialAttack
	push bc
	ld c, SPECIAL_ATTACK_STAT
	call GetEnemyMonStat
	call ApplySpecialBoosts2		; in case of critical hit, apply special modifiers to attacker only if it's advantageous for them
	pop bc
	jr .scaleStats					; defensive stat is already loaded, so skip that part
.loadDefensiveStat
	ld a, [bc]		; at this point bc points to defense or special according to attack category
	inc bc
	ld e, a
	ld a, [bc]
	ld c, a
	ld b, e			; bc is now defense or special value
; if either the offensive or defensive stat is too large to store in a byte, scale both stats by dividing them by 4
; this allows values with up to 10 bits (values up to 1023) to be handled
; anything larger will wrap around
.scaleStats
	ld a, b
	or h							; is either attack or defense high byte nonzero?
	jr z, .minimumAttack			; if not, we don't need to scale
; bc /= 4 (scale player's defensive stat)
	srl b
	rr c
	srl b
	rr c
; hl /= 4 (scale enemy's offensive stat)
	srl h
	rr l
	srl h
	rr l
.minimumAttack					; make attack at least one
	ld b, l						; *B = attack [possibly scaled] [C contains defense]
	ld a, b
	and a
	jr nz, .minimumDefense
	inc b						; if attack is zero, set it to one
.minimumDefense					; make defense at least one
	ld a, c
	and a
	jr nz, .applyCriticalHit
	inc c						; if defense is zero, set it to one
.applyCriticalHit
	ld a, [wEnemyMonLevel]
	ld e, a
	ld a, [wCriticalHitOrOHKO]
	and a					; check for critical hit
	jr z, .done
	sla e					; double level if it was a critical hit
.done
	or $1					; simplified from "ld a, $1; and a; and a;"
	ret

; get stat c of enemy mon
; c: stat to get (HP=1,Attack=2,Defense=3,Speed=4,Special Attack=5, Special Defense=6)
GetEnemyMonStat:
	push de
	push bc
	ld a, [wLinkState]
	cp LINK_STATE_BATTLING
	jr nz, .notLinkBattle
	ld hl, wEnemyMon1Stats
	dec c
	sla c
	ld b, $0
	add hl, bc
	ld a, [wEnemyMonPartyPos]
	ld bc, wEnemyMon2 - wEnemyMon1
	call AddNTimes
	ld a, [hli]
	ld [H_MULTIPLICAND + 1], a
	ld a, [hl]
	ld [H_MULTIPLICAND + 2], a
	pop bc
	pop de
	ret
.notLinkBattle
	ld a, [wEnemyMonLevel]
	ld [wCurEnemyLVL], a
	ld a, [wEnemyMonSpecies]
	ld [wMonSpeciesTemp], a			; to handle 2 bytes species IDs
	ld a, [wEnemyMonSpecies + 1]	; to handle 2 bytes species IDs
	ld [wMonSpeciesTemp + 1], a		; to handle 2 bytes species IDs
	call GetMonHeader
	ld hl, wEnemyMonDVs
	ld de, wLoadedMonDVs
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de							; add this for the new DV for special defense
	ld a, [hl]						; add this for the new DV for special defense
	ld [de], a						; add this for the new DV for special defense
	pop bc
	ld b, $0
	ld hl, wLoadedMonHPEV - 1
	call CalcStat
	pop de
	ret

CalculateDamage:
; input:
;   b: attack
;   c: opponent defense
;   d: base power
;   e: level
; output:
;	sets z flag if damage is zero, unsets it otherwise

	ld a, [H_WHOSETURN] ; whose turn?
	and a
	ld a, [wPlayerMoveEffect]
	jr z, .effect
	ld a, [wEnemyMoveEffect]
.effect
	cp OHKO_EFFECT			; check if it's an OHKO move
	jr nz, .notOHKO
	ld a, $ff				; if it is, max the damage
	ld [wDamage], a
	ld [wDamage+1], a
	and a					; this is just to unset the z flag before returning
	ret
.notOHKO
; Don't calculate damage for moves that don't do any.
	ld a, d ; base power
	and a
	ret z
.skipbp
	xor a
	ld hl, H_DIVIDEND
	ldi [hl], a
	ldi [hl], a
	ld [hl], a
; Multiply level by 2
	ld a, e ; level
	add a
	jr nc, .nc
	push af
	ld a, 1
	ld [hl], a
	pop af
.nc
	inc hl
	ldi [hl], a

; Divide by 5
	ld a, 5
	ldd [hl], a
	push bc
	ld b, 4
	call Divide
	pop bc

; Add 2
	inc [hl]
	inc [hl]

	inc hl ; multiplier

; Multiply by attack base power
	ld [hl], d
	call Multiply

; Multiply by attack stat
	ld [hl], b
	call Multiply

; Divide by defender's defense stat
	ld [hl], c
	ld b, 4
	call Divide

; Divide by 50
	ld [hl], 50
	ld b, 4
	call Divide

	ld hl, wDamage
	ld b, [hl]
	ld a, [H_QUOTIENT + 3]
	add b
	ld [H_QUOTIENT + 3], a
	jr nc, .asm_3dfd0

	ld a, [H_QUOTIENT + 2]
	inc a
	ld [H_QUOTIENT + 2], a
	and a
	jr z, .asm_3e004

.asm_3dfd0
	ld a, [H_QUOTIENT]
	ld b, a
	ld a, [H_QUOTIENT + 1]
	or a
	jr nz, .asm_3e004

	ld a, [H_QUOTIENT + 2]
	cp 998 / $100
	jr c, .asm_3dfe8
	cp 998 / $100 + 1
	jr nc, .asm_3e004
	ld a, [H_QUOTIENT + 3]
	cp 998 % $100
	jr nc, .asm_3e004

.asm_3dfe8
	inc hl
	ld a, [H_QUOTIENT + 3]
	ld b, [hl]
	add b
	ld [hld], a

	ld a, [H_QUOTIENT + 2]
	ld b, [hl]
	adc b
	ld [hl], a
	jr c, .asm_3e004

	ld a, [hl]
	cp 998 / $100
	jr c, .asm_3e00a
	cp 998 / $100 + 1
	jr nc, .asm_3e004
	inc hl
	ld a, [hld]
	cp 998 % $100
	jr c, .asm_3e00a

.asm_3e004
; cap at 997
	ld a, 997 / $100
	ld [hli], a
	ld a, 997 % $100
	ld [hld], a

.asm_3e00a
; add 2
	inc hl
	ld a, [hl]
	add 2
	ld [hld], a
	jr nc, .done
	inc [hl]

.done
	ld a, 1
	and a
	ret

; determines if attack is a critical hit
CriticalHitTest:
	jpab CriticalHitTest_

; function to determine if Counter hits and if so, how much damage it does
; output: set z flag if move effect is COUNTER_EFFECT, unsets it otherwise
HandleCounterMove:
	ld a, [H_WHOSETURN]
	and a
; player's turn
	ld hl, wEnemyMoveExtra
	ld bc, wPlayerMoveExtra
	ld de, wEnemyMovePower
	ld a, [wPlayerMoveEffect]
	jr z, .next
; enemy's turn
	ld hl, wPlayerMoveExtra
	ld bc, wEnemyMoveExtra
	ld de, wPlayerMovePower
	ld a, [wEnemyMoveEffect]
.next
	cp COUNTER_EFFECT				; use a move effect ID instead of a move ID
	ret nz							; return if not using a counter move
	ld a, $01
	ld [wMoveMissed], a				; initialize the move missed variable to true (it is set to false below if the move hits)
	ld a, [de]
	and a
	ret z													; miss if the opponent's last selected move's Base Power is 0.
	call CheckSubstitute									; checks whether damage was done to a Susbtitute
	ret z													; if yes, miss
	ld a, [hl]												; check if user's move category is the same as the enemy's
	and ((1 << IS_SPECIAL_MOVE) | (1 << IS_STATUS_MOVE))
	ld d, a
	ld a, [bc]
	and ((1 << IS_SPECIAL_MOVE) | (1 << IS_STATUS_MOVE))
	xor d													; if both moves don't have the same category, xor gives non-zero result
	jr z, .counterableType
	xor a
	ret
.counterableType
	call ApplyImmunities	; check if target is immune, if it is, wDamage is set to zero
	ld hl, wDamage
	ld a, [hli]
	or [hl]
	ret z
; if it did damage, double it
	ld a, [hl]
	add a
	ldd [hl], a
	ld a, [hl]
	adc a
	ld [hl], a
	jr nc, .noCarry
; damage is capped at 0xFFFF
	ld a, $ff
	ld [hli], a
	ld [hl], a
.noCarry
	xor a
	ld [wMoveMissed], a
.moveHitTest
	call MoveHitTest ; do the normal move hit test in addition to Counter's special rules
	xor a
	ret

ApplyAttackToEnemyPokemon:
	ld a, [wPlayerMoveEffect]
	cp OHKO_EFFECT
	jr z, ApplyDamageToEnemyPokemon
	cp SUPER_FANG_EFFECT
	jr z, .superFangEffect
	cp LEVEL_DAMAGE_EFFECT
	jr z, .levelDamage
	cp FIXED_DAMAGE_EFFECT
	jr z, .fixedDamage
	cp PSYWAVE_EFFECT
	jr z, .psywaveDamage
	ld a, [wPlayerMovePower]
	and a
	jp z, ApplyAttackToEnemyPokemonDone ; no attack to apply if base power is 0
	jr ApplyDamageToEnemyPokemon
.superFangEffect
; set the damage to half the target's HP
	ld de, wDamage
	ld a, [wEnemyBattleStatus2]		; if player has a substitute
	bit HAS_SUBSTITUTE_UP, a		; use substitute HP to compute damage
	ld hl, wEnemyMonHP
	jr z, .halveHP
	ld hl, wEnemySubstituteHP
	inc de
	ld b, 0
	xor a							; this is to unset the carry flag for next rr operation
	jr .hasSubstitute
.halveHP
	ld a, [hli]
	srl a
	ld [de], a
	inc de
	ld b, a
.hasSubstitute
	ld a, [hl]
	rr a
	ld [de], a
	or b
	jr nz, ApplyDamageToEnemyPokemon
; make sure Super Fang's damage is always at least 1
	ld a, $01
	ld [de], a
	jr ApplyDamageToEnemyPokemon
.levelDamage
	ld hl, wBattleMonLevel
	ld a, [hl]
	ld b, a						; b = attacker level
	jr .storeDamage
.fixedDamage
	ld a, [wPlayerMovePower]	; fixed damage moves now do damage equal to move power
	ld b, a
	jr .storeDamage
.psywaveDamage
	ld hl, wBattleMonLevel
	call PsywaveDamage			; updated formula (fixes the infinite loop)
.storeDamage					; store damage value at b
	ld hl, wDamage
	xor a
	ld [hli], a
	ld a, b
	ld [hl], a

ApplyDamageToEnemyPokemon:
	ld hl, wDamage
	ld a, [hli]
	ld b, a
	ld a, [hl]
	or b
	jr z, ApplyAttackToEnemyPokemonDone ; we're done if damage is 0
	ld a, [wEnemyBattleStatus2]
	bit HAS_SUBSTITUTE_UP, a			; does the enemy have a substitute?
	jr z, .noSubstitute
	callab AttackSubstitute_
	jr ApplyAttackToEnemyPokemonDone
.noSubstitute
; subtract the damage from the pokemon's current HP
; also, save the current HP at wHPBarOldHP
	ld hl, wNewBattleFlags
	res SUBSTITUTE_TOOK_DAMAGE, [hl]	; as soon as a move hits the enemy, reset flag indicating a sub took damage
	call UpdateBideDamage
ApplyDamageToEnemyPokemon_main:
	call CheckDefrost					; check if the move defrosts the enemy
	ld hl, wDamage + 1
	ld a, [hld]
	ld b, a
	ld a, [wEnemyMonHP + 1]
	ld [wHPBarOldHP], a
	sub b
	ld [wEnemyMonHP + 1], a
	ld a, [hl]
	ld b, a
	ld a, [wEnemyMonHP]
	ld [wHPBarOldHP+1], a
	sbc b
	ld [wEnemyMonHP], a
	jr nc, .animateHpBar
; if more damage was done than the current HP, zero the HP and set the damage (wDamage)
; equal to how much HP the pokemon had before the attack
	ld a, [wHPBarOldHP+1]
	ld [hli], a
	ld a, [wHPBarOldHP]
	ld [hl], a
	xor a
	ld hl, wEnemyMonHP
	ld [hli], a
	ld [hl], a
.animateHpBar
	ld hl, wEnemyMonMaxHP
	ld a, [hli]
	ld [wHPBarMaxHP+1], a
	ld a, [hl]
	ld [wHPBarMaxHP], a
	ld hl, wEnemyMonHP
	ld a, [hli]
	ld [wHPBarNewHP+1], a
	ld a, [hl]
	ld [wHPBarNewHP], a
	coord hl, 2, 2
	xor a
	ld [wHPBarType], a
	predef UpdateHPBar2 ; animate the HP bar shortening
ApplyAttackToEnemyPokemonDone:
	jp DrawEnemyHUDAndHPBar			; prevent the HUD from displaying when the player mon is fainted

ApplyAttackToPlayerPokemon:
	ld a, [wEnemyMoveEffect]
	cp OHKO_EFFECT
	jr z, ApplyDamageToPlayerPokemon
	cp SUPER_FANG_EFFECT
	jr z, .superFangEffect
	cp LEVEL_DAMAGE_EFFECT
	jr z, .levelDamage
	cp FIXED_DAMAGE_EFFECT
	jr z, .fixedDamage
	cp PSYWAVE_EFFECT
	jr z, .psywaveDamage
	ld a, [wEnemyMovePower]
	and a
	jp z, ApplyAttackToPlayerPokemonDone
	jr ApplyDamageToPlayerPokemon
.superFangEffect
; set the damage to half the target's HP
	ld de, wDamage					; moved before the fork
	ld a, [wPlayerBattleStatus2]	; if player has a substitute
	bit HAS_SUBSTITUTE_UP, a		; use substitute HP to compute damage
	ld hl, wBattleMonHP
	jr z, .halveHP
	ld hl, wPlayerSubstituteHP
	inc de
	ld b, 0
	xor a							; this is to unset the carry flag for next rr operation
	jr .hasSubstitute
.halveHP
	ld a, [hli]
	srl a
	ld [de], a
	inc de
	ld b, a
.hasSubstitute
	ld a, [hl]
	rr a
	ld [de], a
	or b
	jr nz, ApplyDamageToPlayerPokemon
; make sure Super Fang's damage is always at least 1
	ld a, $01
	ld [de], a
	jr ApplyDamageToPlayerPokemon
.levelDamage
	ld hl, wEnemyMonLevel
	ld a, [hl]
	ld b, a
	jr .storeDamage
.fixedDamage
	ld a, [wEnemyMovePower]
	ld b, a
	jr .storeDamage
.psywaveDamage
	ld hl, wEnemyMonLevel
	call PsywaveDamage			; updated formula
.storeDamage
	ld hl, wDamage
	xor a
	ld [hli], a
	ld a, b
	ld [hl], a

ApplyDamageToPlayerPokemon:
	ld hl, wDamage
	ld a, [hli]
	ld b, a
	ld a, [hl]
	or b
	jr z, ApplyAttackToPlayerPokemonDone ; we're done if damage is 0
	ld a, [wPlayerBattleStatus2]
	bit HAS_SUBSTITUTE_UP, a ; does the player have a substitute?
	jr z, .noSubstitute
	callab AttackSubstitute_
	jr ApplyAttackToPlayerPokemonDone
.noSubstitute
; subtract the damage from the pokemon's current HP
; also, save the current HP at wHPBarOldHP and the new HP at wHPBarNewHP
	ld hl, wNewBattleFlags
	res SUBSTITUTE_TOOK_DAMAGE, [hl]	; as soon as a move hits the player, reset flag indicating a sub took damage
	call UpdateBideDamage
ApplyDamageToPlayerPokemon_main:
	call CheckDefrost					; check if the move defrosts the player
	ld hl, wDamage + 1
	ld a, [hld]
	ld b, a
	ld a, [wBattleMonHP + 1]
	ld [wHPBarOldHP], a
	sub b
	ld [wBattleMonHP + 1], a
	ld [wHPBarNewHP], a
	ld b, [hl]
	ld a, [wBattleMonHP]
	ld [wHPBarOldHP+1], a
	sbc b
	ld [wBattleMonHP], a
	ld [wHPBarNewHP+1], a
	jr nc, .animateHpBar
; if more damage was done than the current HP, zero the HP and set the damage (wDamage)
; equal to how much HP the pokemon had before the attack
	ld a, [wHPBarOldHP+1]
	ld [hli], a
	ld a, [wHPBarOldHP]
	ld [hl], a
	xor a
	ld hl, wBattleMonHP
	ld [hli], a
	ld [hl], a
	ld hl, wHPBarNewHP
	ld [hli], a
	ld [hl], a
.animateHpBar
	ld hl, wBattleMonMaxHP
	ld a, [hli]
	ld [wHPBarMaxHP+1], a
	ld a, [hl]
	ld [wHPBarMaxHP], a
	coord hl, 10, 9
	ld a, $01
	ld [wHPBarType], a
	predef UpdateHPBar2 ; animate the HP bar shortening
ApplyAttackToPlayerPokemonDone:
	jp DrawPlayerHUDAndHPBar			; prevents the HUD from being displayed when the enemy mon is fainted

; this function mutualizes the damage calculation for Psywave
; input: attacker level in hl
; output: damage in b
PsywaveDamage:
	ld a, [hl]
	ld b, a
	srl a
	ld c, a						; c = level * 0.5
	add b
	ld b, a
	inc b						; b = (level * 1.5) + 1
.loop							; loop until a random number in the range [c, b[ is found
	call BattleRandom
	cp c
	jr c, .loop
	cp b
	jr nc, .loop
	and a
	jr nz, .atLeastOneDamage
	inc a
.atLeastOneDamage
	ld b, a
	ret
	
; this function raises the attack modifier of a pokemon using Rage when that pokemon is attacked
HandleBuildingRage:
; values for the player turn
	ld hl, wEnemyBattleStatus2
	ld de, wEnemyMonStatMods
	ld bc, wEnemyMoveNum
	ld a, [H_WHOSETURN]
	and a
	jr z, .next
; values for the enemy turn
	ld hl, wPlayerBattleStatus2
	ld de, wPlayerMonStatMods
	ld bc, wPlayerMoveNum
.next
	bit USING_RAGE, [hl]				; is the pokemon being attacked under the effect of Rage?
	ret z								; return if not
	ld a, [wMoveMissed]					; add a check to see if the move actually hit
	and a
	ret nz								; if the move missed, don't build Rage
	ld hl, wNewBattleFlags
	bit SUBSTITUTE_TOOK_DAMAGE, [hl]
	ret nz								; if damage was done to a substitute, don't build Rage
	ld a, [de]
	cp STAT_MODIFIER_PLUS_6
	ret z								; return if attack modifier is already maxed
	ld a, [H_WHOSETURN]
	xor $01								; flip turn for the stat modifier raising function
	ld [H_WHOSETURN], a
; temporarily change the target pokemon's move to $00 and the effect to the one
; that causes the attack modifier to go up one stage
	ld h, b
	ld l, c
	ld [hl], $00 ; null move number
	inc hl
	ld [hl], ATTACK_UP1_EFFECT
	push hl
	ld hl, BuildingRageText
	call PrintText
	call StatModifierUpEffect ; stat modifier raising function
	pop hl
	xor a
	ldd [hl], a ; null move effect
	ld a, RAGE
	ld [hl], a ; restore the target pokemon's move number to Rage
	ld a, [H_WHOSETURN]
	xor $01 ; flip turn back to the way it was
	ld [H_WHOSETURN], a
	ret

BuildingRageText:
	TX_FAR _BuildingRageText
	db "@"

; copy last move for Mirror Move
; sets zero flag on failure and unsets zero flag on success
MirrorMoveCopyMove:
	call CheckIfTargetIsThere				; check if target is still alive
	jr z, .mirrorMoveFailed
	ld a, [H_WHOSETURN]
	and a
; values for player turn
	ld a, [wPlayerLastAttackReceived]
	ld hl, wPlayerSelectedMove
	ld de, wPlayerMoveNum
	ld bc, wEnemyMonSpecies
	jr z, .next
; values for enemy turn
	ld a, [wEnemyLastAttackReceived]
	ld de, wEnemyMoveNum
	ld hl, wEnemySelectedMove
	ld bc, wBattleMonSpecies
.next
	ld [hl], a
	and a									; has the target selected any move yet?
	jr z, .mirrorMoveFailed
	push af									; save copied move id
	push hl
	ld hl, wNewBattleFlags
	ld a, [H_WHOSETURN]
	and a
	jr z, .playersTurn
	bit ENEMY_SIGNATURE_MOVE, [hl]
	jr z, .next2
	set USING_SIGNATURE_MOVE, [hl]
	jr .next2
.playersTurn
	bit PLAYER_SIGNATURE_MOVE, [hl]
	jr z, .next2
	set USING_SIGNATURE_MOVE, [hl]
.next2
	pop hl
	ld a, [bc]
	ld [wMonSpeciesTemp], a
	inc bc
	ld a, [bc]
	ld [wMonSpeciesTemp + 1], a
	pop af
	push af
	call ReloadMoveData						; signature move id mapping is done here
	pop af									; restore copied move id
	cp SIGNATURE_MOVE_1
	jr z, .signatureMove
	cp SIGNATURE_MOVE_2
	ret nz
.signatureMove								; if the copied move was a signature move, set the
	ld hl, wNewBattleFlags					; corresponding bit to avoid mapping the move id a second time
	set USING_SIGNATURE_MOVE, [hl]
	ld a, $01
	and a									; makes this function unset the z flag
	ret										; when Mirror Move succeeds
.mirrorMoveFailed
	ld hl, MirrorMoveFailedText
	call PrintText
	xor a
	ret

MirrorMoveFailedText:
	TX_FAR _MirrorMoveFailedText
	db "@"

; input : move id in a
; output : z flag is set if move is a signature move, reset otherwise
CheckForSignatureMove:
	ld hl, wNewBattleFlags
	bit USING_SIGNATURE_MOVE, [hl]		; if it's a signature move whose id was already mapped
	jr nz, .signatureMove
	cp SIGNATURE_MOVE_1
	ret z
	cp SIGNATURE_MOVE_2
	ret z
	push bc
	push de
	ld d, a
	ld hl, wPlayerMimicSlot
	ld bc, wPlayerMoveListIndex
	ld a, [H_WHOSETURN]
	and a
	jr z, .next
	ld hl, wEnemyMimicSlot
	ld bc, wEnemyMoveListIndex
.next
	ld a, [bc]
	inc a
	ld b, a
	ld a, [hl]
	cp b
	ld a, d
	pop de
	pop bc
	ret
.signatureMove
	xor a
	ret

; mutualize this part of ReloadMoveData
ReadMoveData:
	ld [wd11e], a
	call CheckForSignatureMove
	jr nz, .notSignatureMove
	jpab ReadSignatureMoveDataInBattle
.notSignatureMove
	dec a
	ld hl, Moves
	ld bc, MoveEnd - Moves
	call AddNTimes
	ld a, BANK(Moves)
	call FarCopyData ; copy the move's stats
.afterReadMove
; the follow two function calls are used to reload the move name
	call GetMoveName
	call CopyStringToCF4B
	ret

; function used to reload move data for Mirror Move and Metronome
ReloadMoveData:
	ld [wd11e], a						; put move id in wd11e for GetMoveName
.gotMoveId:
	call CheckForSignatureMove
	jr nz, .notSignatureMove
	callab ReadSignatureMoveData		; for Mirror Move and Metronome, we only need to get the mapped move id
	call ReadMoveData.afterReadMove		; get the move name
	jr .incrementPP
.notSignatureMove
	call ReadMoveData.notSignatureMove
.incrementPP
	jpab IncrementMovePP

; function that picks a random move for metronome
MetronomePickMove:
	xor a
	ld [wAnimationType], a
	ld a, METRONOME
	call PlayMoveAnimation		; play Metronome's animation
	callab _MetronomePickMove
	ld a, [wd11e]				; get result of previous function in a
	jr ReloadMoveData.gotMoveId

; function to adjust the base damage of an attack to account for type effectiveness
AdjustDamageForMoveType:
; values for player turn
	ld hl, wBattleMonType
	ld a, [hli]
	ld b, a    ; b = type 1 of attacker
	ld c, [hl] ; c = type 2 of attacker
	ld hl, wEnemyMonType
	ld a, [hli]
	ld d, a    ; d = type 1 of defender
	ld e, [hl] ; e = type 2 of defender
	ld a, [wPlayerMoveType]
	ld [wMoveType], a
	ld a, [H_WHOSETURN]
	and a
	jr z, .next
; values for enemy turn
	ld hl, wEnemyMonType
	ld a, [hli]
	ld b, a    ; b = type 1 of attacker
	ld c, [hl] ; c = type 2 of attacker
	ld hl, wBattleMonType
	ld a, [hli]
	ld d, a    ; d = type 1 of defender
	ld e, [hl] ; e = type 2 of defender
	ld a, [wEnemyMoveType]
	ld [wMoveType], a
.next
	ld a, [wMoveType]
	cp b ; does the move type match type 1 of the attacker?
	jr z, .sameTypeAttackBonus
	cp c ; does the move type match type 2 of the attacker?
	jr z, .sameTypeAttackBonus
	jr .skipSameTypeAttackBonus
.sameTypeAttackBonus
; if the move type matches one of the attacker's types
	ld hl, wDamage + 1
	ld a, [hld]
	ld h, [hl]
	ld l, a    ; hl = damage
	ld b, h
	ld c, l    ; bc = damage
	srl b
	rr c      ; bc = floor(0.5 * damage)
	add hl, bc ; hl = floor(1.5 * damage)
; store damage
	ld a, h
	ld [wDamage], a
	ld a, l
	ld [wDamage + 1], a
.skipSameTypeAttackBonus
	ld a, NEUTRAL
	ld [wDamageMultipliers], a				; reinitialize effectiveness
	ld a, [wMoveType]
	ld b, a
	ld hl, TypeEffects
.loop
	ld a, [hli]						; a = "attacking type" of the current type pair
	cp $ff
	jr z, .done
	cp b							; does move type match "attacking type"?
	jr nz, .nextTypePair
	ld a, [hl]						; a = "defending type" of the current type pair
	cp d							; does type 1 of defender match "defending type"?
	jr z, .matchingPairFound
	cp e							; does type 2 of defender match "defending type"?
	jr z, .matchingPairFound
	jr .nextTypePair
.matchingPairFound
; if the move type matches the "attacking type" and one of the defender's types matches the "defending type"
	push hl
	push bc
	inc hl
	ld a, [hl] 					; a = damage multiplier for the current type relation
	ld bc, wDamageMultipliers
	call UpdateMultiplier
.skipTypeImmunity
	pop bc
	pop hl
.nextTypePair
	inc hl
	inc hl
	jr .loop
.done
	ld hl, wDamage				; once the global multiplier has been computed in the loop, load it in a
	ld a, [wDamageMultipliers]
	and a
	jr z, .noEffect				; if multiplier is zero, zero the damage
	cp NEUTRAL					; compare multiplier to neutral damage
	ret z						; if neutral damage, don't modify the damage
	ld d, a						; save multiplier in d
	ld a, [hli]					; put base damage in bc
	ld b, a						; put base damage in bc
	ld a, [hld]					; put base damage in bc and make hl point back to low byte of base damage
	ld c, a						; put base damage in bc
	ld a, d						; restore multiplier in a
	jr nc, .superEffective
.notVeryEffective
	call ApplyResistance
	jr .updateDamage
.superEffective
	call ApplyWeakness
	jr .updateDamage
.noEffect
	ld bc, $0000
	ld a, $1
	ld [wMoveMissed], a
.updateDamage
	ld [hl], b
	inc hl
	ld [hl], c
	ret

; function to apply type resistance to damage
ApplyResistance:
	srl b							; halve the damage
	rr c							; halve the damage
	cp NOT_VERY_EFFECTIVE			; compare multiplier to NOT_VERY_EFFECTIVE to check if it's x0.5 or x0.25
	jr nc, .checkMinimumDamage		; if multiplier isn't lower than NOT_VERY_EFFECTIVE, means it's x0.5 damage, so skip the next part
	srl b							; else means it's x0.25 damage, so halve the damage again
	rr c
.checkMinimumDamage
	ld a, c
	or b
	ret nz
	ld c, $1						; damage is at least 1 after type multipliers
	ret

; function to apply type weakness to damage
ApplyWeakness:
	sla c						; double damage
	rl b						; double damage
	cp DOUBLE_WEAKNESS			; is it quadruple damage?
	ret c						; if carry, means multiplier is only x2, so skip next part
	sla c						; if no carry, means it's x4 damage, so double it again
	rl b
	ret

; function to tell how effective the type of an enemy attack is on the player's current pokemon
; (e.g. 4x weakness / resistance, weaknesses and resistances canceling)
; the result is stored in [wTypeEffectiveness]
; as far is can tell, this is only used once in some AI code to help decide which move to use
AIGetTypeEffectiveness:
	ld a, [wEnemyMoveType]
	ld d, a                    ; d = type of enemy move
	ld hl, wBattleMonType
	ld b, [hl]                 ; b = type 1 of player's pokemon
	inc hl
	ld c, [hl]                 ; c = type 2 of player's pokemon
	ld a, NEUTRAL
	ld [wTypeEffectiveness], a ; initialize to neutral effectiveness
	ld hl, TypeEffects
.loop
	ld a, [hli]
	cp $ff
	ret z
	cp d                      ; match the type of the move
	jr nz, .nextTypePair1
	ld a, [hli]
	cp b                      ; match with type 1 of pokemon
	jr z, .matchingPairFound
	cp c                      ; or match with type 2 of pokemon
	jr z, .matchingPairFound
	jr .nextTypePair2
.nextTypePair1
	inc hl
.nextTypePair2
	inc hl
	jr .loop
.matchingPairFound
	ld a, [hl]
	push bc						; add this to take both types into account
	ld bc, wTypeEffectiveness	; address of the total multiplier that will be updated by the next function call
	call UpdateMultiplier		; add this to take both types into account
	pop bc						; add this to take both types into account
	jr .nextTypePair2			; add this to take both types into account

; this function updates the damage multiplier stored in bc according to
; the value of the current type relation stored in a
; INPUT
; a: multiplier for this type relation
; bc: address of the variable holding the total multiplier value
; OUTPUT
; bc: variable in bc will be updated according to multiplier value in a
UpdateMultiplier:
	and a
	jr z, .noEffect
	cp NEUTRAL
	ld a, [bc]
	jr nc, .superEffective
	srl a					; if current type relation is not very effective, halve total multiplier
	jr .updateMultiplier
.superEffective:
	sla a					; if current type relation is super effective, double total multiplier
	jr .updateMultiplier
.noEffect:
	xor a					; if current type relation is an immunity, zero the total multiplier
.updateMultiplier:
	ld [bc], a
	ret
	
; function that puts zero in W_DAMAGE if the defender is immune to the move's type
; leaves it unchanged otherwise
ApplyImmunities:
	ld a, NEUTRAL
	ld [wDamageMultipliers], a	; initialize damage multiplier to NEUTRAL in case target isn't immune
; values for player turn
	ld hl, wEnemyMonType
	ld a, [hli]
	ld d, a						; d = type 1 of defender
	ld e, [hl]					; e = type 2 of defender
	ld a, [H_WHOSETURN]
	and a
	ld a, [wPlayerMoveType]
	jr z, .next
; values for enemy turn
	ld hl, wBattleMonType
	ld a, [hli]
	ld d, a						; d = type 1 of defender
	ld e, [hl]					; e = type 2 of defender
	ld a, [wEnemyMoveType]
.next
	ld b, a						; put attacker move type in b
	ld hl, TypeEffects
.loop
	ld a, [hli] 				; a = "attacking type" of the current type pair
	cp a, $ff
	jr z, .done
	cp b 						; does move type match "attacking type"?
	jr nz, .nextTypePair
	ld a, [hl] 					; a = "defending type" of the current type pair
	cp d 						; does type 1 of defender match "defending type"?
	jr z, .matchingPairFound
	cp e 						; does type 2 of defender match "defending type"?
	jr z, .matchingPairFound
.nextTypePair
	inc hl
	inc hl
	jr .loop
.matchingPairFound
	inc hl
	ld a, [hli]					; load multiplier for the current pair in a then move hl to attacking type of the next pair
	and a
	jr nz, .loop				; if multiplier is not null, continue the loop
	ld hl, wDamage				; else zero the damage
	ld [hli], a					; a is necessarily zero at this point
	ld [hl], a
	ld [wDamageMultipliers], a	; put zero in type matchup multiplier to have the correct failure message
	inc a
	ld [wMoveMissed], a			; put 1 in W_MOVEMISSED so that the game detects the immunity
.done
	ret
	
INCLUDE "data/type_effects.asm"

; some tests that need to pass for a move to hit
; moved out of bank F
MoveHitTest:
	jpab _MoveHitTest

; multiplies damage by a random percentage from ~85% to 100%
; moved out of bank F
RandomizeDamage:
	jpab _RandomizeDamage

; for more detailed commentary, see equivalent function for player side (ExecutePlayerMove)
ExecuteEnemyMove:
	ld hl, wNewBattleFlags
	res USING_SIGNATURE_MOVE, [hl]
	ld a, [wEnemySelectedMove]
	inc a
	jp z, ExecuteEnemyMoveDone
	call PrintGhostText
	jp z, ExecuteEnemyMoveDone
	ld a, [wLinkState]
	cp LINK_STATE_BATTLING
	jr nz, .executeEnemyMove
	ld b, $1
	ld a, [wSerialExchangeNybbleReceiveData]
	cp LINKBATTLE_STRUGGLE
	jr z, .executeEnemyMove
	cp 4
	ret nc
.executeEnemyMove
	xor a
	ld [wMoveMissed], a
	ld [wMoveDidntMiss], a
	call CheckEnemyStatusConditions
	jr nz, .enemyHasNoSpecialConditions
	jp hl
.enemyHasNoSpecialConditions
	ld a, [wEnemyMimicSlot]
	ld b, a
	ld a, [wEnemyMoveListIndex]
	inc a
	cp b
	jr nz, .afterMimicTest
	ld hl, wNewBattleFlags
	set USING_SIGNATURE_MOVE, [hl]
	set ENEMY_SIGNATURE_MOVE, [hl]
.afterMimicTest
	call GetCurrentMove
	ld hl, wEnemyBattleStatus1
	bit CHARGING_UP, [hl] ; is the enemy charging up for attack?
	jr nz, EnemyCanExecuteChargingMove ; if so, jump

CheckIfEnemyNeedsToChargeUp:
	ld a, [wEnemyMoveEffect]
	cp CHARGE_EFFECT
	jp z, ChargeEffect				; jump directly to the handler for charging moves
	cp INVULNERABLE_EFFECT
	jp z, ChargeEffect				; jump directly to the handler for charging moves
	cp SKY_ATTACK_EFFECT
	jp z, ChargeEffect				; jump directly to the handler for charging moves
	cp SKULL_BASH_EFFECT
	jp z, ChargeEffect				; jump directly to the handler for charging moves
	jr EnemyCanExecuteMove
EnemyCanExecuteChargingMove:
	ld hl, wEnemyBattleStatus1
	res CHARGING_UP, [hl] ; no longer charging up for attack
	res INVULNERABLE, [hl] ; no longer invulnerable to typical attacks
	ld a, [wEnemyMoveNum]
	ld [wd11e], a
	call GetEnemyMoveName					; to handle signature moves
	ld de, wcd6d
	call CopyStringToCF4B
EnemyCanExecuteMove:
	xor a
	ld [wMonIsDisobedient], a
	call PrintMonName1Text
	ld hl, DecrementPP
	ld de, wEnemySelectedMove				; pointer to the move just used
	ld b, BANK(DecrementPP)
	call Bankswitch							; decrement enemy PP
	ld a, [wEnemyMoveListIndex]				; get the move index in the moveset
	ld [wEnemyLastMoveListIndex], a			; store it in the variable holding the last used move index
	callab StorePlayerLastAttackReceived	; store the ID of the move used by the enemy in the player's memory
	ld a, [wEnemyMoveEffect]
	ld hl, ResidualEffects1
	ld de, $1
	call IsInArray
	jr nc, .notInResidualEffects1	; zero the damage when enemy uses a non-damaging move (so that Bide has the correct damage count)
	call GetDamageVarsForEnemyAttack; zero the damage when enemy uses a non-damaging move (so that Bide has the correct damage count)
	jp JumpMoveEffect
.notInResidualEffects1:
	ld a, [wEnemyMoveEffect]
	cp THRASH_PETAL_DANCE_EFFECT	; since this effect is now the only one in SpecialEffectsCont, just test it directly
	call z, JumpMoveEffect			; execute the effect of moves like Thrash but don't skip anything
EnemyMoveHitTest:
	call MoveHitTest				; moved from after call RandomizeDamage
EnemyDamageCalculation:
	call SwapPlayerAndEnemyLevels
	call HandleCounterMove			; move this here from after call CriticalHitTest to avoid testing for critical hits with Counter
	jr z, handleIfEnemyMoveMissed	; move this here from after call CriticalHitTest to avoid testing for critical hits with Counter
	ld a, [wEnemyMoveEffect]
	ld hl, SetDamageEffects
	ld de, $1
	call IsInArray
	jr nc, .damageCalculation		; if move effect isn't in SetDamageEffects array, jump
	call ApplyImmunities			; apply type immunities only (not weaknesses or resistances)
	jp handleIfEnemyMoveMissed		; effects in SetDamageEffects skip normal damage calculation
.damageCalculation
	call MoveAttributesModifications
	call CriticalHitTest
	call SwapPlayerAndEnemyLevels
	call GetDamageVarsForEnemyAttack
	call SwapPlayerAndEnemyLevels
	call CalculateDamage
	jp z, EnemyCheckIfFlyOrChargeEffect
	call AdjustDamageForMoveType
	call RandomizeDamage
	call ApplyOtherModificators		; general function to apply damage modifications that apply to final damage value

handleIfEnemyMoveMissed:
	ld a, [wMoveMissed]
	and a
	jr z, .moveDidNotMiss
	ld a, [wEnemyMoveEffect]
	cp EXPLODE_EFFECT
	jr z, handleExplosionMiss
	jr EnemyCheckIfFlyOrChargeEffect
.moveDidNotMiss
	call SwapPlayerAndEnemyLevels

GetEnemyAnimationType:
	ld a, [wEnemyMoveEffect]
	and a
	ld a, $1
	jr z, playEnemyMoveAnimation
	ld a, $2
	jr playEnemyMoveAnimation
handleExplosionMiss:
	call SwapPlayerAndEnemyLevels
	xor a
playEnemyMoveAnimation:
	ld [wAnimationType], a
	ld a, [wEnemyMoveNum]
	call PlayMoveAnimation
	call HandleExplodingAnimation
	call DrawEnemyHUDAndHPBar
	jr EnemyCheckIfMirrorMoveEffect

EnemyCheckIfFlyOrChargeEffect:
	call SwapPlayerAndEnemyLevels
	ld c, 30
	call DelayFrames
	ld a, [wEnemyMoveEffect]
	cp INVULNERABLE_EFFECT
	jr z, .playAnim
	cp CHARGE_EFFECT
	jr z, .playAnim
	cp SKY_ATTACK_EFFECT
	jr z, .playAnim
	cp SKULL_BASH_EFFECT
	jr z, .playAnim
	jr EnemyCheckIfMirrorMoveEffect
.playAnim
	xor a
	ld [wAnimationType], a
	ld a, STATUS_AFFECTED_ANIM
	call PlaySpecialAnimation
EnemyCheckIfMirrorMoveEffect:
	ld a, [wEnemyMoveEffect]
	cp MIRROR_MOVE_EFFECT
	jr nz, .notMirrorMoveEffect
	call MirrorMoveCopyMove
	jp z, ExecuteEnemyMoveDone
	jp CheckIfEnemyNeedsToChargeUp
.notMirrorMoveEffect
	cp METRONOME_EFFECT
	jr nz, .notMetronomeEffect
	call MetronomePickMove
	jp CheckIfEnemyNeedsToChargeUp
.notMetronomeEffect
	ld a, [wEnemyMoveEffect]
	ld hl, ResidualEffects2
	ld de, $1
	call IsInArray
	jp c, JumpMoveEffect
	ld a, [wMoveMissed]
	and a
	jr z, .moveDidNotMiss
	call PrintMoveFailureText
	ld a, [wEnemyMoveEffect]
	cp EXPLODE_EFFECT
	jr z, .handleExplosionMiss
	ld a, [wEnemyNumAttacksLeft]
	dec a
	jr z, .lastThrashingTurn		; if it was the last turn of thrashing move, don't disrupt it
	ld hl, wEnemyBattleStatus1
	res THRASHING_ABOUT, [hl]		; if move missed, disrupt thrashing moves
.lastThrashingTurn
	jp ExecuteEnemyMoveDone
.moveDidNotMiss
	call ApplyAttackToPlayerPokemon
	call PrintCriticalOHKOText
	callab DisplayEffectiveness
	ld a, 1
	ld [wMoveDidntMiss], a
.handleExplosionMiss
	ld a, [wEnemyMoveEffect]
	ld hl, AlwaysHappenSideEffects
	ld de, $1
	call IsInArray
	call c, JumpMoveEffect
	ld a, [wMoveMissed]
	and a							; in case of suicide move miss, don't check the target's HP
	jp nz, ExecuteEnemyMoveDone
	ld hl, wBattleMonHP
	ld a, [hli]
	ld b, [hl]
	or b
	jr nz, .targetNotFainted
	call ExecuteEnemyMoveDone		; if the target fainted, still decrement thrash counter
	ld b, 0							; have to reset b to zero for the KO to register (b is set to 1 in ExecuteEnemyMoveDone)
	ret								; if the target fainted, don't do anything else
.targetNotFainted
	call HandleBuildingRage
	ld hl, wEnemyBattleStatus1
	bit ATTACKING_MULTIPLE_TIMES, [hl] ; is mon hitting multiple times? (example: double kick)
	jr z, .notMultiHitMove
	push hl
	ld hl, wEnemyNumAttacksLeft
	dec [hl]
	pop hl
	jp nz, EnemyDamageCalculation		; jump a bit further back to recalculate the damage and critical hit chance for each individual hit
	res ATTACKING_MULTIPLE_TIMES, [hl]	; mon is no longer hitting multiple times
	ld hl, HitXTimesText
	call PrintText
	xor a
	ld [wEnemyNumHits], a
.notMultiHitMove
	ld a, [wEnemyMoveEffect]
	and a
	jr z, ExecuteEnemyMoveDone
	ld hl, SpecialEffects
	ld de, $1
	call IsInArray
	call nc, JumpMoveEffect
	jr ExecuteEnemyMoveDone

HitXTimesText:
	TX_FAR _HitXTimesText
	db "@"

ExecuteEnemyMoveDone:
	ld hl, wEnemyBattleStatus1
	bit THRASHING_ABOUT, [hl]
	jr z, .notThrashingAbout
	ld hl, wEnemyNumAttacksLeft
	dec [hl]							; did Thrashing About counter hit 0?
	jp nz, .notThrashingAbout
	ld hl, wEnemyBattleStatus1
	res THRASHING_ABOUT, [hl]			; mon is no longer using thrash or petal dance
	bit CONFUSED, [hl]
	jr nz, .notThrashingAbout			; if the mon is already confused, don't reconfuse it
	set CONFUSED, [hl]					; mon is now confused
	call BattleRandom
	and 3
	inc a
	inc a								; confused for 2-5 turns
	ld [wEnemyConfusedCounter], a
	xor a
	ld [wAnimationType], a
	ld a, CONFUSED_ENEMY
	call PlaySpecialAnimation
	ld hl, ConfusedDueToFatigueText
	call PrintText
.notThrashingAbout
	ld b, $1
	ret

; checks for various status conditions affecting the enemy mon
; stores whether the mon cannot use a move this turn in Z flag
CheckEnemyStatusConditions:
	ld hl, wEnemyMonStatus
	ld a, [hl]
	and SLP						; sleep mask
	jr z, .checkIfFrozen
	dec a						; decrement number of turns left
	ld [wEnemyMonStatus], a
	and a
	jr nz, .FastAsleep
	ld hl, WokeUpText			; add this to allow the enemy to attack on the turn they wake up
	call PrintText				; add this to allow the enemy to attack on the turn they wake up
	call DrawEnemyHUDAndHPBar	; redraw enemy's status
	jr .checkIfFlinched			; add this to allow the enemy to attack on the turn they wake up
.FastAsleep:
	ld hl, FastAsleepText
	call PrintText
	xor a
	ld [wAnimationType], a
	ld a, SLP_ANIM
	call PlaySpecialAnimation
.sleepDone
	xor a
	ld [wEnemyUsedMove], a
	ld hl, ExecuteEnemyMoveDone ; enemy can't move this turn
	jp .enemyReturnToHL
.checkIfFrozen
	bit FRZ, [hl]
	jr z, .checkIfFlinched
	call ThawingOutChance		; this function checks whether the pokemon thaws out and clears its status if it does
								; it sets the z flag if the pokemon thaws out, unsets it otherwise
	jr z, .checkIfFlinched		; if enemy thaws out, jump to next check
	xor a
	ld [wEnemyUsedMove], a
	ld hl, ExecuteEnemyMoveDone ; enemy can't move this turn
	jp .enemyReturnToHL
.checkIfFlinched
	ld hl, wEnemyBattleStatus1
	bit FLINCHED, [hl] ; check if enemy mon flinched
	jp z, .checkIfMustRecharge
	res FLINCHED, [hl]
	res THRASHING_ABOUT, [hl]	; disrupt thrashing moves
	inc hl
	res NEEDS_TO_RECHARGE, [hl] ; clear "must recharge" flag
	ld hl, FlinchedText
	call PrintText
	ld hl, ExecuteEnemyMoveDone ; enemy can't move this turn
	jp .enemyReturnToHL
.checkIfMustRecharge
	ld hl, wEnemyBattleStatus2
	bit NEEDS_TO_RECHARGE, [hl] ; check if enemy mon has to recharge after using a move
	jr z, .checkIfAnyMoveDisabled
	res NEEDS_TO_RECHARGE, [hl]
	ld hl, MustRechargeText
	call PrintText
	ld hl, ExecuteEnemyMoveDone ; enemy can't move this turn
	jp .enemyReturnToHL
.checkIfAnyMoveDisabled
	ld hl, wEnemyDisabledMove
	ld a, [hl]
	and a
	jr z, .checkIfConfused
	dec a ; decrement disable counter
	ld [hl], a
	and $f ; did disable counter hit 0?
	jr nz, .checkIfConfused
	ld [hl], a
	ld [wEnemyDisabledMoveNumber], a
	ld hl, DisabledNoMoreText
	call PrintText
.checkIfConfused
	ld a, [wEnemyBattleStatus1]
	add a ; check if enemy mon is confused
	jp nc, .checkIfTriedToUseDisabledMove
	ld hl, wEnemyConfusedCounter
	dec [hl]
	jr nz, .isConfused
	ld hl, wEnemyBattleStatus1
	res CONFUSED, [hl] ; if confused counter hit 0, reset confusion status
	ld hl, ConfusedNoMoreText
	call PrintText
	jp .checkIfTriedToUseDisabledMove
.isConfused
	ld hl, IsConfusedText
	call PrintText
	xor a
	ld [wAnimationType], a
	ld a, CONFUSED_ENEMY
	call PlaySpecialAnimation
	call BattleRandom
	cp TWO_OUT_OF_THREE
	jr c, .checkIfTriedToUseDisabledMove
	ld hl, wEnemyBattleStatus1
	ld a, [hl]
	and ((1 << CONFUSED) | (1 << USING_TRAPPING_MOVE)) ; added USING_TRAPPING_MOVE to preserve when a mon hits itself
	ld [hl], a
	ld hl, HurtItselfText
	call PrintText
	ld hl, wBattleMonDefense
	ld a, [hli]
	push af
	ld a, [hld]
	push af
	ld a, [wEnemyMonDefense]
	ld [hli], a
	ld a, [wEnemyMonDefense + 1]
	ld [hl], a
	ld hl, wEnemyMoveEffect
	push hl
	ld a, [hl]
	push af
	xor a
	ld [hli], a
	ld [wCriticalHitOrOHKO], a
	ld a, 40
	ld [hli], a
	ld a, TYPELESS					; make self-confusion damage typeless instead of normal
	ld [hli], a						; replaced ld [hl] with ld [hli]
	inc hl							; skip accuracy
	inc hl							; skip PP
	ld [hl], (PRIORITY_NORMAL << 4)|(NOT_SOUND_BASED << 3)|(CONTACT << 2)|(CATEGORY_STATUS)	; set wEnemyMoveExtra so that the pseudo move has normal priority and is considered a status move so that Counter or Mirror Coat can't counter it and that physical stats get used to calculate damage
	call GetDamageVarsForEnemyAttack
	call CalculateDamage
	pop af
	pop hl
	ld [hl], a
	ld hl, wBattleMonDefense + 1
	pop af
	ld [hld], a
	pop af
	ld [hl], a
	xor a
	ld [wAnimationType], a
	ld [H_WHOSETURN], a
	ld a, POUND
	call PlayMoveAnimation
	call ApplyDamageToEnemyPokemon_main	; moved this here instead of after reverting the turn back to normal
										; so that when the enemy hurts itself, it damages its own substitute if it has one
	ld a, $1
	ld [H_WHOSETURN], a
	jr .monHurtItselfOrFullyParalysed
.checkIfTriedToUseDisabledMove
; prevents a disabled move that was selected before being disabled from being used
	ld a, [wEnemyDisabledMoveNumber]
	and a
	jr z, .checkIfParalysed
	ld hl, wEnemySelectedMove
	cp [hl]
	jr nz, .checkIfParalysed
	call PrintMoveIsDisabledText
	ld hl, ExecuteEnemyMoveDone ; if a disabled move was somehow selected, player can't move this turn
	jp .enemyReturnToHL
.checkIfParalysed
	ld hl, wEnemyMonStatus
	bit PAR, [hl]
	jr z, .checkIfUsingBide
	call BattleRandom
	cp TWENTY_FIVE_PERCENT+1
	jr nc, .checkIfUsingBide
	ld hl, FullyParalyzedText
	call PrintText
.monHurtItselfOrFullyParalysed
	ld hl, wEnemyBattleStatus1
	ld a, [hl]
	; clear bide, thrashing about, charging up, invulnerable
	and $ff ^ ((1 << STORING_ENERGY) | (1 << THRASHING_ABOUT) | (1 << CHARGING_UP) | (1 << INVULNERABLE))
	; added INVULNERABLE to correct the bug of mid-Fly or mid-Dig paralysis making the Pokémon invulnerable indefinitely
	; removed USING_TRAPPING_MOVE to let trapping effect continue even when the mon using it loses a turn to paralysis
	ld [hl], a
	ld a, [wEnemyMoveEffect]
	cp INVULNERABLE_EFFECT
	jr z, .flyOrChargeEffect
	cp CHARGE_EFFECT
	jr z, .flyOrChargeEffect
	cp SKY_ATTACK_EFFECT
	jr z, .flyOrChargeEffect
	cp SKULL_BASH_EFFECT
	jr z, .flyOrChargeEffect
	jr .notFlyOrChargeEffect
.flyOrChargeEffect
	xor a
	ld [wAnimationType], a
	ld a, STATUS_AFFECTED_ANIM
	call PlaySpecialAnimation
.notFlyOrChargeEffect
	ld hl, ExecuteEnemyMoveDone
	jp .enemyReturnToHL ; if using a two-turn move, enemy needs to recharge the first turn
.checkIfUsingBide
	ld hl, wEnemyBattleStatus1
	bit STORING_ENERGY, [hl] ; is mon using bide?
	jr z, .checkIfThrashingAbout
	xor a
	ld [wEnemyMoveNum], a
	ld hl, wEnemyBidingTurnsLeft
	dec [hl] ; did Bide counter hit 0?
	jr z, .unleashEnergy
	ld hl, StoringEnergyText		; display text saying the pokemon is storing energy
	call PrintText					; display text saying the pokemon is storing energy
	ld hl, ExecuteEnemyMoveDone
	jp .enemyReturnToHL ; unless mon unleashes energy, can't move this turn
.unleashEnergy
	ld hl, wEnemyBattleStatus1
	res STORING_ENERGY, [hl] ; not using bide any more
	ld hl, UnleashedEnergyText
	call PrintText
	ld a, $1
	ld [wEnemyMovePower], a
	ld hl, wEnemyBideAccumulatedDamage + 1
	ld a, [hld]
	add a
	ld b, a
	ld [wDamage + 1], a
	ld a, [hl]
	rl a ; double the damage
	ld [wDamage], a
	or b
	jr nz, .next
	ld a, $1
	ld [wMoveMissed], a
.next
	push hl
	call ApplyImmunities			; make Bide ineffective against Ghost types
	pop hl
	xor a
	ld [hli], a
	ld [hl], a
	ld a, BIDE
	ld [wEnemyMoveNum], a
	call SwapPlayerAndEnemyLevels
	ld hl, handleIfEnemyMoveMissed			; skip damage calculation, DecrementPP and MoveHitTest
	jp .enemyReturnToHL
.checkIfThrashingAbout
	bit THRASHING_ABOUT, [hl]				; is mon using thrash or petal dance?
	jr z, .checkIfUsingRage
	ld hl, ThrashingAboutText
	call PrintText
	ld hl, EnemyMoveHitTest					; skip DecrementPP
	jp .enemyReturnToHL
.checkIfUsingRage
	ld a, [wEnemyMoveEffect]
	cp RAGE_EFFECT							; test if move effect = Rage
	jp z, .checkEnemyStatusConditionsDone	; if so, don't reset the Rage flag
	ld hl, wEnemyBattleStatus2
	res USING_RAGE, [hl]					; reset the Rage flag
	jp .checkEnemyStatusConditionsDone
.enemyReturnToHL
	xor a ; set Z flag
	ret
.checkEnemyStatusConditionsDone
	ld a, $1
	and a ; clear Z flag
	ret

ConfusedDueToFatigueText:
	TX_FAR _ConfusedDueToFatigueText
	db "@"

GetCurrentMove:
	ld de, wPlayerMoveNum
	ld a, [H_WHOSETURN]
	and a
	ld a, [wPlayerSelectedMove]
	jr z, .next
	ld de, wEnemyMoveNum
	ld a, [wEnemySelectedMove]
.next
	jp ReadMoveData

LoadEnemyMonData:
	ld a, [wLinkState]
	cp LINK_STATE_BATTLING
	jp z, LoadEnemyMonFromParty
	ld a, [wIsInBattle]
	cp BATTLE_STATE_TRAINER			; is it a trainer battle?
	jr nz, .next
	call LoadEnemyMonFromParty
	jp .loadBaseEXP
.next
	ld a, [wEnemyMonSpecies2]
	ld [wMonSpeciesTemp], a
	ld [wEnemyMonSpecies], a		; to handle 2 bytes species IDs
	ld a, [wEnemyMonSpecies2 + 1]
	ld [wMonSpeciesTemp + 1], a
	ld [wEnemyMonSpecies + 1], a
	call GetMonHeader
	call GetMonCatchRate			; get the catch rate now since wMonSpeciesTemp/wMonSpeciesTemp + 1 are already set
	ld a, [wEnemyBattleStatus3]
	bit TRANSFORMED, a ; is enemy mon transformed?
	ld hl, wTransformedEnemyMonOriginalDVs ; original DVs before transforming
	ld a, [hli]
	ld b, [hl]
	inc hl					; add this for the new DV for special defense
	ld c, [hl]				; add this for the new DV for special defense
	jr nz, .storeDVs
; random DVs for wild mon
	call BattleRandom
	ld b, a
	call BattleRandom
	ld c, a					; add this for the new DV for special defense
	call BattleRandom		; add this for the new DV for special defense
.storeDVs
	ld hl, wEnemyMonDVs
	ld [hli], a
	ld [hl], b
	inc hl					; add this for the new DV for special defense
	ld [hl], c				; add this for the new DV for special defense
	callab LegendaryDVs		; add this to give legendaries/mythicals at least 3 maxed DVs
	ld de, wEnemyMonLevel
	ld a, [wCurEnemyLVL]
	ld [de], a
	inc de
	ld b, 0
	ld hl, wEnemyMonHP
	push hl
	call CalcStats
	pop hl
	ld a, [wEnemyBattleStatus3]
	bit TRANSFORMED, a ; is enemy mon transformed?
	jr nz, .copyTypes ; if transformed, jump
; if it's a wild mon and not transformed, init the current HP to max HP and the status to 0
	ld a, [wEnemyMonMaxHP]
	ld [hli], a
	ld a, [wEnemyMonMaxHP+1]
	ld [hli], a
	xor a
	inc hl
	ld [hl], a ; init status to 0
.copyTypes
	ld hl, wMonHTypes
	ld de, wEnemyMonType
	ld a, [hli]            ; copy type 1
	ld [de], a
	inc de
	ld a, [hli]            ; copy type 2
	ld [de], a
	inc de
; for a wild mon, first copy default moves from the mon header
	ld hl, wMonHMoves
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	dec de
	dec de
	dec de
	xor a
	ld [wLearningMovesFromDayCare], a
	predef WriteMonMoves ; get moves based on current level
.loadMovePPs
	ld hl, wEnemyMonMoves
	ld de, wEnemyMonPP - 1
	predef LoadMovePPs
	ld hl, wMonHBaseStats
	ld de, wEnemyMonBaseStats
	ld b, NUM_STATS
.copyBaseStatsLoop
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .copyBaseStatsLoop
.loadBaseEXP
	ld hl, wMonHBaseEXP
	inc de					; skip catch rate byte since it's already been set earlier with GetMonCatchRate
	ld a, [hl]				; base exp
	ld [de], a
	call GetMonName			; wMonSpeciesTemp/wMonSpeciesTemp + 1 are already set
	ld hl, wcd6d
	ld de, wEnemyMonNick
	ld bc, NAME_LENGTH
	call CopyData
	ld a, [wBattleType]
	cp BATTLE_TYPE_FACILITY					; pokemon seen in the Battle Facility are not registered in the dex
	jr z, .skipAddToPokedexSeen
	callab AddToPokedexSeenBySpeciesID		; wMonSpeciesTemp/wMonSpeciesTemp + 1 are already set
.skipAddToPokedexSeen
	ld hl, wEnemyMonLevel
	ld de, wEnemyMonUnmodifiedLevel
	ld bc, 1 + NUM_STATS * 2
	call CopyData
	ld a, STAT_MODIFIER_DEFAULT ; default stat mod
	ld b, NUM_STAT_MODS ; number of stat mods
	ld hl, wEnemyMonStatMods
.statModLoop
	ld [hli], a
	dec b
	jr nz, .statModLoop
	ret

; calls BattleTransition to show the battle transition animation and initializes some battle variables
DoBattleTransitionAndInitBattleVariables:
	ld a, [wLinkState]
	cp LINK_STATE_BATTLING
	jr nz, .next
; link battle
	xor a
	ld [wMenuJoypadPollCount], a
	ld b, SET_PAL_LINK_START					; add this to make the pokeballs red in the Link battle versus screen
	call RunPaletteCommand						; add this to make the pokeballs red in the Link battle versus screen
	callab DisplayLinkBattleVersusTextBox
	ld a, $1
	ld [wUpdateSpritesEnabled], a
	call ClearScreen
	ld b, SET_PAL_OVERWORLD						; add this to make the battle transition black
	call RunPaletteCommand						; add this to make the battle transition black
.next
	call DelayFrame
	predef BattleTransition
	callab LoadHudAndHpBarAndStatusTilePatterns
	ld a, $1
	ld [H_AUTOBGTRANSFERENABLED], a
	ld a, $ff
	ld [wUpdateSpritesEnabled], a
	call ClearSprites
	call ClearScreen
	xor a
	ld [H_AUTOBGTRANSFERENABLED], a
	ld [hWY], a
	ld [rWY], a
	ld [hTilesetType], a
	ld hl, wPlayerMimicSlot
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld [wPlayerDisabledMove], a
	ret

; swaps the level values of the BattleMon and EnemyMon structs
SwapPlayerAndEnemyLevels:
	push bc
	ld a, [wBattleMonLevel]
	ld b, a
	ld a, [wEnemyMonLevel]
	ld [wBattleMonLevel], a
	ld a, b
	ld [wEnemyMonLevel], a
	pop bc
	ret

; loads either red back pic or old man back pic
; also writes OAM data and loads tile patterns for the Red or Old Man back sprite's head
; (for use when scrolling the player sprite and enemy's silhouettes on screen)
LoadPlayerBackPic:
	ld a, [wBattleType]
	cp BATTLE_TYPE_OLD_MAN	; is it the old man tutorial?
	ld de, RedPicBack
	jr nz, .next
	ld de, OldManPic
.next
	ld a, BANK(RedPicBack)
	call UncompressSpriteFromDE
	predef ScaleSpriteByTwo
	ld hl, wOAMBuffer
	xor a
	ld [hOAMTile], a ; initial tile number
	ld b, $7 ; 7 columns
	ld e, $a0 ; X for the left-most column
.loop ; each loop iteration writes 3 OAM entries in a vertical column
	ld c, $3 ; 3 tiles per column
	ld d, $38 ; Y for the top of each column
.innerLoop ; each loop iteration writes 1 OAM entry in the column
	ld [hl], d ; OAM Y
	inc hl
	ld [hl], e ; OAM X
	ld a, $8 ; height of tile
	add d ; increase Y by height of tile
	ld d, a
	inc hl
	ld a, [hOAMTile]
	ld [hli], a ; OAM tile number
	inc a ; increment tile number
	ld [hOAMTile], a
	inc hl
	dec c
	jr nz, .innerLoop
	ld a, [hOAMTile]
	add $4 ; increase tile number by 4
	ld [hOAMTile], a
	ld a, $8 ; width of tile
	add e ; increase X by width of tile
	ld e, a
	dec b
	jr nz, .loop
	ld de, vBackPic
	call InterlaceMergeSpriteBuffers
	ld a, $a
	ld [$0], a
	xor a
	ld [$4000], a
	ld hl, vSprites
	ld de, sSpriteBuffer1
	ld a, [H_LOADEDROMBANK]
	ld b, a
	ld c, 7 * 7
	call CopyVideoData
	xor a
	ld [$0], a
	ld a, $31
	ld [hStartTileID], a
	coord hl, 1, 5
	predef_jump CopyUncompressedPicToTilemap

ScrollTrainerPicAfterBattle:
	jpab _ScrollTrainerPicAfterBattle

ApplyBurnAndParalysisPenaltiesToPlayer:
	ld a, $1
	jr ApplyBurnAndParalysisPenalties

ApplyBurnAndParalysisPenaltiesToEnemy:
	xor a

ApplyBurnAndParalysisPenalties:
	ld [H_WHOSETURN], a
ApplyBurnAndParalysisPenaltiesToCurrentTarget:
	call QuarterSpeedDueToParalysis
	jp HalveAttackDueToBurn

QuarterSpeedDueToParalysis:
	push bc
	callab QuarterSpeedDueToParalysis_
	pop bc
	ret

HalveAttackDueToBurn:
	push bc
	callab HalveAttackDueToBurn_
	pop bc
	ret

CalculateModifiedStats:
	ld c, 0
.loop
	call CalculateModifiedStat
	inc c
	ld a, c
	cp NUM_STATS - 1
	jr nz, .loop
	ret

; calculate modified stat for stat c (0 = attack, 1 = defense, 2 = speed, 3 = special)
CalculateModifiedStat:
	push bc
	push bc
	ld a, [wCalculateWhoseStats]
	and a
	ld a, c
	ld hl, wBattleMonAttack
	ld de, wPlayerMonUnmodifiedAttack
	ld bc, wPlayerMonStatMods
	jr z, .next
	ld hl, wEnemyMonAttack
	ld de, wEnemyMonUnmodifiedAttack
	ld bc, wEnemyMonStatMods
.next
	add c
	ld c, a
	jr nc, .noCarry1
	inc b
.noCarry1
	ld a, [bc]
	pop bc
	ld b, a
	push bc
	sla c
	ld b, 0
	add hl, bc
	ld a, c
	add e
	ld e, a
	jr nc, .noCarry2
	inc d
.noCarry2
	pop bc
	push hl
	ld hl, StatModifierRatios
	dec b
	sla b
	ld c, b
	ld b, 0
	add hl, bc
	xor a
	ld [H_MULTIPLICAND], a
	ld a, [de]
	ld [H_MULTIPLICAND + 1], a
	inc de
	ld a, [de]
	ld [H_MULTIPLICAND + 2], a
	ld a, [hli]
	ld [H_MULTIPLIER], a
	call Multiply
	ld a, [hl]
	ld [H_DIVISOR], a
	ld b, $4
	call Divide
	pop hl
	ld a, [H_DIVIDEND + 3]
	sub 999 % $100
	ld a, [H_DIVIDEND + 2]
	sbc 999 / $100
	jp c, .storeNewStatValue
; cap the stat at 999
	ld a, 999 / $100
	ld [H_DIVIDEND + 2], a
	ld a, 999 % $100
	ld [H_DIVIDEND + 3], a
.storeNewStatValue
	ld a, [H_DIVIDEND + 2]
	ld [hli], a
	ld b, a
	ld a, [H_DIVIDEND + 3]
	ld [hl], a
	or b
	jr nz, .done
	inc [hl] ; if the stat is 0, bump it up to 1
.done
	pop bc
	ret

ApplyBadgeStatBoosts:
	ld a, [wLinkState]
	cp LINK_STATE_BATTLING
	ret z ; return if link battle
	ld a, [wBattleType]
	cp BATTLE_TYPE_FACILITY
	ret z							; return if Battle Facility battle
	ld a, [wObtainedBadges]
	ld b, a
	ld hl, wBattleMonAttack			; instead of looping over the stats in the order they appear in RAM,
	bit BOULDER_BADGE, b			; check for each stat a specific badge bit so that the order
	call nz, ApplyBoostToStat		; of badges doesn't correlate with the order of stat boosts
	ld hl, wBattleMonSpeed			; This allows to fix the badge boosts (Thunder badge boosts Speed
	bit THUNDER_BADGE, b			; like it was supposed to, and Soul badge boosts Defense)
	call nz, ApplyBoostToStat
	ld hl, wBattleMonDefense
	bit SOUL_BADGE, b
	call nz, ApplyBoostToStat
	ld hl, wBattleMonSpecialAttack
	bit VOLCANO_BADGE, b
	call nz, ApplyBoostToStat
	ld hl, wBattleMonSpecialDefense
	bit VOLCANO_BADGE, b
	call nz, ApplyBoostToStat
	ret

; multiply stat at hl by 1.125
; cap stat at 999
ApplyBoostToStat:
	ld a, [hli]
	ld d, a
	ld e, [hl]
	srl d
	rr e
	srl d
	rr e
	srl d
	rr e
	ld a, [hl]
	add e
	ld [hld], a
	ld a, [hl]
	adc d
	ld [hli], a
	ld a, [hld]
	sub 999 % $100
	ld a, [hl]
	sbc 999 / $100
	ret c
	ld a, 999 / $100
	ld [hli], a
	ld a, 999 % $100
	ld [hld], a
	ret

LoadHudAndHpBarAndStatusTilePatterns:
	call LoadHpBarAndStatusTilePatterns

LoadHudTilePatterns:
	ld a, [rLCDC]
	add a ; is LCD disabled?
	jr c, .lcdEnabled
.lcdDisabled
	ld hl, BattleHudTiles1
	ld de, vChars2 + $6d0
	ld bc, BattleHudTiles1End - BattleHudTiles1
	ld a, BANK(BattleHudTiles1)
	call FarCopyDataDouble
	ld hl, BattleHudTiles2
	ld de, vChars2 + $730
	ld bc, BattleHudTiles3End - BattleHudTiles2
	ld a, BANK(BattleHudTiles2)
	jp FarCopyDataDouble
.lcdEnabled
	ld de, BattleHudTiles1
	ld hl, vChars2 + $6d0
	lb bc, BANK(BattleHudTiles1), (BattleHudTiles1End - BattleHudTiles1) / $8
	call CopyVideoDataDouble
	ld de, BattleHudTiles2
	ld hl, vChars2 + $730
	lb bc, BANK(BattleHudTiles2), (BattleHudTiles3End - BattleHudTiles2) / $8
	jp CopyVideoDataDouble

PrintEmptyString:
	ld hl, .emptyString
	jp PrintText
.emptyString
	db "@"


HandleExplodingAnimation:
	ld a, [H_WHOSETURN]
	and a
	ld hl, wEnemyMonType1
	ld de, wEnemyBattleStatus1
	ld a, [wPlayerMoveNum]
	jr z, .player
	ld hl, wBattleMonType1
	ld de, wEnemyBattleStatus1
	ld a, [wEnemyMoveNum]
.player
	cp SELFDESTRUCT
	jr z, .isExplodingMove
	cp EXPLOSION
	ret nz
.isExplodingMove
	ld a, [de]
	bit INVULNERABLE, a ; fly/dig
	ret nz
	ld a, [hli]
	cp GHOST
	ret z
	ld a, [hl]
	cp GHOST
	ret z
	ld a, [wMoveMissed]
	and a
	ret nz
	ld a, 5
	ld [wAnimationType], a

; Renamed from PlayMoveAnimation
; now only used for animations such as Sleep, Poison or other things that are not moves
PlaySpecialAnimation:
	ld [wAnimationID], a
	call Delay3
	predef_jump MoveAnimation

; Added this function to handle move animations
; animations for things other than moves are handled by PlaySpecialAnimation
; old moves still use the same bank as before, new moves use the new bank
PlayMoveAnimation:
	ld [wAnimationID], a
	ld hl, wNewBattleFlags
	bit USING_SIGNATURE_MOVE, [hl]
	jr nz, .signatureMove
	cp SIGNATURE_MOVE_1
	jr nz, .notSignatureMove1
.signatureMove
	call Delay3
	jpab SignatureMoveAnimation
.notSignatureMove1
	cp SIGNATURE_MOVE_2
	jr z, .signatureMove
	cp STRUGGLE + 1
	jr c, .oldMove
	jpab MoveAnimation_2
.oldMove
	call Delay3
	predef_jump MoveAnimation
	
InitBattle:
	ld a, [wCurOpponent]
	ld b, a							; to handle 2 bytes species IDs
	ld a, [wCurOpponent + 1]
	or b
	jr z, DetermineWildOpponent

InitOpponent:
	ld a, [wCurOpponent]			; to handle 2 bytes species IDs
	ld [wEnemyMonSpecies2], a		; to handle 2 bytes species IDs
	ld a, [wCurOpponent + 1]		; to handle 2 bytes species IDs
	ld [wEnemyMonSpecies2 + 1], a	; to handle 2 bytes species IDs
	jr InitBattleCommon

DetermineWildOpponent:
	ld a, [wd732]
	bit 1, a
	jr z, .asm_3ef2f
	ld a, [hJoyHeld]
	bit 1, a ; B button pressed?
	ret nz
.asm_3ef2f
	ld a, [wNumberOfNoRandomBattleStepsLeft]
	and a
	ret nz
	callab TryDoWildEncounter
	ret nz
InitBattleCommon:
	ld a, [wMapPalOffset]
	push af
	ld hl, wLetterPrintingDelayFlags
	ld a, [hl]
	push af
	res 1, [hl]
	callab InitBattleVariables
	ld a, [wEngagedTrainerClass]
	and a								; if engaged trainer class is nul, this means we're in a wild battle
	jr z, InitWildBattle
	cp STATIC_MON						; if engaged trainer class is STATIC_MON, this means it's a static wild mon
	jr z, InitWildBattle				; (don't use inc a because a is used afterwards in case of trainer battles)
	ld [wTrainerClass], a
	call GetTrainerInformation
	callab ReadTrainer
	call DoBattleTransitionAndInitBattleVariables
	call _LoadTrainerPic
	xor a
	ld [wEnemyMonSpecies2], a
	ld [wEnemyMonSpecies2 + 1], a		; to handle 2 bytes species IDs
	ld [hStartTileID], a
	dec a
	ld [wAICount], a
	coord hl, 12, 0
	predef CopyUncompressedPicToTilemap
	ld a, $ff
	ld [wEnemyMonPartyPos], a
	ld a, BATTLE_STATE_TRAINER
	ld [wIsInBattle], a
	jp _InitBattleCommon

InitWildBattle:
	ld a, BATTLE_STATE_WILD
	ld [wIsInBattle], a
	call LoadEnemyMonData
	call DoBattleTransitionAndInitBattleVariables
	ld a, [wCurOpponent]			; wCurOpponent is normally zero during wild battles, only GHOST MAROWAK uses it
	ld b, a
	ld a, [wCurOpponent + 1]
	ld c, a
	ld hl, GHOST_MAROWAK			; use a dedicated species ID to differentiate from any possible type of wild MAROWAK
	call CompareBCtoHL
	jr z, .isGhost
	call IsGhostBattle
	jr nz, .isNoGhost
.isGhost
	ld hl, wMonHSpriteDim
	ld a, $66
	ld [hli], a   ; write sprite dimensions
	ld bc, GhostPic
	ld a, c
	ld [hli], a   ; write front sprite pointer
	ld [hl], b
	ld hl, wEnemyMonNick  ; set name to "GHOST"
	ld a, "G"
	ld [hli], a
	ld a, "H"
	ld [hli], a
	ld a, "O"
	ld [hli], a
	ld a, "S"
	ld [hli], a
	ld a, "T"
	ld [hli], a
	ld [hl], "@"
	ld bc, MON_GHOST					; to handle 2 bytes species IDs
	ld a, b								; to handle 2 bytes species IDs
	ld [wMonSpeciesTemp], a				; to handle 2 bytes species IDs
	ld a, c								; to handle 2 bytes species IDs
	ld [wMonSpeciesTemp + 1], a			; to handle 2 bytes species IDs
	call GetMonHeader					; to handle 2 bytes species IDs
	ld de, vFrontPic
	call LoadMonFrontSprite				; load ghost sprite
	jr .spriteLoaded
.isNoGhost
	ld de, vFrontPic
	call LoadMonFrontSprite ; load mon sprite
.spriteLoaded
	xor a
	ld [wTrainerClass], a
	ld [hStartTileID], a
	coord hl, 12, 0
	predef CopyUncompressedPicToTilemap

; common code that executes after init battle code specific to trainer or wild battles
_InitBattleCommon:
	ld b, SET_PAL_BATTLE_BLACK
	call RunPaletteCommand
	call SlidePlayerAndEnemySilhouettesOnScreen
	xor a
	ld [H_AUTOBGTRANSFERENABLED], a
	ld hl, .emptyString
	call PrintText
	call SaveScreenTilesToBuffer1
	call ClearScreen
	ld a, $98
	ld [H_AUTOBGTRANSFERDEST + 1], a
	ld a, $1
	ld [H_AUTOBGTRANSFERENABLED], a
	call Delay3
	ld a, $9c
	ld [H_AUTOBGTRANSFERDEST + 1], a
	call LoadScreenTilesFromBuffer1
	coord hl, 9, 7
	lb bc, 5, 10
	call ClearScreenArea
	coord hl, 1, 0
	lb bc, 4, 10
	call ClearScreenArea
	call ClearSprites
	ld a, [wIsInBattle]
	dec a ; is it a wild battle?
	call z, DrawEnemyHUDAndHPBar ; draw enemy HUD and HP bar if it's a wild battle
	call StartBattle
	callab EndOfBattle
	pop af
	ld [wLetterPrintingDelayFlags], a
	pop af
	ld [wMapPalOffset], a
	ld a, [wSavedTilesetType]
	ld [hTilesetType], a
	scf
	ret
.emptyString
	db "@"

_LoadTrainerPic:
; wd033-wd034 contain pointer to pic
	ld a, [wTrainerPicPointer]
	ld e, a
	ld a, [wTrainerPicPointer + 1]
	ld d, a ; de contains pointer to trainer pic
	ld a, [wLinkState]
	and a
	ld a, Bank(TrainerPics) ; this is where all the trainer pics are (not counting Red's)
	jr z, .loadSprite
	ld a, Bank(RedPicFront)
.loadSprite
	call UncompressSpriteFromDE
	ld de, vFrontPic
	ld a, $77
	ld c, a
	jp LoadUncompressedSpriteData

; animates the mon "growing" out of the pokeball
AnimateSendingOutMon:
	ld a, [wPredefRegisters]
	ld h, a
	ld a, [wPredefRegisters + 1]
	ld l, a
	ld a, [hStartTileID]
	ld [hBaseTileID], a
	ld b, $4c
	ld a, [wIsInBattle]
	and a
	jr z, .notInBattle
	add b
	ld [hl], a
	call Delay3
	ld bc, -(SCREEN_WIDTH * 2 + 1)
	add hl, bc
	ld a, 1
	ld [wDownscaledMonSize], a
	lb bc, 3, 3
	predef CopyDownscaledMonTiles
	ld c, 4
	call DelayFrames
	ld bc, -(SCREEN_WIDTH * 2 + 1)
	add hl, bc
	xor a
	ld [wDownscaledMonSize], a
	lb bc, 5, 5
	predef CopyDownscaledMonTiles
	ld c, 5
	call DelayFrames
	ld bc, -(SCREEN_WIDTH * 2 + 1)
	jr .next
.notInBattle
	ld bc, -(SCREEN_WIDTH * 6 + 3)
.next
	add hl, bc
	ld a, [hBaseTileID]
	add $31
	jr CopyUncompressedPicToHL

CopyUncompressedPicToTilemap:
	ld a, [wPredefRegisters]
	ld h, a
	ld a, [wPredefRegisters + 1]
	ld l, a
	ld a, [hStartTileID]
CopyUncompressedPicToHL:
	lb bc, 7, 7
	ld de, SCREEN_WIDTH
	push af
	ld a, [wSpriteFlipped]
	and a
	jr nz, .flipped
	pop af
.loop
	push bc
	push hl
.innerLoop
	ld [hl], a
	add hl, de
	inc a
	dec c
	jr nz, .innerLoop
	pop hl
	inc hl
	pop bc
	dec b
	jr nz, .loop
	ret

.flipped
	push bc
	ld b, 0
	dec c
	add hl, bc
	pop bc
	pop af
.flippedLoop
	push bc
	push hl
.flippedInnerLoop
	ld [hl], a
	add hl, de
	inc a
	dec c
	jr nz, .flippedInnerLoop
	pop hl
	dec hl
	pop bc
	dec b
	jr nz, .flippedLoop
	ret

LoadMonBackPic:
; Assumes the monster's attributes have
; been loaded with GetMonHeader.
	coord hl, 1, 5
	ld b, 7
	ld c, 8
	call ClearScreenArea
	ld hl,  wMonHBackSprite - wMonHeader
	call UncompressMonSprite
	predef ScaleSpriteByTwo
	ld de, vBackPic
	call InterlaceMergeSpriteBuffers ; combine the two buffers to a single 2bpp sprite
	ld hl, vSprites
	ld de, vBackPic
	ld c, (2*SPRITEBUFFERSIZE)/16 ; count of 16-byte chunks to be copied
	ld a, [H_LOADEDROMBANK]
	ld b, a
	jp CopyVideoData

JumpMoveEffect:
	call _JumpMoveEffect
	ld b, $1
	ret

_JumpMoveEffect:
	ld a, [H_WHOSETURN]
	and a
	ld a, [wPlayerMoveEffect]
	jr z, .next1
	ld a, [wEnemyMoveEffect]
.next1
	cp ATTACK_DOWN_SIDE_EFFECT2		; move effects from ATTACK_DOWN_SIDE_EFFECT2 and above are handled in another bank
	jr c, .localBank
	jpab HandleNewEffect
.localBank
	dec a							; subtract 1, there is no special effect for 00
	add a							; x2, 16bit pointers
	ld hl, MoveEffectPointerTable
	ld b, 0
	ld c, a
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl							; jump to special effect handler

MoveEffectPointerTable:
	 dw HealEffect                ; REST_EFFECT
	 dw PoisonEffect              ; POISON_SIDE_EFFECT1
	 dw DrainHPEffect             ; DRAIN_HP_EFFECT
	 dw FreezeBurnParalyzeEffect  ; BURN_SIDE_EFFECT1
	 dw FreezeBurnParalyzeEffect  ; FREEZE_SIDE_EFFECT
	 dw FreezeBurnParalyzeEffect  ; PARALYZE_SIDE_EFFECT1
	 dw ExplodeEffect             ; EXPLODE_EFFECT
	 dw DrainHPEffect             ; DREAM_EATER_EFFECT
	 dw $0000                     ; MIRROR_MOVE_EFFECT
	 dw StatModifierUpEffect      ; ATTACK_UP1_EFFECT
	 dw StatModifierUpEffect      ; DEFENSE_UP1_EFFECT
	 dw StatModifierUpEffect      ; SPEED_UP1_EFFECT
	 dw StatModifierUpEffect      ; SPECIAL_ATTACK_UP1_EFFECT
	 dw StatModifierUpEffect      ; SPECIAL_DEFENSE_UP1_EFFECT
	 dw StatModifierUpEffect      ; ACCURACY_UP1_EFFECT
	 dw StatModifierUpEffect      ; EVASION_UP1_EFFECT
	 dw PayDayEffect              ; PAY_DAY_EFFECT
	 dw $0000                     ; ALWAYS_HIT_EFFECT
	 dw StatModifierDownEffect    ; ATTACK_DOWN1_EFFECT
	 dw StatModifierDownEffect    ; DEFENSE_DOWN1_EFFECT
	 dw StatModifierDownEffect    ; SPEED_DOWN1_EFFECT
	 dw StatModifierDownEffect    ; SPECIAL_ATTACK_DOWN1_EFFECT
	 dw StatModifierDownEffect    ; SPECIAL_DEFENSE_DOWN1_EFFECT
	 dw StatModifierDownEffect    ; ACCURACY_DOWN1_EFFECT
	 dw StatModifierDownEffect    ; EVASION_DOWN1_EFFECT
	 dw ConversionEffect          ; CONVERSION_EFFECT
	 dw HazeEffect                ; HAZE_EFFECT
	 dw BideEffect                ; BIDE_EFFECT
	 dw ThrashPetalDanceEffect    ; THRASH_PETAL_DANCE_EFFECT
	 dw EjectEffect               ; EJECT_EFFECT
	 dw TwoToFiveAttacksEffect    ; TWO_TO_FIVE_ATTACKS_EFFECT
	 dw TwoToFiveAttacksEffect    ; unused effect
	 dw FlinchSideEffect          ; FLINCH_SIDE_EFFECT1
	 dw SleepEffect               ; SLEEP_EFFECT
	 dw PoisonEffect              ; POISON_SIDE_EFFECT2
	 dw FreezeBurnParalyzeEffect  ; BURN_SIDE_EFFECT2
	 dw FreezeBurnParalyzeEffect  ; unused effect
	 dw FreezeBurnParalyzeEffect  ; PARALYZE_SIDE_EFFECT2
	 dw FlinchSideEffect          ; FLINCH_SIDE_EFFECT2
	 dw $0000                     ; OHKO_EFFECT
	 dw $0000                     ; CHARGE_EFFECT pointer no longer used
	 dw $0000                     ; SUPER_FANG_EFFECT
	 dw $0000                     ; LEVEL_DAMAGE_EFFECT
	 dw TrappingSideEffect        ; TRAPPING_SIDE_EFFECT
	 dw $0000                     ; INVULNERABLE_EFFECT pointer no longer used
	 dw TwoToFiveAttacksEffect    ; ATTACK_TWICE_EFFECT
	 dw $0000                     ; JUMP_KICK_EFFECT
	 dw MistEffect                ; MIST_EFFECT
	 dw FocusEnergyEffect         ; FOCUS_ENERGY_EFFECT
	 dw RecoilEffect              ; RECOIL_EFFECT
	 dw ConfusionEffect           ; CONFUSION_EFFECT
	 dw StatModifierUpEffect      ; ATTACK_UP2_EFFECT
	 dw StatModifierUpEffect      ; DEFENSE_UP2_EFFECT
	 dw StatModifierUpEffect      ; SPEED_UP2_EFFECT
	 dw StatModifierUpEffect      ; SPECIAL_ATTACK_UP2_EFFECT
	 dw StatModifierUpEffect      ; SPECIAL_DEFENSE_UP2_EFFECT
	 dw StatModifierUpEffect      ; ACCURACY_UP2_EFFECT
	 dw StatModifierUpEffect      ; EVASION_UP2_EFFECT
	 dw HealEffect                ; HEAL_EFFECT
	 dw TransformEffect           ; TRANSFORM_EFFECT
	 dw StatModifierDownEffect    ; ATTACK_DOWN2_EFFECT
	 dw StatModifierDownEffect    ; DEFENSE_DOWN2_EFFECT
	 dw StatModifierDownEffect    ; SPEED_DOWN2_EFFECT
	 dw StatModifierDownEffect    ; SPECIAL_ATTACK_DOWN2_EFFECT
	 dw StatModifierDownEffect    ; SPECIAL_DEFENSE_DOWN2_EFFECT
	 dw StatModifierDownEffect    ; ACCURACY_DOWN2_EFFECT
	 dw StatModifierDownEffect    ; EVASION_DOWN2_EFFECT
	 dw ReflectLightScreenEffect  ; LIGHT_SCREEN_EFFECT
	 dw ReflectLightScreenEffect  ; REFLECT_EFFECT
	 dw PoisonEffect              ; POISON_EFFECT
	 dw ParalyzeEffect            ; PARALYZE_EFFECT
	 dw StatModifierDownEffect    ; ATTACK_DOWN_SIDE_EFFECT
	 dw StatModifierDownEffect    ; DEFENSE_DOWN_SIDE_EFFECT
	 dw StatModifierDownEffect    ; SPEED_DOWN_SIDE_EFFECT
	 dw StatModifierDownEffect    ; SPECIAL_ATTACK_DOWN_SIDE_EFFECT
	 dw StatModifierDownEffect    ; SPECIAL_DEFENSE_DOWN_SIDE_EFFECT
	 dw StatModifierDownEffect    ; unused effect
	 dw StatModifierDownEffect    ; unused effect
	 dw StatModifierDownEffect    ; unused effect
	 dw StatModifierDownEffect    ; unused effect
	 dw ConfusionEffect           ; CONFUSION_SIDE_EFFECT
	 dw TwoToFiveAttacksEffect    ; TWINEEDLE_EFFECT
	 dw $0000                     ; unused effect
	 dw SubstituteEffect          ; SUBSTITUTE_EFFECT
	 dw HyperBeamEffect           ; HYPER_BEAM_EFFECT
	 dw RageEffect                ; RAGE_EFFECT
	 dw MimicEffect               ; MIMIC_EFFECT
	 dw $0000                     ; METRONOME_EFFECT
	 dw LeechSeedEffect           ; LEECH_SEED_EFFECT
	 dw SplashEffect              ; SPLASH_EFFECT
	 dw DisableEffect             ; DISABLE_EFFECT
	 dw $0000                     ; FIXED_DAMAGE_EFFECT
	 dw $0000                     ; PSYWAVE_EFFECT
	 dw TeleportEffect            ; TELEPORT_EFFECT
	 dw StruggleEffect            ; STRUGGLE_EFFECT
	 dw PoisonEffect              ; BAD_POISON_EFFECT
	 dw $0000                     ; COUNTER_EFFECT
	 dw FlinchSideEffect          ; SKY_ATTACK_EFFECT
	 dw $0000                     ; SKULL_BASH_EFFECT
	 dw TriAttackEffect           ; TRI_ATTACK_EFFECT
	 dw $0000                     ; WEIGHT_DAMAGE_EFFECT

SleepEffect:
	ld de, wEnemyMonStatus
	ld hl, wEnemyBattleStatus2
	ld a, [H_WHOSETURN]
	and a
	jr z, .sleepEffect
	ld de, wBattleMonStatus
	ld hl, wPlayerBattleStatus2
.sleepEffect
	call CheckTargetSubstitute	; add this to make sleep moves fail on substitutes
	jr nz, .didntAffect			; add this to make sleep moves fail on substitutes
	ld a, [de]
	ld b, a
	and $7
	jr z, .notAlreadySleeping ; can't affect a mon that is already asleep
	ld hl, AlreadyAsleepText
	jp PrintText
.notAlreadySleeping
	ld a, b
	and a
	jr nz, .didntAffect ; can't affect a mon that is already statused
	push de
	push hl
	ld hl, wEnemyMonType
	ld de, wPlayerMoveType
	ld a, [H_WHOSETURN]
	and a
	jr z, .checkGrassImmunity
	ld hl, wBattleMonType
	ld de, wEnemyMoveType
.checkGrassImmunity				; add this part to make Grass pokemon immune to Grass non-sound-based sleep-inducing moves
	ld a, [de]
	cp GRASS
	jr nz, .moveHitTest
	inc de
	inc de
	inc de						; make de point to wEnemyMoveExtra
	ld a, [de]
	bit IS_SOUND_BASED_MOVE, a	; sound-based Grass sleep moves (Grasswhistle) can work on Grass types
	jr nz, .moveHitTest
	ld a, [hli]
	cp GRASS
	jr z, .doesntAffect
	ld a, [hl]
	cp GRASS
	jr z, .doesntAffect
.moveHitTest
	pop hl
	pop de
	ld a, [wMoveMissed]
	and a
	jr nz, .didntAffect
.setSleepCounter
; set target's sleep counter to a random number between 2 and 5
	call BattleRandom
	and $3
	inc a
	inc a							; increment result twice, making it between 2 and 5
	ld [de], a						; store result in status variable
	res NEEDS_TO_RECHARGE, [hl]		; remove Hyperbeam recharge flag for the target
	dec hl							; make hl point to BATTSTATUS1 variable
	res STORING_ENERGY, [hl]		; disrupt Bide
	res THRASHING_ABOUT, [hl]		; disrupt thrashing moves
	call PlayCurrentMoveAnimation2
	ld hl, FellAsleepText
	call PrintText
	jp DrawHUDsAndHPBars
.didntAffect
	jp PrintDidntAffectText
.doesntAffect
	pop hl
	pop de
	jp PrintDoesntAffectText

FellAsleepText:
	TX_FAR _FellAsleepText
	db "@"

AlreadyAsleepText:
	TX_FAR _AlreadyAsleepText
	db "@"

PoisonEffect:
	ld hl, wEnemyMonStatus
	ld de, wPlayerMoveEffect
	ld a, [H_WHOSETURN]
	and a
	jr z, .poisonEffect
	ld hl, wBattleMonStatus
	ld de, wEnemyMoveEffect
.poisonEffect
	call CheckTargetSubstitute
	jr nz, .noEffect		; can't poison a substitute target
	ld a, [hli]
	ld b, a
	and a
	jr nz, .noEffect		; miss if target is already statused
	ld a, [hli]
	cp POISON				; can't poison a poison-type target
	jr z, .targetImmune
	cp STEEL				; can't poison a steel-type target
	jr z, .targetImmune
	ld a, [hld]
	cp POISON				; can't poison a poison-type target
	jr z, .targetImmune
	cp STEEL				; can't poison a steel-type target
	jr z, .targetImmune
	ld a, [de]
	cp POISON_SIDE_EFFECT1
	ld b, TEN_PERCENT+1			; reaffected this effect for 10% chance
	jr z, .sideEffectTest
	cp POISON_SIDE_EFFECT2
	ld b, THIRTY_PERCENT+1		; reaffected this effect for 30% chance
	jr z, .sideEffectTest
	cp POISON_SIDE_EFFECT3
	ld b, FORTY_PERCENT+1		; added a new move effect for 40% chance
	jr z, .sideEffectTest
	cp BAD_POISON_SIDE_EFFECT
	ld b, FIFTY_PERCENT+1		; added a new move effect for Poison Fang
	jr z, .sideEffectTest
	push hl
	push de
	call MoveHitTest		; apply accuracy tests
	pop de
	pop hl
	ld a, [wMoveMissed]
	and a
	jr nz, .didntAffect
	jr .inflictPoison
.noEffect
	ld a, [de]
	cp POISON_EFFECT
	jr z, .didntAffect
	cp BAD_POISON_EFFECT
	jr z, .didntAffect
	ret
.targetImmune
	ld a, [de]
	cp POISON_EFFECT
	jr z, .end
	cp BAD_POISON_EFFECT
	jr z, .end
	ret
.didntAffect
	ld c, 50
	call DelayFrames
	jp PrintDidntAffectText
.end
	ld c, 50
	call DelayFrames
	jp PrintDoesntAffectText
.sideEffectTest
	call BattleRandom
	cp b ; was side effect successful?
	ret nc
.inflictPoison
	dec hl
	set PSN, [hl] ; mon is now poisoned
	push de
	ld a, [H_WHOSETURN]
	and a
	ld b, ANIM_C7
	ld a, [de]
	ld de, wPlayerToxicCounter
	jr nz, .ok
	ld b, ANIM_A9
	ld de, wEnemyToxicCounter
.ok
	cp BAD_POISON_EFFECT		; check against move effect instead of move
	jr z, .badPoison			; need to check more than one effect now
	cp BAD_POISON_SIDE_EFFECT
	jr nz, .normalPoison
.badPoison
	set BADLY_POISONED, [hl]	; else set bad poison status
	xor a
	ld [de], a
	ld hl, BadlyPoisonedText
	jr .continue
.normalPoison
	ld hl, PoisonedText
.continue
	pop de
	ld a, [de]
	cp POISON_EFFECT
	jr z, .regularPoisonEffect
	cp BAD_POISON_EFFECT
	jr z, .regularPoisonEffect
	ld a, b
	call PlayBattleAnimation2
	jr .displayText					; mutualize the PrintText and DrawHUDsAndHPBars calls
.regularPoisonEffect
	call PlayCurrentMoveAnimation2
.displayText
	call PrintText
	jp DrawHUDsAndHPBars			; update status of target on screen

PoisonedText:
	TX_FAR _PoisonedText
	db "@"

BadlyPoisonedText:
	TX_FAR _BadlyPoisonedText
	db "@"

DrainHPEffect:
	jpab DrainHPEffect_

ExplodeEffect:
	jpab ExplodeEffect_

; complete overhaul of the function to check specific types for specific effects
; instead of just comparing the move type to the target's types
FreezeBurnParalyzeEffect:
	call CheckTargetSubstitute
	ret nz							; return if they have a substitute, can't effect them
	jpab FreezeBurnParalyzeEffect_

CheckDefrost:
	jpab CheckDefrost_

StatModifierUpEffect:
	ld hl, wPlayerMonStatMods
	ld de, wPlayerMoveEffect
	ld a, [H_WHOSETURN]
	and a
	jr z, .statModifierUpEffect
	ld hl, wEnemyMonStatMods
	ld de, wEnemyMoveEffect
.statModifierUpEffect
	ld a, [de]
	sub ATTACK_UP1_EFFECT
	cp EVASION_UP1_EFFECT + $3 - ATTACK_UP1_EFFECT ; covers all +1 effects
	jr c, .incrementStatMod
	sub ATTACK_UP2_EFFECT - ATTACK_UP1_EFFECT ; map +2 effects to equivalent +1 effect
.incrementStatMod
	ld c, a					; put offset between affected stat and attack in c (if affected stat is attack, c=0, if it's defense, c=1 etc.)
	ld b, $0
	add hl, bc
	ld b, [hl]
	inc b								; increment corresponding stat mod
	ld a, STAT_MODIFIER_PLUS_6			; use new constant instead of $d
	cp b								; can't raise stat past +6 ($d or 13)
	jp c, PrintNothingHappenedText
	ld a, [de]
	cp EVASION_UP1_EFFECT + 1
	jr c, .ok
	inc b								; if so, increment stat mod again
	ld a, STAT_MODIFIER_PLUS_6
	cp b								; unless it's already +6
	jr nc, .ok
	ld b, a
.ok
	ld [hl], b
	ld a, c
	cp ACCURACY_STAT_MOD
	jr nc, UpdateStatDone ; jump if mod affected is evasion/accuracy
	push hl
	ld a, [H_WHOSETURN]
	push af
	ld [wCalculateWhoseStats], a		; input for next function
	call CalculateModifiedStat			; apply stat modifier to affected stat
	ld a, [wLinkState]
	cp LINK_STATE_BATTLING
	jr z, .statusNerfs					; if in link battle, skip the badge boost
	ld a, [H_WHOSETURN]
	and a
	jr nz, .statusNerfs					; if it's the CPU's turn, skip the badge boost
	ld hl, wBattleMonAttack
	ld b, $0
	add hl, bc							; make hl point to the affected stat
	add hl, bc							; make hl point to the affected stat (need to add c twice since stats are stored over two bytes)
	ld a, [wObtainedBadges]
	ld d, a
	ld a, c								; load offset between attack modifier and affected stat modifier in a
	and a
	jr nz, .checkDefense				; if offset is not null, it means affected stat is not attack, so move on
	bit BOULDER_BADGE, d				; else it means affected stat is attack, so check if the player has the BoulderBadge	
	call nz, ApplyBoostToStat			; if yes, apply stat boost
	jr .statusNerfs
.checkDefense
	cp DEFENSE_STAT_MOD
	jr nz, .checkSpeed					; if not, move on to Speed
	bit SOUL_BADGE, d					; if yes, does the player have the SoulBadge?
	call nz, ApplyBoostToStat			; if yes again, apply stat boost
	jr .statusNerfs
.checkSpeed
	cp SPEED_STAT_MOD
	jr nz, .checkSpecial				; if not, move on to Special
	bit THUNDER_BADGE, d				; if yes, does the player have the ThunderBadge?
	call nz, ApplyBoostToStat			; if yes again, apply stat boost
	jr .statusNerfs
.checkSpecial							; if we're here, it means affected stat is Special Attack or Special Defense, so no need for more checks
	bit VOLCANO_BADGE, d				; does the player have the VolcanoBadge?
	call nz, ApplyBoostToStat			; if yes, apply stat boost
.statusNerfs
	ld a, [H_WHOSETURN]
	xor $1
	ld [H_WHOSETURN], a					; reverse the turn for next functions
	ld a, c								; put offset between attack and the affected stat in a
	and a
	call z, HalveAttackDueToBurn		; if affected stat is attack, halve attack of user if it is Burned
	cp SPEED_STAT_MOD
	call z, QuarterSpeedDueToParalysis	; if it is, quarter speed of user if it is Paralysed
	pop af
	ld [H_WHOSETURN], a					; restore the turn's original value
	pop hl
UpdateStatDone:
	ld b, c
	inc b
	call PrintStatText
	call PlayCurrentMoveAnimation
	ld de, wPlayerMoveNum
	ld bc, wPlayerMonMinimized
	ld a, [H_WHOSETURN]
	and a
	jr z, .asm_3f4e6
	ld de, wEnemyMoveNum
	ld bc, wEnemyMonMinimized
.asm_3f4e6
	ld a, [de]
	cp MINIMIZE
	jr nz, .displayText
	ld a, $1
	ld [bc], a
.displayText
	ld hl, MonsStatsRoseText
	call PrintText
	ret

RestoreOriginalStatModifier:
	pop hl
	dec [hl]

PrintNothingHappenedText:
	ld hl, NothingHappenedText
	jp PrintText

MonsStatsRoseText:
	TX_FAR _MonsStatsRoseText
	TX_ASM
	ld hl, GreatlyRoseText
	ld a, [H_WHOSETURN]
	and a
	ld a, [wPlayerMoveEffect]
	jr z, .playerTurn
	ld a, [wEnemyMoveEffect]
.playerTurn
	cp ATTACK_DOWN1_EFFECT
	ret nc
	ld hl, RoseText
	ret

GreatlyRoseText:
	TX_DELAY
	TX_FAR _GreatlyRoseText
; fallthrough
RoseText:
	TX_FAR _RoseText
	db "@"

; add this function for move effects that always drop a stat in addition to doing damage
; also used by move effects that inflict recoil stat drops to the user
LowerStat:
	ld b, d
	ld hl, wEnemyMonStatMods
	ld de, wPlayerMoveEffect
	ld a, [H_WHOSETURN]
	and a
	jr z, .next
	ld hl, wPlayerMonStatMods
	ld de, wEnemyMoveEffect
.next
	ld a, b
	sub ATTACK_DOWN_SIDE_EFFECT2 - ATTACK_DOWN1_EFFECT	; make new effect ID coincide with old effect IDs for stat lowering effects like Growl
	ld [de], a
	cp ATTACK_DOWN_SIDE_EFFECT
	jr c, .next2
	sub ATTACK_DOWN_SIDE_EFFECT - ATTACK_DOWN1_EFFECT
.next2
	jp StatModifierDownEffect.mapEffectToStatIndex

StatModifierDownEffect:
	callab CheckCottonSpore			; apply GRASS immunity if move is Cotton Spore
	jp z, PrintDoesntAffectText
	ld hl, wEnemyMonStatMods
	ld de, wPlayerMoveEffect
	ld bc, wEnemyBattleStatus1
	ld a, [H_WHOSETURN]
	and a
	jr z, .statModifierDownEffect
	ld hl, wPlayerMonStatMods
	ld de, wEnemyMoveEffect
	ld bc, wPlayerBattleStatus1
.statModifierDownEffect
	call CheckTargetSubstitute					; can't hit through substitute
	jp nz, MoveMissed
	ld a, [de]
	cp ATTACK_DOWN_SIDE_EFFECT
	jr c, .nonSideEffect
	cp ATTACK_DOWN_SIDE_EFFECT4
	ld b, THIRTY_PERCENT + 1					; 30% chance for some new move effects
	ld c, ATTACK_DOWN_SIDE_EFFECT4
	jr nc, .gotChance
	cp ATTACK_DOWN_SIDE_EFFECT3
	ld b, TWENTY_PERCENT + 1					; 20% chance for some new move effects
	ld c, ATTACK_DOWN_SIDE_EFFECT3
	jr nc, .gotChance
	ld b, TEN_PERCENT + 1						; 10% chance by default and for old move effect
	ld c, ATTACK_DOWN_SIDE_EFFECT
.gotChance
	call BattleRandom
	cp b
	jp nc, CantLowerAnymore
	ld a, [de]
	sub c										; map each stat to its index
	jr .decrementStatMod
.nonSideEffect									; non-side effects only
	ld a, [wMoveMissed]
	and a
	jp nz, MoveMissed
	ld a, [bc]
	bit INVULNERABLE, a							; fly/dig
	jp nz, MoveMissed
	ld a, [de]
.mapEffectToStatIndex
	sub ATTACK_DOWN1_EFFECT
	cp EVASION_DOWN1_EFFECT + $3 - ATTACK_DOWN1_EFFECT	; covers all -1 effects
	jr c, .decrementStatMod
	sub ATTACK_DOWN2_EFFECT - ATTACK_DOWN1_EFFECT		; map -2 effects to corresponding -1 effect
.decrementStatMod
	ld c, a
	ld b, $0
	add hl, bc
	ld b, [hl]
	dec b								; dec corresponding stat mod
	jp z, CantLowerAnymore				; if stat mod is 1 (-6), can't lower anymore
	ld a, [de]
	cp ATTACK_DOWN2_EFFECT - $16
	jr c, .ok
	cp EVASION_DOWN2_EFFECT + $5
	jr nc, .ok
	dec b								; stat down 2 effects only (dec mod again)
	jr nz, .ok
	inc b								; increment mod to 1 (-6) if it would become 0 (-7)
.ok
	ld [hl], b							; save modified mod
	ld a, c
	cp ACCURACY_STAT_MOD
	jr nc, UpdateLoweredStatDone		; jump for evasion/accuracy
	push hl
	push de
	; start of block modification
	ld a, [H_WHOSETURN]
	xor $1
	ld [wCalculateWhoseStats], a		; input for next function
	call CalculateModifiedStat			; apply stat modifier to affected stat
	ld a, [wLinkState]
	cp LINK_STATE_BATTLING
	jr z, .statusNerfs					; if in link battle, skip the badge boost
	ld a, [H_WHOSETURN]
	and a
	jr z, .statusNerfs					; if it's the player's turn, skip the badge boost
	ld hl, wBattleMonAttack				; used for badge boosts only
	ld b, $0
	add hl, bc							; make hl point to the affected stat
	add hl, bc							; make hl point to the affected stat (need to add c twice since stats are stored over two bytes)
	ld a, [wObtainedBadges]
	ld d, a
	ld a, c								; load offset between attack modifier and affected stat modifier in a
	and a
	jr nz, .checkDefense				; if offset is not null, it means affected stat is not attack, so move on
	bit BOULDER_BADGE, d				; else it means affected stat is attack, so check if the player has the BoulderBadge	
	call nz, ApplyBoostToStat			; if yes, apply stat boost
	jr .statusNerfs
.checkDefense
	cp DEFENSE_STAT_MOD
	jr nz, .checkSpeed					; if not, move on to Speed
	bit SOUL_BADGE, d					; if yes, does the player have the SoulBadge?
	call nz, ApplyBoostToStat			; if yes again, apply stat boost
	jr .statusNerfs
.checkSpeed
	cp SPEED_STAT_MOD
	jr nz, .checkSpecial				; if not, move on to Special
	bit THUNDER_BADGE, d				; if yes, does the player have the ThunderBadge?
	call nz, ApplyBoostToStat			; if yes again, apply stat boost
	jr .statusNerfs
.checkSpecial
	bit VOLCANO_BADGE, d				; does the player have the VolcanoBadge?
	call nz, ApplyBoostToStat			; if yes, apply stat boost
.statusNerfs
	ld a, c								; put offset between attack and the affected stat in a
	and a
	call z, HalveAttackDueToBurn		; if affected stat is attack, halve attack of target if it is Burned
	cp SPEED_STAT_MOD
	call z, QuarterSpeedDueToParalysis	; if it is, quarter speed of target if it is Paralysed
	; end of block modification
	pop de
	pop hl
UpdateLoweredStatDone:
	ld b, c
	inc b
	push de
	call PrintStatText
	pop de
	ld a, [de]
	cp EVASION_DOWN2_EFFECT + 1
	jr nc, .displayText
	call PlayCurrentMoveAnimation2
.displayText
	ld hl, MonsStatsFellText
	call PrintText
	ret

CantLowerAnymore_Pop:
	pop de
	pop hl
	inc [hl]

CantLowerAnymore:
	ld a, [de]
	cp ATTACK_DOWN_SIDE_EFFECT
	ret nc
	ld hl, NothingHappenedText
	jp PrintText

MoveMissed:
	ld a, [de]
	cp $44
	ret nc
	jp ConditionalPrintButItFailed

MonsStatsFellText:
	TX_FAR _MonsStatsFellText
	TX_ASM
	ld hl, FellText
	ld a, [H_WHOSETURN]
	and a
	ld a, [wPlayerMoveEffect]
	jr z, .playerTurn
	ld a, [wEnemyMoveEffect]
.playerTurn
; check if the move's effect decreases a stat by 2
	cp BIDE_EFFECT
	ret c
	cp ATTACK_DOWN_SIDE_EFFECT
	ret nc
	ld hl, GreatlyFellText
	ret

GreatlyFellText:
	TX_DELAY
	TX_FAR _GreatlyFellText
; fallthrough
FellText:
	TX_FAR _FellText
	db "@"

PrintStatText:
	ld hl, StatsTextStrings
	ld c, "@"
.findStatName_outer
	dec b
	jr z, .foundStatName
.findStatName_inner
	ld a, [hli]
	cp c
	jr z, .findStatName_outer
	jr .findStatName_inner
.foundStatName
	ld de, wcf4b
	ld bc, $a
	jp CopyData

StatsTextStrings:
	db "ATTACK@"
	db "DEFENSE@"
	db "SPEED@"
	db "SP.ATK@"
	db "SP.DEF@"
	db "ACCURACY@"
	db "EVADE@"

StatModifierRatios:
; first byte is numerator, second byte is denominator
	db 25, 100  ; 0.25
	db 28, 100  ; 0.28
	db 33, 100  ; 0.33
	db 40, 100  ; 0.40
	db 50, 100  ; 0.50
	db 66, 100  ; 0.66
	db  1,   1  ; 1.00
	db 15,  10  ; 1.50
	db  2,   1  ; 2.00
	db 25,  10  ; 2.50
	db  3,   1  ; 3.00
	db 35,  10  ; 3.50
	db  4,   1  ; 4.00

BideEffect:
	ld hl, wPlayerBattleStatus1
	ld de, wPlayerBideAccumulatedDamage
	ld bc, wPlayerBidingTurnsLeft
	ld a, [H_WHOSETURN]
	and a
	jr z, .bideEffect
	ld hl, wEnemyBattleStatus1
	ld de, wEnemyBideAccumulatedDamage
	ld bc, wEnemyBidingTurnsLeft
.bideEffect
	set STORING_ENERGY, [hl] ; mon is now using bide
	xor a
	ld [de], a
	inc de
	ld [de], a
	ld [wPlayerMoveEffect], a
	ld [wEnemyMoveEffect], a
	ld a, 2					; set Bide duration to a fixed number of 2 turns
	ld [bc], a
	ld a, [H_WHOSETURN]
	add XSTATITEM_ANIM
	jp PlayBattleAnimation2

ThrashPetalDanceEffect:
	ld hl, wPlayerBattleStatus1
	ld de, wPlayerNumAttacksLeft
	ld a, [H_WHOSETURN]
	and a
	jr z, .thrashPetalDanceEffect
	ld hl, wEnemyBattleStatus1
	ld de, wEnemyNumAttacksLeft
.thrashPetalDanceEffect
	set THRASHING_ABOUT, [hl] ; mon is now using thrash/petal dance
	call BattleRandom
	and $1
	inc a
	inc a
	ld [de], a				; set thrash/petal dance counter to 2 or 3 at random
	ld a, [H_WHOSETURN]
	add ANIM_B0
	jp PlayBattleAnimation2

EjectSideEffectHandler:
	ld hl, wPlayerMoveEffect
	ld a, [H_WHOSETURN]
	and a
	jr z, .checkMoveEffect
	ld hl, wEnemyMoveEffect
.checkMoveEffect
	ld a, [hl]
	cp EJECT_SIDE_EFFECT
	ret nz						; skip this handler if move effect isn't the right one
	ld hl, wOptions
	ld a, [hl]
	set BATTLE_ANIMATIONS, [hl]	; disable animations since it was already played before
	push hl
	push af
	call EjectEffect
	pop af
	pop hl
	ld [hl], a
	ret

EjectEffect:
	call CheckIfTargetIsThere
	jr z, .fail
	ld hl, wEnemyBattleStatus1
	ld bc, wPlayerMoveNum
	ld de, wEnemyMoveNum
	ld a, [H_WHOSETURN]
	and a
	jr z, .checkInvulnerable
	ld hl, wPlayerBattleStatus1
	ld bc, wEnemyMoveNum
	ld de, wPlayerMoveNum
.checkInvulnerable
	bit INVULNERABLE, [hl]
	jr z, .notInvulnerable
	ld a, [de]
	cp FLY
	jr nz, .fail
	ld hl, wNewBattleFlags
	bit USING_SIGNATURE_MOVE, [hl]
	jr nz, .fail		; no signature move can eject a target during Fly
	ld a, [bc]
	cp WHIRLWIND		; Whirlwind can hit a target during Fly
	jr nz, .fail
.notInvulnerable
	ld a, [wIsInBattle] ; is it a trainer battle or a wild battle?
	dec a
	jr nz, .trainerBattle
	ld hl, wCurEnemyLVL
	ld bc, wBattleMonLevel
	ld de, wPlayerMoveNum
	ld a, [H_WHOSETURN]
	and a
	jr z, .next
	ld de, wEnemyMoveNum
	push hl			; store hl in the stack
	push bc			; store bc in the stack
	pop hl			; pop bc into hl
	pop bc			; pop hl into bc
.next
	ld a, [bc]			; bc = attacker level
	ld b, a
	inc b
	ld a, [hl]			; hl = defender level
	cp b				; compare defender level to attacker level + 1
	jr nc, .fail		; if attacker level < defender level, print "but it failed"
.endWildBattle			; move succeeds, end the battle
	push de				; store move ID pointer in stack
	call CopyPlayerMonCurHPAndStatusFromBattleToParty
	xor a
	ld [wAnimationType], a
	inc a
	ld [wEscapedFromBattle], a
	pop de						; get move ID pointer back from the stack
	ld a, [de]
	call PlayMoveAnimation		; move animation
	ld c, 20
	call DelayFrames
	ret
.failDrainStack
	pop bc			; drain stack to restore it to its original state from before the call to this function
.fail
	ld hl, wPlayerMoveEffect
	ld a, [H_WHOSETURN]
	and a
	jr z, .testMoveEffect
	ld hl, wEnemyMoveEffect
.testMoveEffect
	ld a, [hl]
	cp EJECT_SIDE_EFFECT
	ret z						; in case of failure, don't print any text if this is a side effect
	ld a, $1
	ld [wMoveMissed], a
	ld c, 40
	call DelayFrames
	jp PrintButItFailedText_
.trainerBattle
	ld hl, wEnemyMon1HP
	ld bc, wPlayerMoveNum
	ld a, [H_WHOSETURN]
	and a
	ld a, [wEnemyPartyCount]
	jr z, .countRemainingPokemon
	ld hl, wPartyMon1HP
	ld bc, wEnemyMoveNum
	ld a, [wPartyCount]
.countRemainingPokemon
	push bc		; store move ID pointer in stack
	ld c, a
	push hl		; store address of first party pokemon HP in the stack
	ld d, $0	; keep count of unfainted monsters
	ld e, c		; store the total number of party pokemon in e
.loop
	ld a, [hli]
	ld b, a
	ld a, [hld]
	or b
	jr z, .fainted ; is monster fainted?
	inc d
.fainted
	push bc
	ld bc, wPartyMon2 - wPartyMon1
	add hl, bc
	pop bc
	dec c
	jr nz, .loop
	ld a, d						; how many available monsters are there?
	cp 2 						; check whether there are at least two pokemon left
	pop hl						; get address of first party pokemon cur HP from the stack
	jr c, .failDrainStack		; if only one monster left, print "but it failed"
	dec e						; e is now the max index for a party position, since it is equal to the
								; number of party pokemon minus 1
	call ChooseDraggedPokemon	; gets the party index of the dragged pokemon in c
	ld a, c
	ld [wWhichPokemon], a		; put party index of dragged pokemon in wWhichPokemon
	xor a
	ld [wAnimationType], a
	pop bc						; get move ID pointer from stack
	ld a, [bc]
	call PlayMoveAnimation
	ld c, 20
	call DelayFrames
	ld a, [H_WHOSETURN]
	and a
	jr nz, .switchPlayer
	callab SwitchEnemyMon
	jr .displayText
.switchPlayer
	call PlayerSendOutMon
.displayText
	ld hl, DraggedOutText
	jp PrintText

; This function is used to handle the case when a pokemon gets to attack first even though it is
; using a move like Roar or Whirlwind. It sets the opponent's selected move to $ff in that case,
; in order to cancel the turn of the opponent rather than have the incoming pokemon use the move
; chosen by the switched out pokemon.
RoarUsedFirst:
	ld hl, wEnemySelectedMove
	ld a, [H_WHOSETURN]
	and a
	jr z, .playersTurn
	ld hl, wPlayerSelectedMove
.playersTurn
	ld a, [wNewBattleFlags]
	bit FORCED_SWITCH_OCCURRED, a
	ret z							; if the move used didn't force switch the opponent, don't cancel their turn
	ld a, $ff
	ld [hl], a
	ret

RanFromBattleText:
	TX_FAR _RanFromBattleText
	db "@"

TwoToFiveAttacksEffect:
	jpab TwoToFiveAttacksEffect_

FlinchSideEffect:
	call CheckTargetSubstitute
	ret nz
	ld hl, wEnemyBattleStatus1
	ld de, wPlayerMoveEffect
	ld a, [H_WHOSETURN]
	and a
	jr z, .flinchSideEffect
	ld hl, wPlayerBattleStatus1
	ld de, wEnemyMoveEffect
.flinchSideEffect
	ld a, [de]
	cp FLINCH_SIDE_EFFECT3
	ld b, THIRTY_PERCENT+1
	jr z, .gotEffectChance
	cp FLINCH_SIDE_EFFECT2
	ld b, TWENTY_PERCENT+1
	jr z, .gotEffectChance
	ld b, TEN_PERCENT+1				; default chance is 10% (useful for *-Fang moves)
.gotEffectChance
	call BattleRandom
	cp b
	ret nc
	set FLINCHED, [hl]				; set mon's status to flinching
	ret

ChargeEffect:
	ld hl, wPlayerBattleStatus1
	ld de, wPlayerMoveEffect
	ld a, [H_WHOSETURN]
	and a
	ld b, XSTATITEM_ANIM
	jr z, .chargeEffect
	ld hl, wEnemyBattleStatus1
	ld de, wEnemyMoveEffect
	ld b, ANIM_AF
.chargeEffect
	set CHARGING_UP, [hl]
	ld a, [de]
	cp INVULNERABLE_EFFECT
	jr nz, .notInvulnerable
	set INVULNERABLE, [hl]
.notInvulnerable
	push de
	dec de
	ld a, [de]
	cp FLY
	jr nz, .notFly
	ld b, FLY_FIRST_TURN_ANIM		; added a distinct animation pointer for Flying up instead of using the same as Teleport
.notFly
	cp DIG
	jr nz, .notDigOrFly
	ld b, DIG_FIRST_TURN_ANIM
.notDigOrFly
	cp PHANTOMFORCE
	jr nz, .notDigOrFlyOrPhantomForce
	ld b, PHANTOMFORCE_FIRST_TURN_ANIM
.notDigOrFlyOrPhantomForce
	cp SHADOW_FORCE
	jr nz, .notDigOrFlyOrPhantomForceOrShadowForce
	ld b, SHADOW_FORCE_FIRST_TURN_ANIM
.notDigOrFlyOrPhantomForceOrShadowForce
	xor a
	ld [wAnimationType], a
	ld a, b
	call PlayBattleAnimation
	ld a, [de]
	ld [wChargeMoveNum], a
	ld hl, ChargeMoveEffectText
	call PrintText
	pop de
	ld a, [de]
	cp SKULL_BASH_EFFECT
	jr nz, .notSkullBash
	ld hl, wPlayerMonDefenseMod
	ld a, [H_WHOSETURN]
	and a
	jr z, .checkDefenseModifier
	ld hl, wEnemyMonDefenseMod
.checkDefenseModifier
	ld a, [hl]
	cp STAT_MODIFIER_PLUS_6			; check user's defense modifier
	jr nc, .notSkullBash			; if defense is already maxed, skip the boost
	ld a, [wOptions]
	push af
	or (1 << BATTLE_ANIMATIONS)		; set bit BATTLE_ANIMATIONS of the Options (turn battle animations off)
	ld [wOptions], a
	ld a, DEFENSE_UP1_EFFECT
	ld [de], a
	call JumpMoveEffect
	pop af
	ld [wOptions], a				; restore the options
.notSkullBash
	ld b, $1
	ret

ChargeMoveEffectText:
	TX_FAR _ChargeMoveEffectText
	TX_ASM
	ld a, [wChargeMoveNum]
	ld hl, DisappearedInstantlyText
	cp SHADOW_FORCE
	ret z
	cp PHANTOMFORCE
	ret z
	cp SOLARBEAM
	ld hl, TookInSunlightText
	ret z
	cp SKULL_BASH
	ld hl, LoweredItsHeadText
	ret z
	cp SKY_ATTACK
	ld hl, SkyAttackGlowingText
	ret z
	cp FLY
	ld hl, FlewUpHighText
	ret z
	cp DIG
	ld hl, DugAHoleText
	ret z
	ld hl, MadeWhirlwindText
	ret

DisappearedInstantlyText:
	TX_FAR _DisappearedInstantlyText
	db "@"

TookInSunlightText:
	TX_FAR _TookInSunlightText
	db "@"

LoweredItsHeadText:
	TX_FAR _LoweredItsHeadText
	db "@"

SkyAttackGlowingText:
	TX_FAR _SkyAttackGlowingText
	db "@"

FlewUpHighText:
	TX_FAR _FlewUpHighText
	db "@"

DugAHoleText:
	TX_FAR _DugAHoleText
	db "@"

MadeWhirlwindText:
	TX_FAR _MadeWhirlwindText
	db "@"

TrappingSideEffect:
	call CheckTargetSubstitute
	ret nz							; can't trap a target that is behind a substitute
	ld hl, wPlayerBattleStatus1
	ld de, wPlayerTrappingCounter
	ld a, [H_WHOSETURN]
	and a
	jr z, .trappingEffect
	ld hl, wEnemyBattleStatus1
	ld de, wEnemyTrappingCounter
.trappingEffect
	bit USING_TRAPPING_MOVE, [hl]	; was the attacking mon already using a trapping move before ?
	ret nz							; trapping move effects don't stack
	set USING_TRAPPING_MOVE, [hl]	; mon is now using a trapping move
	ld hl, wPlayerTrappingMoveId	; this variable will hold the attack ID for use when applying damage between turns
	ld bc, wPlayerSelectedMove		; get move id used by player
	and a							; a still holds the "whose turn" flag
	jr z, .initDone
	ld hl, wEnemyTrappingMoveId		; this variable will hold the attack ID for use when applying damage between turns
	ld bc, wEnemySelectedMove		; get move id used by opponent
.initDone
	ld a, [bc]						; get ID of the attack causing partial trapping
	ld [hl], a						; put it in dedicated variable
	ld [wd11e], a					; input for next function
	push de							; save duration counter for later
	call GetAttackerMoveName		; get attack name for display in next textbox
	ld hl, TrappedByAttackText
	call PrintText					; display text saying the target is trapped
	call BattleRandom				; 3/8 chance for 2 and 3 attacks, and 1/8 chance for 4 and 5 attacks
	and $3
	cp $2
	jr c, .setTrappingCounter
	call BattleRandom
	and $3
.setTrappingCounter
	inc a
	inc a							; add this to compensate for the new behavior of these moves
	inc a							; add this to be able to display the "Freed from <attack>" text without shortening the duration of the effect
	pop de							; restore duration counter in de
	ld [de], a
	ret

MistEffect:
	jpab MistEffect_

FocusEnergyEffect:
	jpab FocusEnergyEffect_

RecoilEffect:
	jpab RecoilEffect_

; add this effect to distinguish Struggle from other recoil moves
StruggleEffect:
	jpab StruggleEffect_

; reworked the function so that multiple side effects with different probabilities are possible
ConfusionEffect:
	ld a, [H_WHOSETURN]
	and a
	ld hl, wEnemyBattleStatus1
	ld bc, wEnemyConfusedCounter
	ld de, wPlayerMoveEffect
	jr z, .main
	ld hl, wPlayerBattleStatus1
	ld bc, wPlayerConfusedCounter
	ld de, wEnemyMoveEffect
.main
	call CheckTargetSubstitute
	jr nz, ConfusionEffectFailed
	bit CONFUSED, [hl]					; is mon confused?
	jr nz, ConfusionEffectFailed
	ld a, [de]
	cp CONFUSION_EFFECT
	jr nz, .sideEffect
	push hl
	push bc
	push de
	call MoveHitTest
	pop de
	pop bc
	pop hl
	ld a, [wMoveMissed]
	and a
	jr nz, ConfusionEffectFailed
	jr .confuseTarget
.sideEffect
	push bc
	ld b, THIRTY_PERCENT+1
	cp CONFUSION_SIDE_EFFECT3
	jr z, .diceRoll
	ld b, TWENTY_PERCENT+1
	cp CONFUSION_SIDE_EFFECT2
	jr z, .diceRoll
	ld b, TEN_PERCENT+1					; 10% chance by default (for the original CONFUSION_SIDE_EFFECT)
.diceRoll
	call BattleRandom
	cp b
	pop bc
	ret nc
.confuseTarget
	set CONFUSED, [hl]					; mon is now confused
	call BattleRandom
	and $3
	inc a
	inc a
	ld [bc], a							; confusion status will last 1-4 turns
	ld a, [de]
	cp CONFUSION_EFFECT
	call z, PlayCurrentMoveAnimation2
	ld hl, BecameConfusedText
	jp PrintText

BecameConfusedText:
	TX_FAR _BecameConfusedText
	db "@"

ConfusionEffectFailed:
	ld a, [de]
	cp CONFUSION_EFFECT
	ret nz
	ld c, 50
	call DelayFrames
	jp ConditionalPrintButItFailed

ParalyzeEffect:
	jpab ParalyzeEffect_

SubstituteEffect:
	jpab SubstituteEffect_

HyperBeamEffect:
	jpab HyperBeamEffect_

RageEffect:
	jpab RageEffect_

MimicEffect:
	ld c, 50
	call DelayFrames
	call CheckIfTargetIsThere				; don't check for accuracy, instead check if target is still alive
	jp z, .mimicMissed
	call CheckTargetSubstitute				; make Mimic miss against a substitute
	jp nz, .mimicMissed
	ld a, [H_WHOSETURN]
	and a
	ld hl, wBattleMonMoves
	ld de, wEnemyMonMoves
	ld bc, wPlayerLastMoveListIndex			; moveset index of last move used by the player
	ld a, [wPlayerBattleStatus1]
	jr nz, .enemyTurn
	ld hl, wEnemyMonMoves
	ld de, wBattleMonMoves
	ld bc, wEnemyLastMoveListIndex			; moveset index of last move used by the enemy
	ld a, [wEnemyBattleStatus1]
.enemyTurn
	bit INVULNERABLE, a
	jp nz, .mimicMissed
	ld a, [bc]						; load moveset index of the last move used by the target
	ld c, a
	inc a							; this is to test whether index of last used move is $ff
	jp z, .mimicMissed				; if it is, it means the target hasn't used a move yet, so fail
	ld b, $0
	add hl, bc						; point hl to the move ID of the copied move
	ld b, [hl]						; put ID of the copied move into b
	ld a, b
	ld [wd11e], a
	push hl
	push bc
	; check if copied move is a forbidden move (such as Metronome, Mirror Move)
	ld hl, wEnemyMimicSlot
	ld bc, wEnemyLastMoveListIndex
	ld a, [H_WHOSETURN]
	and a
	jr z, .checkForbiddenMoves
	ld hl, wPlayerMimicSlot
	ld bc, wPlayerLastMoveListIndex
.checkForbiddenMoves
	ld a, [hl]
	and a
	jr z, .checkForbiddenMoves2
	ld h, a
	ld a, [bc]
	inc a							; LastMoveListIndex starts at 0
	cp h
	jr z, .checkForbiddenSignatureMoves
.checkForbiddenMoves2
	ld a, [wd11e]					; restore move id
	cp METRONOME
	jp z, .mimicMissedPopTwice
	cp MIRROR_MOVE					; forbid mirror move to avoid complications
	jp z, .mimicMissedPopTwice
	cp STRUGGLE
	jp z, .mimicMissedPopTwice
.checkForbiddenSignatureMoves
	cp TRANSFORM
	jp z, .mimicMissedPopTwice
.checkSignatureMove
	ld hl, wNewBattleFlags
	ld a, [H_WHOSETURN]
	and a
	jr z, .checkFlag
	bit PLAYER_SIGNATURE_MOVE, [hl]
	jr .maybeSetFlag
.checkFlag
	bit ENEMY_SIGNATURE_MOVE, [hl]
.maybeSetFlag
	jr z, .continue
	set USING_SIGNATURE_MOVE, [hl]
.continue
	pop bc
	pop hl
	push de
	call GetDefenderMoveName		; get the name from the unmapped move id
	pop de
	ld a, b							; restore move id in a after previous function
	call CheckForSignatureMove
	push af							; save result of previous function
	jr nz, .notSignatureMove
	ld a, b
	ld [wd11e], a
	push de
	callab MapDefenderSignatureMove
	ld b, d							; put mapped move id in b
	pop de
.notSignatureMove
	ld hl, wNewBattleFlags
	res USING_SIGNATURE_MOVE, [hl]
	ld c, NUM_MOVES
	ld h, d							; put user's moveset address in hl
	ld l, e							; put user's moveset address in hl
.loop								; check if copied move is already known by the user
	ld a, [hl]
	push hl
	call CheckForSignatureMove
	pop hl
	ld a, [hl]
	jr nz, .notSignatureMove2
	ld [wd11e], a
	push bc
	push hl
	callab MapAttackerSignatureMove	; map signature move id inside user's moveset
	pop hl
	pop bc
	ld a, d
.notSignatureMove2
	cp b							; compare current move to copied move
	jr z, .mimicMissedPopOnce		; if they match, mimic fails
	dec c
	inc hl
	jr nz, .loop					; if c is not null, there are still moves to check
	ld d, b							; put ID of the copied move into d
	pop af							; restore result of earlier CheckForSignatureMove
	jr nz, .notSignatureMove3		; if the copied move is not a signature move, jump
	ld hl, wPlayerMimicSlot
	ld bc, wPlayerMoveListIndex		; moveset index of the move used by the player (so Mimic here)
	ld a, [H_WHOSETURN]
	and a
	jr z, .player
	ld hl, wEnemyMimicSlot
	ld bc, wEnemyMoveListIndex		; moveset index of the move used by the enemy (so Mimic here)
.player
	ld a, [bc]
	inc a							; the index starts at 0, but MimicSlot variables start at 1
	ld [hl], a						; in case of signature move, save mimic's slot number in the user's moveset in new variable
.notSignatureMove3
	ld a, [H_WHOSETURN]
	and a
	ld hl, wBattleMonMoves
	ld bc, wPlayerLastMoveListIndex
	ld a, [wPlayerMoveListIndex]
	jr z, .playerTurn
	ld hl, wEnemyMonMoves
	ld bc, wEnemyLastMoveListIndex
	ld a, [wEnemyMoveListIndex]
.playerTurn
	push bc
	ld c, a
	ld b, $0
	add hl, bc
	ld a, d
	ld [hl], a
	pop hl							; pop bc into hl
	ld [hl], $ff					; if mimic succeeds, reset last used move index
	call PlayCurrentMoveAnimation
	ld hl, MimicLearnedMoveText
	jp PrintText
.mimicMissedPopTwice
	pop af
.mimicMissedPopOnce
	pop af
.mimicMissed
	jp PrintButItFailedText_

MimicLearnedMoveText:
	TX_FAR _MimicLearnedMoveText
	db "@"

LeechSeedEffect:
	jpab LeechSeedEffect_

SplashEffect:
	call PlayCurrentMoveAnimation
	jp PrintNoEffectText

DisableEffect:
	ld a, [wMoveMissed]
	and a
	jr nz, .moveMissed
	ld de, wEnemyDisabledMove
	ld hl, wEnemyMonMoves
	ld a, [H_WHOSETURN]
	and a
	ld a, [wEnemyLastMoveListIndex]
	jr z, .disableEffect
	ld de, wPlayerDisabledMove
	ld hl, wBattleMonMoves
	ld a, [wPlayerLastMoveListIndex]
.disableEffect
	ld c, a				; put last move used index in c
	inc a				; check if last move used index is $ff
	jr z, .moveMissed	; if move index was $ff, it means the pokemon hasn't used a move yet, so move fails
; no effect if target already has a move disabled
	ld a, [de]
	and a
	jr nz, .moveMissed
.pickMoveToDisable
	push hl
	ld b, a				; if we're here then a is zero, and c is last move used index
	add hl, bc			; make hl point to last move used in the target's moveset
	ld a, [hl]			; load targeted move id in a
	ld [wd11e], a		; store move number
	ld a, [H_WHOSETURN]
	and a
	ld hl, wBattleMonPP
	jr nz, .enemyTurn
	ld hl, wEnemyMonPP
.enemyTurn
	add hl, bc
	ld a, [hl]
	pop hl
	and a
	jr z, .moveMissed			; fail if the targeted move has 0 PP
	ld a, DISABLE_DURATION		; disable the move for a fixed number of turns
	inc c ; move 1-4 will be disabled
	swap c
	add c ; map disabled move to high nibble of wEnemyDisabledMove / wPlayerDisabledMove
	ld [de], a
	call PlayCurrentMoveAnimation2
	ld hl, wPlayerDisabledMoveNumber
	ld a, [H_WHOSETURN]
	and a
	jr nz, .printDisableText
	inc hl ; wEnemyDisabledMoveNumber
.printDisableText
	ld a, [wd11e] ; move number
	ld [hl], a
	call GetDefenderMoveName		; to handle signature moves
	ld hl, MoveWasDisabledText
	jp PrintText
.moveMissed
	jp PrintButItFailedText_

MoveWasDisabledText:
	TX_FAR _MoveWasDisabledText
	db "@"

PayDayEffect:
	jpab PayDayEffect_

ConversionEffect:
	jpab ConversionEffect_

HazeEffect:
	jpab HazeEffect_

HealEffect:
	jpab HealEffect_

TransformEffect:
	jpab TransformEffect_

ReflectLightScreenEffect:
	jpab ReflectLightScreenEffect_

NothingHappenedText:
	TX_FAR _NothingHappenedText
	db "@"

PrintNoEffectText:
	ld hl, NoEffectText
	jp PrintText

NoEffectText:
	TX_FAR _NoEffectText
	db "@"

ConditionalPrintButItFailed:
	ld a, [wMoveDidntMiss]
	and a
	ret nz ; return if the side effect failed, yet the attack was successful

PrintButItFailedText_:
	ld hl, ButItFailedText
	jp PrintText

ButItFailedText:
	TX_FAR _ButItFailedText
	db "@"

PrintDidntAffectText:
	ld hl, DidntAffectText
	jp PrintText

DidntAffectText:
	TX_FAR _DidntAffectText
	db "@"

IsUnaffectedText:
	TX_FAR _IsUnaffectedText
	db "@"

CheckTargetSubstitute:
	push hl
	push bc
	ld hl, wEnemyBattleStatus2
	ld bc, wPlayerMoveExtra
	ld a, [H_WHOSETURN]
	and a
	jr z, .next
	ld hl, wPlayerBattleStatus2
	ld bc, wEnemyMoveExtra
.next
	ld a, [bc]
	bit IS_SOUND_BASED_MOVE, a
	jr z, .checkSubstitute				; only check for substitute if the move is not sound-based
	xor a								; set the z flag to ignore the target's substitute
	jr .done
.checkSubstitute
	bit HAS_SUBSTITUTE_UP, [hl]
.done
	pop bc
	pop hl
	ret

PlayCurrentMoveAnimation2:
; animation at MOVENUM will be played unless MOVENUM is 0
; plays wAnimationType 3 or 6
	ld a, [H_WHOSETURN]
	and a
	ld a, [wPlayerMoveNum]
	jr z, .notEnemyTurn
	ld a, [wEnemyMoveNum]
.notEnemyTurn
	and a
	ret z
	call SetAnimationType3or6
	ld a, [wAnimationID]
	jr PlayBattleAnimationGotID2

PlayBattleAnimation2:
; play animation ID at a and animation type 6 or 3
	call SetAnimationType3or6
	jp PlayBattleAnimationGotID

; add this function to mutualize some code
SetAnimationType3or6:
	ld [wAnimationID], a
	ld a, [H_WHOSETURN]
	and a
	ld a, $6
	jr z, .storeAnimationType
	ld a, $3
.storeAnimationType
	ld [wAnimationType], a
	ret
	
PlayCurrentMoveAnimation:
; animation at MOVENUM will be played unless MOVENUM is 0
; resets wAnimationType
	xor a
	ld [wAnimationType], a
	ld a, [H_WHOSETURN]
	and a
	ld a, [wPlayerMoveNum]
	ld hl, wPlayerBattleStatus3
	jr z, .notEnemyTurn
	ld a, [wEnemyMoveNum]
	ld hl, wEnemyBattleStatus3
.notEnemyTurn
	and a
	ret z
	ld [wAnimationID], a
	bit USED_XITEM, [hl]			; check if this was called following an X item use
	jr z, PlayBattleAnimationGotID2	; if not, use move animations
	jr PlayBattleAnimationGotID		; else use special animations

PlayBattleAnimation:
; play animation ID at a and predefined animation type
	ld [wAnimationID], a

PlayBattleAnimationGotID:
; play animation at wAnimationID
	push hl
	push de
	push bc
	predef MoveAnimation
	pop bc
	pop de
	pop hl
	ret

; add this function to handle only move animations
; let the original function handle other animations
PlayBattleAnimationGotID2:
; play animation at wAnimationID
	push hl
	push de
	push bc
	call PlayMoveAnimation
	pop bc
	pop de
	pop hl
	ret

; This function puts the value of the Defense stat to be used in damage calculations in bc.
; The value is computed by comparing the raw value with the current value, and taking whichever one
; is most advantageous to the attacker.
ApplyDefReductions:
	ld a, [hli]					; store raw Defense of the player in $ff97/$ff98
	ld [H_MULTIPLICAND + 1], a
	ld a, [hl]
	ld [H_MULTIPLICAND + 2], a
ApplyDefReductions2:
	ld hl, wPlayerMonDefenseMod
	ld bc, wBattleMonDefense
	ld a, [H_WHOSETURN]
	and a
	jr nz, .playerDefending
	ld hl, wEnemyMonDefenseMod
	ld bc, wEnemyMonDefense
	jr .checkStatModifier
.playerDefending
	ld a, [wLinkState]
	cp LINK_STATE_BATTLING
	jr z, .checkStatModifier
;if not in link, apply badge boost to raw Defense stored at ff97/ff98 if the player has the corresponding badge
	push hl
	push de
	ld hl, H_MULTIPLICAND + 1
	ld a, [wObtainedBadges]
	bit SOUL_BADGE, a
	call nz, ApplyBoostToStat		; multiply two bytes value stored at hl/hl+1 by 1.125
	pop de
	pop hl
.checkStatModifier
	ld a, [hl]
	cp STAT_MODIFIER_DEFAULT
	ld hl, H_MULTIPLICAND + 1
	jr nc, .end	; if no carry, it means the stat modifier is neutral or beneficial, so use raw stat
				; else it means the stat modifier is disadvantageous, so use the current stat value
	ld h, b
	ld l, c
.end
	ld a, [hli]
	ld b, a
	ld c, [hl]
	ret


; This function makes hl point to the address of the attack stat to use in damage calculation
; The value is computed by comparing the raw value with the current value, and taking whichever one
; is most advantageous to the attacker.
ApplyAttackMods:
	ld a, [hli]						; store raw Attack of the player in $ff97/$ff98
	ld [H_MULTIPLICAND + 1], a
	ld a, [hl]
	ld [H_MULTIPLICAND + 2], a
ApplyAttackMods2:
	ld hl, H_MULTIPLICAND + 1		; contains raw attack stat of the enemy when called
	ld bc, wBattleMonAttack
	ld a, [H_WHOSETURN]
	and a
	ld a, [wPlayerMonAttackMod]
	ld e, a
	jr z, .playerAttacking
	ld bc, wEnemyMonAttack
	ld a, [wEnemyMonAttackMod]
	ld e, a
	jr .checkBurned
.playerAttacking
	ld a, [wLinkState]
	cp LINK_STATE_BATTLING
	jr z, .checkBurned
;if not in link, apply badge boost to raw Attack stored at ff97/ff98 if the player has the corresponding badge
	ld a, [wObtainedBadges]
	bit BOULDER_BADGE, a		; use new constant
	push de
	call nz, ApplyBoostToStat	; multiply two bytes value stored at hl/hl+1 by 1.125
	pop de
.checkBurned
	ld a, [H_WHOSETURN]
	and a
	ld a, [wBattleMonStatus]
	jr z, .asm_3feef
	ld a, [wEnemyMonStatus]
.asm_3feef
	and 1 << BRN				; is the Pokemon Burned?
	jr z, .checkStatModifier	; if it is, divide raw stat by 2
	push bc
	ld a, [hli]
	ld b, a
	ld a, [hl]
	srl b
	rr a
	or b
	jr nz, .notNull
	inc a
.notNull
	ld [hld], a
	ld a, b
	ld [hl], a
	pop bc
.checkStatModifier
	ld a, e
	cp STAT_MODIFIER_DEFAULT
	jr c, .loadValue	; if carry, it means the stat modifier is disadvantageous, so use raw stat
						; else it means the stat modifier is neutral or beneficial, so use it
	ld h, b				; put bc in hl, so that hl points to current attack value (with modifier)
	ld l, c
.loadValue
	ld a, [hli]
	ld l, [hl]
	ld h, a				;*HL = attacker attack
	ret


; This function puts the value of the defender's Special stat to be used in damage calculations in bc.
; The value is computed by comparing the raw value with the current value, and taking whichever one
; is most advantageous to the attacker.
ApplySpecialReductions:
	ld a, [hli]					; store raw Special of the player in $ff97/$ff98
	ld [H_MULTIPLICAND + 1], a
	ld a, [hl]
	ld [H_MULTIPLICAND + 2], a
ApplySpecialReductions2:
	ld hl, wPlayerMonSpecialDefenseMod
	ld bc, wBattleMonSpecialDefense
	ld a, [H_WHOSETURN]
	and a
	jr nz, .player
	ld hl, wEnemyMonSpecialDefenseMod
	ld bc, wEnemyMonSpecialDefense
	jr .checkStatModifier
.player
	ld a, [wLinkState]
	cp LINK_STATE_BATTLING
	jr z, .checkStatModifier
;if not in link, apply badge boost to raw Special stored at ff97/ff98 if the player has the corresponding badge
	push hl
	push de
	ld hl, H_MULTIPLICAND + 1
	ld a, [wObtainedBadges]
	bit VOLCANO_BADGE, a
	call nz, ApplyBoostToStat		; multiply two bytes value stored at hl/hl+1 by 1.125
	pop de
	pop hl
.checkStatModifier ; 3ff4b
	ld a, [hl]
	cp STAT_MODIFIER_DEFAULT
	ld hl, H_MULTIPLICAND + 1
	jr nc, .end	; if no carry, it means the stat modifier is neutral or beneficial, so use raw stat
				; else it means the stat modifier is disadvantageous, so use the current stat value
	ld h, b
	ld l, c
.end
	ld a, [hli]
	ld b, a
	ld c, [hl]
	ret


; This function puts the value of the attacker's Special stat to be used in damage calculations at hl/hl+1.
; The value is computed by comparing the raw value with the current value, and taking whichever one
; is most advantageous to the attacker.
ApplySpecialBoosts:
	ld a, [hli]					; store raw Special of the player in $ff97/$ff98
	ld [H_MULTIPLICAND + 1], a
	ld a, [hl]
	ld [H_MULTIPLICAND + 2], a
ApplySpecialBoosts2:
	ld hl, H_MULTIPLICAND + 1
	ld bc, wBattleMonSpecialAttack
	ld a, [H_WHOSETURN]
	and a
	ld a, [wPlayerMonSpecialAttackMod]
	ld e, a
	jr z, .playerAttacking
	ld bc, wEnemyMonSpecialAttack
	ld a, [wEnemyMonSpecialAttackMod]
	ld e, a
	jr .checkStatModifier
.playerAttacking
	ld a, [wLinkState]
	cp LINK_STATE_BATTLING
	jr z, .checkStatModifier
;if not in link, apply badge boost to raw Special stored at ff97/ff98 if the player has the corresponding badge
	ld a, [wObtainedBadges]
	bit VOLCANO_BADGE, a
	push de
	call nz, ApplyBoostToStat		; multiply two bytes value stored at hl/hl+1 by 1.125
	pop de
.checkStatModifier
	ld a, e
	cp STAT_MODIFIER_DEFAULT
	jr c, .loadValue	; if carry, it means the stat modifier is disadvantageous, so use raw stat
						; else it means the stat modifier is neutral or beneficial, so use it
	ld h, b				; put bc in hl, so that hl points to current attack value (with modifier)
	ld l, c
.loadValue
	ld a, [hli]
	ld l, [hl]
	ld h, a				;*HL = attacker attack
	ret

; This function needs to be added to correct the bug with Counter working when
; the Substitute took damage for the pokemon:
CheckSubstitute:
	ld a, [wNewBattleFlags]				; variable holding the flag that indicates whether a Substitute has taken damage this turn
	and (1 << SUBSTITUTE_TOOK_DAMAGE)	; reset all the bits except the flag SUBSTITUTE_TOOK_DAMAGE
	xor (1 << SUBSTITUTE_TOOK_DAMAGE)	; flip the flag SUBSTITUTE_TOOK_DAMAGE, so that a becomes zero if it is set, non-zero otherwise
	ret
	

; add this function to handle trapping moves in between turns
HandleTrappingMoves:
	push hl
	ld hl, wEnemyTrappingCounter	; duration counter
	ld bc, wEnemyBattleStatus1
	ld de, wEnemyTrappingMoveId
	ld a, [H_WHOSETURN]
	and a
	jr z, .main
	ld hl, wPlayerTrappingCounter	; duration counter
	ld bc, wPlayerBattleStatus1
	ld de, wPlayerTrappingMoveId
.main:
	ld a, [bc]
	bit USING_TRAPPING_MOVE, a		; test whether the opponent has a trapping move going
	jr z, .exit						; return if not
	ld a, [de]						; put move ID in a
	ld [wd11e], a					; put move ID in $d11e for name lookup later
	dec [hl]
	jr z, .freed
	ld a, [H_WHOSETURN]
	push af				
	xor $1				; reverse turn in order to display animation on the pokemon
	ld [H_WHOSETURN], a ; who's taking the damage
	xor a
	ld [wAnimationType], a		; set animation type to zero to have no hit sound or shaking/blinking animation after the move animation
	ld a, [de]
	call PlaySpecialAnimation	; play animation from the opposite side
	pop af				
	ld [H_WHOSETURN], a
	ld d, CANNOT_BE_TOXIC		; this is in order to avoid using the toxic counter for the damage
	pop hl				
	call HandlePoisonBurnLeechSeed_DecreaseOwnHP
	push hl				
	ld hl, HurtByAttackText
	jr .displayText
.freed:
	ld a, [bc]						; reload flags variable
	res USING_TRAPPING_MOVE, a		; unsets the flag in the status variable
	ld [bc], a
	ld hl, FreedFromAttackText
.displayText:
	call GetDefenderMoveName		; to handle signature moves
	call PrintText
.exit:
	pop hl
	ret

; this function checks whether the player can switch his active pokemon
; It sets the z flag if yes, unsets it if no
CheckPlayerSwitchAllowed:
	jpab _CheckPlayerSwitchAllowed

; This function gets a random number n between 0 and the max index for
; the target's party pokemon (ie. if target has 5 pokemon left, 0 =< n <= 4)
; It also checks if the generated number corresponds to the battling pokemon
; or to a fainted pokemon, in which case it generates another number until
; finding one that corresponds to a pokemon that is neither out nor fainted.
; If this function is called while the target has only one pokemon remaining,
; it will loop indefinitely.
; It also stores the internal ID of the dragged pokemon in $cfd9.
; result is stored in c
; input:
; e must hold the max index for party position
; hl must hold the address of first party pokemon cur HP
ChooseDraggedPokemon:
	call BattleRandom
	and 7						; cap at 7 (00000111)
	ld c, a						; put random number in c
	ld a, e						; put max index for party position in a
	cp c						; compare it to the random number
	jr c, ChooseDraggedPokemon	; if random number > max index for party position, try again
.isChosenPokemonAlreadyOut
	ld a, [H_WHOSETURN]
	and a
	ld a, [wEnemyMonPartyPos]
	jr z, .next
	ld a, [wPlayerMonNumber]
.next
	cp c
	jr z, ChooseDraggedPokemon	; if chosen pokemon is the battling pokemon, try again
	push hl
	push bc		; store party index of chosen pokemon in the stack
	ld a, c		; put party index of chosen pokemon in a for next function call
	ld bc, wPartyMon2 - wPartyMon1
	call AddNTimes	; make hl point to the cur HP of the chosen pokemon
	ld a,[hli]
	ld b,a
	ld a,[hl]
	or b
	pop bc				; get chosen pokemon party index from the stack
	pop hl				; get address of first party pokemon cur HP from the stack
	jr z, ChooseDraggedPokemon	; if chosen pokemon has zero HP, try again
	ld a, [H_WHOSETURN]
	and a
	jr z, .end
	ld hl, wPartySpecies
	add hl, bc		; make hl point to the internal ID of the dragged pokemon
	add hl, bc		; since species are now on 2 bytes, need to add bc twice
	ld a, [hli]		; since species are now on 2 bytes, need to read the next byte too
	ld [wBattleMonSpecies2], a
	ld a, [hl]						; to handle 2 bytes species ID
	ld [wBattleMonSpecies2 + 1], a	; to handle 2 bytes species ID
.end
	ld hl, wNewBattleFlags
	set FORCED_SWITCH_OCCURRED, [hl]	; sets the flag indicating that a forced switch occurred during this turn
	ret

; added this function to handle Teleport with the new behaviour of trapping moves
TeleportEffect:
	ld a, [wIsInBattle]
	dec a
	jr nz, .trainerBattle		; in case of a Trainer battle, switch out the user if other mons are available
.succeed
	call CopyPlayerMonCurHPAndStatusFromBattleToParty
	xor a
	ld [wAnimationType], a		; this is to indicate that the animation doesn't use any "impact" sound
	ld a, TELEPORT				; put Teleport's move ID in a for the next function call
	call PlayMoveAnimation
	ld c, 20
	call DelayFrames
	call SaveScreenTilesToBuffer1
	ld a, [wIsInBattle]
	dec a
	ret nz							; in case of a Trainer battle, don't escape from battle
	inc a
	ld [wEscapedFromBattle], a		; this seems to be a kind of end of battle flag
	ld hl, RanFromBattleText
	jp PrintText
.trainerBattle
	callab ChooseNewPokemon
	ld hl, wNewBattleFlags
	bit FORCED_SWITCH_OCCURRED, [hl]
	jr z, .fail							; Teleport fails if cannot switch
	call TeleportEffect.succeed			; do the animation if successful
	ld a, [H_WHOSETURN]
	and a
	jr z, .playerSwitch
	jpab SwitchEnemyMon
.playerSwitch
	call ChooseNextMon
	ld hl, wAILayer2Encouragement
	dec [hl]								; SendOutMon sets it to zero, decrement it here to compensate the increment that will happen at the end of the turn
	ret
.fail
	ld c, 20
	call DelayFrames
	jp PrintButItFailedText_

TrappedByAttackText:
	TX_FAR _TrappedByAttackText
	db "@"

HurtByAttackText:
	TX_FAR _HurtByAttackText
	db "@"

FreedFromAttackText:
	TX_FAR _FreedFromAttackText
	db "@"

CantSwitchText:
	TX_FAR _CantSwitchText
	db "@"		

DraggedOutText:
	TX_FAR _DraggedOutText
	db "@"

; unused, for switch effects (Volt-Switch, U-Turn)
SecondaryEffectPlayerSwitchText:
	TX_FAR _ForcedPlayerSwitchText
	db "@"
	
; unused, for switch effects (Volt-Switch, U-Turn)
SecondaryEffectEnemySwitchText:
	TX_FAR _ForcedEnemySwitchText
	db "@"

; Function to check if the user of a move has fainted due to the execution of the move
; sets the z flag if the user has fainted, unsets it otherwise
IsUserFainted:
	ld hl, wBattleMonHP
	ld a, [H_WHOSETURN]
	and a
	jr z, .main
	ld hl, wEnemyMonHP
.main
	ld a, [hli]
	ld b, [hl]
	or b
	ret

; function to apply everything that happens between turns to the enemy
ApplyBetweenTurnsEventsToPlayer:
	ld hl, wBattleMonHP
	ld a, [hli]
	ld b, [hl]
	or b
	jr z, .done							; if player pokemon is fainted, don't do anything
	ld hl, wPlayerBattleStatus3
	bit BETWEEN_TURNS_PHASE_DONE, [hl]	; have the between turns events been applied to the player's pokemon?
	ret nz								; if so, don't apply them again
	xor a
	ld [H_WHOSETURN], a					; force the turn to the player's
	call HandlePoisonBurnLeechSeed		; apply between turn events to the player's pokemon (f:43bd)
	call z, RemoveFaintedPlayerMon		; if mon fainted, previous call set the z flag
	ret z								; if it was the last mon, previous call set the z flag
.done
	ld hl, wPlayerBattleStatus3
	set BETWEEN_TURNS_PHASE_DONE, [hl]	; set flag to indicate that between turns events were applied to the player
	or $1								; unset the z flag
	ret

; function to apply everything that happens between turns to the enemy
ApplyBetweenTurnsEventsToEnemy:
	ld hl, wAILayer2Encouragement		; increment it here instead of in ExecuteEnemyMove so that it is incremented also when the AI uses an item or switches
	inc [hl]
	ld hl, wEnemyMonHP
	ld a, [hli]
	ld b, [hl]
	or b
	jr z, .done							; if enemy pokemon is fainted, don't do anything
	ld hl, wEnemyBattleStatus3
	bit BETWEEN_TURNS_PHASE_DONE, [hl]	; test whether the between turns events have already been applied to the enemy's pokemon
	ret nz								; if so, don't apply them again
	ld a, $1
	ld [H_WHOSETURN], a					; force the turn to the enemy's
	call HandlePoisonBurnLeechSeed		; apply between turns events to the enemy's pokemon (f:43bd)
	call z, FaintEnemyPokemon			; if mon fainted, previous call set the z flag
	ret z								; if it was the last mon, previous call set the z flag
.done
	ld hl, wEnemyBattleStatus3
	set BETWEEN_TURNS_PHASE_DONE, [hl]	; set flag to indicate that between turns events were applied to the enemy
	or $1								; unset the z flag
	ret

; This function sets the z flag if the chosen move has 0 PP
CheckEnemyPP:
	ld de, wEnemyMonPP				; PP of the first move
	add e
	ld e, a							; make de point to the PP of the chosen move
	jr nc, .next
	inc d
.next
	ld a, [de]
	and a
	ret

; This function makes the AI use Struggle if all of its moves have run out of PP or if the only move with PP is Disabled
; input: b must contain the disabled move index (or 0 if no move is disabled)
CheckEnemyAllPPExhausted:
	ld hl, wEnemyMonPP	; PP of the first move
.loop
	ld a, [hli]			; load the PP of the current move and make hl point to the next
	dec b				; decrement the disabled move index (if no move is disabled, it will just roll over)
	jr z, .next			; if b is now zero, it means that the current move is the disabled move, so skip it
	and a				; else, check whether this move still has some PP
	ret nz				; if it has, stop checking, return with the z flag unset
.next
	dec c				; if the move has no more PP or is disabled or inexistant, then decrement the loop counter
	ret z				; if all the moves have been tested and are unavailable, return with the z flag set
	jr .loop			; if not all moves have been tested, then loop again

UpdateBideDamage:
	jpab UpdateBideDamage_

; function to check if the target of a move is still alive before the move hits
CheckIfTargetIsThere:
	ld hl, wEnemyMonHP 
	ld a, [H_WHOSETURN] 
	and a 
	jr z, .playersTurn 
	ld hl, wBattleMonHP 
.playersTurn 
	ld a, [hli] 
	ld b, a 
	ld a, [hl] 
	or b
	ret

CallHideSubstituteShowMonAnim:
	jpab CallHideSubstituteShowMonAnim_

CallReshowSubstituteAnim:
	jpab CallReshowSubstituteAnim_

; new effect for Tri Attack
TriAttackEffect:
	call CheckTargetSubstitute
	ret nz							;return if they have a substitute, can't effect them
	jpab TriAttackEffect_

; function to handle moves whose base power or other attributes vary
MoveAttributesModifications:
	jpab MoveAttributesModifications_

; function to apply damage modifications that apply after damage value is computed (like stomp on a minimized target)
ApplyOtherModificators:
	jpab ApplyOtherModificators_
