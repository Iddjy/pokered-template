Route23HyperTrainingRoom_Script:
	jp EnableAutoTextBoxDrawing

Route23HyperTrainingRoom_TextPointers:
	dw HyperTrainingText
	dw MoveTutorText

HyperTrainingText:
	TX_ASM
	call SaveScreenTilesToBuffer2
	ld hl, HyperTrainingText1
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jp nz, .finish
	ld a, GOLDBOTTLECAP
	ld [wcf0d], a
	ld b, a
	call IsItemInBag
	jr nz, .hasGoldBottleCap
.checkBottleCap
	ld a, BOTTLE_CAP
	ld [wcf0d], a
	ld b, a
	call IsItemInBag
	jr nz, .hasBottleCap
	ld hl, HyperTrainingText2
	call PrintText
	jp .done
.hasGoldBottleCap
	ld hl, HyperTrainingText11
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jp z, .hasBottleCap
	ld hl, HyperTrainingText12
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jp nz, .finish
	jr .checkBottleCap
.hasBottleCap
	ld hl, HyperTrainingText3
	call PrintText
	xor a
	ld [wPartyMenuTypeOrMessageID], a
	ld [wUpdateSpritesEnabled], a
	ld [wMenuItemToSwap], a
	call DisplayPartyMenu
	push af
	call GBPalWhiteOutWithDelay3
	call RestoreScreenTilesAndReloadTilePatterns
	call LoadGBPal
	pop af
	jp c, .finish
	call GetPartyMonName2
	ld hl, wPartyMon1Level
	ld bc, wPartyMon2 - wPartyMon1
	ld a, [wWhichPokemon]
	call AddNTimes
	ld a, [hl]
	cp 50
	jr nc, .passedLevelCheck
	ld hl, HyperTrainingText8
	call PrintText
	jp .done
.passedLevelCheck
	ld bc, wPartyMon1DVs - wPartyMon1Level
	add hl, bc
	push hl									; save address of first DV byte
	ld c, NUM_DVS
.checkDVsLoop
	ld a, [hli]
	cp $ff
	jr nz, .notMaxed
	dec c
	jr nz, .checkDVsLoop
	pop hl
	ld hl, HyperTrainingText5
	call PrintText
	jp .done
.notMaxed
	ld a, [wcf0d]
	cp GOLDBOTTLECAP
	jr nz, .notGoldCap
	pop hl									; restore address of first DV byte in hl
	ld a, $ff								; max out all DVs
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld hl, HyperTrainingText10
	call PrintText
	ld a, SFX_INTRO_LUNGE
	call PlaySoundWaitForCurrent
	call WaitForSoundToFinish
	call Delay3
	ld hl, HyperTrainingText7
	call PrintText
	ld a, SFX_GET_KEY_ITEM
	call PlaySoundWaitForCurrent
	call WaitForSoundToFinish
	ld hl, wPartyMon1Species
	ld bc, wPartyMon2 - wPartyMon1
	ld a, [wWhichPokemon]
	call AddNTimes
	ld a, [hli]
	ld [wMonSpeciesTemp], a
	ld a, [hl]
	ld [wMonSpeciesTemp + 1], a					 ; populate wMonSpeciesTemp/wMonSpeciesTemp+1 for GetMonHeader
	ld bc, wPartyMon1Stats - (wPartyMon1Species + 1)
	add hl, bc
	ld d, h
	ld e, l										; put address of target mon's stats in de for CalcStats later
	push de
	call GetMonHeader							; necessary for CalcStats later
	ld bc, wPartyMon1Level - (wPartyMon1Stats)
	add hl, bc
	ld a, [hl]
	ld [wCurEnemyLVL], a						; input for CalcStats
	ld bc, wPartyMon1EVs - 1 - wPartyMon1Level	; CalcStats expects hl to point to the byte before the mon's EVs
	add hl, bc
	ld b, 1										; consider stat exp in CalcStats
	pop de										; restore address of stats in de for CalcStats
	call CalcStats
	ld a, GOLDBOTTLECAP
	jp .removeItem
