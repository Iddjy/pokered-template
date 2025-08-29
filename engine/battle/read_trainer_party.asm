ReadTrainer:
; don't change any moves in a link battle
	ld a, [wLinkState]
	and a
	ret nz
	ld a, [wBattleType]
	cp BATTLE_TYPE_FACILITY						; parties are determined differently in the Battle Facility
	ret z
	ld hl, wEnemyPartyCount						; set [wEnemyPartyCount] to 0, [wEnemyPartyCount+1] and [wEnemyPartyCount+2] to FF
	xor a
	ld [hli], a
	dec a
	ld [hli], a									; to handle 2 bytes terminator
	ld [hl], a
	ld a, [wTrainerClass]
	dec a
	add a
	ld hl, TrainerClassPointers					; pointer table for trainer classes
	ld c, a
	ld b, 0
	add hl, bc									; hl contains the address of the pointer to the trainer class
	ld a, [hli]
	ld h, [hl]
	ld l, a										; hl now points to the pointer of the first trainer of the trainer class
	ld a, [wTrainerNo]							; which instance of the trainer class are we fighting
	dec a										; trainer numbers start at 1
	add a										; double the trainer number because pointers are 2 bytes
	ld e, a
	ld d, 0
	add hl, de									; advance hl by twice the trainer number to get to the pointer to the trainer data
	ld a, [hli]									; read trainer pointer
	ld h, [hl]									; read trainer pointer
	ld l, a										; read trainer pointer
.loadTrainerData
	ld a, [hli]									; read trainer party size
	ld b, a										; pokemon slot counter
	ld de, wEnemyMon1Moves						; RAM address of the 1st move of the 1st pokémon in the enemy's team
.loopPokemon
	push bc										; to handle 2 bytes species IDs
	ld a, [hli]									; read the species ID of the current slot
	ld c, a										; to handle 2 bytes species IDs
	ld a, [hli]									; to handle 2 bytes species IDs
	ld b, a										; to handle 2 bytes species IDs
	or c										; to handle 2 bytes species IDs
	jr nz, .addPokemon							; if species ID is not null, add the pokémon to the party
	push de										; else skip to the next pokémon entry
	ld de, TrainerDataMon1End - TrainerDataMon1 - 2	; size of a pokemon entry minus 2 because we incremented hl twice already
	add hl, de									; advance hl by enough bytes in order to get to the next pokémon entry
	pop de
	pop bc										; to handle 2 bytes species IDs
	jp .nextPokemonEntry
.addPokemon
	ld a, [hli]						; read the level of the current pokémon
	ld [wCurEnemyLVL], a			; store it in wCurEnemyLVL for AddPartyMon
	ld a, 1
	ld [wMonDataLocation], a		; input to tell AddPartyMon that we're filling up a trainer party
	ld a, b							; to handle 2 bytes species IDs
	ld [wMonSpeciesTemp], a			; to handle 2 bytes species IDs
	ld a, c							; to handle 2 bytes species IDs
	ld [wMonSpeciesTemp + 1], a		; to handle 2 bytes species IDs
	call AddPartyMon
	pop bc							; to handle 2 bytes species IDs
	ld c, NUM_MOVES					; move slot counter
.loopMoves
	ld a, [hli]						; read the current move ID of the current pokémon
	cp $ff							; if move ID is $ff, leave this slot unchanged from default moveset
	jr z, .nextMoveEntry			; skip to the next move
	ld [de], a						; else write the move ID in the corresponding RAM location
	call updateMovePP				; updates the move's PP according to the new move's data
.nextMoveEntry
	inc de							; increment RAM address to point to the next move slot
	dec c							; decrease slot counter
	jr nz, .loopMoves				; if there are still move slots to fill, loop back to .loopMoves
	push hl
	ld h, d
	ld l, e
	ld de, wEnemyMon1DVs - (wEnemyMon1Moves + NUM_MOVES)	; this makes de point to DVs
	add hl, de
	push hl
	ld d, h
	ld e, l
	ld a, [wTrainerClass]
	dec a
	ld hl, TrainerClassTiers
	add l						; add the trainer class index to hl
	ld l, a
	jr nc, .noCarry
	inc h
.noCarry
	push hl
	ld a, [hl]					; load the trainer class DVs/EVs tiers
	and $F0						; mask out the EVs tier
	swap a						; put the DVs tier in the least significant word
	and a
	jr z, .computeDVsDone		; if the DVs tier is 0, all DVs are set to 0
	ld c, a
	ld a, AI_TRAINER_DV_INCREMENT
	ld h, a
.computeDVs
	dec c
	jr z, .computeDVsDone
	add h						; for each increment in the tier, add AI_TRAINER_DV_INCREMENT to the DV byte
	jr .computeDVs
.computeDVsDone
	ld c, NUM_DVS
.loopDVs
	ld [de], a
	inc de
	dec c
	jr nz, .loopDVs
	ld h, d
	ld l, e
	ld de, wEnemyMon1EVs - (wEnemyMon1DVs + NUM_DVS)	; this makes de go from the DVs to the EVs
	add hl, de
	ld d, h
	ld e, l
	pop hl
	ld a, [hl]					; load the trainer class DVs/EVs tiers
	and $0F						; mask out the DVs tier
	and a
	jr z, .computeEVsDone		; if the EVs tier is 0, all EVs are set to 0
	ld c, a
	ld a, AI_TRAINER_EV_INCREMENT
	ld h, a
.computeEVs
	dec c
	jr z, .computeEVsDone
	add h						; for each increment in the tier, add AI_TRAINER_EV_INCREMENT EVs to all stats
	jr .computeEVs
.computeEVsDone
	ld c, NUM_STATS
