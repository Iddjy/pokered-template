BattleFacility:
	ld a, [wSilphCo1FCurScript]
	cp 1								; if map script is 1 when this is called, it means we're handling the player exiting the Battle Facility
	jr nz, .next
	ld a, HS_BATTLE_FACILITY_OPPONENT
	ld [wMissableObjectIndex], a
	predef HideObject					; hide the opponent's sprite for next time
	xor a
	ld [wSilphCo1FCurScript], a			; reset silph co 1F script
	ld hl, wd730
	res 5, [hl]							; need to reset this before saving to avoid inputs being ignored for a few seconds on the continue screen
	jpab SaveSAV.save
.next
	ld hl, wFlags_D733
	bit BIT_BATTLE_FACILITY_RUN_ACTIVE, [hl]	; check if the flag indicating a run is ongoing is set, meaning the player turned off the game in the middle of a run
	jr z, .welcome
	ld hl, BattleFacilitySorryText
	call PrintText
	ld hl, BattleFacilityRunWasInterruptedText
	call PrintText
	; reset winning streak
	ld hl, wBattleFacilityCurrentStreak
	xor a
	ld [hli], a
	ld [hl], a
	ld [wBattleFacilitySubCounter], a
	ld hl, wFlags_D733
	res BIT_BATTLE_FACILITY_RUN_ACTIVE, [hl]
	jr .postGameText
.welcome
	ld hl, SilphCo1FWelcomeText
	call PrintText
	ld b, BATTLE_PASS
	call IsItemInBag
	jr nz, .postGameText
	ld hl, SilphCo1FPresidentText
	jp PrintText
.postGameText
	CheckEvent EVENT_BATTLE_FACILITY_INTRO_TEXT
	jr nz, .enterText
	ld hl, BattleFacilityIntroText
	call PrintText
	ld hl, BattleFacilityIntroRulesText
	call PrintText
	ld hl, BattleFacilityIntroEndText
	call PrintText
	ld a, HS_SILPH_CO_1F_1
	ld [wMissableObjectIndex], a
	ld hl, wFontLoaded
	res 0, [hl]								; this is necessary to make the sprite appear immediately
	push hl
	predef ShowObject
	pop hl
	set 0, [hl]								; restore the correct value for printing text
	SetEvent EVENT_BATTLE_FACILITY_INTRO_TEXT
	call DelayFrame
.enterText
	ld hl, wBattleFacilityCurrentStreak
	ld a, [hli]
	ld b, a
	ld a, [hl]
	or b
	ld hl, BattleFacilityNoWinningStreakText
	jr z, .printCurrentStreak
	ld hl, BattleFacilityCurrentStreakText
	ld a, [wBattleFacilityCurrentStreak + 1]
	cp $ff
	jr nz, .printCurrentStreak
	ld a, b
	cp $ff
	jr nz, .printCurrentStreak
	ld hl, BattleFacilityCantHandleCurrentStreakText
.printCurrentStreak
	call PrintText
	ld hl, wBattleFacilityRecordStreak
	ld a, [hli]
	ld b, a
	ld a, [hl]
	ld hl, BattleFacilityRecordStreakText
	cp $ff
	jr nz, .printRecordStreak
	ld a, b
	cp $ff
	jr nz, .printRecordStreak
	ld hl, BattleFacilityCantHandleRecordStreakText
.printRecordStreak
	call PrintText
	ld hl, BattleFacilityEnterText
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	ld hl, BattleFacilityGoodbyeText
	jr nz, .done
	ld a, [wPartyCount]
	cp BATTLE_FACILITY_PARTY_LENGTH
	jr z, .checkBannedSpecies
	ld hl, BattleFacilitySorryText
	call PrintText
	ld hl, BattleFacilityMustHave3MonsText
	jr .invalid
.checkBannedSpecies
	call CheckBannedSpecies
	jr nc, .checkDifferentSpecies
	ld a, b
	ld [wMonSpeciesTemp], a
	ld a, c
	ld [wMonSpeciesTemp + 1], a
	ld hl, BattleFacilitySorryText
	call PrintText
	call GetMonName
	ld hl, BattleFacilityPokemonIsBannedText
	jr .invalid
.checkDifferentSpecies
	call CheckDifferentSpecies
	ld hl, BattleFacilityNeedToSaveText
	jr nz, .valid
	ld hl, BattleFacilitySorryText
	call PrintText
	ld hl, BattleFacilityMustBeDifferentSpeciesText
	jr .invalid
.valid
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr z, .proceed
	ld hl, BattleFacilityGoodbyeText
	jr .done
.proceed
	ld hl, wFlags_D733
	set BIT_BATTLE_FACILITY_RUN_ACTIVE, [hl]	; flag to indicate a Battle Facility run is ongoing
	callab SaveSAV.save
	ld hl, BattleFacilityValidatedText
	call PrintText
	ld hl, wSimulatedJoypadStatesEnd
	ld de, SilphCo1FMovementRLE
	call DecodeRLEList
	dec a
	ld [wSimulatedJoypadStatesIndex], a
	jp StartSimulatingJoypadStates
.invalid
	call PrintText
	ld hl, BattleFacilityPleaseAdjustText
.done
	jp PrintText
	
SilphCo1FWelcomeText:
	TX_FAR _SilphCo1FWelcomeText
	TX_BLINK
	db "@"

BattleFacilityGoodbyeText:
	TX_FAR _BattleFacilityGoodbyeText
	db "@"

SilphCo1FPresidentText:
	TX_FAR _SilphCo1FPresidentText
	db "@"

BattleFacilityIntroText:
	TX_FAR _BattleFacilityIntroText
	TX_BLINK
	db "@"

