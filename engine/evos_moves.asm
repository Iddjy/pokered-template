; try to evolve the mon in [wWhichPokemon]
TryEvolvingMon:
	ld hl, wCanEvolveFlags
	xor a
	ld [hl], a
	ld a, [wWhichPokemon]
	ld c, a
	ld b, FLAG_SET
	call Evolution_FlagAction

EvolutionAfterBattle:
	ld a, [hTilesetType]
	push af
	xor a
	ld [wEvolutionOccurred], a
	dec a
	ld [wWhichPokemon], a
	push hl
	push bc
	push de
	ld hl, wPartySpecies		; use wPartySpecies since that's relative to this variable that we're positionning hl
	push hl

Evolution_PartyMonLoop:				; loop over party mons
	ld hl, wWhichPokemon
	inc [hl]
	pop hl
	ld a, [hli]
	ld [wEvoOldSpecies], a
	cp $ff							; have we reached the end of the party?
	ld a, [hli]
	jr nz, .notFinished				; if first byte isn't $ff, then we haven't reached the end of the party
	cp $ff							; if first byte is $ff, check the second byte to see if we reached the $ffff terminator
	jp z, .done
.notFinished
	push hl							; push next species ID address in wPartySpecies in the stack
	ld [wEvoOldSpecies + 1], a		; to handle 2 bytes species IDs
	ld a, [wWhichPokemon]
	ld c, a
	ld hl, wCanEvolveFlags
	ld b, FLAG_TEST
	call Evolution_FlagAction
	ld a, c
	and a							; is the mon's bit set?
	jp z, Evolution_PartyMonLoop	; if not, go to the next mon
	ld a, [wEvoOldSpecies]
	ld b, a
	ld a, [wEvoOldSpecies + 1]
	ld c, a
	dec bc							; use bc to store species ID since they're now 2 bytes
	ld hl, EvosMovesPointerTable
	add hl, bc						; add bc twice since pointers are 2 bytes
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	push hl
	xor a							; PLAYER_PARTY_DATA
	ld [wMonDataLocation], a
	call LoadMonData
	pop hl

.evoEntryLoop ; loop over evolution entries
	ld a, [hli]
	and a ; have we reached the end of the evolution data?
	jr z, Evolution_PartyMonLoop
	ld b, a ; evolution type
	cp EV_TRADE
	jr z, .checkTradeEvo
; not trade evolution
	ld a, [wLinkState]
	cp LINK_STATE_TRADING
	jr z, Evolution_PartyMonLoop ; if trading, go to the next mon
	ld a, b
	cp EV_ITEM
	jr z, .checkItemEvo
	ld a, [wForceEvolution]
	and a
	jr nz, Evolution_PartyMonLoop
	ld a, b
	cp EV_LEVEL
	jr z, .checkLevel
	cp EV_EFFORT
	jr z, .checkEffort
	cp EV_MOVE
	jr z, .checkMoveset
.checkTradeEvo
	ld a, [wLinkState]
	cp LINK_STATE_TRADING
	jp nz, .nextEvoEntry1	; if not trading, go to the next evolution entry
	ld a, [hli] ; level requirement
	ld b, a
	ld a, [wLoadedMonLevel]
	cp b ; is the mon's level greater than the evolution requirement?
	jp c, Evolution_PartyMonLoop ; if so, go the next mon
	jr .doEvolution
.checkItemEvo
	ld a, [hli]
	ld b, a							; evolution item
	ld a, [wEvoStoneItemID]
	cp b							; was the evolution item in this entry used?
	jp nz, .nextEvoEntry1			; if not, go to the next evolution entry
	ld a, [wIsInBattle]
	and a							; this is necessary to avoid artificial item evolutions at the end of battles
	jp nz, .nextEvoEntry1			; if this is the end of a battle, don't trigger item evolutions
	jr .checkLevel
.checkEffort
	call CheckEffortThreshold		; sets carry flag if mon meets threshold
	jp nc, .nextEvoEntry1
	jr .checkLevel
.checkMoveset
	ld a, [hli]						; load id of required move
	call CheckMoveset				; sets carry flag if mon knows required move
	jp nc, .nextEvoEntry1
	; fallthrough
.checkLevel
	ld a, [hli] ; level requirement
	ld b, a
	ld a, [wLoadedMonLevel]
	cp b ; is the mon's level lower than the evolution requirement?
	jp c, .nextEvoEntry2			; if so, go to the next evolution entry