.loopEVs
	ld [de], a
	inc de
	dec c						; decrease counter
	jr nz, .loopEVs
	pop hl
	call updateStats
	ld h, d
	ld l, e
	ld de, wEnemyMon2Moves - (wEnemyMon1EVs + NUM_STATS)	; this makes de go from the EVs of mon n to the moves of mon n+1
	add hl, de
	ld d, h
	ld e, l
	pop hl
.nextPokemonEntry
	dec b							; one pokémon slot down
	jp nz, .loopPokemon				; while b>0, there are slots remaining, so loop back
; this part computes the money gain for the trainer
	xor a			 				; clear wAmountMoneyWon through wAmountMoneyWon + 2 to initialize money gain to zero
	ld de, wAmountMoneyWon
	ld [de], a
	inc de
	ld [de], a
	inc de
	ld [de], a
	ld a, [wCurEnemyLVL]			; money gain is proportional to the level of the last pokémon on the trainer's team
	ld b, a
.lastLoop
	ld hl, wTrainerBaseMoney + 1	; base money gain for this trainer class
	ld c, 2
	push bc
	predef AddBCDPredef				; this function does BCD sum (over c bytes) of hl and de and stores the result in de
	pop bc
	inc de
	inc de
	dec b
	jr nz, .lastLoop
	ret

; for calls from another bank, use de as input
FarUpdateStats:
	ld h, d
	ld l, e
; this is called for each mon inside the loop
; input: hl = pointer to current mon's DVs
updateStats:
	push hl
	push bc
	push de
	ld bc, wEnemyMon1Stats - wEnemyMon1DVs
	add hl, bc
	ld d, h
	ld e, l
	ld bc, (wEnemyMon1EVs - 1) - wEnemyMon1Stats
	add hl, bc
	ld b, 1
	push hl
	push de
	call CalcStats
	pop de
	pop hl
	ld bc, wEnemyMon1HP - (wEnemyMon1EVs - 1)
	add hl, bc
	ld a, [de]
	ld [hli], a
	inc de
	ld a, [de]
	ld [hl], a
	pop de
	pop bc
	pop hl
	ret

; for calls from another bank, use wd11e as input
FarUpdateMovePP:
	ld a, [wd11e]
; a already contains the move ID when this function is called
updateMovePP:
	push hl
	and a						; test the move ID
	jr nz, .notEmptySlot		; if move ID is $00, it means it's an empty slot, set PP to zero
	ld [wcd6d + MOVEDATA_PP], a
	jr .setPP
.notEmptySlot
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
	ld hl, Moves				; position of the first move in the move table in bank E
	ld bc, MoveEnd - Moves		; size of the move structure
	dec a						; decrement a by one because move IDs start at 1
	call AddNTimes				; makes hl point to the ath move's PP in the move table
	ld a, BANK(Moves)			; $e
	call FarCopyData			; copies the move's PP from the move table into $cd6d
.afterReadMove
	pop bc
	pop de
	; at this point, the move's PP is stored in wcd6d
	; and de points to the move ID in the in-battle data for the trainer
.setPP
	push de
	ld h, d
	ld l, e
	ld de, wEnemyMon1PP - wEnemyMon1Moves
	add hl, de				; this makes de go from the move ID to the move's PP in in-battle data
	ld d, h
	ld e, l
	ld a, [wcd6d + MOVEDATA_PP]
	ld [de], a				; store the PP value in the corresponding RAM location
	pop de
	pop hl
	ret

; use different DVs and EVs according to the trainer class tier
; first word is DVs tier, DVs are equal to the DVs tier in all stats
; second word is EVs tier, EVs are equal to 5 times the EVs tier in all stats
TrainerClassTiers:
	; Youngster
	db $82
	; BugCatcherData
	db $81
	; LassData
	db $82
	; SailorData
	db $86
	; JrTrainerMData
	db $A4
	; JrTrainerFData
	db $A4
	; PokemaniacData
	db $C8
	; SuperNerdData
	db $C4
	; HikerData
	db $8A
	; BikerData
	db $83
	; BurglarData
	db $83
	; EngineerData
	db $86
	; Juggler1Data
	db $85
	; FisherData
	db $83
	; SwimmerData
	db $83
	; CueBallData
	db $83
	; GamblerData
	db $63
	; BeautyData
	db $83
	; PsychicData
	db $86
	; RockerData
	db $83
	; JugglerData
	db $85
	; TamerData
	db $AA
	; BirdKeeperData
	db $A2
	; BlackbeltData
	db $88
	; Green1Data
	db $F0
	; ProfOakData
	db $FF
	; ChiefData
	db $83
	; ScientistData
	db $C6
	; GiovanniData
	db $EE
	; RocketData
	db $43
	; CooltrainerMData
	db $AC
	; CooltrainerFData
	db $AC
	; BrunoData
	db $FF
	; BrockData
	db $77
	; MistyData
	db $88
	; LtSurgeData
	db $99
	; ErikaData
	db $AA
	; KogaData
	db $BB
	; BlaineData
	db $DD
	; SabrinaData
	db $CC
	; GentlemanData
	db $8C
	; Green2Data
	db $F8
	; Green3Data
	db $FF
	; LoreleiData
	db $FF
	; ChannelerData
	db $82
	; AgathaData
	db $FF
	; LanceData
	db $FF
	; Brock2Data
	db $FF
	; Misty2Data
	db $FF
	; LtSurge2Data
	db $FF
	; Erika2Data
	db $FF
	; Koga2Data
	db $FF
	; Sabrina2Data
	db $FF
	; Blaine2Data
	db $FF
	; Giovanni2Data
	db $FF
