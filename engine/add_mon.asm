_AddPartyMon:
; Adds a new mon to the player's or enemy's party.
; [wMonDataLocation] is used in an unusual way in this function.
; If the lower nybble is 0, the mon is added to the player's party, else the enemy's.
; If the entire value is 0, then the player is allowed to name the mon.
	ld de, wPartyCount
	ld a, [wMonDataLocation]
	and $f
	jr z, .next
	ld de, wEnemyPartyCount
.next
	ld a, [de]
	inc a
	cp PARTY_LENGTH + 1
	ret nc ; return if the party is already full
	ld [de], a
	ld a, [de]
	ld [hNewPartyLength], a
	inc de							; skip the Party Count byte
	dec a							; use the old party length to skip existing party species
	add a							; to handle 2 bytes species IDs (double old party size to move de to the right offset in party species)
	add e
	ld e, a
	jr nc, .noCarry
	inc d
.noCarry
	ld a, [wMonSpeciesTemp]			; to handle 2 bytes species IDs
	ld [de], a 						; write species of new mon in party list
	inc de
	ld a, [wMonSpeciesTemp + 1]		; to handle 2 bytes species IDs
	ld [de], a						; to handle 2 bytes species IDs
	inc de							; to handle 2 bytes species IDs
	ld a, $ff ; terminator
	ld [de], a
	inc de							; to handle 2 bytes terminator
	ld [de], a						; to handle 2 bytes terminator
	ld hl, wPartyMonOT
	ld a, [wMonDataLocation]
	and $f
	jr z, .next2
	ld hl, wEnemyMonOT
.next2
	ld a, [hNewPartyLength]
	dec a
	call SkipFixedLengthTextEntries
	ld d, h
	ld e, l
	ld hl, wPlayerName
	ld bc, NAME_LENGTH
	call CopyData
	ld a, [wMonDataLocation]
	and a
	jr nz, .skipNaming
	ld hl, wPartyMonNicks
	ld a, [hNewPartyLength]
	dec a
	call SkipFixedLengthTextEntries
	ld a, NAME_MON_SCREEN
	ld [wNamingScreenType], a
	predef AskName
.skipNaming
	ld hl, wPartyMons
	ld a, [wMonDataLocation]
	and $f
	jr z, .next3
	ld hl, wEnemyMons
.next3
	ld a, [hNewPartyLength]
	dec a
	ld bc, wPartyMon2 - wPartyMon1
	call AddNTimes
	ld e, l
	ld d, h
	call GetMonHeader
	ld a, [wMonSpeciesTemp]			; to handle 2 bytes species IDs
	ld [de], a 						; write species of new mon in party data
	inc de
	ld a, [wMonSpeciesTemp + 1]		; to handle 2 bytes species IDs
	ld [de], a						; to handle 2 bytes species IDs
	inc de							; to handle 2 bytes species IDs
	push hl
	ld a, [wMonDataLocation]
	and $f
	ld a, $88						; changed $98 into $88 to have all DVs equal to 8 now that HP has its own byte
	ld b, $88
	ld c, $88						; add this for the new DV for special defense
	jr nz, .next4

; If the mon is being added to the player's party, update the pokedex.
	call GetDexNumberBySpeciesID
	call AddToPokedexOwned			; to handle 2 bytes species IDs
	call AddToPokedexSeen			; to handle 2 bytes species IDs

	pop hl
	push hl

	ld a, [wIsInBattle]
	and a ; is this a wild mon caught in battle?
	jr nz, .copyEnemyMonData

; gift mon
	push hl
	push bc
	push de
	call Random
	ld [wEnemyMonDVs], a
	call Random
	ld [wEnemyMonDVs + 1], a
	call Random
	ld [wEnemyMonDVs + 2], a
	ld a, [wMonSpeciesTemp]
	ld b, a
	ld a, [wMonSpeciesTemp + 1]
	ld c, a
	call LegendaryDVs.gotSpecies	; give 3 maxed DVs for legendary/mythical pokemon
	pop de
	pop bc
	pop hl
	jr z, .generateRandomDVs
	ld a, [wEnemyMonDVs]
	ld b, a
	ld a, [wEnemyMonDVs + 1]
	ld c, a
	ld a, [wEnemyMonDVs + 2]
	jr .next4
	
.generateRandomDVs
	call Random ; generate random IVs
	ld b, a
	call Random
	ld c, a			; add this for the new DV for special defense
	call Random		; add this for the new DV for special defense