.doEvolution
	ld [wCurEnemyLVL], a
	ld a, 1
	ld [wEvolutionOccurred], a
	push hl
	ld a, [hli]
	ld [wEvoNewSpecies+1], a		; to handle 2 bytes species IDs
	ld a, [hl]
	ld [wEvoNewSpecies], a
	ld a, [wWhichPokemon]
	ld hl, wPartyMonNicks
	call GetPartyMonName
	call CopyStringToCF4B
	ld hl, IsEvolvingText
	call PrintText
	ld c, 50
	call DelayFrames
	xor a
	ld [H_AUTOBGTRANSFERENABLED], a
	coord hl, 0, 0
	lb bc, 12, 20
	call ClearScreenArea
	ld a, $1
	ld [H_AUTOBGTRANSFERENABLED], a
	ld a, $ff
	ld [wUpdateSpritesEnabled], a
	call ClearSprites
	callab EvolveMon
	jp c, CancelledEvolution
	ld hl, EvolvedText
	call PrintText
	pop hl
	push hl							; push it back at once
	ld a, [hli]
	ld [wMonSpeciesTemp+1], a		; to handle 2 bytes species IDs
	ld [wLoadedMonSpecies+1], a		; to handle 2 bytes species IDs
	ld [wEvoNewSpecies+1], a		; to handle 2 bytes species IDs
	ld a, [hl]
	ld [wMonSpeciesTemp], a			; to handle 2 bytes species IDs
	ld [wLoadedMonSpecies], a
	ld [wEvoNewSpecies], a
	ld a, MONSTER_NAME
	ld [wNameListType], a
	ld a, BANK(TrainerNames) ; bank is not used for monster names
	ld [wPredefBank], a
	call GetName
	ld hl, IntoText
	call PrintText_NoCreatingTextBox
	ld de, wcd6d
	ld hl, wEnemyMonNick
	call CopyString								; necessary for the new dex entry text to display the right name
	ld a, SFX_GET_ITEM_2
	call PlaySoundWaitForCurrent
	call WaitForSoundToFinish
	ld c, 40
	call DelayFrames
	call RenameEvolvedMon
	ld a, [wMonSpeciesTemp]
	ld d, a
	ld a, [wMonSpeciesTemp + 1]					; to handle 2 bytes species IDs
	ld e, a
	ld hl, wMonHIndex
	ld a, d
	ld [hli], a									; copy the species ID here
	ld a, e										; because we can't copy directly from the ROM
	ld [hl], a
	dec de
	ld hl, BaseStats + 2						; skip the species ID because it's stored low byte first in the ROM
	ld bc, MonBaseStatsEnd - MonBaseStats		; while it must be stored high byte first in the RAM
	call AddNTimes16Bits						; use 2 bytes function
	ld de, wMonHBaseStats						; start right after species ID
	dec bc										; reduce bc by 2 since we don't want FarCopyData to copy the species ID
	dec bc
	ld a, BANK(BaseStats)
	call FarCopyData
	ld hl, wLoadedMonHPEV - 1
	ld de, wLoadedMonStats
	ld b, $1
	call CalcStats								; recalculating new stats and storing them in wLoadedMonStats
	ld a, [wWhichPokemon]						; START updating current HP with the amount of MaxHP gained through evolution v
	ld hl, wPartyMon1
	ld bc, wPartyMon2 - wPartyMon1
	call AddNTimes
	ld e, l
	ld d, h
	push hl
	push bc
	ld bc, wPartyMon1MaxHP - wPartyMon1
	add hl, bc									; this makes hl point to current HP in party data before evolution
	ld a, [hli]
	ld b, a
	ld c, [hl]
	ld hl, wLoadedMonMaxHP + 1					; this is the high byte of the new MaxHP after evolution
	ld a, [hld]
	sub c										; get the difference between new maxHP and old MaxHP and store it in bc
	ld c, a
	ld a, [hl]
	sbc b										; get the difference between new maxHP and old MaxHP and store it in bc
	ld b, a
	ld hl, wLoadedMonHP + 1						; this is the high byte of the new current HP after evolution
	ld a, [hl]
	add c										; add the difference between new maxHP and old MaxHP to current HP
	ld [hld], a
	ld a, [hl]
	adc b										; add the difference between new maxHP and old MaxHP to current HP
	ld [hl], a									; END updating current HP with the amount of MaxHP gained through evolution ^
	dec hl										; makes hl point to the beginning of the evolved mon data in wLoadedMon
	dec hl										; since the species ID now occupies 2 bytes, we have to decrement hl twice
	pop bc										; makes bc = wPartyMon2 - wPartyMon1
	call CopyData								; copy new values calculated in wLoadedMon into party data
	xor a
	ld [wMonDataLocation], a
	call LearnMoveFromLevelUp
	pop hl
	predef SetPartyMonTypes
	pop hl										; restore address of new species id in hl
	push hl										; push it back to the stack since we still need it later
	inc hl										; move hl to the list of Evolution moves
	inc hl										; move hl to the list of Evolution moves