.notGoldCap
	ld hl, HyperTrainingText4
	call PrintText
	call SaveScreenTilesToBuffer2
	ld a, STATS_MENU
	ld [wTextBoxID], a
	call DisplayTextBoxID
	call LoadScreenTilesFromBuffer2
	pop hl									; restore address of first DV byte in hl
	ld a, [wMenuExitMethod]
	cp CHOSE_MENU_ITEM
	jp nz, .finish
	ld a, [wChosenMenuItem]
	cp NUM_STATS
	jp z, .finish
	call MapStatToDV						; since we don't show the stats in the order they are stored in the DV bytes, we need to do a mapping here
	ld e, a
	ld d, 0
	srl e									; shift right because each DV byte contains 2 DVs, one per word
	push af
	add hl, de								; make hl point to correct DV byte
	pop af
	ld a, [hl]								; read current value of DV byte
	ld b, a
	jr c, .noSwap
	swap a
.noSwap
	and %00001111							; mask out the bits corresponding to the other stat in this DV byte
	cp 15
	jp nc, .statAlreadyMaxed
	ld a, [wChosenMenuItem]
	call MapStatToDV
	srl a
	ld a, b
	jr c, .maxOutLowWord					; if chosen menu item is even, the stat is in the low word of this DV byte
	or %11110000							; max out the second DV in this DV byte
	jr .storeDV
.maxOutLowWord
	or %00001111							; max out the first DV in this DV byte
.storeDV
	ld [hl], a
	ld hl, HyperTrainingText10
	call PrintText
	ld a, SFX_BATTLE_25
	call PlaySoundWaitForCurrent
	call WaitForSoundToFinish
	call Delay3
	ld hl, HyperTrainingText7
	call PrintText
	ld a, SFX_LEVEL_UP
	call PlaySoundWaitForCurrent
	call WaitForSoundToFinish
	ld hl, wPartyMon1Species
	ld bc, wPartyMon2 - wPartyMon1
	ld a, [wWhichPokemon]
	call AddNTimes
	ld a, [hli]
	ld [wMonSpeciesTemp], a
	ld a, [hl]
	ld [wMonSpeciesTemp + 1], a
	call GetMonHeader							; necessary for CalcStat later
	ld bc, wPartyMon1Level - (wPartyMon1Species + 1)
	add hl, bc
	ld a, [hl]
	ld [wCurEnemyLVL], a						; input for CalcStat
	ld bc, wPartyMon1EVs - 1 - wPartyMon1Level	; CalcStat expects hl to point to the byte before the mon's EVs
	add hl, bc
	ld a, [wChosenMenuItem]
	call MapStatIndex
	ld c, a
	ld b, 1										; consider stat exp in CalcStat
	call CalcStat
	ld hl, wPartyMon1Stats
	ld bc, wPartyMon2Species - wPartyMon1Species
	ld a, [wWhichPokemon]
	call AddNTimes
	ld a, [wChosenMenuItem]
	call MapStatIndex
	dec a
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	ld a, [H_MULTIPLICAND+1]
	ld [hli], a
	ld a, [H_MULTIPLICAND+2]
	ld [hl], a
	ld a, BOTTLE_CAP
.removeItem
	ld [hItemToRemoveID], a
	callab RemoveItemByID
	jr .done
.statAlreadyMaxed
	ld hl, HyperTrainingText6
	call PrintText
	jr .done
.finish
	ld hl, HyperTrainingText9
	call PrintText
.done
	jp TextScriptEnd

MapStatToDV:
	push hl
	ld hl, StatsToDVsMap
	inc a
.mappingLoop
	dec a
	jr z, .getDVIndex
	inc hl
	jr .mappingLoop
.getDVIndex
	ld a, [hl]
	pop hl
	ret

; mapping between stat index and DV index
; needed because DVs are not stored in the same order as stats are displayed in the menu
StatsToDVsMap:
	db 3
	db 0
	db 1
	db 5
	db 4
	db 2

MapStatIndex:
	push hl
	ld hl, StatsToStatsMap
	inc a
.mappingLoop
	dec a
	jr z, .getStatIndex
	inc hl
	jr .mappingLoop
.getStatIndex
	ld a, [hl]
	pop hl
	ret

; mapping between stat index in the menu and stat number for CalcStat
; needed because stats are stored in a different order internally than what is displayed in menus
StatsToStatsMap:
	db 1
	db 2
	db 3
	db 5
	db 6
	db 4

HyperTrainingText1:
	TX_FAR _HyperTrainingText1
	db "@"

HyperTrainingText2:
	TX_FAR _HyperTrainingText2
	db "@"

