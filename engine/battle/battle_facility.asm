BattleFacility_StartBattle:
	ld a, [wPartyCount]
	ld b, a
	ld a, [wOptions]
	push af
	set BATTLE_STYLE, a
	ld [wOptions], a
	call BackupPokemonExperience		; save real experience values for the team in the last 3 slots (since they are empty in the Battle Facility)
	ld hl, wPartyMon1Level
	ld de, wPartyMon1Stats
.setPlayerLevels
	ld a, [hl]
	push bc
	ld bc, wPartyMon1BoxLevel - wPartyMon1Level
	add hl, bc
	ld [hl], a									; store original level in BoxLevel to restore it after the battle (we must do it even for mons whose level is <=50 because their BoxLevel might never have been initialized and the restore is done in every case)
	ld bc, wPartyMon1Level - wPartyMon1BoxLevel
	add hl, bc
	pop bc
	cp BATTLE_FACILITY_LEVEL + 1
	jr c, .nextPokemon
	ld a, BATTLE_FACILITY_LEVEL
	call SetPokemonLevel
	call SetPokemonExperience
.nextPokemon
	push bc
	ld bc, wPartyMon2 - wPartyMon1
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
	jr nz, .setPlayerLevels
	call GenerateBattleFacilityParty
	ld a, BATTLE_TYPE_FACILITY
	ld [wBattleType], a
	ld hl, BattleFacilityVictoryText
	ld de, BattleFacilityDefeatText					; not used by the battle code
	call SaveEndBattleTextPointers
	ld hl, wd72d
	set 7, [hl]										; needed to make the victory text appear
	predef InitOpponent
	pop af
	ld [wOptions], a								; restore Options
	ld a, [wPartyCount]
	ld b, a
	ld hl, wPartyMon1BoxLevel						; use BoxLevel to restore original levels of all pokemon on the team
	ld de, wPartyMon1Stats
.resetPlayerLevels
	ld a, [hl]
	push bc
	ld bc, wPartyMon1Level - wPartyMon1BoxLevel
	add hl, bc
	pop bc
	call SetPokemonLevel
	push bc
	ld bc, wPartyMon2BoxLevel - wPartyMon1Level
	add hl, bc
	push hl
	ld h, d
	ld l, e
	ld bc, wPartyMon2 - wPartyMon1
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	pop bc
	dec b
	jr nz, .resetPlayerLevels
	call RestorePokemonExperience
	ld hl, wFlags_D733					; this flag is set when winning against the final rival, to allow the victory music to continue after reloading the map
	res 1, [hl]							; reset it here in case the trainer class SONY3 is used in the Battle Facility, so that it doesn't prevent music from changing when entering a map
	ld hl, wd72e
	set 5, [hl]							; flag to indicate that a battle just ended for PlayDefaultMusicFadeOutCurrent (inside LoadMapData)
	call GBPalWhiteOutWithDelay3
	call LoadMapData
	callba ClearVariablesOnEnterMap
	call GBFadeInFromWhite
	ld hl, wd72e
	res 5, [hl]
	ret

; input: target level in a
; input: pointer to the pokemon level in hl (wPartyMonXLevel)
SetPokemonLevel:
	ld [hl], a
	ld [wCurEnemyLVL], a	; for CalcStats
	push de
	push hl
	push bc
	ld bc, wPartyMon1Species - wPartyMon1Level
	add hl, bc
	ld a, [hli]
	ld [wMonSpeciesTemp], a
	ld a, [hld]
	ld [wMonSpeciesTemp + 1], a
	call GetMonHeader
	ld bc, (wPartyMon1EVs - 1) - wPartyMon1Species
	add hl, bc
	ld b, 1								; consider EVs
	push hl
	push de
	call CalcStats
	pop de
	pop hl
	ld bc, wEnemyMon1HP - (wEnemyMon1EVs - 1)
	add hl, bc
	ld a, [de]
	ld [hli], a							; set current HP equal to maxHP
	inc de
	ld a, [de]
	ld [hl], a							; set current HP equal to maxHP
	pop bc
	pop hl
	pop de
	ret

; Serves to update the amount of Experience so that it corresponds to Battle Facility fixed level
SetPokemonExperience:
	push de
	push bc
	push hl
	ld d, BATTLE_FACILITY_LEVEL
	callab CalcExperience				; set current Experience to the value for the Battle Facility level
	pop hl
	push hl
	ld bc, wPartyMon1Exp - wPartyMon1Level
	add hl, bc
	ld a, [hExperience]
	ld [hli], a
	ld a, [hExperience + 1]
	ld [hli], a
	ld a, [hExperience + 2]
	ld [hl], a
	pop hl
	pop bc
	pop de
	ret

; Saves original experience values of the 3 pokemon to slots 4 to 6
BackupPokemonExperience:
	push bc
	ld bc, wPartyMon2 - wPartyMon1
	ld hl, wPartyMon1Exp
	call CopyExperience
	ld hl, wPartyMon2Exp
	call CopyExperience
	ld hl, wPartyMon3Exp
	call CopyExperience
	pop bc
	ret

CopyExperience:
	ld a, [hli]
	ld [hExperience], a
	ld a, [hli]
	ld [hExperience + 1], a
	ld a, [hld]
	ld [hExperience + 2], a
	dec hl
	ld a, 3
	call AddNTimes
	ld a, [hExperience]
	ld [hli], a
	ld a, [hExperience + 1]
	ld [hli], a
	ld a, [hExperience + 2]
	ld [hl], a
	ret