.learnEvolutionMoves
	ld a, [hli]									; run through the list of moves at the end of the evolution entry
	cp $ff
	jr z, .evolutionMovesDone					; if we reached the terminator, it means we're done with Evolution moves
	push hl
	call LearnSpecificMove						; learn move whose ID is stored in a
	pop hl
	jr .learnEvolutionMoves
.evolutionMovesDone
	call ClearScreen							; moved it here to keep the pokemon's sprite during move learning
	ld a, [wIsInBattle]
	and a
	call z, Evolution_ReloadTilesetTilePatterns
	call GetDexNumberBySpeciesID				; sets wMonDexNumber and wMonDexNumber + 1 for next functions
	callab AddToPokedexSeen						; uses wMonDexNumber and wMonDexNumber + 1 as input
	callab CheckPokedexOwned
	jr nz, .skipAddingToDex
	callab AddToPokedexOwned					; uses wMonDexNumber and wMonDexNumber + 1 as input
	CheckEvent EVENT_GOT_POKEDEX				; since it is possible to evolve a mon before getting the dex,
	jr z, .skipAddingToDex						; only show dex data if player actually has the pokedex
	ld hl, NewDexDataAddedText
	call PrintText
	predef ShowPokedexData
	call ReloadTilesetTilePatterns				; the dex screen uses its own tile patterns, so we must reload the map's tile patterns
.skipAddingToDex
	pop de										; restore address of next byte in evolution data into de
	pop hl										; restore the address we are at in the wPartySpecies array
	push hl										; push it back for use in the next loop iteration
	dec hl										; need to move back one species ID (so 2 bytes) because
	dec hl										; the address saved was that of the next mon in the party
	ld a, [wLoadedMonSpecies]
	ld [hli], a
	ld a, [wLoadedMonSpecies + 1]				; to handle 2 bytes species IDs
	ld [hl], a
	ld l, e
	ld h, d
.nextEvoEntry1
	inc hl										; skip the level requirement
.nextEvoEntry2
	inc hl										; skip the species ID
	inc hl										; skip the species ID
.nextEvoEntryLoop
	ld a, [hli]
	cp $ff										; skip list of Evolution moves at the end of evolution entry
	jr nz, .nextEvoEntryLoop
	jp .evoEntryLoop

.done
	pop de
	pop bc
	pop hl
	pop af
	ld [hTilesetType], a
	ld a, [wLinkState]
	cp LINK_STATE_TRADING
	ret z
	ld a, [wIsInBattle]
	and a
	ret nz
	ld a, [wEvolutionOccurred]
	and a
	call nz, PlayDefaultMusic
	ret

; added
NewDexDataAddedText:
	TX_FAR _ItemUseBallText06
	TX_SFX_DEX_PAGE_ADDED
	TX_BLINK
	db "@"

