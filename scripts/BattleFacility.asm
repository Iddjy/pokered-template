BattleFacility_Script:
	ld hl, BattleFacility_ScriptPointers
	ld a, [wBattleFacilityCurScript]
	jp CallFunctionInTable

BattleFacility_ScriptPointers:
	dw BattleFacilityScript0
	dw BattleFacilityScript1
	dw BattleFacilityScript2
	dw BattleFacilityScript3
	dw BattleFacilityScript4
	dw BattleFacilityScript5
	dw BattleFacilityScript6
	dw BattleFacilityScript7
	dw BattleFacilityScript8
	dw BattleFacilityScript9

BattleFacilityScript0:
	ld hl, wSimulatedJoypadStatesEnd
	ld de, BattleFacilityMovementRLE_1
	call DecodeRLEList
	dec a
	ld [wSimulatedJoypadStatesIndex], a
	call StartSimulatingJoypadStates
	ld a, 1
	ld [wBattleFacilityCurScript], a
	ld a, 3
	ld [wBattleResult], a				; initialize wBattleResult with special value to signal the beginning of a run
	ret

BattleFacilityMovementRLE_1:
	db D_LEFT,2
	db D_DOWN,4
	db $ff

BattleFacilityScript1:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	call Delay3
	ld a, PLAYER_DIR_RIGHT
	ld [wPlayerMovingDirection], a
	ld de, WaiterMovesDown
	ld a, 1
	ld [H_SPRITEINDEX], a
	call MoveSprite
	ld a, 2
	ld [wBattleFacilityCurScript], a
	ret

BattleFacilityScript2:
	ld a, [wd730]
	bit 0, a
	ret nz
	ld a, 1
	ld [H_SPRITEINDEX], a
	call GetSpriteMovementByte2Pointer
	ld [hl], DOWN						; necessary to force the sprite to keep facing down once movement is finished
	ld a, PLAYER_DIR_UP
	ld [wPlayerMovingDirection], a
	xor a
	ld [wJoyIgnore], a
	ld a, [wBattleResult]
	cp 3
	jr z, .awardGoldBottleCap			; if this is the first battle of the run, don't award BPs but award Gold Bottle Cap if the player has one stored
	and a
	jr nz, .healParty					; if the player didn't win, don't award BPs
	ld a, [wPlayerBattlePoints]
	inc a
	jr z, .maxedBP
	ld a, 8
	ld [hSpriteIndexOrTextID], a
	call DisplayTextID
	call CalculateBPAmount
	ld [wd0b5], a
	call AwardBP
	jr .awardGoldBottleCap
.maxedBP
	ld a, 9
	ld [hSpriteIndexOrTextID], a
	call DisplayTextID
.awardGoldBottleCap
	call AwardGoldBottleCap