; Serves to restore Experience to the real value before entering Battle Facility
RestorePokemonExperience:
	ld bc, wPartyMon1 - wPartyMon2
	ld hl, wPartyMon4Exp
	call CopyExperience
	ld hl, wPartyMon5Exp
	call CopyExperience
	ld hl, wPartyMon6Exp
	jp CopyExperience
	ret

PlayerTriesRunningFromBattleFacility:
	ld hl, DoYouWantToForfeitText
	call PrintText
	coord hl, 14, 8
	lb bc, 9, 15
	ld a, TWO_OPTION_MENU
	ld [wTextBoxID], a
	ld a, NO_YES_MENU						; use menu with NO as default cursor position
	ld [wTwoOptionMenuID], a
	call DisplayTextBoxID
	ld a, [wMenuExitMethod]
	cp CHOSE_FIRST_ITEM						; did the player choose NO?
	push af
	call nz, _HandleBattleFacilityDefeat	; if the player chose YES, display defeat text
	pop af									; restore z flag
	ret

_HandleBattleFacilityDefeat:
	ld hl, wEnemyMon1HP
	ld bc, wEnemyMon2 - wEnemyMon1 - 1
	ld d, 0
	ld e, BATTLE_FACILITY_PARTY_LENGTH
.countAliveEnemyMonLoop
	ld a, [hli]
	or [hl]
	jr z, .next
	inc d
.next
	add hl, bc
	dec e
	jr nz, .countAliveEnemyMonLoop
	ld a, d
	dec a
	jr nz, .lossConfirmed					; if the opponent still has at least one non-KO mon, they win
	ld a, [wEnemyBattleStatus3]
	bit SUICIDED, a
	jr z, .lossConfirmed
	xor a
	ld [wBattleResult], a
	jpab TrainerBattleVictory.victory		; if the opponent used a suicide move with their last mon, victory goes to the player
.lossConfirmed
	ld a, 1
	ld [wBattleResult], a					; set result to defeat
	coord hl, 0, 0
	lb bc, 4, 21
	call ClearScreenArea
	coord hl, 10, 0
	lb bc, 7, 9
	call ClearScreenArea
	callab _ScrollTrainerPicAfterBattle
	ld c, 40
	call DelayFrames
	callba SaveTrainerName
	ld hl, BattleFacilityDefeatText
	jp PrintText

GenerateBattleFacilityParty:
	ld hl, wEnemyPartyCount						; set [wEnemyPartyCount] to 0, [wEnemyPartyCount+1] and [wEnemyPartyCount+2] to FF
	xor a
	ld [hli], a
	dec a
	ld [hli], a									; to handle 2 bytes terminator
	ld [hl], a
	ld b, BATTLE_FACILITY_PARTY_LENGTH			; pokemon slot counter
	ld de, wEnemyMon1Moves						; RAM address of the 1st move of the 1st pokémon in the enemy's team
.loopPokemon
	push bc										; to handle 2 bytes species IDs
.chooseTier
	call ChooseTier
.roll
	call Random
	cp c										; c contains the number of entries in the selected tier
	jr nc, .roll
	ld bc, BattleFacilityMons_Tier1End - BattleFacilityMons_Tier1
	call AddNTimes
	ld a, [hli]									; read the species ID of the current slot
	ld [wMonSpeciesTemp + 1], a
	ld a, [hli]
	ld [wMonSpeciesTemp], a
	push hl
	ld hl, wEnemyPartyMons
.duplicatesLoop
	ld a, [hli]
	ld b, a
	cp $ff
	ld a, [hli]
	jr nz, .checkDuplicateSpecies
	cp $ff
	jr z, .addPokemon							; we've reached the end of the enemy's party list without finding a duplicate
.checkDuplicateSpecies
	ld c, a
	push hl
	ld a, [wMonSpeciesTemp + 1]
	ld l, a
	ld a, [wMonSpeciesTemp]
	ld h, a
	call CompareBCtoHL
	pop hl
	jr nz, .duplicatesLoop
	pop hl
	jr .chooseTier								; if we rolled a species already present in the enemy's team, we start over
.addPokemon
	ld a, BATTLE_FACILITY_LEVEL
	ld [wCurEnemyLVL], a			; store it in wCurEnemyLVL for AddPartyMon
	ld a, 1
	ld [wMonDataLocation], a		; input to tell AddPartyMon that we're filling up a trainer party
	call AddPartyMon
	pop hl
	pop bc
	ld c, NUM_MOVES					; move slot counter
.loopMoves
	ld a, [hli]						; read the current move ID of the current pokémon
	cp $ff							; if move ID is $ff, leave this slot unchanged from default moveset
	jr z, .nextMoveEntry			; skip to the next move
	ld [de], a						; else write the move ID in the corresponding RAM location
	ld [wd11e], a					; input for next function
	push hl
	push bc
	callab FarUpdateMovePP			; updates the move's PP according to the new move's data
	pop bc
	pop hl