RenameEvolvedMon:
; Renames the mon to its new, evolved form's standard name unless it had a
; nickname, in which case the nickname is kept.
	ld a, [wEvoOldSpecies]
	ld [wMonSpeciesTemp], a
	ld a, [wEvoOldSpecies+1]
	ld [wMonSpeciesTemp+1], a
	call GetName					; get name of the old species in wcd6d
	ld a, [wEvoNewSpecies]
	ld [wMonSpeciesTemp], a
	ld a, [wEvoNewSpecies+1]		; restore wMonSpeciesTemp to the species of the evolved form now in case the function exits early
	ld [wMonSpeciesTemp+1], a
	ld hl, wcd6d
	ld de, wcf4b					; here wcf4b already contains the nickname of the mon that just evolved (it's set in .doEvolution)
.compareNamesLoop
	ld a, [de]
	inc de
	cp [hl]
	inc hl
	ret nz							; if the mon's name is different from its species' name, don't rename it
	cp "@"
	jr nz, .compareNamesLoop
	ld a, [wWhichPokemon]
	ld bc, NAME_LENGTH
	ld hl, wPartyMonNicks
	call AddNTimes
	push hl
	call GetName
	ld hl, wcd6d
	pop de
	jp CopyData

CancelledEvolution:
	ld hl, StoppedEvolvingText
	call PrintText
	call ClearScreen
	pop hl
	call Evolution_ReloadTilesetTilePatterns
	jp Evolution_PartyMonLoop

EvolvedText:
	TX_FAR _EvolvedText
	db "@"

IntoText:
	TX_FAR _IntoText
	db "@"

StoppedEvolvingText:
	TX_FAR _StoppedEvolvingText
	db "@"

IsEvolvingText:
	TX_FAR _IsEvolvingText
	db "@"

Evolution_ReloadTilesetTilePatterns:
	ld a, [wLinkState]
	cp LINK_STATE_TRADING
	ret z
	jp ReloadTilesetTilePatterns

LearnMoveFromLevelUp:
	ld hl, EvosMovesPointerTable
	ld a, [wMonSpeciesTemp]
	ld b, a
	ld a, [wMonSpeciesTemp + 1]		; to handle 2 bytes species IDs
	ld c, a
	dec bc
	ld hl, EvosMovesPointerTable
	add hl, bc						; to handle 2 bytes species IDs
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call SkipEvolutionData
.learnSetLoop ; loop over the learn set until we reach a move that is learnt at the current level or the end of the list
	ld a, [hli]
	and a							; have we reached the end of the learnset?
	ret z							; if we've reached the end of the learn set, jump
	ld b, a							; level the move is learnt at
	ld a, [wCurEnemyLVL]
	cp b							; is the move learnt at the mon's current level?
	ld a, [hli]						; move ID
	push hl
	call z, LearnSpecificMove
	pop hl
	jr .learnSetLoop

; entrypoint to call this from another bank
_LearnSpecificMove:
	ld a, [wd11e]

; added this entry point for Evolution moves
LearnSpecificMove:
	ld d, a							; ID of move to learn
	ld a, [wMonDataLocation]
	and a
	jr nz, .next
; If [wMonDataLocation] is 0 (PLAYER_PARTY_DATA), get the address of the mon's
; current moves in party data. Every call to this function sets
; [wMonDataLocation] to 0 because other data locations are not supported.
; If it is not 0, this function will not work properly.
	ld hl, wPartyMon1Moves
	ld a, [wWhichPokemon]
	ld bc, wPartyMon2 - wPartyMon1
	call AddNTimes
.next
	ld b, NUM_MOVES
.checkCurrentMovesLoop			; check if the move to learn is already known
	ld a, [hli]
	cp d
	jr z, .done					; if already known, jump
	dec b
	jr nz, .checkCurrentMovesLoop
	ld a, d
	ld [wMoveNum], a
	ld [wd11e], a
	ld bc, wPartyMon1Species - (wPartyMon1Moves + NUM_MOVES)	; make hl point to the mon's species id
	add hl, bc													; make hl point to the mon's species id
	ld a, [hli]													; read the species id and put it in wMonSpeciesTemp for GetMoveName
	ld [wMonSpeciesTemp], a										; read the species id and put it in wMonSpeciesTemp for GetMoveName
	ld a, [hl]													; read the species id and put it in wMonSpeciesTemp for GetMoveName
	ld [wMonSpeciesTemp + 1], a									; read the species id and put it in wMonSpeciesTemp for GetMoveName
	call GetMoveName
	call CopyStringToCF4B
	predef LearnMove
.done
	ret

; writes the moves a mon has at level [wCurEnemyLVL] to [de]
; move slots are being filled up sequentially and shifted if all slots are full
WriteMonMoves:
	call GetPredefRegisters
	push hl
	push de
	push bc
	ld hl, EvosMovesPointerTable
	ld a, [wMonSpeciesTemp]
	ld b, a
	ld a, [wMonSpeciesTemp + 1]		; to handle 2 bytes species IDs
	ld c, a
	dec bc
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call SkipEvolutionData
	jr .firstMove
.nextMove
	pop de
.nextMove2
	inc hl
.firstMove
	ld a, [hli]       ; read level of next move in learnset
	and a
	jp z, .done       ; end of list
	cp 1				; check if the move is learnt at level one
	jp z, .nextMove2	; if it is, skip it
	ld b, a
	ld a, [wCurEnemyLVL]
	cp b
	jp c, .done       ; mon level < move level (assumption: learnset is sorted by level)
	ld a, [wLearningMovesFromDayCare]
	and a
	jr z, .skipMinLevelCheck
	ld a, [wDayCareStartLevel]
	cp b
	jr nc, .nextMove2 ; min level >= move level

.skipMinLevelCheck

; check if the move is already known
	push de
	ld c, NUM_MOVES
.alreadyKnowsCheckLoop
	ld a, [de]
	inc de
	cp [hl]
	jr z, .nextMove
	dec c
	jr nz, .alreadyKnowsCheckLoop

; try to find an empty move slot
	pop de
	push de
	ld c, NUM_MOVES
.findEmptySlotLoop
	ld a, [de]
	and a
	jr z, .writeMoveToSlot2
	inc de
	dec c
	jr nz, .findEmptySlotLoop

; no empty move slots found
	pop de
	push de
	push hl
	ld h, d
	ld l, e
	call WriteMonMoves_ShiftMoveData ; shift all moves one up (deleting move 1)
	ld a, [wLearningMovesFromDayCare]
	and a
	jr z, .writeMoveToSlot

; shift PP as well if learning moves from day care
	push de
	ld bc, wPartyMon1PP - (wPartyMon1Moves + 3)
	add hl, bc
	ld d, h
	ld e, l
	call WriteMonMoves_ShiftMoveData ; shift all move PP data one up
	pop de

.writeMoveToSlot
	pop hl
.writeMoveToSlot2
	ld a, [hl]
	ld [de], a
	ld a, [wLearningMovesFromDayCare]
	and a
	jr z, .nextMove

; write move PP value if learning moves from day care
	push hl
	ld a, [hl]
	ld hl, wPartyMon1PP - wPartyMon1Moves
	add hl, de
	push hl
	dec a
	ld hl, Moves
	ld bc, MoveEnd - Moves
	call AddNTimes
	ld de, wBuffer
	ld a, BANK(Moves)
	call FarCopyData
	ld a, [wBuffer + MOVEDATA_PP]
	pop hl
	ld [hl], a
	pop hl
	jr .nextMove

.done
	pop bc
	pop de
	pop hl
	ret

; shifts all move data one up (freeing 4th move slot)
WriteMonMoves_ShiftMoveData:
	ld c, NUM_MOVES - 1
.loop
	inc de
	ld a, [de]
	ld [hli], a
	dec c
	jr nz, .loop
	ret

Evolution_FlagAction:
	predef_jump FlagActionPredef

; function used to skip evolution data
; expects hl to point to the start of evolution data
; makes hl point to the next byte after evolution data
SkipEvolutionData:
	ld a, [hli]
	and a
	ret z							; if we reached the evolution data terminator, we're done
	cp EV_ITEM						; check what kind of evo entry this is
	jr z, .skipAdditionalByte		; if it's an item evo entry, we need to skip the item id
	cp EV_MOVE						; check what kind of evo entry this is
	jr nz, .skipLevelAndSpeciesID	; if it's not an item evo entry, then there's one less byte to skip
.skipAdditionalByte
	inc hl							; skip the item ID or the move ID
.skipLevelAndSpeciesID
	inc hl							; skip the level requirement and the species ID
	inc hl
	inc hl
.skipEvoMoves
	ld a, [hli]						; skip the evo moves
	cp $ff
	jr nz, .skipEvoMoves
	jr SkipEvolutionData			; check if there are other evo entries to skip

; add this function to check if a mon that evolves by Effort Values meets the threshold
; sets carry if yes, unsets it if no
CheckEffortThreshold:
	push hl
	push bc
	ld c, NUM_STATS
	ld hl, wLoadedMonEVs
	ld b, $0
.loop
	ld a, [hli]
	cp EFFORT_VALUE_THRESHOLD	; compare current stat EV to the threshold
	jr nc, .yes					; if this stat alone has more EVs than the threshold, return yes
	add b						; add the current stat EV to the total in b
	jr c, .yes					; if this sum has a carry, it means we're above the threshold (which fits in one byte)
	cp EFFORT_VALUE_THRESHOLD	; compare current total to the threshold
	jr nc, .yes					; if the total is higher than the threshold, return yes
	ld b, a
	dec c
	jr nz, .loop
	xor a						; if we're here, it means we did all stats, so unset carry flag to return no
	jr .done
.yes
	scf
.done
	pop bc
	pop hl
	ret

; add this function to check if a mon that evolves when knowing a certain move has it in its moveset
; sets carry if yes, unsets it if no
CheckMoveset:
	push hl
	push bc
	ld b, a
	ld c, NUM_MOVES
	ld hl, wLoadedMonMoves
.loop
	ld a, [hli]
	cp b						; compare current move to required move
	jr z, .yes					; if it's a match, return yes
	dec c
	jr nz, .loop
	xor a
	jr .done
.yes
	scf
.done
	pop bc
	pop hl
	ret

; add this function for the move relearner
; it will add starting moves + all level up moves that are below the mon's current level to wRelearnableMoves
; input: mon's level in d, mon's species in wMonSpeciesTemp/wMonSpeciesTemp+1
FillUpRememberMoveList:
	push de
	call GetMonHeader
	ld hl, wRelearnableMoves
	ld bc, wRelearnableMovesEnd - wRelearnableMoves
	ld a, $FF
	call FillMemory					; fill list of relearnable moves with $FF
	ld hl, wMonHMoves
	ld bc, wRelearnableMoves + 1	; first byte is the size of the list, which we don't know yet
	ld e, 0							; initialize the size of the list
	ld d, NUM_MOVES
.startingMoves
	ld a, [hli]
	and a
	jr z, .nextStartingMove
	call CheckKnownMoves
	jr c, .nextStartingMove			; if the mon already knows the move, skip it
	call CheckDuplicateMoves
	jr c, .nextStartingMove			; if the list already contains the move, skip it
	ld [bc], a
	inc bc
	inc e
.nextStartingMove
	dec d
	jr nz, .startingMoves
	ld a, e							; save list size in a
	pop de							; restore mon's level in d
	ld e, a							; put list size back in e
	push bc
	ld hl, EvosMovesPointerTable
	ld a, [wMonSpeciesTemp]
	ld b, a
	ld a, [wMonSpeciesTemp + 1]
	ld c, a
	dec bc
	add hl, bc
	add hl, bc
	pop bc
	ld a, [hli]
	ld h, [hl]
	ld l, a							; here we have the address of the mon's evos_moves data in hl
.skipEvosData
	ld a, [hli]
	and a
	jr z, .levelupMoves				; no more evolution data
	cp EV_ITEM
	jr nz, .skipLevelAndSpecies
	inc hl							; skip item id for item evos
.skipLevelAndSpecies
	inc hl							; skip level
	inc hl							; skip species ID
	inc hl							; skip species ID
.skipEvosMoves
	ld a, [hli]
	cp $ff
	jr nz, .skipEvosMoves
	jr .skipEvosData
.levelupMoves
	ld a, [hli]
	and a
	jr z, .finish
	cp d							; compare level at which move is learned to mon's level
	jr z, .addMoveToList			; if they're equal, add the move to the list
	jr nc, .finish					; if mon's level is strictly inferior to move level, we're done (assumes learnsets are in level order)
.addMoveToList
	ld a, [hli]
	call CheckKnownMoves
	jr c, .levelupMoves				; if the mon already knows the move, skip it
	call CheckDuplicateMoves
	jr c, .levelupMoves				; if the list already contains the move, skip it
	ld [bc], a
	inc bc
	inc e
	ld a, e
	cp wRelearnableMovesEnd - wRelearnableMoves - 2	; - 2 is to account for list size and terminator
	jr c, .levelupMoves				; RAM area starting at wRelearnableMoves can only hold so many moves, so only loop back if it's not full yet
.finish
	ld a, e
	ld [wRelearnableMoves], a		; put list size at the start of the list
	ret

; function used to avoid adding a move that the mon already knows to the list of relearnable moves
; input : move id to check in a, mon's moves in wMoves to wMoves + 3
; output : sets carry flag if move is known, unsets it otherwise
CheckKnownMoves:
	push hl
	push bc
	push af
	ld hl, wMoves
	ld c, NUM_MOVES
	ld b, a
.loop
	ld a, [hli]
	cp b
	jr z, .moveIsKnown
	dec c
	jr nz, .loop
	pop af
	and a
	jr .finish
.moveIsKnown
	pop af
	scf
.finish
	pop bc
	pop hl
	ret

; function used to avoid adding duplicate moves to the list of relearnable moves
; input : move id to check in a
; output : sets carry flag if move is already in the list, unsets it otherwise
CheckDuplicateMoves:
	push hl
	push bc
	push af
	ld hl, wRelearnableMoves + 1
	ld b, a
.loop
	ld a, [hli]
	cp b
	jr z, .duplicate
	cp $FF
	jr nz, .loop
	pop af
	and a
	jr .finish
.duplicate
	pop af
	scf
.finish
	pop bc
	pop hl
	ret

INCLUDE "data/evos_moves.asm"