.healParty
	ld a, 4
	ld [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld hl, wBattleFacilityCurrentStreak
	ld a, [hli]
	and a
	jr nz, .notFirstSpecialBattle
	ld a, [hl]
	cp 49									; we check against 49 because we want to know if the NEXT battle is number 50
	jr z, .firstSpecialBattle
	jr nc, .notFirstSpecialBattle
	jr .notSpecialBattle					; special battles occur only after the first 50
.firstSpecialBattle
	ld b, PROF_OAK							; battle 50 is always against PROF_OAK
	ld [wGymLeaderNo], a					; any non-null value in wGymLeaderNo will trigger the gym leader battle theme
	jr .setTrainerClass
.notFirstSpecialBattle
	ld a, [wBattleFacilitySubCounter]		; after the first 50 battles, a special battle occurs every 10 battles
	and $7f									; mask out MSB
	cp 9									; we check against 9 because we want to know if the NEXT battle is a special battle
	jr z, .specialBattle
	cp 19									; we check against 19 because we want to know if the NEXT battle is a special battle
	jr z, .specialBattle
	cp 29									; we check against 29 because we want to know if the NEXT battle is a special battle
	jr z, .specialBattle
	cp 39									; we check against 39 because we want to know if the NEXT battle is a special battle
	jr z, .specialBattle
	cp 49									; we check against 49 because we want to know if the NEXT battle is a special battl
	jr nz, .notSpecialBattle
.specialBattle
	ld [wGymLeaderNo], a					; any non-null value in wGymLeaderNo will trigger the gym leader battle theme
.generateClass
	call Random
	cp 9
	jr nc, .generateClass					; roll until we get a number between 0 and 8
	ld b, BROCK
	and a
	jr z, .setTrainerClass
	ld b, MISTY
	dec a
	jr z, .setTrainerClass
	ld b, LT_SURGE
	dec a
	jr z, .setTrainerClass
	ld b, ERIKA
	dec a
	jr z, .setTrainerClass
	ld b, KOGA
	dec a
	jr z, .setTrainerClass
	ld b, SABRINA
	dec a
	jr z, .setTrainerClass
	ld b, BLAINE
	dec a
	jr z, .setTrainerClass
	ld b, GIOVANNI
	dec a
	jr z, .setTrainerClass
	ld b, PROF_OAK
	jr .setTrainerClass
.notSpecialBattle
	call Random
	and a						; reroll if number is zero since trainer class IDs start at 1
	jr z, .notSpecialBattle
	cp NUM_TRAINER_CLASSES + 1	; reroll if the number is higher than the max trainer class ID
	jr nc, .notSpecialBattle
	ld b, a
	push bc
	ld hl, ForbiddenClasses
	ld de, 1
	call IsInArray				; reroll if the class is among the forbidden ones
	pop bc
	jr c, .notSpecialBattle
.setTrainerClass
	ld a, b
	ld [wTrainerClass], a
	ld [wEngagedTrainerClass], a
	ld hl, TrainerClassSprites
.lookupSprite
	ld a, [hli]
	cp b
	ld a, [hli]
	jr nz, .lookupSprite
	ld hl, wSpriteStateData1 + (16 * 3)	; 16 is the size of one sprite's state data, and we're changing the picture ID of the 3rd sprite on the map
	ld [hl], a
	call GBFadeOutToWhite
	ld a, [wBattleResult]
	dec a
	jr z, .skipSpriteUpdate				; when the player was defeated, don't update the opponent sprite since it is still on screen
	call DisableLCD						; must disable LCD for sprite to reload correctly (not sure why exactly) so we use the healing as an excuse to mask the screen blanking out
	callab InitMapSprites				; reload sprite data to take new sprite id into account
	call EnableLCD
.skipSpriteUpdate
	ld a, SFX_HEAL_AILMENT
	call PlaySoundWaitForCurrent
	call WaitForSoundToFinish
	call GBFadeInFromWhite
	predef HealParty
	ld a, [wBattleResult]
	and a
	jr z, .nextBattle
	cp 3								; handle special case of first battle in a run
	jr z, .nextBattle
	; handle defeat
	ld hl, wBattleFacilityCurrentStreak
	xor a
	ld [hli], a
	ld [hl], a
	ld a, [wBattleFacilitySubCounter]
	and $80								; don't reset the MSB to keep track of pending Gold Bottle Caps
	ld [wBattleFacilitySubCounter], a
	ld a, 8
	ld [wBattleFacilityCurScript], a
	ret
.nextBattle
	call EnableAutoTextBoxDrawing
	ld a, 5
	ld [hSpriteIndexOrTextID], a
	call DisplayTextID
	xor a
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld a, [wBattleFacilityCurScript]
	cp 8
	ret z											; in case the player chose to stop, return at once
	ld a, PLAYER_DIR_RIGHT
	ld [wPlayerMovingDirection], a
	ld a, 1
	ld [H_SPRITEINDEX], a
	ld de, WaiterMovesUp
	jp MoveSprite

BattleFacilityScript3:
	ld a, [wd730]
	bit 0, a
	ret nz
	ld a, 1
	ld [H_SPRITEINDEX], a
	call GetSpriteMovementByte2Pointer
	ld [hl], DOWN						; necessary to force the sprite to keep facing down once movement is finished
	xor a ; SPRITE_FACING_DOWN
	ld [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay
	ld a, 4
	ld [wBattleFacilityCurScript], a
	ret

WaiterMovesDown:
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db $FF

WaiterMovesUp:
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db $FF

NPCMovementScript3:
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db $FF

NPCMovementScript4:
	db NPC_MOVEMENT_LEFT
	db NPC_MOVEMENT_LEFT
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db $FF

BattleFacilityScript4:
	ld a, HS_BATTLE_FACILITY_OPPONENT
	ld [wMissableObjectIndex], a
	predef ShowObject
	ld de, NPCMovementScript3
	ld a, 3
	ld [H_SPRITEINDEX], a
	call MoveSprite
	ld a, 5
	ld [wBattleFacilityCurScript], a
	ret

; trainer classes that can't be opponents in normal battles
ForbiddenClasses:
	db JUGGLER_X
	db SONY1
	db SONY2
	db SONY3
	db PROF_OAK
	db CHIEF
	db GIOVANNI
	db ROCKET
	db BRUNO
	db BROCK
	db MISTY
	db LT_SURGE
	db ERIKA
	db KOGA
	db SABRINA
	db BLAINE
	db LORELEI
	db AGATHA
	db LANCE
	db BRUNO
	db BROCK2
	db MISTY2
	db LT_SURGE2
	db ERIKA2
	db KOGA2
	db SABRINA2
	db BLAINE2
	db GIOVANNI2
	db $FF

TrainerClassSprites:
	db YOUNGSTER, SPRITE_BUG_CATCHER
	db BUG_CATCHER, SPRITE_BUG_CATCHER
	db LASS, SPRITE_LASS
	db SAILOR, SPRITE_SAILOR
	db JR_TRAINER_M, SPRITE_BLACK_HAIR_BOY_1
	db JR_TRAINER_F, SPRITE_LASS
	db POKEMANIAC, SPRITE_BLACK_HAIR_BOY_2
	db SUPER_NERD, SPRITE_BLACK_HAIR_BOY_2
	db HIKER, SPRITE_HIKER
	db BIKER, SPRITE_BIKER
	db BURGLAR, SPRITE_BLACK_HAIR_BOY_2
	db ENGINEER, SPRITE_BLACK_HAIR_BOY_2
	db FISHER, SPRITE_FISHER2
	db SWIMMER, SPRITE_BLACK_HAIR_BOY_2
	db CUE_BALL, SPRITE_BIKER
	db GAMBLER, SPRITE_GAMBLER
	db BEAUTY, SPRITE_FOULARD_WOMAN
	db PSYCHIC_TR, SPRITE_BUG_CATCHER
	db ROCKER, SPRITE_ROCKER
	db JUGGLER, SPRITE_ROCKER
	db TAMER, SPRITE_ROCKER
	db BIRD_KEEPER, SPRITE_BLACK_HAIR_BOY_1
	db BLACKBELT, SPRITE_HIKER
	db PROF_OAK, SPRITE_OAK
	db SCIENTIST, SPRITE_OAK_SCIENTIST_AIDE
	db GIOVANNI, SPRITE_GIOVANNI
	db COOLTRAINER_M, SPRITE_BLACK_HAIR_BOY_1
	db COOLTRAINER_F, SPRITE_LASS
	db BROCK, SPRITE_BLACK_HAIR_BOY_2
	db MISTY, SPRITE_BRUNETTE_GIRL
	db LT_SURGE, SPRITE_ROCKER
	db ERIKA, SPRITE_ERIKA
	db KOGA, SPRITE_BLACKBELT
	db BLAINE, SPRITE_FAT_BALD_GUY
	db SABRINA, SPRITE_GIRL
	db GENTLEMAN, SPRITE_GENTLEMAN
	db CHANNELER, SPRITE_MEDIUM

BattleFacilityScript5:
	ld a, [wd730]
	bit 0, a
	ret nz
	call GetSpriteMovementByte2Pointer
	ld [hl], LEFT							; necessary to force the sprite to keep facing left once movement is finished
	ld a, SPRITE_FACING_LEFT
	ld [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay
	call UpdateSprites
	xor a
	ld [wJoyIgnore], a
	ld a, 3
	ld [hSpriteIndexOrTextID], a
	call DisplayTextID
	callab BattleFacility_StartBattle
	ld a, 2
	ld [H_SPRITEINDEX], a
	call GetSpriteMovementByte2Pointer
	ld [hl], DOWN							; necessary to force the sprite to keep facing down
	ld a, [wBattleResult]
	and a
	jr z, .victory							; anything other than a victory is considered a defeat (ie draw is a defeat)
	ld a, 1
	ld [wBattleFacilityCurScript], a
	ret
.victory
	ld hl, wBattleFacilityCurrentStreak
	ld a, [hli]
	ld b, a
	ld h, [hl]
	ld l, b
	ld a, [wBattleFacilityRecordStreak + 1]
	ld b, a
	ld a, [wBattleFacilityRecordStreak]
	ld c, a
	call CompareBCtoHL
	jr nc, .done
	ld a, h
	ld [wBattleFacilityRecordStreak + 1], a
	ld a, l
	ld [wBattleFacilityRecordStreak], a
.done
	ld a, 6
	ld [wBattleFacilityCurScript], a
	ret

BattleFacilityScript6:
	ld de, NPCMovementScript4
	ld a, 3
	ld [H_SPRITEINDEX], a
	call MoveSprite
	ld a, 7
	ld [wBattleFacilityCurScript], a
	ret

BattleFacilityScript7:
	ld a, [wd730]
	bit 0, a
	ret nz
	ld a, HS_BATTLE_FACILITY_OPPONENT
	ld [wMissableObjectIndex], a
	predef HideObject
	ld a, SFX_GO_OUTSIDE
	call PlaySoundWaitForCurrent
	ld a, 1
	ld [wBattleFacilityCurScript], a
	ret

; called when the player loses or stops
BattleFacilityScript8:
	ld hl, wFlags_D733
	res BIT_BATTLE_FACILITY_RUN_ACTIVE, [hl]			; unset the flag indicating a run is ongoing
	xor a
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld [wBattleFacilityCurScript], a
	ld a, SILPH_CO_1F
	ld [hWarpDestinationMap], a
	ld a, 4
	ld [wDestinationWarpID], a
	ld a, SAFFRON_CITY
	ld [wLastMap], a
	ld hl, wd72d
	set 3, [hl]
	ld a, 1
	ld [wSilphCo1FCurScript], a							; script to force a game save after exiting
	inc a
	ld [wcf0d], a
	ret

BattleFacilityScript9:
	ret

DecrementCurrentStreak:
	ld a, [wBattleFacilitySubCounter]
	dec a
	ld [wBattleFacilitySubCounter], a
	ld hl, wBattleFacilityCurrentStreak + 1
	ld a, [hl]
	dec a
	ld [hld], a
	cp $ff
	ret nz
	dec [hl]
	ret

; unsets z flag if current battle is a special battle, sets it otherwise
IsItASpecialBattle:
	ld a, [wBattleFacilitySubCounter]
	and $7f									; mask out MSB
	cp 10
	jr z, .checkStreak
	cp 20
	jr z, .checkStreak
	cp 30
	jr z, .checkStreak
	cp 40
	jr z, .checkStreak
	cp 50
	jr nz, .ordinaryBattle
.checkStreak
	ld hl, wBattleFacilityCurrentStreak + 1
	ld a, [hld]
	ld b, a
	ld a, [hl]
	and a
	ret nz
	ld a, b
	cp 50
	jr c, .ordinaryBattle					; special battles only occur after the first 50 battles
.specialBattle
	or 1									; unset z flag for special battles
	ret
.ordinaryBattle
	xor a
	ret

CalculateBPAmount:
	ld a, [wBattleFacilitySubCounter]
	and $7f									; mask out MSB
	cp 10
	jr z, .checkStreak
	cp 20
	jr z, .checkStreak
	cp 30
	jr z, .checkStreak
	cp 40
	jr z, .checkStreak
	cp 50
	jr nz, .ordinaryBattle
	; fallthrough for 50
.resetSubCounter
	ld a, $80
	ld [wBattleFacilitySubCounter], a		; every 50 victories in a row, reset the sub counter's 7 low bits and set the MSB to trigger Gold Bottle Cap award
.checkStreak
	ld hl, wBattleFacilityCurrentStreak + 1
	ld a, [hld]
	ld b, a
	ld a, [hl]
	and a
	jr nz, .specialBattle
	ld a, b
	cp 50
	jr c, .ordinaryBattle					; special battles only occur after the first 50 battles
.specialBattle
	ld a, 20								; award 20 BPs after special battles
	ret
.ordinaryBattle
	ld hl, wBattleFacilityCurrentStreak + 1
	ld a, [hld]
	ld b, a
	ld a, [hl]
	and a
	jr z, .next
	ld a, MAX_BP_REWARD		; if current streak high byte is not null, automatically give max amount of BPs
	ret
.next
	ld c, 1
	ld d, 0
.loop
	inc c
	ld a, c
	cp MAX_BP_REWARD
	jr nc, .gotAmount
	ld a, 10
	add d
	ld d, a
	cp b
	jr c, .loop
.gotAmount
	ld a, c
	ret

; input: amount of BP to award in wd0b5
AwardBP:
	ld a, [wd0b5]
	ld b, a
	ld a, [wPlayerBattlePoints]
	add b
	jr nc, .store
	ld a, $ff						; cap Battle Points to $FF
.store
	ld [wPlayerBattlePoints], a
	ld a, 7
	ld [hSpriteIndexOrTextID], a
	jp DisplayTextID

AwardGoldBottleCap:
	ld a, [wBattleFacilitySubCounter]
	bit 7, a								; test MSB
	ret z
	ld a, 10
	ld [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld b, GOLDBOTTLECAP
	ld c, 1
	call GiveItem
	jr nc, .bagFull
	ld a, [wBattleFacilitySubCounter]
	res 7, a								; reset MSB
	ld [wBattleFacilitySubCounter], a
	ld a, 11
	ld [hSpriteIndexOrTextID], a
	jp DisplayTextID
.bagFull
	ld a, 12
	ld [hSpriteIndexOrTextID], a
	call DisplayTextID
	ret

BattleFacility_TextPointers:
	dw BattleFacilityText1			; waiter NPC text
	dw BattleFacilityText2			; waiter NPC text
	dw BattleFacilityText3			; opponent NPC text
	dw BattleFacilityText4
	dw BattleFacilityText5
	dw BattleFacilityText6
	dw BattleFacilityText7
	dw BattleFacilityText8
	dw BattleFacilityText9
	dw BattleFacilityText10
	dw BattleFacilityText11
	dw BattleFacilityText12

BattleFacilityText4:
	TX_FAR _BattleFacilityText4
	db "@"

BattleFacilityText5:
	TX_ASM
	ld a, [wBattleFacilitySubCounter]
	inc a
	ld [wBattleFacilitySubCounter], a
	ld hl, wBattleFacilityCurrentStreak + 1
	ld a, [hl]
	inc a
	ld [hld], a
	jr nz, .notCapped
	ld a, [hl]
	inc a
	jr z, .cap					; if we've reached the max capacity for 2-bytes value, don't rollover, keep maxed value
	ld [hl], a
	jr .notCapped
.cap
	dec a
	inc hl
	ld [hl], a					; restore $FF in first byte in case we're capped
	ld [wcf0d], a				; store $ff in wcf0d to signal we've hit the cap
	ld hl, LostCountText		; if current streak is maxed out, display alternate text
	jr .next
.notCapped
	xor a
	ld [wcf0d], a				; store 0 in wcf0d to signal we didn't hit the cap
	ld hl, NextBattleText
.next
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	call PrintText
	call IsItASpecialBattle
	jr z, .ordinaryBattle
	ld hl, BattleFacilitySpecialOpponentText
	call PrintText
.ordinaryBattle
	ld a, 3
	ld [wBattleFacilityCurScript], a
	ld a, [wBattleResult]
	cp 3
	jp z, TextScriptEnd				; don't ask the player if they want to stop for the first battle of a run
	ld hl, BattleFacilityText6
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jp z, TextScriptEnd
	ld hl, DoYouWantToStopText
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jp nz, TextScriptEnd
	ld a, [wcf0d]
	and a
	call z, DecrementCurrentStreak			; cancel the increase done previously since the battle wasn't played, except when current streak is capped
	ld a, 8
	ld [wBattleFacilityCurScript], a
	jp TextScriptEnd

NextBattleText:
	TX_FAR _NextBattleText
	db "@"

LostCountText:
	TX_FAR _LostCountText
	db "@"

BattleFacilitySpecialOpponentText:
	TX_FAR _BattleFacilitySpecialOpponentText
	db "@"

DoYouWantToStopText:
	TX_FAR _DoYouWantToStopText
	db "@"

BattleFacilityText1:
	TX_ASM
	ld a, [wBattleFacilityCurScript]
	cp 9							; this is to prevent this text displaying when the player mashes the A button during Battle Facility scripts
	jr c, .done
	ld hl, BattleFacilityText1_
	call PrintText
.done
	jp TextScriptEnd
	
BattleFacilityText1_:
	TX_FAR _BattleFacilityText1
	db "@"

BattleFacilityText2:
	TX_FAR _BattleFacilityText2
	db "@"

BattleFacilityText3:
	TX_ASM
	ld a, [wTrainerClass]
	ld hl, BattleFacilityPreBattleText_ProfOak
	cp PROF_OAK
	jr z, .printText
	ld hl, BattleFacilityPreBattleText_Brock
	cp BROCK
	jr z, .printText
	ld hl, BattleFacilityPreBattleText_Misty
	cp MISTY
	jr z, .printText
	ld hl, BattleFacilityPreBattleText_LtSurge
	cp LT_SURGE
	jr z, .printText
	ld hl, BattleFacilityPreBattleText_Erika
	cp ERIKA
	jr z, .printText
	ld hl, BattleFacilityPreBattleText_Koga
	cp KOGA
	jr z, .printText
	ld hl, BattleFacilityPreBattleText_Sabrina
	cp SABRINA
	jr z, .printText
	ld hl, BattleFacilityPreBattleText_Blaine
	cp BLAINE
	jr z, .printText
	ld hl, BattleFacilityPreBattleText_Giovanni
	cp GIOVANNI
	jr z, .printText
.roll
	call Random
	cp (PreBattleTextPointersEnd - PreBattleTextPointers) / 3
	jr nc, .roll
	ld de, wBuffer
	ld hl, PreBattleTextPointers
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	add hl, bc
	ld a, $17			; text command id for TX_FAR macro
	ld [de], a
	inc de
	ld a, [hli]			; in this section we're composing a dynamic TX_FAR macro with the data taken from the pointer table
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	inc de
	ld a, "@"
	ld [de], a
	ld hl, wBuffer
.printText
	call PrintText
	jp TextScriptEnd

PreBattleTextPointers:
	dwb _CeladonGymBattleText3, BANK(_CeladonGymBattleText3)
	dwb _CeladonGymBattleText7, BANK(_CeladonGymBattleText7)
	dwb _CinnabarGymText_75994, BANK(_CinnabarGymText_75994)
	dwb _CinnabarGymText_759c9, BANK(_CinnabarGymText_759c9)
	dwb _FightingDojoBattleText2, BANK(_FightingDojoBattleText2)
	dwb _FightingDojoBattleText3, BANK(_FightingDojoBattleText3)
	dwb _FightingDojoAfterBattleText4, BANK(_FightingDojoAfterBattleText4)
	dwb _FuchsiaGymBattleText1, BANK(_FuchsiaGymBattleText1)
	dwb _FuchsiaGymBattleText3, BANK(_FuchsiaGymBattleText3)
	dwb _PokemonTower3BattleText1, BANK(_PokemonTower3BattleText1)
	dwb _PokemonTower3BattleText2, BANK(_PokemonTower3BattleText2)
	dwb _PokemonTower3BattleText3, BANK(_PokemonTower3BattleText3)
	dwb _PokemonTower4BattleText2, BANK(_PokemonTower4BattleText2)
	dwb _PokemonTower4BattleText3, BANK(_PokemonTower4BattleText3)
	dwb _PokemonTower5BattleText1, BANK(_PokemonTower5BattleText1)
	dwb _PokemonTower6BattleText3, BANK(_PokemonTower6BattleText3)
	dwb _PokemonTower6BattleText1, BANK(_PokemonTower6BattleText1)
	dwb _RockTunnel1BattleText3, BANK(_RockTunnel1BattleText3)
	dwb _RockTunnel1BattleText4, BANK(_RockTunnel1BattleText4)
	dwb _RockTunnel2BattleText3, BANK(_RockTunnel2BattleText3)
	dwb _RockTunnel2BattleText4, BANK(_RockTunnel2BattleText4)
	dwb _RockTunnel2BattleText6, BANK(_RockTunnel2BattleText6)
	dwb _RockTunnel2BattleText7, BANK(_RockTunnel2BattleText7)
	dwb _RockTunnel2BattleText8, BANK(_RockTunnel2BattleText8)
	dwb _RockTunnel2BattleText9, BANK(_RockTunnel2BattleText9)
	dwb _RockTunnel2AfterBattleText3, BANK(_RockTunnel2AfterBattleText3)
	dwb _Route3BattleText2, BANK(_Route3BattleText2)
	dwb _Route3BattleText5, BANK(_Route3BattleText5)
	dwb _Route3BattleText6, BANK(_Route3BattleText6)
	dwb _Route3BattleText7, BANK(_Route3BattleText7)
	dwb _Route6BattleText6, BANK(_Route6BattleText6)
	dwb _Route6BattleText5, BANK(_Route6BattleText5)
	dwb _Route8BattleText1, BANK(_Route8BattleText1)
	dwb _Route8BattleText2, BANK(_Route8BattleText2)
	dwb _Route8BattleText3, BANK(_Route8BattleText3)
	dwb _Route8BattleText5, BANK(_Route8BattleText5)
	dwb _Route9BattleText4, BANK(_Route9BattleText4)
	dwb _Route9BattleText5, BANK(_Route9BattleText5)
	dwb _Route9BattleText6, BANK(_Route9BattleText6)
	dwb _Route9BattleText8, BANK(_Route9BattleText8)
	dwb _Route9AfterBattleText4, BANK(_Route9AfterBattleText4)
	dwb _Route10BattleText2, BANK(_Route10BattleText2)
	dwb _Route10BattleText3, BANK(_Route10BattleText3)
	dwb _Route10BattleText4, BANK(_Route10BattleText4)
	dwb _Route11BattleText1, BANK(_Route11BattleText1)
	dwb _Route11BattleText2, BANK(_Route11BattleText2)
	dwb _Route11BattleText3, BANK(_Route11BattleText3)
	dwb _Route11AfterBattleText2, BANK(_Route11AfterBattleText2)
	dwb _Route11AfterBattleText4, BANK(_Route11AfterBattleText4)
	dwb _Route11BattleText5, BANK(_Route11BattleText5)
	dwb _Route11BattleText6, BANK(_Route11BattleText6)
	dwb _Route11BattleText7, BANK(_Route11BattleText7)
	dwb _Route11BattleText8, BANK(_Route11BattleText8)
	dwb _Route11BattleText10, BANK(_Route11BattleText10)
	dwb _Route12BattleText3, BANK(_Route12BattleText3)
	dwb _Route12BattleText6, BANK(_Route12BattleText6)
	dwb _Route13BattleText4, BANK(_Route13BattleText4)
	dwb _Route13BattleText6, BANK(_Route13BattleText6)
	dwb _Route13BattleText8, BANK(_Route13BattleText8)
	dwb _Route13BattleText9, BANK(_Route13BattleText9)
	dwb _Route13AfterBattleText8, BANK(_Route13AfterBattleText8)
	dwb _Route14BattleText1, BANK(_Route14BattleText1)
	dwb _Route14BattleText3, BANK(_Route14BattleText3)
	dwb _Route14AfterBattleText3, BANK(_Route14AfterBattleText3)
	dwb _Route14BattleText5, BANK(_Route14BattleText5)
	dwb _Route14BattleText6, BANK(_Route14BattleText6)
	dwb _Route14AfterBattleText6, BANK(_Route14AfterBattleText6)
	dwb _Route14BattleText7, BANK(_Route14BattleText7)
	dwb _Route14BattleText8, BANK(_Route14BattleText8)
	dwb _Route14BattleText10, BANK(_Route14BattleText10)
	dwb _Route15BattleText1, BANK(_Route15BattleText1)
	dwb _Route15BattleText2, BANK(_Route15BattleText2)
	dwb _Route15BattleText5, BANK(_Route15BattleText5)
	dwb _Route15BattleText6, BANK(_Route15BattleText6)
	dwb _Route15BattleText7, BANK(_Route15BattleText7)
	dwb _Route15BattleText9, BANK(_Route15BattleText9)
	dwb _Route15AfterBattleText7, BANK(_Route15AfterBattleText7)
	dwb _Route15AfterBattleText9, BANK(_Route15AfterBattleText9)
	dwb _Route15BattleText10, BANK(_Route15BattleText10)
	dwb _Route16BattleText3, BANK(_Route16BattleText3)
	dwb _Route16BattleText5, BANK(_Route16BattleText5)
	dwb _Route16AfterBattleText5, BANK(_Route16AfterBattleText5)
	dwb _Route16AfterBattleText6, BANK(_Route16AfterBattleText6)
	dwb _Route17AfterBattleText4, BANK(_Route17AfterBattleText4)
	dwb _Route17BattleText7, BANK(_Route17BattleText7)
	dwb _Route17BattleText8, BANK(_Route17BattleText8)
	dwb _Route17AfterBattleText8, BANK(_Route17AfterBattleText8)
	dwb _Route17BattleText10, BANK(_Route17BattleText10)
	dwb _Route17AfterBattleText10, BANK(_Route17AfterBattleText10)
	dwb _Route18BattleText1, BANK(_Route18BattleText1)
	dwb _Route19BattleText8, BANK(_Route19BattleText8)
	dwb _Route19BattleText3, BANK(_Route19BattleText3)
	dwb _Route20BattleText4, BANK(_Route20BattleText4)
	dwb _Route20BattleText5, BANK(_Route20BattleText5)
	dwb _Route20BattleText8, BANK(_Route20BattleText8)
	dwb _Route21AfterBattleText5, BANK(_Route21AfterBattleText5)
	dwb _Route25BattleText1, BANK(_Route25BattleText1)
	dwb _Route25BattleText4, BANK(_Route25BattleText4)
	dwb _Route25AfterBattleText1, BANK(_Route25AfterBattleText1)
	dwb _Route25AfterBattleText2, BANK(_Route25AfterBattleText2)
	dwb _Route25BattleText5, BANK(_Route25BattleText5)
	dwb _Route25BattleText6, BANK(_Route25BattleText6)
	dwb _Route25BattleText7, BANK(_Route25BattleText7)
	dwb _SafariZoneRestHouse3Text3, BANK(_SafariZoneRestHouse3Text3)
	dwb _SafariZoneEntranceText_753e6, BANK(_SafariZoneEntranceText_753e6)
	dwb _SaffronGymBattleText3, BANK(_SaffronGymBattleText3)
	dwb _SaffronGymBattleText4, BANK(_SaffronGymBattleText4)
	dwb _SaffronGymBattleText5, BANK(_SaffronGymBattleText5)
	dwb _SaffronCityText8, BANK(_SaffronCityText8)
	dwb _SilphCo4BattleText3, BANK(_SilphCo4BattleText3)
	dwb _SilphCo8BattleText1, BANK(_SilphCo8BattleText1)
	dwb _SilphCo9BattleText1, BANK(_SilphCo9BattleText1)
	dwb _SilphCo9BattleText2, BANK(_SilphCo9BattleText2)
	dwb _SilphCo9AfterBattleText2, BANK(_SilphCo9AfterBattleText2)
	dwb _SSAnne5BattleText1, BANK(_SSAnne5BattleText1)
	dwb _SSAnne8BattleText1, BANK(_SSAnne8BattleText1)
	dwb _SSAnne8AfterBattleText1, BANK(_SSAnne8AfterBattleText1)
	dwb _SSAnne8BattleText3, BANK(_SSAnne8BattleText3)
	dwb _SSAnne8BattleText4, BANK(_SSAnne8BattleText4)
	dwb _SSAnne9Text_61c10, BANK(_SSAnne9Text_61c10)
	dwb _SSAnne9Text_61c1f, BANK(_SSAnne9Text_61c1f)
	dwb _SSAnne9BattleText3, BANK(_SSAnne9BattleText3)
	dwb _SSAnne10BattleText4, BANK(_SSAnne10BattleText4)
	dwb _SSAnne5AfterBattleText1, BANK(_SSAnne5AfterBattleText1)
	dwb _VermilionMartText3, BANK(_VermilionMartText3)
	dwb _VictoryRoad1BattleText1, BANK(_VictoryRoad1BattleText1)
	dwb _VictoryRoad1BattleText2, BANK(_VictoryRoad1BattleText2)
	dwb _VictoryRoad2AfterBattleText4, BANK(_VictoryRoad2AfterBattleText4)
	dwb _VictoryRoad2AfterBattleText5, BANK(_VictoryRoad2AfterBattleText5)
	dwb _VictoryRoad3BattleText2, BANK(_VictoryRoad3BattleText2)
	dwb _VictoryRoad3BattleText3, BANK(_VictoryRoad3BattleText3)
	dwb _VictoryRoad3BattleText5, BANK(_VictoryRoad3BattleText5)
	dwb _VictoryRoad3AfterBattleText5, BANK(_VictoryRoad3AfterBattleText5)
	dwb _ViridianGymBattleText1, BANK(_ViridianGymBattleText1)
	dwb _ViridianGymBattleText2, BANK(_ViridianGymBattleText2)
	dwb _ViridianGymBattleText3, BANK(_ViridianGymBattleText3)
	dwb _ViridianGymBattleText5, BANK(_ViridianGymBattleText5)
PreBattleTextPointersEnd:

BattleFacilityPreBattleText_ProfOak:
	TX_FAR _BattleFacilityPreBattleText_ProfOak
	db "@"

BattleFacilityPreBattleText_Brock:
	TX_FAR _BattleFacilityPreBattleText_Brock
	db "@"

BattleFacilityPreBattleText_Misty:
	TX_FAR _BattleFacilityPreBattleText_Misty
	db "@"

BattleFacilityPreBattleText_LtSurge:
	TX_FAR _BattleFacilityPreBattleText_LtSurge
	db "@"

BattleFacilityPreBattleText_Erika:
	TX_FAR _BattleFacilityPreBattleText_Erika
	db "@"

BattleFacilityPreBattleText_Koga:
	TX_FAR _BattleFacilityPreBattleText_Koga
	db "@"

BattleFacilityPreBattleText_Sabrina:
	TX_FAR _BattleFacilityPreBattleText_Sabrina
	db "@"

BattleFacilityPreBattleText_Blaine:
	TX_FAR _BattleFacilityPreBattleText_Blaine
	db "@"

BattleFacilityPreBattleText_Giovanni:
	TX_FAR _BattleFacilityPreBattleText_Giovanni
	db "@"

BattleFacilityText6:
	TX_FAR _BattleFacilityText6
	db "@"

BattleFacilityText7:
	TX_FAR _BattleFacilityText7
	TX_SFX_ITEM_1
	db "@"

BattleFacilityText8:
	TX_FAR _BattleFacilityText8
	db "@"

BattleFacilityText9:
	TX_FAR _BattleFacilityText9
	db "@"

BattleFacilityText10:
	TX_FAR _BattleFacilityText10
	db "@"

BattleFacilityText11:
	TX_FAR _BattleFacilityText11
	TX_SFX_ITEM_2
	db "@"

BattleFacilityText12:
	TX_FAR _BattleFacilityText12
	db "@"