.nextMoveEntry
	inc de							; increment RAM address to point to the next move slot
	dec c							; decrease slot counter
	jr nz, .loopMoves				; if there are still move slots to fill, loop back to .loopMoves
	push bc
	push hl
	ld h, d
	ld l, e
	ld bc, wEnemyMon1EVs - (wEnemyMon1Moves + NUM_MOVES)	; this makes de point to EVs
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	pop bc
	ld a, [hl]						; read first byte of the EVs, it contains data for the first 4 EVs
	and %00000011					; mask out all but the least significant 2 bits, corresponding to the HP EV
	call SetEV
	ld a, [hl]						; read first byte of the EVs, it contains data for the first 4 EVs
	and %00001100					; mask out all bits except those corresponding to the Attack EV
	srl a							; shift bits all the way to the right
	srl a
	call SetEV
	ld a, [hl]						; read first byte of the EVs, it contains data for the first 4 EVs
	and %00110000					; mask out all bits except those corresponding to the Defense EV
	srl a							; shift bits all the way to the right
	srl a
	srl a
	srl a
	call SetEV
	ld a, [hli]						; read first byte of the EVs, it contains data for the first 4 EVs
	and %11000000					; mask out all bits except those corresponding to the Speed EV
	rlc a							; rotate bits to the left so that they end up at the right most end
	rlc a
	call SetEV
	ld a, [hl]						; read second byte of the EVs, it contains data for the last 2 EVs
	and %00000011					; mask out all bits except those corresponding to the Special Attack EV
	call SetEV
	ld a, [hli]						; read second byte of the EVs, it contains data for the last 2 EVs
	and %00001100					; mask out all bits except those corresponding to the Special Defense EV
	srl a							; shift bits all the way to the right
	srl a
	call SetEV
	push hl
	ld h, d
	ld l, e
	ld de, wEnemyMon1DVs - (wEnemyMon1EVs + NUM_STATS)	; this makes de point to DVs
	add hl, de
	ld d, h
	ld e, l
.computeDVs
	ld a, [wBattleFacilityCurrentStreak]
	and a
	jr z, .checkLowByte2
	ld c, 15									; if current streak high byte is not zero, use maxed DVs
	jr .computeDVsDone
.checkLowByte2
	ld a, [wBattleFacilityCurrentStreak + 1]
	ld c, 0
	cp 11
	jr c, .computeDVsDone
	ld c, 3
	cp 21
	jr c, .computeDVsDone
	ld c, 6
	cp 31
	jr c, .computeDVsDone
	ld c, 9
	cp 41
	jr c, .computeDVsDone
	ld c, 12
	cp 50
	jr c, .computeDVsDone
	ld c, 15
.computeDVsDone
	ld a, c					; here c contains a 4-bit value, copy it in a
	swap c					; then swap c so that the 4-bit value gets shifted to the most significant 4 bits
	or c					; then or a and c together so that the 4-bit value gets repeated in both words of a
	ld c, NUM_DVS
.loopDVs
	ld [de], a
	inc de
	dec c
	jr nz, .loopDVs
	push de
	ld d, h					; put hl in de for next function
	ld e, l					; put hl in de for next function
	push bc
	callab FarUpdateStats
	pop bc
	pop de
	ld h, d
	ld l, e
	ld de, wEnemyMon2Moves - (wEnemyMon1DVs + NUM_DVS)	; this makes de go from the DVs of mon n to the moves of mon n+1
	add hl, de
	ld d, h
	ld e, l
	pop hl
.nextPokemonEntry
	dec b							; one pokémon slot down
	jp nz, .loopPokemon				; while b>0, there are slots remaining, so loop back
	ret

; input: EV byte in a, with irrelevant bits masked
; input: destination address in de
SetEV:
	and a
	ld c, a
	jr z, .storeEV
	ld c, ONE_OUT_OF_THREE
	dec a
	jr z, .storeEV
	ld c, TWO_OUT_OF_THREE
	dec a
	jr z, .storeEV
	ld c, HUNDRED_PERCENT
.storeEV
	ld a, c
	ld [de], a
	inc de
	ret

; chooses a tier to draw a pokemon from according to current streak (or trainer class for special battles)
; puts chosen tier address in hl
; puts chosen tier's size in c
ChooseTier:
	ld a, [wTrainerClass]
	cp PROF_OAK
	jr nz, .notProfOak
	ld hl, BattleFacilityMons_ProfOak
.gotSpecialTier
	ld c, 8
	ret
.notProfOak
	cp BROCK
	jr nz, .notBrock
	ld hl, BattleFacilityMons_Brock
	jr .gotSpecialTier
.notBrock
	cp MISTY
	jr nz, .notMisty
	ld hl, BattleFacilityMons_Misty
	jr .gotSpecialTier
.notMisty
	cp LT_SURGE
	jr nz, .notLtSurge
	ld hl, BattleFacilityMons_LtSurge
	jr .gotSpecialTier
.notLtSurge
	cp ERIKA
	jr nz, .notErika
	ld hl, BattleFacilityMons_Erika
	jr .gotSpecialTier
.notErika
	cp KOGA
	jr nz, .notKoga
	ld hl, BattleFacilityMons_Koga
	jr .gotSpecialTier
.notKoga
	cp SABRINA
	jr nz, .notSabrina
	ld hl, BattleFacilityMons_Sabrina
	jr .gotSpecialTier
.notSabrina
	cp BLAINE
	jr nz, .notBlaine
	ld hl, BattleFacilityMons_Blaine
	jr .gotSpecialTier
.notBlaine
	cp GIOVANNI
	jr nz, .notGiovanni
	ld hl, BattleFacilityMons_Giovanni
	jr .gotSpecialTier
.notGiovanni
	ld a, [wBattleFacilityCurrentStreak]
	and a
	jr nz, .lastCase