HyperTrainingText3:
	TX_FAR _HyperTrainingText3
	db "@"

HyperTrainingText4:
	TX_FAR _HyperTrainingText4
	db "@"

HyperTrainingText5:
	TX_FAR _HyperTrainingText5
	db "@"

HyperTrainingText6:
	TX_FAR _HyperTrainingText6
	db "@"

HyperTrainingText7:
	TX_FAR _HyperTrainingText7
	db "@"

HyperTrainingText8:
	TX_FAR _HyperTrainingText8
	db "@"

HyperTrainingText9:
	TX_FAR _HyperTrainingText9
	db "@"

HyperTrainingText10:
	TX_FAR _HyperTrainingText10
	db "@"

HyperTrainingText11:
	TX_FAR _HyperTrainingText11
	db "@"

HyperTrainingText12:
	TX_FAR _HyperTrainingText12
	db "@"

MoveTutorText:
	TX_ASM
	call SaveScreenTilesToBuffer2
	CheckEvent EVENT_MOVE_TUTOR_INTRO_TEXT
	jr nz, .afterIntro
	ld hl, MoveTutorIntroText
	call PrintText
	SetEvent EVENT_MOVE_TUTOR_INTRO_TEXT
.afterIntro
	ld hl, MoveTutorDoYouHaveTinyMushroomText
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jp nz, .done
	ld b, TINYMUSHROOM
	call IsItemInBag
	jr z, .done
	ld hl, MoveTutorMoves
	ld de, wMoveTutorMoves
	ld a, NUM_TUTOR_MOVES
	ld [de], a
	inc de
	ld bc, NUM_TUTOR_MOVES + 1
	call CopyData
	ld hl, MoveTutorWhichMoveToTeach
	call PrintText
	ld hl, wMoveTutorMoves
	ld a, l
	ld [wListPointer], a
	ld a, h
	ld [wListPointer + 1], a
	ld a, [wListScrollOffset]
	push af
	xor a
	ld [wCurrentMenuItem], a
	ld [wListScrollOffset], a
	ld [wPrintItemPrices], a
	ld a, MOVESLISTMENU
	ld [wListMenuID], a
	call DisplayListMenuID
	pop bc
	ld a, b
	ld [wListScrollOffset], a
	jr c, .done
	ld a, [wWhichPokemon]					; chosen move index in item list
	inc a
	ld hl, wMoveTutorMoves
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	ld [wd11e], a							; store move id to learn in wd11e for next function
	ld [wMoveNum], a						; needed to display the right string (ABLE/NOT ABLE) in the party menu
	call GetMoveName
	call CopyStringToCF4B					; copy move name to wcf4b
	ld a, 1
	ld [wLetterPrintingDelayFlags], a		; necessary to make the moveset menu appear all at once because we are already within a text command
	callab ItemUseTMHM.useMachine
	jr z, .skipItemRemoval					; if the move was not taught, jump
	ld a, TINYMUSHROOM
	ld [hItemToRemoveID], a
	callab RemoveQuantifiableItemByID
.skipItemRemoval
	call GBPalWhiteOutWithDelay3
	call RestoreScreenTilesAndReloadTilePatterns
	call LoadGBPal
.done
	ld hl, MoveTutorOutroText
	call PrintText
	jp TextScriptEnd

MoveTutorMoves:
	db NASTY_PLOT
	db AMNESIA
	db IRON_DEFENSE
	db AGILITY
	db LEAF_STORM
	db PHANTOMFORCE
	db ROCK_BLAST
	db BRAVE_BIRD
	db AURA_SPHERE
	db SUCKER_PUNCH
	db ZEN_HEADBUTT
	db HYPER_VOICE
	db AQUA_TAIL
	db DRAIN_PUNCH
	db LEECH_LIFE
	db OUTRAGE
	db GUNK_SHOT
	db SUPERPOWER
	db FLARE_BLITZ
	db DRACO_METEOR
	db $FF

MoveTutorWhichMoveToTeach:
	TX_FAR _MoveTutorWhichMoveToTeach
	db "@"

MoveTutorIntroText:
	TX_FAR _MoveTutorIntroText
	db "@"

MoveTutorDoYouHaveTinyMushroomText:
	TX_FAR _MoveTutorDoYouHaveTinyMushroomText
	db "@"

MoveTutorOutroText:
	TX_FAR _MoveTutorOutroText
	db "@"