BattleFacilityIntroEndText:
	TX_FAR _BattleFacilityIntroEndText
	TX_BLINK
	db "@"

BattleFacilityNoWinningStreakText:
	TX_FAR _BattleFacilityNoWinningStreakText
	TX_BLINK
	db "@"

BattleFacilityCurrentStreakText:
	TX_FAR _BattleFacilityCurrentStreakText
	TX_BLINK
	db "@"

BattleFacilityRecordStreakText:
	TX_FAR _BattleFacilityRecordStreakText
	TX_BLINK
	db "@"

BattleFacilityEnterText:
	TX_FAR _BattleFacilityEnterText
	db "@"

BattleFacilityValidatedText:
	TX_FAR _BattleFacilityValidatedText
	db "@"

BattleFacilityIntroRulesText:
	TX_FAR _BattleFacilityRulesText
	TX_BLINK
	db "@"

BattleFacilitySorryText:
	TX_FAR _BattleFacilitySorryText
	TX_BLINK
	db "@"

BattleFacilityMustHave3MonsText:
	TX_FAR _BattleFacilityMustHave3MonsText
	TX_BLINK
	db "@"

BattleFacilityPokemonIsBannedText:
	TX_FAR _BattleFacilityPokemonIsBannedText
	TX_BLINK
	db "@"

BattleFacilityMustBeDifferentSpeciesText:
	TX_FAR _BattleFacilityMustBeDifferentSpeciesText
	TX_BLINK
	db "@"

BattleFacilityPleaseAdjustText:
	TX_FAR _BattleFacilityPleaseAdjustText
	db "@"

BattleFacilityCantHandleCurrentStreakText:
	TX_FAR _BattleFacilityCantHandleCurrentStreakText
	TX_BLINK
	db "@"

BattleFacilityCantHandleRecordStreakText:
	TX_FAR _BattleFacilityCantHandleRecordStreakText
	TX_BLINK
	db "@"

BattleFacilityNeedToSaveText:
	TX_FAR _BattleFacilityNeedToSaveText
	db "@"

BattleFacilityGameSavedText:
	TX_FAR _GameSavedText
	db "@"

BattleFacilityRunWasInterruptedText:
	TX_FAR _BattleFacilityRunWasInterruptedText
	TX_BLINK
	db "@"

SilphCo1FMovementRLE:
	db D_UP,5			; need 1 more up step than the actual distance to keep wSimulatedJoypadStatesIndex > 0 for the last step in order to walk through the impassable elevator door
	db D_RIGHT,4
	db $ff

; output: unsets z if team is valid, sets it otherwise
CheckDifferentSpecies:
	ld hl, wPartySpecies
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld c, a
	ld a, [hli]			; compare 1st and 2nd pokemon
	cp b
	jr nz, .next1
	ld a, [hl]
	cp c
	ret z
.next1					; compare 1st and 3rd pokemon
	inc hl
	ld a, [hli]
	cp b
	jr nz, .next2
	ld a, [hld]
	cp c
	ret z
.next2					; compare 2nd and 3rd pokemon
	dec hl
	dec hl
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld c, a
	ld a, [hli]
	cp b
	ret nz
	ld a, [hl]
	cp c
	ret

; sets carry flag if one of the team members is banned, and puts the banned species in bc
CheckBannedSpecies:
	ld hl, wPartySpecies
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld c, a
	push hl
	ld hl, BattleFacilityBannedSpecies
.loop1
	ld a, [hli]
	cp $ff
	ld d, a
	ld a, [hli]
	jr nz, .next1
	cp $ff
	jr z, .checkSecondTeamMember
.next1
	push hl
	ld l, d
	ld h, a
	call CompareBCtoHL
	pop hl
	jr z, .foundBannedSpecies
	jr .loop1
.checkSecondTeamMember
	pop hl
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld c, a
	push hl
	ld hl, BattleFacilityBannedSpecies
.loop2
	ld a, [hli]
	cp $ff
	ld d, a
	ld a, [hli]
	jr nz, .next2
	cp $ff
	jr z, .checkThirdTeamMember
.next2
	push hl
	ld l, d
	ld h, a
	call CompareBCtoHL
	pop hl
	jr z, .foundBannedSpecies
	jr .loop2
.checkThirdTeamMember
	pop hl
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld c, a
	push hl
	ld hl, BattleFacilityBannedSpecies
.loop3
	ld a, [hli]
	cp $ff
	ld d, a
	ld a, [hli]
	jr nz, .next3
	cp $ff
	jr z, .allClear
.next3
	push hl
	ld l, d
	ld h, a
	call CompareBCtoHL
	pop hl
	jr z, .foundBannedSpecies
	jr .loop3
.foundBannedSpecies
	pop hl
	scf
	ret
.allClear
	pop hl
	and a			; clear carry flag
	ret

BattleFacilityBannedSpecies:
	dw GIRATINA_ALTERED
	dw GIRATINA_ORIGIN
	dw MEWTWO
	dw MEW
	dw ARCEUS_NORMAL
	dw ARCEUS_FIRE
	dw ARCEUS_WATER
	dw ARCEUS_ELECTRIC
	dw ARCEUS_GRASS
	dw ARCEUS_ICE
	dw ARCEUS_FIGHTING
	dw ARCEUS_POISON
	dw ARCEUS_GROUND
	dw ARCEUS_FLYING
	dw ARCEUS_PSYCHIC
	dw ARCEUS_BUG
	dw ARCEUS_ROCK
	dw ARCEUS_GHOST
	dw ARCEUS_DRAGON
	dw ARCEUS_DARK
	dw ARCEUS_STEEL
	dw ARCEUS_FAIRY
	dw $FFFF