.checkLowByte
	ld a, [wBattleFacilityCurrentStreak + 1]
	ld hl, BattleFacilityMons_Tier1
	ld c, 183
	cp 11
	ret c
	cp 21
	jr nc, .next1
	call Random
	cp FIFTY_PERCENT
	ret c
	ld hl, BattleFacilityMons_Tier2
	ld c, 185
	ret
.next1
	cp 31
	jr nc, .next2
	call Random
	cp TWENTY_PERCENT
	ret c
	ld hl, BattleFacilityMons_Tier2
	ld c, 185
	ret
.next2
	ld hl, BattleFacilityMons_Tier2
	ld c, 185
	cp 41
	jr nc, .next3
	call Random
	cp EIGHTY_PERCENT
	ret c
	ld hl, BattleFacilityMons_Tier3
	ld c, 191
	ret
.next3
	cp 51
	jr nc, .lastCase
	call Random
	cp SIXTY_PERCENT
	ret c
	ld hl, BattleFacilityMons_Tier3
	ld c, 191
	ret
.lastCase
	call Random
	cp FIFTY_PERCENT - 1
	ret c
	ld hl, BattleFacilityMons_Tier3
	ld c, 191
	cp $ff
	ret nz
	ld hl, BattleFacilityMons_Tier4	; one chance in 256 to roll a legendary
	ld c, 3
	ret

; inputs: address of a list of pointers (of the form: offset,bank) in hl
; inputs: number of entries in the list in c
; outputs: TX_FAR macro dynamically constructed at wBuffer, and hl pointing to it
LoadRandomText:
	call Random
	cp c
	jr nc, LoadRandomText
	ld de, wBuffer
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
	ret

BattleFacilityVictoryText:
	TX_ASM
	ld a, [wTrainerClass]
	ld hl, BattleFacilityVictoryText_ProfOak
	cp PROF_OAK
	jr z, .printText
	ld hl, BattleFacilityVictoryText_Brock
	cp BROCK
	jr z, .printText
	ld hl, BattleFacilityVictoryText_Misty
	cp MISTY
	jr z, .printText
	ld hl, BattleFacilityVictoryText_LtSurge
	cp LT_SURGE
	jr z, .printText
	ld hl, BattleFacilityVictoryText_Erika
	cp ERIKA
	jr z, .printText
	ld hl, BattleFacilityVictoryText_Koga
	cp KOGA
	jr z, .printText
	ld hl, BattleFacilityVictoryText_Sabrina
	cp SABRINA
	jr z, .printText
	ld hl, BattleFacilityVictoryText_Blaine
	cp BLAINE
	jr z, .printText
	ld hl, BattleFacilityVictoryText_Giovanni
	cp GIOVANNI
	jr z, .printText
	push bc								; save text cursor position
	ld hl, VictoryTextPointers
	ld c, (VictoryTextPointersEnd - VictoryTextPointers) / 3
	call LoadRandomText
	pop bc								; restore text cursor position
.printText
	call TextCommandProcessor			; can't use PrintText here because we want to append the text to an already open text box
	jp TextScriptEnd