.next4
	push bc
	ld bc, wPartyMon1DVs - wPartyMon1
	add hl, bc
	pop bc
	ld [hli], a
	ld [hl], b
	inc hl														; add this for the new DV for special defense
	ld [hl], c													; add this for the new DV for special defense
	ld bc, (wPartyMon1HPEV - 1) - (wPartyMon1DVs + NUM_DVS - 1)
	add hl, bc
	ld a, 1												; HP stat
	ld c, a
	ld b, 0
	call CalcStat										; calc HP stat (set cur Hp to max HP)
	ld a, [H_MULTIPLICAND+1]
	ld [de], a
	inc de
	ld a, [H_MULTIPLICAND+2]
	ld [de], a
	inc de
	xor a
	ld [de], a         ; box level
	inc de
	ld [de], a         ; status ailments
	inc de
	jr .copyMonTypesAndMoves
.copyEnemyMonData
	ld bc, wEnemyMon1DVs - wEnemyMon1
	add hl, bc
	ld a, [wEnemyMonDVs] ; copy IVs from cur enemy mon
	ld [hli], a
	ld a, [wEnemyMonDVs + 1]
	ld [hli], a					; add this to account for new DV for special defense
	ld a, [wEnemyMonDVs + 2]	; add this to account for new DV for special defense
	ld [hl], a
	ld a, [wEnemyMonHP]			; copy HP from cur enemy mon
	ld [de], a
	inc de
	ld a, [wEnemyMonHP+1]
	ld [de], a
	inc de
	xor a
	ld [de], a                ; box level
	inc de
	ld a, [wEnemyMonStatus]   ; copy status ailments from cur enemy mon
	ld [de], a
	inc de
.copyMonTypesAndMoves
	ld hl, wMonHTypes
	ld a, [hli]       ; type 1
	ld [de], a
	inc de
	ld a, [hli]       ; type 2
	ld [de], a
	; removed the copy of the catch rate
	ld hl, wMonHMoves		; initialize moveset to the starting moves of the species
	ld a, [hli]
	inc de
	push de					; here de point to 1st move slot
	ld [de], a
	ld a, [hli]
	inc de
	ld [de], a
	ld a, [hli]
	inc de
	ld [de], a
	ld a, [hli]
	inc de
	ld [de], a
	push de					; here de points to the 4th move slot
	dec de
	dec de
	dec de					; go back to the first move slot for next function
	xor a
	ld [wLearningMovesFromDayCare], a
	predef WriteMonMoves	; this function gives the mon the moves from its learnset according to its level
	pop de
	ld a, [wPlayerID]  ; set trainer ID to player ID
	inc de
	ld [de], a
	ld a, [wPlayerID + 1]
	inc de
	ld [de], a
	xor a
	ld b, NUM_STATS			; use NUM_STATS instead of NUM_STATS * 2 since now EVs are stored over 1 byte
.writeEVsLoop				; set all EVs to 0
	inc de
	ld [de], a
	dec b
	jr nz, .writeEVsLoop
	push de						; moved the part handling experience after the part handling EVs
	ld a, [wCurEnemyLVL]
	ld d, a
	callab CalcExperience
	pop de
	inc de
	ld a, [hExperience] ; write experience
	ld [de], a
	inc de
	ld a, [hExperience + 1]
	ld [de], a
	inc de
	ld a, [hExperience + 2]
	ld [de], a
	ld bc, (wPartyMon1PP - 1) - (wPartyMon1Exp + 2)
	ld h, d														; copy de into hl
	ld l, e
	add hl, bc													; make hl point to last DV byte
	ld d, h														; copy hl back in de
	ld e, l
	pop hl														; pop the address of 1st move slot into hl
	call AddPartyMon_WriteMovePP
	inc de
	ld a, [wCurEnemyLVL]
	ld [de], a
	inc de
	ld a, [wIsInBattle]
	dec a
	jr nz, .calcFreshStats
	ld hl, wEnemyMonMaxHP
	ld bc, NUM_STATS * 2
	call CopyData          ; copy stats of cur enemy mon
	pop hl
	jr .done
.calcFreshStats
	pop hl
	ld bc, (wPartyMon1HPEV - 1) - wPartyMon1
	add hl, bc
	ld b, 1
	call CalcStats         ; calculate fresh set of stats
.done
	scf
	ret