VictoryTextPointers:
	dwb _CeladonGymEndBattleText4, BANK(_CeladonGymEndBattleText4)
	dwb _CeladonGymEndBattleText6, BANK(_CeladonGymEndBattleText6)
	dwb _CeladonGymEndBattleText7, BANK(_CeladonGymEndBattleText7)
	dwb _CeladonGymEndBattleText8, BANK(_CeladonGymEndBattleText8)
	dwb _FightingDojoText_5ce93, BANK(_FightingDojoText_5ce93)
	dwb _FightingDojoEndBattleText3, BANK(_FightingDojoEndBattleText3)
	dwb _FightingDojoEndBattleText4, BANK(_FightingDojoEndBattleText4)
	dwb _CinnabarGymText_75aa2, BANK(_CinnabarGymText_75aa2)
	dwb _CinnabarGymText_75999, BANK(_CinnabarGymText_75999)
	dwb _CeruleanGymEndBattleText1, BANK(_CeruleanGymEndBattleText1)
	dwb _CeruleanGymEndBattleText2, BANK(_CeruleanGymEndBattleText2)
	dwb _FuchsiaGymEndBattleText3, BANK(_FuchsiaGymEndBattleText3)
	dwb _MtMoon1EndBattleText4, BANK(_MtMoon1EndBattleText4)
	dwb _MtMoon1EndBattleText5, BANK(_MtMoon1EndBattleText5)
	dwb _MtMoon1EndBattleText7, BANK(_MtMoon1EndBattleText7)
	dwb _MtMoon1EndBattleText8, BANK(_MtMoon1EndBattleText8)
	dwb _MtMoon3EndBattleText5, BANK(_MtMoon3EndBattleText5)
	dwb _PokemonTower4EndBattleText3, BANK(_PokemonTower4EndBattleText3)
	dwb _PokemonTower5EndBattleText2, BANK(_PokemonTower5EndBattleText2)
	dwb _RocketHideout1EndBattleText2, BANK(_RocketHideout1EndBattleText2)
	dwb _RocketHideout1EndBattleText4, BANK(_RocketHideout1EndBattleText4)
	dwb _RocketHideout1EndBattleText5, BANK(_RocketHideout1EndBattleText5)
	dwb _RocketHideout3EndBattleText2, BANK(_RocketHideout3EndBattleText2)
	dwb _RockTunnel1EndBattleText1, BANK(_RockTunnel1EndBattleText1)
	dwb _RockTunnel1EndBattleText4, BANK(_RockTunnel1EndBattleText4)
	dwb _RockTunnel1EndBattleText6, BANK(_RockTunnel1EndBattleText6)
	dwb _RockTunnel1EndBattleText7, BANK(_RockTunnel1EndBattleText7)
	dwb _RockTunnel2EndBattleText7, BANK(_RockTunnel2EndBattleText7)
	dwb _Route3EndBattleText7, BANK(_Route3EndBattleText7)
	dwb _Route6EndBattleText1, BANK(_Route6EndBattleText1)
	dwb _Route6EndBattleText2, BANK(_Route6EndBattleText2)
	dwb _Route6EndBattleText3, BANK(_Route6EndBattleText3)
	dwb _Route6EndBattleText5, BANK(_Route6EndBattleText5)
	dwb _Route6EndBattleText6, BANK(_Route6EndBattleText6)
	dwb _Route8EndBattleText1, BANK(_Route8EndBattleText1)
	dwb _Route8EndBattleText3, BANK(_Route8EndBattleText3)
	dwb _Route9EndBattleText1, BANK(_Route9EndBattleText1)
	dwb _Route9EndBattleText2, BANK(_Route9EndBattleText2)
	dwb _Route9EndBattleText3, BANK(_Route9EndBattleText3)
	dwb _Route9EndBattleText4, BANK(_Route9EndBattleText4)
	dwb _Route10EndBattleText5, BANK(_Route10EndBattleText5)
	dwb _Route10EndBattleText6, BANK(_Route10EndBattleText6)
	dwb _Route11EndBattleText3, BANK(_Route11EndBattleText3)
	dwb _Route11EndBattleText4, BANK(_Route11EndBattleText4)
	dwb _Route11EndBattleText5, BANK(_Route11EndBattleText5)
	dwb _Route12EndBattleText3, BANK(_Route12EndBattleText3)
	dwb _Route12EndBattleText6, BANK(_Route12EndBattleText6)
	dwb _Route12EndBattleText7, BANK(_Route12EndBattleText7)
	dwb _Route13EndBattleText3, BANK(_Route13EndBattleText3)
	dwb _Route13EndBattleText4, BANK(_Route13EndBattleText4)
	dwb _Route13EndBattleText5, BANK(_Route13EndBattleText5)
	dwb _Route13EndBattleText6, BANK(_Route13EndBattleText6)
	dwb _Route13EndBattleText8, BANK(_Route13EndBattleText8)
	dwb _Route13EndBattleText11, BANK(_Route13EndBattleText11)
	dwb _Route14EndBattleText1, BANK(_Route14EndBattleText1)
	dwb _Route14EndBattleText3, BANK(_Route14EndBattleText3)
	dwb _Route14EndBattleText4, BANK(_Route14EndBattleText4)
	dwb _Route14EndBattleText5, BANK(_Route14EndBattleText5)
	dwb _Route14EndBattleText6, BANK(_Route14EndBattleText6)
	dwb _Route15EndBattleText2, BANK(_Route15EndBattleText2)
	dwb _Route15EndBattleText3, BANK(_Route15EndBattleText3)
	dwb _Route15EndBattleText4, BANK(_Route15EndBattleText4)
	dwb _Route15EndBattleText8, BANK(_Route15EndBattleText8)
	dwb _Route16EndBattleText3, BANK(_Route16EndBattleText3)
	dwb _Route16EndBattleText5, BANK(_Route16EndBattleText5)
	dwb _Route17EndBattleText6, BANK(_Route17EndBattleText6)
	dwb _Route18EndBattleText1, BANK(_Route18EndBattleText1)
	dwb _Route19EndBattleText2, BANK(_Route19EndBattleText2)
	dwb _Route19EndBattleText6, BANK(_Route19EndBattleText6)
	dwb _Route19EndBattleText9, BANK(_Route19EndBattleText9)
	dwb _Route19EndBattleText10, BANK(_Route19EndBattleText10)
	dwb _Route20EndBattleText4, BANK(_Route20EndBattleText4)
	dwb _Route20EndBattleText7, BANK(_Route20EndBattleText7)
	dwb _Route20EndBattleText9, BANK(_Route20EndBattleText9)
	dwb _Route21EndBattleText7, BANK(_Route21EndBattleText7)
	dwb _Route21EndBattleText9, BANK(_Route21EndBattleText9)
	dwb _Route24EndBattleText1, BANK(_Route24EndBattleText1)
	dwb _Route24EndBattleText4, BANK(_Route24EndBattleText4)
	dwb _Route25EndBattleText2, BANK(_Route25EndBattleText2)
	dwb _Route25EndBattleText3, BANK(_Route25EndBattleText3)
	dwb _Route25EndBattleText7, BANK(_Route25EndBattleText7)
	dwb _SilphCo3EndBattleText2, BANK(_SilphCo3EndBattleText2)
	dwb _SilphCo4EndBattleText4, BANK(_SilphCo4EndBattleText4)
	dwb _SilphCo5EndBattleText4, BANK(_SilphCo5EndBattleText4)
	dwb _SilphCo7EndBattleText2, BANK(_SilphCo7EndBattleText2)
	dwb _SilphCo8EndBattleText1, BANK(_SilphCo8EndBattleText1)
	dwb _SilphCo8EndBattleText2, BANK(_SilphCo8EndBattleText2)
	dwb _SilphCo9EndBattleText2, BANK(_SilphCo9EndBattleText2)
	dwb _SilphCo10EndBattleText1, BANK(_SilphCo10EndBattleText1)
	dwb _SilphCo10EndBattleText2, BANK(_SilphCo10EndBattleText2)
	dwb _SSAnne8EndBattleText3, BANK(_SSAnne8EndBattleText3)
	dwb _SSAnne9EndBattleText2, BANK(_SSAnne9EndBattleText2)
	dwb _SSAnne9EndBattleText4, BANK(_SSAnne9EndBattleText4)
	dwb _SSAnne10EndBattleText2, BANK(_SSAnne10EndBattleText2)
	dwb _SSAnne10EndBattleText3, BANK(_SSAnne10EndBattleText3)
	dwb _VermilionGymEndBattleText3, BANK(_VermilionGymEndBattleText3)
	dwb _VictoryRoad1EndBattleText1, BANK(_VictoryRoad1EndBattleText1)
	dwb _VictoryRoad1EndBattleText2, BANK(_VictoryRoad1EndBattleText2)
	dwb _VictoryRoad2EndBattleText4, BANK(_VictoryRoad2EndBattleText4)
	dwb _VictoryRoad2EndBattleText5, BANK(_VictoryRoad2EndBattleText5)
	dwb _VictoryRoad3EndBattleText2, BANK(_VictoryRoad3EndBattleText2)
	dwb _VictoryRoad3EndBattleText3, BANK(_VictoryRoad3EndBattleText3)
	dwb _VictoryRoad3EndBattleText4, BANK(_VictoryRoad3EndBattleText4)
	dwb _VictoryRoad3EndBattleText5, BANK(_VictoryRoad3EndBattleText5)
	dwb _ViridianForestEndBattleText2, BANK(_ViridianForestEndBattleText2)
	dwb _ViridianForestEndBattleText3, BANK(_ViridianForestEndBattleText3)
	dwb _ViridianGymEndBattleText1, BANK(_ViridianGymEndBattleText1)
	dwb _ViridianGymEndBattleText5, BANK(_ViridianGymEndBattleText5)
	dwb _ViridianGymEndBattleText8, BANK(_ViridianGymEndBattleText8)
VictoryTextPointersEnd:

BattleFacilityVictoryText_ProfOak:
	TX_FAR _BattleFacilityVictoryText_ProfOak
	db "@"

BattleFacilityVictoryText_Brock:
	TX_FAR _BattleFacilityVictoryText_Brock
	db "@"

BattleFacilityVictoryText_Misty:
	TX_FAR _BattleFacilityVictoryText_Misty
	db "@"

BattleFacilityVictoryText_LtSurge:
	TX_FAR _BattleFacilityVictoryText_LtSurge
	db "@"

BattleFacilityVictoryText_Erika:
	TX_FAR _BattleFacilityVictoryText_Erika
	db "@"

BattleFacilityVictoryText_Koga:
	TX_FAR _BattleFacilityVictoryText_Koga
	db "@"

BattleFacilityVictoryText_Sabrina:
	TX_FAR _BattleFacilityVictoryText_Sabrina
	db "@"

BattleFacilityVictoryText_Blaine:
	TX_FAR _BattleFacilityVictoryText_Blaine
	db "@"

BattleFacilityVictoryText_Giovanni:
	TX_FAR _BattleFacilityVictoryText_Giovanni
	db "@"

BattleFacilityDefeatText:
	TX_FAR _TrainerNameText				; need this here but not in victory text because the game handles it natively for victory text
	TX_ASM
	ld a, [wTrainerClass]
	ld hl, BattleFacilityDefeatText_ProfOak
	cp PROF_OAK
	jr z, .printText
	ld hl, BattleFacilityDefeatText_Brock
	cp BROCK
	jr z, .printText
	ld hl, BattleFacilityDefeatText_Misty
	cp MISTY
	jr z, .printText
	ld hl, BattleFacilityDefeatText_LtSurge
	cp LT_SURGE
	jr z, .printText
	ld hl, BattleFacilityDefeatText_Erika
	cp ERIKA
	jr z, .printText
	ld hl, BattleFacilityDefeatText_Koga
	cp KOGA
	jr z, .printText
	ld hl, BattleFacilityDefeatText_Sabrina
	cp SABRINA
	jr z, .printText
	ld hl, BattleFacilityDefeatText_Blaine
	cp BLAINE
	jr z, .printText
	ld hl, BattleFacilityDefeatText_Giovanni
	cp GIOVANNI
	jr z, .printText
	push bc								; save text cursor position
	ld hl, DefeatTextPointers
	ld c, (DefeatTextPointersEnd - DefeatTextPointers) / 3
	call LoadRandomText
	pop bc								; restore text cursor position
.printText
	call TextCommandProcessor			; can't use PrintText here because we want to append the text to an already open text box
	jp TextScriptEnd