LoadMovePPs:
	call GetPredefRegisters
	; fallthrough
AddPartyMon_WriteMovePP:
	ld b, NUM_MOVES
.pploop
	ld a, [hli]     ; read move ID
	and a
	jr z, .empty
	push hl
	push de
	push bc
	ld de, wcd6d
	cp SIGNATURE_MOVE_1
	jr z, .signatureMove
	cp SIGNATURE_MOVE_2
	jr nz, .notSignatureMove
.signatureMove
	ld [wd11e], a
	callab ReadSignatureMoveData
	jr .afterReadMove
.notSignatureMove
	dec a
	ld hl, Moves
	ld bc, MoveEnd - Moves
	call AddNTimes
	ld a, BANK(Moves)
	call FarCopyData
.afterReadMove
	pop bc
	pop de
	pop hl
	ld a, [wcd6d + MOVEDATA_PP]
.empty
	inc de
	ld [de], a
	dec b
	jr nz, .pploop ; there are still moves to read
	ret

; adds enemy mon [wcf91] (at position [wWhichPokemon] in enemy list) to own party
; used in the cable club trade center
_AddEnemyMonToPlayerParty:
	ld hl, wPartyCount
	ld a, [hl]
	cp PARTY_LENGTH
	scf
	ret z						; party full, return failure
	inc a
	ld [hli], a					; add 1 to party members and skip party count byte
	dec a						; use old party count to get offset of party species data
	ld c, a
	ld b, $0
	add hl, bc
	add hl, bc					; to handle 2 bytes species IDs
	ld a, [wMonSpeciesTemp]		; to handle 2 bytes species IDs
	ld [hli], a					; to handle 2 bytes species IDs (add mon as last list entry)
	ld a, [wMonSpeciesTemp + 1]	; to handle 2 bytes species IDs
	ld [hli], a					; add mon as last list entry
	ld a, $ff					; to handle 2 bytes terminator
	ld [hli], a					; to handle 2 bytes terminator
	ld [hl], a					; to handle 2 bytes terminator
	ld hl, wPartyMons
	ld a, [wPartyCount]
	dec a
	ld bc, wPartyMon2 - wPartyMon1
	call AddNTimes
	ld e, l
	ld d, h
	ld hl, wLoadedMon
	call CopyData    ; write new mon's data (from wLoadedMon)
	ld hl, wPartyMonOT
	ld a, [wPartyCount]
	dec a
	call SkipFixedLengthTextEntries
	ld d, h
	ld e, l
	ld hl, wEnemyMonOT
	ld a, [wWhichPokemon]
	call SkipFixedLengthTextEntries
	ld bc, NAME_LENGTH
	call CopyData    ; write new mon's OT name (from an enemy mon)
	ld hl, wPartyMonNicks
	ld a, [wPartyCount]
	dec a
	call SkipFixedLengthTextEntries
	ld d, h
	ld e, l
	ld hl, wEnemyMonNicks
	ld a, [wWhichPokemon]
	call SkipFixedLengthTextEntries
	ld bc, NAME_LENGTH
	call CopyData				; write new mon's nickname (from an enemy mon)
	call GetDexNumberBySpeciesID
	call AddToPokedexOwned			; to handle 2 bytes species IDs
	call AddToPokedexSeen			; to handle 2 bytes species IDs
	and a
	ret							; return success

_MoveMon:
	ld a, [wMoveMonType]
	and a   ; BOX_TO_PARTY
	jr z, .checkPartyMonSlots
	cp DAYCARE_TO_PARTY
	jr z, .checkPartyMonSlots
	cp PARTY_TO_DAYCARE
	ld hl, wDayCareMon
	jr nz, .partyToBox
	call CheckLastPokemonAlive
	ret c
	jr .findMonDataSrc
.partyToBox
	; else it's PARTY_TO_BOX
	ld hl, wNumInBox
	ld a, [hl]
	cp MONS_PER_BOX
	jr nz, .partyOrBoxNotFull
	jr .boxFull
.checkPartyMonSlots
	ld hl, wPartyCount
	ld a, [hl]
	cp PARTY_LENGTH
	jr nz, .partyOrBoxNotFull
.boxFull
	scf
	ret