DefeatTextPointers:
	dwb _BattleFacilityDefeatText1, BANK(_BattleFacilityDefeatText1)
	dwb _BattleFacilityDefeatText2, BANK(_BattleFacilityDefeatText2)
	dwb _BattleFacilityDefeatText3, BANK(_BattleFacilityDefeatText3)
	dwb _BattleFacilityDefeatText4, BANK(_BattleFacilityDefeatText4)
	dwb _BattleFacilityDefeatText5, BANK(_BattleFacilityDefeatText5)
	dwb _BattleFacilityDefeatText6, BANK(_BattleFacilityDefeatText6)
	dwb _BattleFacilityDefeatText7, BANK(_BattleFacilityDefeatText7)
	dwb _BattleFacilityDefeatText8, BANK(_BattleFacilityDefeatText8)
	dwb _BattleFacilityDefeatText9, BANK(_BattleFacilityDefeatText9)
	dwb _BattleFacilityDefeatText10, BANK(_BattleFacilityDefeatText10)
	dwb _BattleFacilityDefeatText11, BANK(_BattleFacilityDefeatText11)
	dwb _BattleFacilityDefeatText12, BANK(_BattleFacilityDefeatText12)
	dwb _BattleFacilityDefeatText13, BANK(_BattleFacilityDefeatText13)
	dwb _BattleFacilityDefeatText14, BANK(_BattleFacilityDefeatText14)
	dwb _BattleFacilityDefeatText15, BANK(_BattleFacilityDefeatText15)
	dwb _BattleFacilityDefeatText16, BANK(_BattleFacilityDefeatText16)
	dwb _BattleFacilityDefeatText17, BANK(_BattleFacilityDefeatText17)
	dwb _BattleFacilityDefeatText18, BANK(_BattleFacilityDefeatText18)
	dwb _BattleFacilityDefeatText19, BANK(_BattleFacilityDefeatText19)
	dwb _BattleFacilityDefeatText20, BANK(_BattleFacilityDefeatText20)
	dwb _BattleFacilityDefeatText21, BANK(_BattleFacilityDefeatText21)
	dwb _BattleFacilityDefeatText22, BANK(_BattleFacilityDefeatText22)
	dwb _BattleFacilityDefeatText23, BANK(_BattleFacilityDefeatText23)
	dwb _BattleFacilityDefeatText24, BANK(_BattleFacilityDefeatText24)
	dwb _BattleFacilityDefeatText25, BANK(_BattleFacilityDefeatText25)
	dwb _BattleFacilityDefeatText26, BANK(_BattleFacilityDefeatText26)
	dwb _BattleFacilityDefeatText27, BANK(_BattleFacilityDefeatText27)
	dwb _BattleFacilityDefeatText28, BANK(_BattleFacilityDefeatText28)
	dwb _BattleFacilityDefeatText29, BANK(_BattleFacilityDefeatText29)
	dwb _BattleFacilityDefeatText30, BANK(_BattleFacilityDefeatText30)
	dwb _BattleFacilityDefeatText31, BANK(_BattleFacilityDefeatText31)
	dwb _BattleFacilityDefeatText32, BANK(_BattleFacilityDefeatText32)
	dwb _BattleFacilityDefeatText33, BANK(_BattleFacilityDefeatText33)
	dwb _BattleFacilityDefeatText34, BANK(_BattleFacilityDefeatText34)
	dwb _BattleFacilityDefeatText35, BANK(_BattleFacilityDefeatText35)
	dwb _BattleFacilityDefeatText36, BANK(_BattleFacilityDefeatText36)
	dwb _BattleFacilityDefeatText37, BANK(_BattleFacilityDefeatText37)
	dwb _BattleFacilityDefeatText38, BANK(_BattleFacilityDefeatText38)
	dwb _BattleFacilityDefeatText39, BANK(_BattleFacilityDefeatText39)
	dwb _BattleFacilityDefeatText40, BANK(_BattleFacilityDefeatText40)
	dwb _BattleFacilityDefeatText41, BANK(_BattleFacilityDefeatText41)
	dwb _BattleFacilityDefeatText42, BANK(_BattleFacilityDefeatText42)
	dwb _BattleFacilityDefeatText43, BANK(_BattleFacilityDefeatText43)
	dwb _BattleFacilityDefeatText44, BANK(_BattleFacilityDefeatText44)
	dwb _BattleFacilityDefeatText45, BANK(_BattleFacilityDefeatText45)
	dwb _BattleFacilityDefeatText46, BANK(_BattleFacilityDefeatText46)
	dwb _BattleFacilityDefeatText47, BANK(_BattleFacilityDefeatText47)
	dwb _BattleFacilityDefeatText48, BANK(_BattleFacilityDefeatText48)
	dwb _BattleFacilityDefeatText49, BANK(_BattleFacilityDefeatText49)
	dwb _BattleFacilityDefeatText50, BANK(_BattleFacilityDefeatText50)
	dwb _BattleFacilityDefeatText51, BANK(_BattleFacilityDefeatText51)
	dwb _BattleFacilityDefeatText52, BANK(_BattleFacilityDefeatText52)
	dwb _BattleFacilityDefeatText53, BANK(_BattleFacilityDefeatText53)
	dwb _BattleFacilityDefeatText54, BANK(_BattleFacilityDefeatText54)
	dwb _BattleFacilityDefeatText55, BANK(_BattleFacilityDefeatText55)
	dwb _BattleFacilityDefeatText56, BANK(_BattleFacilityDefeatText56)
	dwb _BattleFacilityDefeatText57, BANK(_BattleFacilityDefeatText57)
	dwb _BattleFacilityDefeatText58, BANK(_BattleFacilityDefeatText58)
	dwb _BattleFacilityDefeatText59, BANK(_BattleFacilityDefeatText59)
	dwb _BattleFacilityDefeatText60, BANK(_BattleFacilityDefeatText60)
	dwb _BattleFacilityDefeatText61, BANK(_BattleFacilityDefeatText61)
	dwb _BattleFacilityDefeatText62, BANK(_BattleFacilityDefeatText62)
	dwb _BattleFacilityDefeatText63, BANK(_BattleFacilityDefeatText63)
	dwb _BattleFacilityDefeatText64, BANK(_BattleFacilityDefeatText64)
	dwb _BattleFacilityDefeatText65, BANK(_BattleFacilityDefeatText65)
	dwb _BattleFacilityDefeatText66, BANK(_BattleFacilityDefeatText66)
	dwb _BattleFacilityDefeatText67, BANK(_BattleFacilityDefeatText67)
	dwb _BattleFacilityDefeatText68, BANK(_BattleFacilityDefeatText68)
	dwb _BattleFacilityDefeatText69, BANK(_BattleFacilityDefeatText69)
	dwb _BattleFacilityDefeatText70, BANK(_BattleFacilityDefeatText70)
	dwb _BattleFacilityDefeatText71, BANK(_BattleFacilityDefeatText71)
	dwb _BattleFacilityDefeatText72, BANK(_BattleFacilityDefeatText72)
	dwb _BattleFacilityDefeatText73, BANK(_BattleFacilityDefeatText73)
	dwb _BattleFacilityDefeatText74, BANK(_BattleFacilityDefeatText74)
	dwb _BattleFacilityDefeatText75, BANK(_BattleFacilityDefeatText75)
	dwb _BattleFacilityDefeatText76, BANK(_BattleFacilityDefeatText76)
	dwb _BattleFacilityDefeatText77, BANK(_BattleFacilityDefeatText77)
	dwb _BattleFacilityDefeatText78, BANK(_BattleFacilityDefeatText78)
	dwb _BattleFacilityDefeatText79, BANK(_BattleFacilityDefeatText79)
	dwb _BattleFacilityDefeatText80, BANK(_BattleFacilityDefeatText80)
	dwb _BattleFacilityDefeatText81, BANK(_BattleFacilityDefeatText81)
	dwb _BattleFacilityDefeatText82, BANK(_BattleFacilityDefeatText82)
	dwb _BattleFacilityDefeatText83, BANK(_BattleFacilityDefeatText83)
	dwb _BattleFacilityDefeatText84, BANK(_BattleFacilityDefeatText84)
	dwb _BattleFacilityDefeatText85, BANK(_BattleFacilityDefeatText85)
	dwb _BattleFacilityDefeatText86, BANK(_BattleFacilityDefeatText86)
	dwb _BattleFacilityDefeatText87, BANK(_BattleFacilityDefeatText87)
	dwb _BattleFacilityDefeatText88, BANK(_BattleFacilityDefeatText88)
	dwb _BattleFacilityDefeatText89, BANK(_BattleFacilityDefeatText89)
	dwb _BattleFacilityDefeatText90, BANK(_BattleFacilityDefeatText90)
	dwb _BattleFacilityDefeatText91, BANK(_BattleFacilityDefeatText91)
	dwb _BattleFacilityDefeatText92, BANK(_BattleFacilityDefeatText92)
	dwb _BattleFacilityDefeatText93, BANK(_BattleFacilityDefeatText93)
	dwb _BattleFacilityDefeatText94, BANK(_BattleFacilityDefeatText94)
	dwb _BattleFacilityDefeatText95, BANK(_BattleFacilityDefeatText95)
	dwb _BattleFacilityDefeatText96, BANK(_BattleFacilityDefeatText96)
	dwb _BattleFacilityDefeatText97, BANK(_BattleFacilityDefeatText97)
	dwb _BattleFacilityDefeatText98, BANK(_BattleFacilityDefeatText98)
	dwb _BattleFacilityDefeatText99, BANK(_BattleFacilityDefeatText99)
	dwb _BattleFacilityDefeatText100, BANK(_BattleFacilityDefeatText100)
DefeatTextPointersEnd:

BattleFacilityDefeatText_ProfOak:
	TX_FAR _BattleFacilityDefeatText_ProfOak
	db "@"

BattleFacilityDefeatText_Brock:
	TX_FAR _BattleFacilityDefeatText_Brock
	db "@"

BattleFacilityDefeatText_Misty:
	TX_FAR _BattleFacilityDefeatText_Misty
	db "@"

BattleFacilityDefeatText_LtSurge:
	TX_FAR _BattleFacilityDefeatText_LtSurge
	db "@"

BattleFacilityDefeatText_Erika:
	TX_FAR _BattleFacilityDefeatText_Erika
	db "@"

BattleFacilityDefeatText_Koga:
	TX_FAR _BattleFacilityDefeatText_Koga
	db "@"

BattleFacilityDefeatText_Sabrina:
	TX_FAR _BattleFacilityDefeatText_Sabrina
	db "@"

BattleFacilityDefeatText_Blaine:
	TX_FAR _BattleFacilityDefeatText_Blaine
	db "@"

BattleFacilityDefeatText_Giovanni:
	TX_FAR _BattleFacilityDefeatText_Giovanni
	db "@"

DoYouWantToForfeitText:
	TX_FAR _DoYouWantToForfeitText
	db "@"

INCLUDE "data/battle_facility_mons.asm"

INCLUDE "text/maps/BattleFacility.asm"

INCLUDE "text/maps/BattleFacilityElevator.asm"