.partyOrBoxNotFull
	call CheckLastPokemonAlive
	ret c
	inc a
	ld [hli], a				; to handle 2 bytes species IDs (increment number of mons in party/box)
	dec a					; to handle 2 bytes species IDs
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc				; to handle 2 bytes species IDs
	ld a, [wMoveMonType]
	cp DAYCARE_TO_PARTY
	ld bc, wDayCareMon		; to handle 2 bytes species IDs
	jr z, .copySpecies
	ld bc, wMonSpeciesTemp	; to handle 2 bytes species IDs
.copySpecies
	ld a, [bc]				; to handle 2 bytes species IDs
	ld [hli], a				; to handle 2 bytes species IDs (write new mon ID)
	inc bc					; to handle 2 bytes species IDs
	ld a, [bc]				; to handle 2 bytes species IDs
	ld [hli], a				; write new mon ID
	ld a, $ff				; to handle 2 bytes terminator
	ld [hli], a				; to handle 2 bytes terminator
	ld [hl], a				; to handle 2 bytes terminator
.findMonDataDest
	ld a, [wMoveMonType]
	dec a
	ld hl, wPartyMons
	ld bc, wPartyMon2 - wPartyMon1
	ld a, [wPartyCount]
	jr nz, .addMonOffset
	; if it's PARTY_TO_BOX
	ld hl, wBoxMons
	ld bc, wBoxMon2 - wBoxMon1
	ld a, [wNumInBox]
.addMonOffset
	dec a
	call AddNTimes
.findMonDataSrc
	push hl
	ld e, l
	ld d, h
	ld a, [wMoveMonType]
	and a
	ld hl, wBoxMons
	ld bc, wBoxMon2 - wBoxMon1
	jr z, .addMonOffset2
	cp DAYCARE_TO_PARTY
	ld hl, wDayCareMon
	jr z, .copyMonData
	ld hl, wPartyMons
	ld bc, wPartyMon2 - wPartyMon1
.addMonOffset2
	ld a, [wWhichPokemon]
	call AddNTimes
.copyMonData
	push hl
	push de
	ld bc, wBoxMon2 - wBoxMon1
	call CopyData
	pop de
	pop hl
	ld a, [wMoveMonType]
	and a ; BOX_TO_PARTY
	jr z, .findOTdest
	cp DAYCARE_TO_PARTY
	jr z, .findOTdest
	ld bc, wBoxMon2 - wBoxMon1
	add hl, bc
	ld a, [hl]						; hl = Level
	inc de
	inc de
	inc de
	inc de							; to handle 2 bytes species IDs
	ld [de], a						; de = BoxLevel
.findOTdest
	ld a, [wMoveMonType]
	cp PARTY_TO_DAYCARE
	ld de, wDayCareMonOT
	jr z, .findOTsrc
	dec a 
	ld hl, wPartyMonOT
	ld a, [wPartyCount]
	jr nz, .addOToffset
	ld hl, wBoxMonOT
	ld a, [wNumInBox]
.addOToffset
	dec a
	call SkipFixedLengthTextEntries
	ld d, h
	ld e, l
.findOTsrc
	ld hl, wBoxMonOT
	ld a, [wMoveMonType]
	and a
	jr z, .addOToffset2
	ld hl, wDayCareMonOT
	cp DAYCARE_TO_PARTY
	jr z, .copyOT
	ld hl, wPartyMonOT
.addOToffset2
	ld a, [wWhichPokemon]
	call SkipFixedLengthTextEntries
.copyOT
	ld bc, NAME_LENGTH
	call CopyData
	ld a, [wMoveMonType]
.findNickDest
	cp PARTY_TO_DAYCARE
	ld de, wDayCareMonName
	jr z, .findNickSrc
	dec a
	ld hl, wPartyMonNicks
	ld a, [wPartyCount]
	jr nz, .addNickOffset
	ld hl, wBoxMonNicks
	ld a, [wNumInBox]
.addNickOffset
	dec a
	call SkipFixedLengthTextEntries
	ld d, h
	ld e, l
.findNickSrc
	ld hl, wBoxMonNicks
	ld a, [wMoveMonType]
	and a
	jr z, .addNickOffset2
	ld hl, wDayCareMonName
	cp DAYCARE_TO_PARTY
	jr z, .copyNick
	ld hl, wPartyMonNicks
.addNickOffset2
	ld a, [wWhichPokemon]
	call SkipFixedLengthTextEntries
.copyNick
	ld bc, NAME_LENGTH
	call CopyData
	pop hl
	ld a, [wMoveMonType]
	cp PARTY_TO_BOX
	jr z, .done
	cp PARTY_TO_DAYCARE
	jr z, .done
	push hl
	srl a
	add $2
	ld [wMonDataLocation], a			; at this point, hl=wPartyMonX (X=index in party of withdrawn mon) and de=wPartyMonNicks + 22
	call LoadMonData
	callba CalcLevelFromExperience
	ld a, d
	ld [wCurEnemyLVL], a
	pop hl											; at this point, hl=wPartyMonX (de isn't significant)
	ld bc, wBoxMon2 - wBoxMon1
	add hl, bc										; this makes hl point to wPartyMonXLevel
	ld [hli], a										; this makes hl point to wPartyMonXMaxHP
	ld d, h
	ld e, l											; at this point, hl=de=wPartyMonXMaxHP
	ld bc, (wPartyMon1HPEV - 1) - wPartyMon1MaxHP
	add hl, bc										; this makes hl point to wPartyMon1HPEV - 1 for next function
	ld b, $1
	call CalcStats
.done
	and a
	ret

; sets carry flag if depositing the mon would leave the party with only fainted mons, unsets it otherwise
CheckLastPokemonAlive:
	push hl
	push af
	ld a, [wMoveMonType]
	cp PARTY_TO_BOX
	jr z, .check
	cp PARTY_TO_DAYCARE
	jr nz, .allow
.check
	ld hl, wPartyMon1HP
	ld bc, wPartyMon2 - wPartyMon1
	ld a, [wPartyCount]
	ld e, a
	ld d, 0
.loop
	ld a, [wWhichPokemon]
	cp d					; skip the mon to be deposited
	jr z, .next
	ld a, [hli]
	or [hl]
	jr nz, .allow			; if we found a mon with non-zero HP, allow deposit
	dec hl
.next
	inc d
	ld a, d
	cp e
	jr z, .forbid			; if we went over the whole team without finding a member with non-zero HP, forbid deposit
	add hl, bc
	jr .loop
.forbid
	pop af
	pop hl
	scf
	ret
.allow
	pop af
	pop hl
	and a
	ret

; check if enemy is legendary/mythical and if yes, set 3 random DVs to max
LegendaryDVs:
	ld a, [wEnemyBattleStatus3]
	bit TRANSFORMED, a
	ret nz								; if enemy is transformed, don't modify DVs since they have already been set prior to its transformation
	ld a, [wEnemyMonSpecies]
	ld b, a
	ld a, [wEnemyMonSpecies + 1]
	ld c, a
.gotSpecies
	ld hl, LegendaryMythicalSpecies
.checkSpecies
	ld a, [hli]
	cp $ff
	ld d, a
	ld a, [hli]
	jr nz, .next
	cp $ff
	ret z
.next
	push hl
	ld l, d
	ld h, a
	call CompareBCtoHL
	pop hl
	jr nz, .checkSpecies
.set3DVsToMax
	call BattleRandom
	and %00111111					; generate six random bits, one for each DV
	ld b, a
	ld c, a
	xor a
	srl b
	adc 0
	srl b
	adc 0
	srl b
	adc 0
	srl b
	adc 0
	srl b
	adc 0
	srl b
	adc 0
	cp 3							; check that exactly 3 bits are 1 among the 6 we generated, then check each one in turn and set corresponding DV to max if it's set
	jr nz, .set3DVsToMax
	ld hl, wEnemyMonDVs
	srl c							; here c contains the original value containing the 6 random bits of which we made sure exactly 3 are set
	jr nc, .checkDV2
	ld a, [hl]
	or $0f
	ld [hl], a
.checkDV2
	srl c
	jr nc, .checkDV3
	ld a, [hl]
	or $f0
	ld [hl], a
.checkDV3
	inc hl
	srl c
	jr nc, .checkDV4
	ld a, [hl]
	or $0f
	ld [hl], a
.checkDV4
	srl c
	jr nc, .checkDV5
	ld a, [hl]
	or $f0
	ld [hl], a
.checkDV5
	inc hl
	srl c
	jr nc, .checkDV6
	ld a, [hl]
	or $0f
	ld [hl], a
.checkDV6
	srl c
	jr nc, .done
	ld a, [hl]
	or $f0
	ld [hl], a
.done
	and 1					; unset z flag when DVs are set
	ret

LegendaryMythicalSpecies:
	dw ARTICUNO
	dw ZAPDOS
	dw MOLTRES
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
