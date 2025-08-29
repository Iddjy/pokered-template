; creates a set of moves that may be used and returns its address in hl
; unused slots are filled with 0, all used slots may be chosen with equal probability
AIEnemyTrainerChooseMoves:
	ld a, 15		; increase to 15 to allow a bigger range of encouragement values
	ld hl, wBuffer ; init temporary move selection array. Only the moves with the lowest numbers are chosen in the end
	ld [hli], a   ; move 1
	ld [hli], a   ; move 2
	ld [hli], a   ; move 3
	ld [hl], a    ; move 4
	ld a, [wEnemyDisabledMove]						; forbid disabled move (if any)
	swap a
	and $f
	jr z, .noMoveDisabled
	ld hl, wBuffer
	dec a
	ld c, a
	ld b, $0
	add hl, bc										; advance pointer to forbidden move
	ld [hl], $50									; forbid (highly discourage) disabled move
.noMoveDisabled
	ld hl, wEnemyMonPP
	ld de, wBuffer
	ld c, NUM_MOVES
.loopCheckPP
	ld a, [hli]
	and a
	jr nz, .nextMove
	ld a, $50										; forbid (highly discourage) moves with no PP left
	ld [de], a
.nextMove
	inc de
	dec c
	jr nz, .loopCheckPP
	call AIMoveChoiceModification_BattleFacility	; add call to Battle Facility specific routine
	jr z, .loopFindMinimumEntries					; if in Battle Facility, skip usual trainer class AI
	ld hl, TrainerClassMoveChoiceModifications
	ld a, [wTrainerClass]
	ld b, a
.loopTrainerClasses
	dec b
	jr z, .readTrainerClassData
.loopTrainerClassData
	ld a, [hli]
	and a
	jr nz, .loopTrainerClassData
	jr .loopTrainerClasses
.readTrainerClassData
	ld a, [hl]
	and a
	jp z, .useOriginalMoveSet
	push hl
.nextMoveChoiceModification
	pop hl
	ld a, [hli]
	and a
	jr z, .loopFindMinimumEntries
	push hl
	ld hl, AIMoveChoiceModificationFunctionPointers
	dec a
	add a
	ld c, a
	ld b, 0
	add hl, bc    ; skip to pointer
	ld a, [hli]   ; read pointer into hl
	ld h, [hl]
	ld l, a
	ld de, .nextMoveChoiceModification  ; set return address
	push de
	jp hl         ; execute modification function
.loopFindMinimumEntries ; all entries will be decremented sequentially until one of them is zero
	ld hl, wBuffer  ; temp move selection array
	ld de, wEnemyMonMoves  ; enemy moves
	ld c, NUM_MOVES
.loopDecrementEntries
	ld a, [de]
	inc de
	and a
	jr z, .skipEmptySlot			; don't decrement the value for empty slots so that they are never chosen
	dec [hl]
	jr z, .minimumEntriesFound
.skipEmptySlot
	inc hl
	dec c
	jr z, .loopFindMinimumEntries
	jr .loopDecrementEntries
.minimumEntriesFound
	ld a, c
.loopUndoPartialIteration ; undo last (partial) loop iteration
	inc [hl]
	dec hl
	inc a
	cp NUM_MOVES + 1
	jr nz, .loopUndoPartialIteration
	call ForbidExhaustedMoves			; add this to prevent the AI from choosing moves with no PP left
	ld hl, wBuffer						; temp move selection array
	ld de, wEnemyMonMoves				; enemy moves
	ld c, NUM_MOVES
.filterMinimalEntries ; all minimal entries now have value 1. All other slots will be disabled (move set to 0)
	ld a, [de]
	and a
	jr nz, .moveExisting
	ld [hl], a
.moveExisting
	ld a, [hl]
	dec a
	jr z, .slotWithMinimalValue
	xor a
	ld [hli], a     ; disable move slot
	jr .next
.slotWithMinimalValue
	ld a, [de]
	ld [hli], a     ; enable move slot
.next
	inc de
	dec c
	jr nz, .filterMinimalEntries
	ld hl, wBuffer    ; use created temporary array as move set
	ret
.useOriginalMoveSet
	ld hl, wEnemyMonMoves    ; use original move set
	ret

AIMoveChoiceModificationFunctionPointers:
	dw AIMoveChoiceModification1
	dw AIMoveChoiceModification2
	dw AIMoveChoiceModification3

; discourages moves that cause no damage but only a status ailment if player's mon already has one
; made it so that it discourages most status moves that would obviously fail
AIMoveChoiceModification1:
	ld hl, wBuffer - 1 ; temp move selection array (-1 byte offset)
	ld de, wEnemyMonMoves ; enemy moves
	ld b, NUM_MOVES + 1
.nextMove
	dec b
	ret z ; processed all 4 moves
	inc hl
	ld a, [de]
	inc de
	and a
	jr z, .nextMove						; instead of not looking further than the first empty slot, just skip those
	call ReadMove
	ld a, [wEnemyMoveEffect]
	cp SPLASH_EFFECT
	jp z, .discourageMove				; always discourage Splash...
	cp OHKO_EFFECT
	jr nz, .checkDreamEater
	ld a, [wBattleMonLevel]
	ld c, a
	ld a, [wEnemyMonLevel]
	cp c
	jp c, .discourageMove				; if target is higher level than user, discourage OHKO moves
	jr .nextMove
.checkDreamEater
	cp DREAM_EATER_EFFECT				; check dream eater before checking move power
	jr nz, .checkPower
	ld a, [wBattleMonStatus]
	and SLP
	jp z, .discourageMove				; if the player's mon is not asleep, discourage dream eater
.checkPower
	ld a, [wEnemyMovePower]
	and a
	jr nz, .nextMove
	ld a, [wEnemyMoveEffect]
	push hl
	push de
	push bc
	ld hl, StatusAilmentMoveEffects
	ld de, $0001
	call IsInArray
	pop bc
	pop de
	pop hl
	jp nc, .checkLeechSeed				; add checks for various volatile statuses
	ld a, [wBattleMonStatus]
	and a
	jp nz, .discourageMove				; if target already has a non-volatile status condition, discourage this move
	ld a, [wPlayerBattleStatus2]
	bit HAS_SUBSTITUTE_UP, a			; check if target has a Substitute
	jr z, .checkType
	ld a, [wEnemyMoveExtra]
	bit IS_SOUND_BASED_MOVE, a
	jp z, .discourageMove				; if target has a Substitute, and the move isn't sound-based, discourage it
.checkType
	ld a, [wEnemyMoveType]
	cp GRASS							; check if it is a GRASS status move
	jr nz, .checkPara
	ld a, [wEnemyMoveExtra]
	bit IS_SOUND_BASED_MOVE, a
	jr nz, .checkPara					; sound-based GRASS moves (GRASSWHISTLE) are not discouraged if the target is GRASS type
	ld a, [wBattleMonType1]
	cp GRASS
	jr z, .discourageMove				; if player's mon is part GRASS, discourage status non-sound-based GRASS moves (spores and powders)
	ld a, [wBattleMonType2]
	cp GRASS
	jr z, .discourageMove				; if player's mon is part GRASS, discourage status non-sound-based GRASS moves (spores and powders)
.checkPara
	ld a, [wEnemyMoveEffect]
	cp PARALYZE_EFFECT
	jr nz, .checkBurn
	ld a, [wBattleMonType1]
	cp ELECTRIC
	jr z, .discourageMove				; if player's mon is part ELECTRIC, discourage all Paralyzing moves
	ld a, [wBattleMonType2]
	cp ELECTRIC
	jr z, .discourageMove				; if player's mon is part ELECTRIC, discourage all Paralyzing moves
	ld a, [wEnemyMoveType]
	cp ELECTRIC
	jp nz, .nextMove
	ld a, [wBattleMonType1]
	cp GROUND
	jr z, .discourageMove				; if player's mon is part GROUND, discourage Paralyzing electric moves (Thunder Wave)
	ld a, [wBattleMonType2]
	cp GROUND
	jr z, .discourageMove				; if player's mon is part GROUND, discourage Paralyzing electric moves (Thunder Wave)
	jp .nextMove
.checkBurn
	cp BURN_EFFECT
	jr nz, .checkPoison
	ld a, [wBattleMonType1]
	cp FIRE
	jr z, .discourageMove				; if player's mon is part FIRE, discourage all Burning moves
	ld a, [wBattleMonType2]
	cp FIRE
	jr z, .discourageMove				; if player's mon is part FIRE, discourage all Burning moves
	jp .nextMove
.checkPoison
	cp POISON_EFFECT
	jr z, .checkPoisonImmunity
	cp BAD_POISON_EFFECT
	jp nz, .nextMove
.checkPoisonImmunity
	ld a, [wBattleMonType1]
	cp POISON
	jr z, .discourageMove				; if player's mon is part POISON, discourage all Poisoning moves
	cp STEEL
	jr z, .discourageMove				; if player's mon is part STEEL, discourage all Poisoning moves
	ld a, [wBattleMonType2]
	cp POISON
	jr z, .discourageMove				; if player's mon is part POISON, discourage all Poisoning moves
	cp STEEL
	jr z, .discourageMove				; if player's mon is part STEEL, discourage all Poisoning moves
	jp .nextMove
.discourageMove
	ld a, [hl]
	add $10 ; heavily discourage move
	ld [hl], a
	jp .nextMove
.checkLeechSeed
	ld a, [wEnemyMoveEffect]
	cp LEECH_SEED_EFFECT
	jr nz, .checkConfusion
	ld a, [wBattleMonType1]
	cp GRASS
	jr z, .discourageMove				; if player's mon is part GRASS, discourage Leech Seed
	ld a, [wBattleMonType2]
	cp GRASS
	jr z, .discourageMove				; if player's mon is part GRASS, discourage Leech Seed
	ld a, [wPlayerBattleStatus2]
	bit HAS_SUBSTITUTE_UP, a
	jr nz, .discourageMove				; if player's mon has a Substitute, discourage Leech Seed
	bit SEEDED, a						; check if target is already seeded
	jp .applyCheck
.checkConfusion
	cp CONFUSION_EFFECT
	jr nz, .checkMist
	ld a, [wPlayerBattleStatus2]
	bit HAS_SUBSTITUTE_UP, a
	jr z, .checkAlreadyConfused
	ld a, [wEnemyMoveExtra]
	bit IS_SOUND_BASED_MOVE, a
	jr z, .discourageMove				; if player's mon has a Substitute and the confusing move isn't sound-based, discourage it
.checkAlreadyConfused
	ld a, [wPlayerBattleStatus1]
	bit CONFUSED, a						; check if target is already confused
	jp .applyCheck
.checkMist
	cp MIST_EFFECT
	jr nz, .checkFocusEnergy
	ld a, [wEnemyMistCounter]
	and a								; check if user is already under the effect of Mist
	jp .applyCheck
.checkFocusEnergy
	cp FOCUS_ENERGY_EFFECT
	jr nz, .checkLightScreen
	ld a, [wEnemyBattleStatus2]
	bit GETTING_PUMPED, a				; check if user is already under the effect of Focus Energy
	jp .applyCheck
.checkLightScreen
	cp LIGHT_SCREEN_EFFECT
	jr nz, .checkReflect
	ld a, [wEnemyLightScreenCounter]
	and a								; check if user is already under the effect of Light Screen
	jp .applyCheck
.checkReflect
	cp REFLECT_EFFECT
	jr nz, .checkSubstitute
	ld a, [wEnemyReflectCounter]
	and a								; check if user is already under the effect of Reflect
	jp .applyCheck
.checkSubstitute
	cp SUBSTITUTE_EFFECT
	jr nz, .checkDisable
	ld a, 4
	call AICheckIfEnemyHPBelowFraction
	jp c, .discourageMove				; if user's HP is below 1/4th, discourage Substitute
	ld a, [wEnemyBattleStatus2]
	bit HAS_SUBSTITUTE_UP, a			; check if user already has a Substitute
	jp .applyCheck
.checkDisable
	cp DISABLE_EFFECT
	jr nz, .checkTrappingEffect
	ld a, [wPlayerDisabledMove]
	and a								; check if target already has a move disabled
	jp nz, .discourageMove
	jp .checkMimic2
.checkTrappingEffect
	cp TRAPPING_EFFECT
	jr nz, .checkHealing
	ld a, [wBattleMonType1]
	cp GHOST
	jp z, .discourageMove				; if player's mon is part GHOST, discourage trapping moves like Mean Look
	ld a, [wBattleMonType2]
	cp GHOST
	jp z, .discourageMove				; if player's mon is part GHOST, discourage trapping moves like Mean Look
	ld a, [wPlayerBattleStatus2]
	bit HAS_SUBSTITUTE_UP, a
	jp nz, .discourageMove				; if player's mon has a Substitute, discourage trapping moves
	ld a, [wPlayerBattleStatus3]
	bit TRAPPED, a						; check if target is already trapped
	jp .applyCheck
.checkHealing
	cp HEAL_EFFECT
	jr z, .healing
	cp REST_EFFECT
	jr nz, .checkConversion
.healing
	call IsUserAtFullHP
	jp z, .discourageMove				; if user's HP is full, discourage healing moves
	jp .nextMove
.checkConversion
	cp CONVERSION_EFFECT
	jr nz, .checkMirrorMove
	ld a, [wEnemyMonMoves]
	call ReadMove
	ld a, [wEnemyMoveType]				; compare 1st move type to user's types
	ld c, a
	ld a, [wEnemyMonType1]
	cp c
	jp z, .discourageMove				; if type 1 matches, discourage Conversion
	ld a, [wEnemyMonType2]
	cp c
	jp z, .discourageMove				; if type 2 matches, discourage Conversion
	jp .nextMove
.checkMirrorMove
	cp MIRROR_MOVE_EFFECT
	jr nz, .checkMimic
	call CompareSpeeds
	jp c, .checkLastAttackReceived
	jp z, .checkLastAttackReceived
	jp .nextMove						; if user is slower, don't check if the opponent has already used a move
.checkLastAttackReceived
	ld a, [wEnemyLastAttackReceived]
	and a
	jp z, .discourageMove				; if mirror move would fail, discourage it
	jp .nextMove
.checkMimic
	cp MIMIC_EFFECT
	jr nz, .checkTrickRoom
.checkMimic2
	call CompareSpeeds
	jp c, .checkPlayerLastMoveListIndex
	jp z, .checkPlayerLastMoveListIndex
	jp .nextMove						; if user is slower, don't check if the opponent has already used a move
.checkPlayerLastMoveListIndex
	ld a, [wPlayerLastMoveListIndex]
	inc a
	jp z, .discourageMove				; if wPlayerLastMoveListIndex is $ff, Mimic would fail
	jp .nextMove
.checkTrickRoom
	cp TRICK_ROOM_EFFECT
	jp nz, .nextMove
	call CompareSpeeds					; this function already takes Trick Room into account
	jp z, .discourageMove				; in case of speed tie, discourage Trick Room
	ld a, [wTrickRoomCounter]
	jp c, .discourageMove				; if user is faster, discourage Trick Room whether it is active or not
	and a
	jp z, .nextMove						; if user is slower and Trick Room is not active, don't discourage it
	dec a
	jp z, .discourageMove				; if user is slower and Trick Room is active but ending at the end of this turn, discourage it
	jp .nextMove						; if user is slower and Trick Room is not active, or active and not on its last turn, don't discourage it
.applyCheck
	jp nz, .discourageMove
	jp .nextMove

; add this to compare speeds between player and enemy, accounting for Trick Room
; output: sets the z flag in case of speed tie
; output: sets carry flag if enemy is faster (after accounting for Trick Room), unsets it otherwise
CompareSpeeds:
	push hl
	push de
	push bc
	ld de, wBattleMonSpeed
	ld hl, wEnemyMonSpeed
	ld a, [wTrickRoomCounter]
	and a
	jr z, .compareValues
	ld de, wEnemyMonSpeed
	ld hl, wBattleMonSpeed
.compareValues
	ld c, 2
	call StringCmp
	pop bc
	pop de
	pop hl
	ret

StatusAilmentMoveEffects:
	db SLEEP_EFFECT
	db POISON_EFFECT
	db PARALYZE_EFFECT
	db BAD_POISON_EFFECT		; added this to take into account new move effect for Toxic
	db BURN_EFFECT				; added this to take into account new move effect for Will-O-Wisp
	db $FF

; slightly encourage moves with specific effects:
; move effects that fall in the range [ATTACK_UP1_EFFECT, HAZE_EFFECT[
; or in the range [ATTACK_UP2_EFFECT, POISON_EFFECT[
; overhauled this routine so that it becomes more useful
; added some setup effects to the list of encouraged effects
; for stat boosting/stat reducing moves, check the current modifiers to avoid spamming those moves
; take current HP into account for some cases
; use special handling for Speed, Accuracy and Evasion
AIMoveChoiceModification2:
	ld hl, wBuffer - 1				; temp move selection array (-1 byte offset)
	ld de, wEnemyMonMoves			; enemy moves
	ld b, NUM_MOVES + 1
.nextMove
	dec b
	ret z ; processed all 4 moves
	inc hl
	ld a, [de]
	inc de
	and a
	jr z, .nextMove					; instead of not looking further than the first empty slot, just skip those
	call ReadMove
	ld a, [wEnemyMoveEffect]
	cp FOCUS_ENERGY_EFFECT
	jr z, .preferMove
	cp CONVERSION_EFFECT
	jr z, .preferMove
	cp LIGHT_SCREEN_EFFECT
	jr z, .preferMove
	cp REFLECT_EFFECT
	jr z, .preferMove
	cp MIST_EFFECT
	jr z, .preferMove
	cp SUBSTITUTE_EFFECT
	jr z, .preferMove
	cp QUIVER_DANCE_EFFECT
	jr z, QuiverDance				; if move effect is QUIVER_DANCE_EFFECT, encourage this move unless stats are already boosted
	cp ATTACK_UP1_EFFECT
	jr c, .nextMove					; if move effect is < ATTACK_UP1_EFFECT, don't encourage this move
	cp EVASION_UP1_EFFECT + 1
	jp c, StatUp					; if move effect is < EVASION_UP1_EFFECT + 1, encourage this move unless stats are already boosted
	cp ATTACK_DOWN1_EFFECT
	jr c, .nextMove					; if move effect is < ATTACK_DOWN1_EFFECT, don't encourage this move
	cp EVASION_DOWN1_EFFECT + 1
	jp c, StatDown					; if move effect is < EVASION_DOWN1_EFFECT + 1, encourage this move unless target's stats are already reduced
	cp ATTACK_UP2_EFFECT
	jr c, .nextMove					; if move effect is < ATTACK_UP2_EFFECT, don't encourage this move
	cp EVASION_UP2_EFFECT + 1
	jp c, StatUpTwoStages			; if move effect is < EVASION_UP2_EFFECT + 1, encourage this move unless stats are already boosted
	cp ATTACK_DOWN2_EFFECT
	jr c, .nextMove					; if move effect is < ATTACK_DOWN2_EFFECT, don't encourage this move
	cp EVASION_DOWN2_EFFECT + 1
	jp c, StatDownTwoStages			; if move effect is < EVASION_DOWN2_EFFECT + 1, encourage this move unless target's stats are already reduced
	cp ATTACK_DOWN_SIDE_EFFECT2
	jr c, .nextMove					; if move effect is < ATTACK_DOWN_SIDE_EFFECT2, don't encourage this move
	cp ATTACK_DEFENSE_UP_EFFECT
	jp c, StatDownSideEffect		; if move effect is < ATTACK_DEFENSE_UP_EFFECT, encourage this move unless stats are already boosted
	cp ACCURACY_EVASION_UP_EFFECT + 1
	jp c, TwoStatsUpOneStage		; if move effect is <= EVASION_UP_SIDE_EFFECT, encourage this move unless stats are already boosted
	cp EVASION_UP_SIDE_EFFECT + 1
	jp c, StatUpSideEffect
	jr .nextMove					; in any other case, don't encourage this move
.preferMove
	call IsUserAtFullHP
	jr nz, .nextMove				; if the mon is not at full HP, don't encourage this move
	dec [hl]						; slightly encourage this move
	dec [hl]						; encourage these moves a bit more
	jr .nextMove

; sets the z flag if the enemy mon is at full HP, unsets it otherwise
IsUserAtFullHP:
	ld a, 1
	jp AICheckIfEnemyHPBelowFraction ; with a=1, this will set the z flag only if the user's HP is equal to its max HP

; added this whole block to encourage/discourage Quiver Dance according to current stat modifiers and who is faster
QuiverDance:
	call CompareSpeeds
	jr c, .userIsFaster
	jr z, .speedTie
	ld a, SPEED_STAT_MOD + 1
	call GetEnemyModifier
	cp STAT_MODIFIER_DEFAULT
	jr c, .userIsFaster				; if speed modifier is negative, it probably means the opponent can drop our speed, so no point trying to raise it back
	cp STAT_MODIFIER_PLUS_1
	jr z, .speedTie					; if speed modifier is already +1, don't encourage this move as much
	cp STAT_MODIFIER_PLUS_2
	jr nc, .userIsFaster			; if speed modifier is already +2 or more, disregard speed boost (since that probably means the opponent is also boosting its speed)
	dec [hl]						; if user is strictly slower and speed modifier is neutral, encourage this move, even when not at full HP
.speedTie
	dec [hl]						; if it's a speed tie, only contribute a little encouragement from the speed boost
	call IsUserAtFullHP
	jr nz, .done					; if user is not at full HP, don't consider the boosts to SpA/SpD for encouragement
	ld a, SPECIAL_ATTACK_STAT_MOD + 1
	call GetEnemyModifier
	cp STAT_MODIFIER_PLUS_1
	jr nc, .checkSpDef				; if user is at full HP, further encourage the move if modifiers are neutral or lower
	dec [hl]						; but don't discourage it if they are higher, since we want the speed boost anyway
.checkSpDef
	ld a, SPECIAL_DEFENSE_STAT_MOD + 1
	call GetEnemyModifier
	cp STAT_MODIFIER_PLUS_1
	jr nc, .done
	dec [hl]						; if user is at full HP, further encourage the move if modifiers are neutral or lower
	jr .done						; but don't discourage it if they are higher, since we want the speed boost anyway
.userIsFaster
	ld a, SPECIAL_ATTACK_STAT_MOD + 1
	call GetEnemyModifier
	sub STAT_MODIFIER_PLUS_1
	jr nc, .atLeastPlusOneSpA
	ld a, 2
	call AICheckIfEnemyHPBelowFraction
	jr nc, .checkFullHP
	inc [hl]						; if user's HP are below half, discourage move
	jr .checkSpDef2
.checkFullHP
	call IsUserAtFullHP				; if user's stat mod is neutral or lower, check its HP
	jr nz, .checkSpDef2				; if user is not at full HP, don't encourage the move
	dec [hl]						; if user is already faster, only encourage the move if the stat modifier is neutral or lower
	jr .checkSpDef2
.atLeastPlusOneSpA
	inc a							; so that a modifier at +1 causes discouragement
	ld c, a
	ld a, [hl]
	add c							; for every stage above neutral, the move is discouraged by 1
	ld [hl], a
.checkSpDef2
	ld a, SPECIAL_DEFENSE_STAT_MOD + 1
	call GetEnemyModifier
	sub STAT_MODIFIER_PLUS_1
	jr nc, .atLeastPlusOneSpD
	ld a, 2
	call AICheckIfEnemyHPBelowFraction
	jr nc, .checkFullHP2
	inc [hl]						; if user's HP are below half, discourage move
	jr .checkSpDef2
.checkFullHP2
	call IsUserAtFullHP				; if user's stat mod is neutral or lower, check its HP
	jr nz, .done					; if user is not at full HP, don't encourage the move
	dec [hl]						; if user is already faster, only encourage the move if the stat modifier is neutral or lower
	jr .done
.atLeastPlusOneSpD
	inc a							; so that a modifier at +1 causes discouragement
	ld c, a
	ld a, [hl]
	add c							; for every stage above neutral, the move is discouraged by 1
	ld [hl], a
.done
	jp AIMoveChoiceModification2.nextMove

StatUp:
	call StatUp_Main
	jp AIMoveChoiceModification2.nextMove

StatUp_Main:
	sub ATTACK_UP1_EFFECT - 1
	cp SPEED_STAT_MOD + 1
	jr nz, .notSpeed
	call CheckElapsedTurns
	ret c
	call CompareSpeeds
	jr c, .userIsFaster
	jr z, .speedTie
	ld a, SPEED_STAT_MOD + 1
	call GetEnemyModifier
	cp STAT_MODIFIER_DEFAULT
	jr c, .userIsFaster				; if speed modifier is negative, it probably means the opponent can drop our speed, so no point trying to raise it back
	cp STAT_MODIFIER_PLUS_1
	jr z, .speedTie					; if speed modifier is already +1, don't encourage this move as much
	cp STAT_MODIFIER_PLUS_2
	jr nc, .userIsFaster			; if speed modifier is already +2 or more, disregard speed boost (since that probably means the opponent is also boosting its speed)
	dec [hl]
	ld a, [wEnemyMoveEffect]
	cp SPEED_UP2_EFFECT
	jr nz, .speedTie
	dec [hl]						; if it's a +2 speed move, encourage it a bit more
.speedTie
	dec [hl]
	ret
.userIsFaster
	inc [hl]						; if user is faster, discourage this move
	inc [hl]
	ret
.notSpeed
	cp EVASION_STAT_MOD + 1
	jr z, .evasion
	call GetEnemyModifier
	sub STAT_MODIFIER_PLUS_1
	ld c, a
	ld a, 2
	call AICheckIfEnemyHPBelowFraction
	jr nc, .checkModifier
	inc [hl]						; if user's HP are below half, discourage move regardless of modifier
	ret
.checkModifier
	ld a, [wEnemyMoveEffect]
	cp ATTACK_UP2_EFFECT
	jr c, .notPlus2
	cp EVASION_UP2_EFFECT + 1
	jr nc, .notPlus2
	dec c
.notPlus2
	ld a, c
	cp STAT_MODIFIER_PLUS_6 - STAT_MODIFIER_PLUS_1 + 1	; compare to the max possible positive value + 1
	jr c, .skipHPcheck									; if the encouragement value is lower, it means the move is going to be discouraged, so don't check if HP is full
	call IsUserAtFullHP									; else it means the encouragement value is actually a negative number, meaning the move is going to be encouraged, so check if HP is full before doing it
	ret nz
.skipHPcheck
	ld a, [hl]						; for every stage below +1 (+2 for 2 stages boosts), the move is encouraged by 1, but only if HP is full
	add c							; for every stage above +1 (+2 for 2 stages boosts), the move is discouraged by 1
	ld [hl], a
	ret
.evasion
	call GetEnemyModifier
	cp STAT_MODIFIER_PLUS_6
	jr c, .notMaxedOut
	ld a, [hl]
	add 10
	ld [hl], a
	ret
.notMaxedOut
	cp STAT_MODIFIER_PLUS_2
	jr nc, .checkPlus4
	dec [hl]						; encourage move if evasion modifier is +1 or lower
.checkPlus4
	cp STAT_MODIFIER_PLUS_4
	jr c, .checkEffect
	inc [hl]						; discourage move if evasion modifier is +4 or higher
.checkEffect
	ld a, [wEnemyMoveEffect]
	cp EVASION_UP2_EFFECT
	ret nz
	dec [hl]						; encourage move if it's a +2 evasion move
	ret
	
StatUpTwoStages:
	sub ATTACK_UP2_EFFECT - ATTACK_UP1_EFFECT
	jp StatUp
	
StatDown:
	call StatDown_Main
	jp AIMoveChoiceModification2.nextMove

StatDown_Main:
	sub ATTACK_DOWN1_EFFECT - 1
	cp SPEED_STAT_MOD + 1
	jr nz, .notSpeed
	call CheckStatDownBlocked
	jr nz, .blocked
	call CheckElapsedTurns
	ret c
	call CompareSpeeds
	jr c, .userIsFaster
	jr z, .speedTie
	ld a, SPEED_STAT_MOD + 1
	call GetPlayerModifier
	cp STAT_MODIFIER_PLUS_1
	jr nc, .userIsFaster			; if speed modifier is positive, it probably means the opponent can boost its speed, so no point trying to lower it back
	cp STAT_MODIFIER_MINUS_1
	jr z, .speedTie					; if speed modifier is already -1, don't encourage this move as much
	cp STAT_MODIFIER_MINUS_2
	jr nc, .userIsFaster			; if speed modifier is already -2 or less, disregard speed drop (since that probably means the opponent is also dropping our speed)
	dec [hl]
	ld a, [wEnemyMoveEffect]
	cp SPEED_DOWN2_EFFECT
	jr nz, .speedTie
	dec [hl]						; if this is a -2 stages move effect, encourage it a bit more
.speedTie
	dec [hl]
	ret
.userIsFaster
	inc [hl]						; if user is faster, discourage this move
	inc [hl]
	ret
.notSpeed
	cp ACCURACY_STAT_MOD + 1
	jr nz, .notAccuracy
	call CheckStatDownBlocked
	jr nz, .blocked
	call GetPlayerModifier
	cp STAT_MODIFIER_MINUS_5
	jr c, .blocked
	cp STAT_MODIFIER_MINUS_1
	jr c, .checkMinus3
	dec [hl]							; encourage move if modifier is -1 or higher
.checkMinus3
	cp STAT_MODIFIER_MINUS_3
	jr nc, .checkEffect
	inc [hl]							; discourage move if modifier is -4 or lower
.checkEffect
	ld a, [wEnemyMoveEffect]
	cp ACCURACY_DOWN2_EFFECT
	ret nz
	dec [hl]							; if move is -2 accuracy, encourage it a bit more
	ret
.notAccuracy
	call GetPlayerModifier
	ld c, a
	ld a, 2
	call AICheckIfPlayerHPBelowFraction
	jr nc, .checkModifier
	inc [hl]							; if target's HP are below half, discourage move
	ld a, 3
	call AICheckIfPlayerHPBelowFraction
	jr nc, .checkModifier
	inc [hl]							; if target's HP are below 1/3, discourage move further
	ld a, 4
	call AICheckIfPlayerHPBelowFraction
	jr nc, .checkModifier
	inc [hl]							; if target's HP are below 1/4, discourage move further
.checkModifier
	push bc
	call CheckStatDownBlocked
	pop bc
	jr z, .notBlocked
.blocked
	ld a, [hl]
	add 10								; if the move can't hit, strongly discourage it
	ld [hl], a
	ret
.notBlocked
	push bc
	call CheckElapsedTurns
	pop bc
	ret c
	ld a, c
	sub STAT_MODIFIER_DEFAULT
	ld c, a
	ld a, [wEnemyMoveEffect]
	cp ATTACK_DOWN2_EFFECT
	jr c, .minus1
	cp EVASION_DOWN2_EFFECT + 1
	jr nc, .minus1
	inc c							; moves that drop by 2 stages are a bit more encouraged
.minus1
	ld a, c
	cp STAT_MODIFIER_PLUS_6 - STAT_MODIFIER_DEFAULT + 1	; compare encouragement value to the max possible positive value + 1
	jr nc, .skipHPcheck									; if value is strictly superior to the max positive value, it means it's negative, so the move is going to be discouraged, don't check if HP is full
	call IsUserAtFullHP
	ret nz
.skipHPcheck
	ld a, [hl]						; for every stage below neutral (-1 for 2 stages drops), the move is discouraged by 1
	sub c							; for every stage above neutral (-1 for 2 stages drops), the move is encouraged by 1, but only if HP is full
	ld [hl], a
	ret

StatDownTwoStages:
	sub ATTACK_DOWN2_EFFECT - ATTACK_DOWN1_EFFECT
	jp StatDown

TwoStatsUpOneStage:
	cp ATTACK_SPEED_UP_EFFECT
	ld c, ATTACK_STAT_MOD + 1
	jr z, .speedBoost
	cp DEFENSE_SPEED_UP_EFFECT
	ld c, DEFENSE_STAT_MOD + 1
	jr z, .speedBoost
	sub SPEED_SPECIAL_ATTACK_UP_EFFECT
	jr c, .noSpeedBoost
	cp SPEED_EVASION_UP_EFFECT + 1 - SPEED_SPECIAL_ATTACK_UP_EFFECT
	push af
	ld c, SPECIAL_ATTACK_STAT_MOD + 1
	add c
	ld c, a
	pop af
	jr nc, .noSpeedBoost
.speedBoost
	call CompareSpeeds
	jr c, .userIsFaster
	jr z, .speedTie
	ld a, SPEED_STAT_MOD + 1
	call GetEnemyModifier
	cp STAT_MODIFIER_DEFAULT
	jr c, .userIsFaster				; if speed modifier is negative, it probably means the opponent can drop our speed, so no point trying to raise it back
	cp STAT_MODIFIER_PLUS_1
	jr z, .speedTie					; if speed modifier is already +1, don't encourage this move as much
	cp STAT_MODIFIER_PLUS_2
	jr nc, .userIsFaster			; if speed modifier is already +2 or more, disregard speed boost (since that probably means the opponent is also boosting its speed)
	dec [hl]						; if user is strictly slower and speed modifier is neutral, encourage this move, even when not at full HP
.speedTie
	dec [hl]						; if it's a speed tie, only contribute a little encouragement from the speed boost
	ld a, c							; here c contains the other boosted stat modifier's index
	call GetEnemyModifier
	cp STAT_MODIFIER_DEFAULT
	jp nc, AIMoveChoiceModification2.nextMove
	dec [hl]						; further encourage the move if modifier is neutral or lower
	jp AIMoveChoiceModification2.nextMove					; but don't discourage it if it is higher, since we want the speed boost anyway
.userIsFaster
	ld a, ATTACK_UP1_EFFECT - (ATTACK_STAT_MOD + 1)	; this maps the other boosted stat modifier's index to the corresponding move effect id
	add c											; this maps the other boosted stat modifier's index to the corresponding move effect id
	jp StatUp										; if user is faster, consider this move exactly like a single stage stat-up move
.noSpeedBoost
	add SPEED_SPECIAL_ATTACK_UP_EFFECT	; to cancel out the earlier sub and get back the original effect id
	cp DEFENSE_SPEED_UP_EFFECT
	jr c, .attack
	cp SPECIAL_ATTACK_SPECIAL_DEFENSE_UP_EFFECT
	jr c, .defense
	cp SPECIAL_DEFENSE_ACCURACY_UP_EFFECT
	jr c, .specialAttack
	cp ACCURACY_EVASION_UP_EFFECT
	jr c, .specialDefense
	jr .accuracy
.attack
	sub ATTACK_DEFENSE_UP_EFFECT - DEFENSE_STAT_MOD
	ld c, a
	ld a, ATTACK_UP1_EFFECT
	jr .finish
.defense
	sub DEFENSE_SPEED_UP_EFFECT - SPEED_STAT_MOD
	ld c, a
	ld a, DEFENSE_UP1_EFFECT
	jr .finish
.specialAttack
	sub SPECIAL_ATTACK_SPECIAL_DEFENSE_UP_EFFECT - SPECIAL_DEFENSE_STAT_MOD
	ld c, a
	ld a, SPECIAL_ATTACK_UP1_EFFECT
	jr .finish
.specialDefense
	sub SPECIAL_DEFENSE_ACCURACY_UP_EFFECT - ACCURACY_STAT_MOD
	ld c, a
	ld a, SPECIAL_DEFENSE_UP1_EFFECT
	jr .finish
.accuracy
	sub ACCURACY_EVASION_UP_EFFECT - EVASION_STAT_MOD
	ld c, a
	ld a, ACCURACY_UP1_EFFECT
	jr .finish
.finish
	push bc
	call StatUp_Main
	pop bc
	ld a, c
	add ATTACK_UP1_EFFECT
	jp StatUp
	
StatUpSideEffect:
	ld c, a
	push bc
	call _AIGetTypeEffectiveness
	ld a, [wTypeEffectiveness]
	and a
	pop bc
	ld a, c
	jr z, .done						; don't encourage moves that don't affect the target
	sub ATTACK_UP_SIDE_EFFECT - 1
	cp SPEED_STAT_MOD + 1
	jr nz, .notSpeed
	call CompareSpeeds
	jr c, .done
	jr z, .speedTie
	ld a, SPEED_STAT_MOD + 1
	call GetEnemyModifier
	cp STAT_MODIFIER_DEFAULT
	jr c, .done						; if speed modifier is negative, it probably means the opponent can drop our speed, so no point trying to raise it back
	cp STAT_MODIFIER_PLUS_1
	jr z, .speedTie					; if speed modifier is already +1, don't encourage this move as much
	cp STAT_MODIFIER_PLUS_2
	jr nc, .done					; if speed modifier is already +2 or more, disregard speed boost (since that probably means the opponent is also boosting its speed)
	dec [hl]						; if user is strictly slower and speed modifier is neutral, encourage this move, even when not at full HP
.speedTie
	dec [hl]						; if it's a speed tie, only contribute a little encouragement from the speed boost
	jr .done
.notSpeed
	cp EVASION_STAT_MOD + 1
	jr z, .evasion
	call GetEnemyModifier
	cp STAT_MODIFIER_PLUS_1
	jr nc, .done
	ld a, 2
	call AICheckIfEnemyHPBelowFraction
	jr c, .done
	dec [hl]						; encourage the move if modifier is neutral or lower and enemy HP is not below half
	jr .done
.evasion
	call GetEnemyModifier
	cp STAT_MODIFIER_PLUS_6
	jr nc, .done
	dec [hl]						; encourage the move if modifier is not maxed
	cp STAT_MODIFIER_PLUS_3
	jr nc, .done
	dec [hl]						; further encourage the move if modifier is lower than +3
.done
	jp AIMoveChoiceModification2.nextMove

StatDownSideEffect:
	ld c, a
	push bc
	call _AIGetTypeEffectiveness
	ld a, [wTypeEffectiveness]
	and a
	pop bc
	ld a, c
	jr z, .done						; don't encourage moves that don't affect the target
	sub ATTACK_DOWN_SIDE_EFFECT2 - 1
	cp SPEED_STAT_MOD + 1
	jr nz, .notSpeed
	call CheckStatDownBlocked
	jr nz, .done
	call CompareSpeeds
	jr c, .done
	jr z, .speedTie
	ld a, SPEED_STAT_MOD + 1
	call GetPlayerModifier
	cp STAT_MODIFIER_PLUS_1
	jr nc, .done					; if speed modifier is positive, it probably means the opponent can boost its speed, so no point trying to raise it back
	cp STAT_MODIFIER_MINUS_1
	jr z, .speedTie					; if speed modifier is already -1, don't encourage this move as much
	jr c, .done						; if speed modifier is already -2 or lower, disregard speed drop (since that probably means the opponent is also dropping our speed)
	dec [hl]						; if user is strictly slower and speed modifier is neutral, encourage this move, even when not at full HP
.speedTie
	dec [hl]						; if it's a speed tie, only contribute a little encouragement from the speed drop
	jr .done
.notSpeed
	cp ACCURACY_STAT_MOD + 1
	jr z, .accuracy
	call CheckStatDownBlocked
	jr nz, .done
	call GetPlayerModifier
	cp STAT_MODIFIER_DEFAULT
	jr c, .done
	ld a, 3
	call AICheckIfPlayerHPBelowFraction
	jr c, .done
	dec [hl]						; encourage the move if modifier is neutral or higher and target's HP is not below 1/3
	jr .done
.accuracy
	call CheckStatDownBlocked
	jp nz, AIMoveChoiceModification2.nextMove
	call GetPlayerModifier
	cp STAT_MODIFIER_MINUS_6
	jr z, .done
	dec [hl]						; encourage the move if modifier is not minimal
	cp STAT_MODIFIER_MINUS_3
	jr c, .done
	dec [hl]						; further encourage the move if modifier is -3 or higher
.done
	jp AIMoveChoiceModification2.nextMove

; input: stat index in a (ATK=1, DEF=2, SPEED=3, SP.ATK=4, SP.DEF=5, ACCURACY=6, EVADE=7)
; output: value of the stat modifier in a
GetEnemyModifier:
	push hl
	ld hl, wEnemyMonStatMods
.seekModifier
	dec a
	jr z, .gotModifier
	inc hl
	jr .seekModifier
.gotModifier
	ld a, [hl]
	pop hl
	ret

; input: stat index in a (ATK=1, DEF=2, SPEED=3, SP.ATK=4, SP.DEF=5, ACCURACY=6, EVADE=7)
; output: value of the stat modifier in a
GetPlayerModifier:
	push hl
	ld hl, wPlayerMonStatMods
.seekModifier
	dec a
	jr z, .gotModifier
	inc hl
	jr .seekModifier
.gotModifier
	ld a, [hl]
	pop hl
	ret

; unsets the z flag if the player is protected by Mist or a Substitute, sets it otherwise
CheckStatDownBlocked:
	ld c, a
	ld a, [wPlayerMistCounter]
	and a
	jr nz, .done					; if player is protected by MIST, move is blocked
	ld a, [wPlayerBattleStatus2]
	bit HAS_SUBSTITUTE_UP, a	
	jr z, .done						; if player is not protected by MIST or SUBSTITUTE, move is not blocked
	ld a, [wEnemyMoveExtra]		
	bit IS_SOUND_BASED_MOVE, a	
	jr z, .blocked
	xor a							; set z flag to indicate the move is not blocked
	jr .done
.blocked
	and 1							; unset z flag to indicate the move is blocked
.done
	ld a, c
	ret

; this takes into account the number of turns elapsed without a change of pokemon on either side
; sets carry flag if the number of turns elapsed is >= 3
CheckElapsedTurns:
	ld a, [wAILayer2Encouragement]
	cp 3
	jr c, .lessThan3Turns
	ld a, [hl]
	add 5								; after 3 turns have passed without a change of pokemon on either side, strongly discourage this type of moves
	ld [hl], a
	scf
	ret
.lessThan3Turns
	ld c, a
	ld a, [hl]
	add c								; discourage move by 1 for each turn elapsed without a change of pokemon on either side
	ld [hl], a
	xor a
	ret

; encourages moves that are effective against the player's mon
; discourage damaging moves that are ineffective or not very effective against the player's mon,
; unless there's no damaging move that is more effective
AIMoveChoiceModification3:
	ld hl, wBuffer - 1 ; temp move selection array (-1 byte offset)
	ld de, wEnemyMonMoves ; enemy moves
	ld b, NUM_MOVES + 1
.nextMove
	dec b
	ret z ; processed all 4 moves
	inc hl
	ld a, [de]
	inc de
	and a
	jr z, .nextMove					; instead of not looking further than the first empty slot, just skip those
	
	call ReadMove
	ld a, [wEnemyMoveEffect]		; Bide cannot have non-zero Base Power because it would trigger its damage dealing animation on the 1st turn
	cp BIDE_EFFECT					; so we need to check the move effect for Bide before checking the move power
	jr nz, .notBide
	call _AIGetTypeEffectiveness
	ld a, [wTypeEffectiveness]
	jr .notEffectiveMove
.notBide
	ld a, [wEnemyMovePower]			; don't apply this criterion to non-damaging moves
	and a							; so that the AI won't spam "super effective" non-damaging moves
	jr z, .nextMove					; or avoid using "resisted" non-damaging moves
	call _AIGetTypeEffectiveness
	ld a, [wTypeEffectiveness]
	ld [wTypeEffectivenessCopy], a	; save effectiveness in wTypeEffectivenessCopy
	cp NEUTRAL
	jr z, .nextMove
	jr c, .notEffectiveMove
	ld a, [wEnemyMoveEffect]		; don't apply weakness to some move effects
	cp SUPER_FANG_EFFECT
	jr z, .nextMove
	cp LEVEL_DAMAGE_EFFECT
	jr z, .nextMove
	cp FIXED_DAMAGE_EFFECT
	jr z, .nextMove
	cp PSYWAVE_EFFECT
	jr z, .nextMove
	cp COUNTER_EFFECT
	jr z, .nextMove
	cp OHKO_EFFECT
	jr z, .nextMove
	dec [hl]						; super effective move: slightly encourage this move
	dec [hl]						; encourage super effective moves slightly more
	ld a, [wTypeEffectivenessCopy]
	cp DOUBLE_WEAKNESS
	jr c, .nextMove
	dec [hl]						; double super effective move: encourage this move a bit more
	dec [hl]						; double super effective move: encourage this move a bit more
	jr .nextMove
.notEffectiveMove ; discourages sub-neutral moves if better moves are available
	and a						; test if the target is immune to the move
	jr nz, .notIneffective
	ld a, [hl]
	add 15						; strongly discourage moves the target is immune to
	ld [hl], a
	jr .nextMove
.notIneffective
	ld a, [wEnemyMoveEffect]	; don't apply resistance to some move effects
	cp SUPER_FANG_EFFECT
	jr z, .nextMove
	cp LEVEL_DAMAGE_EFFECT
	jr z, .nextMove
	cp FIXED_DAMAGE_EFFECT
	jr z, .nextMove
	cp PSYWAVE_EFFECT
	jr z, .nextMove
	cp COUNTER_EFFECT
	jr z, .nextMove
	cp OHKO_EFFECT
	jr z, .nextMove
	cp BIDE_EFFECT
	jr z, .nextMove
	push hl
	push de
	push bc
	ld a, [wEnemyMoveType]
	ld d, a
	ld hl, wEnemyMonMoves  ; enemy moves
	ld b, NUM_MOVES + 1
	ld c, $0
.loopMoves
	dec b
	jr z, .done
	push hl
	ld hl, wEnemyMonPP		; before examining whether the current move could be better, check its PP
	ld a, NUM_MOVES
	sub b					; make a = NUM_MOVES - b to get the offset of the current potential better move
	add l
	ld l, a					; make hl point to PP of move currently checked
	jr nc, .noCarry
	inc h
.noCarry
	ld a, [hl]				; load potential better move PP in a
	and a					; check whether PP are exhausted
	pop hl
	ld a, [hli]				; read current move ID in a
	jr z, .loopMoves		; don't take into account moves that have no PP left as potential better moves
	and a
	jr z, .loopMoves		; instead of not looking further than the first empty slot, just skip those
	call ReadMove
	ld a, [wEnemyMoveEffect]
	cp SUPER_FANG_EFFECT
	jr z, .checkImmunity ; Super Fang is considered to be a better move (unless it doesn't affect the target)
	cp LEVEL_DAMAGE_EFFECT
	jr z, .checkImmunity ; any level damage move is considered to be better (unless it doesn't affect the target)
	cp FIXED_DAMAGE_EFFECT
	jr z, .checkImmunity ; any fixed damage move is considered to be better (unless it doesn't affect the target)
	cp PSYWAVE_EFFECT
	jr z, .checkImmunity ; Psywave is considered to be a better move (unless it doesn't affect the target)
	ld a, [wEnemyMoveType]
	cp d
	jr z, .loopMoves		; moves that are the same type as the not very effective move can't be better moves
	ld a, [wEnemyMovePower]
	and a
	jr z, .loopMoves				; non-damaging moves can't be better moves
	call _AIGetTypeEffectiveness
	ld a, [wTypeEffectiveness]
	ld e, a
	ld a, [wTypeEffectivenessCopy]
	cp e
	jr c, .betterMoveFound			; moves that are strictly more effective against the target are better moves
	jr .loopMoves
.checkImmunity						; this part is only for moves that have one of the specific effects tested earlier
	call _AIGetTypeEffectiveness
	ld a, [wTypeEffectiveness]
	and a
	jr z, .loopMoves				; moves that are totally ineffective against the target can't be better moves
.betterMoveFound
	ld c, a
.done
	ld a, c
	pop bc
	pop de
	pop hl
	and a
	jp z, .nextMove
	inc [hl]						; slightly discourage this move
	inc [hl]						; discourage resisted moves a bit more
	ld a, [wTypeEffectivenessCopy]
	cp NOT_VERY_EFFECTIVE			; check if the move is doubly resisted
	jp nc, .nextMove
	inc [hl]						; discourage doubly resisted moves even more
	inc [hl]						; discourage doubly resisted moves even more
	jp .nextMove

; implement AI routine to discourage non-STAB damaging moves
AIMoveChoiceModification4:
	ld hl, wBuffer - 1 ; temp move selection array (-1 byte offset)
	ld de, wEnemyMonMoves ; enemy moves
	ld b, NUM_MOVES + 1
.nextMove
	dec b
	ret z ; processed all 4 moves
	inc hl
	ld a, [de]
	inc de
	and a
	jr z, .nextMove					; instead of not looking further than the first empty slot, just skip those
	call ReadMove
	ld a, [wEnemyMovePower]			; don't apply this criterion to non-damaging moves
	and a							; so that the AI won't spam "STAB" non-damaging moves
	jr z, .nextMove
	ld a, [wEnemyMoveEffect]
	cp JUDGMENT_EFFECT				; Judgment always benefits from STAB
	jr z, .nextMove
	push hl
	push de
	push bc
	ld hl, STABInapplicableEffects	; don't take STAB into account for moves with effects in this list
	ld de, 1
	call IsInArray
	pop bc
	pop de
	pop hl
	jr c, .nextMove
	ld a, [wEnemyMoveType]
	ld c, a
	ld a, [wEnemyMonType1]
	cp c
	jr z, .nextMove
	ld a, [wEnemyMonType2]
	cp c
	jr z, .nextMove
	inc [hl]						; discourage this move
	jr .nextMove

STABInapplicableEffects:
	db SUPER_FANG_EFFECT
	db LEVEL_DAMAGE_EFFECT
	db FIXED_DAMAGE_EFFECT
	db PSYWAVE_EFFECT
	db OHKO_EFFECT
	db COUNTER_EFFECT
	db $ff

; AI routine to encourage damaging moves when target is at low HP
AIMoveChoiceModification5:
	ld hl, wBuffer - 1 ; temp move selection array (-1 byte offset)
	ld de, wEnemyMonMoves ; enemy moves
	ld b, NUM_MOVES + 1
.nextMove
	dec b
	ret z ; processed all 4 moves
	inc hl
	ld a, [de]
	inc de
	and a
	jr z, .nextMove			; instead of not looking further than the first empty slot, just skip those
	call ReadMove
	ld a, [wEnemyMovePower]
	and a
	jr z, .nextMove
	ld a, [wEnemyMoveEffect]
	cp COUNTER_EFFECT			; don't encourage counter moves for finishing off opponents
	jr z, .nextMove
	cp SUPER_FANG_EFFECT		; don't encourage super fang for finishing off opponents
	jr z, .nextMove
	ld a, 2
	call AICheckIfPlayerHPBelowFraction
	jr nc, .nextMove
	dec [hl]
	ld a, [wEnemyMoveEffect]
	cp OHKO_EFFECT				; don't encourage OHKO moves further when opponent's HP is below 1/3rd
	jr z, .nextMove
	ld a, 3
	call AICheckIfPlayerHPBelowFraction
	jr nc, .nextMove
	dec [hl]
	ld a, 4
	call AICheckIfPlayerHPBelowFraction
	jr nc, .nextMove
	dec [hl]
	jr .nextMove

; AI routine to encourage priority moves when target is at low HP (and a bit more if user is also at low HP)
AIMoveChoiceModification6:
	ld hl, wBuffer - 1 ; temp move selection array (-1 byte offset)
	ld de, wEnemyMonMoves ; enemy moves
	ld b, NUM_MOVES + 1
.nextMove
	dec b
	ret z ; processed all 4 moves
	inc hl
	ld a, [de]
	inc de
	and a
	jr z, .nextMove				; instead of not looking further than the first empty slot, just skip those
	call ReadMove
	ld a, [wEnemyMovePower]
	and a
	jr z, .nextMove				; don't encourage non-damaging priority moves
	ld a, [wEnemyMoveExtra]
	and $f0						; mask out all but priority bits
	swap a						; move priority bits to the rightmost positions
	cp PRIORITY_PLUS1
	jr c, .nextMove				; skip moves that don't have higher priority than normal
	call CompareSpeeds
	jr c, .userIsFaster
	ld a, 4
	call AICheckIfPlayerHPBelowFraction
	jr nc, .nextMove			; don't encourage priority moves as long as opponent's HP are above 1/4th
	dec [hl]					; if user is slower and opponent's HP are below 1/4th, strongly encourage priority moves
	dec [hl]
	ld a, 4
	call AICheckIfEnemyHPBelowFraction
	jr nc, .userIsFaster
	dec [hl]					; further encourage move if user's HP are below 1/4th
	; fallthrough to further encourage priority moves when either mon's HP are below 1/5th
.userIsFaster
	ld a, 5
	call AICheckIfPlayerHPBelowFraction
	jr nc, .nextMove
	dec [hl]					; if target is below 1/5th HP, encourage priority moves even when faster, to prevent the opponent from hitting us with one of its own priority moves
	dec [hl]
	ld a, 5
	call AICheckIfEnemyHPBelowFraction
	jr nc, .nextMove
	dec [hl]					; if in addition, the user's HP are also below 1/5th, further encourage priority moves
	jr .nextMove

; AI routine to discourage suicide moves with the last mon in the Battle Facility
AIMoveChoiceModification7:
	ld hl, wBuffer - 1 ; temp move selection array (-1 byte offset)
	ld de, wEnemyMonMoves ; enemy moves
	ld b, NUM_MOVES + 1
.nextMove
	dec b
	ret z ; processed all 4 moves
	inc hl
	ld a, [de]
	inc de
	and a
	jr z, .nextMove			; instead of not looking further than the first empty slot, just skip those
	call ReadMove
	ld a, [wEnemyMoveEffect]
	cp EXPLODE_EFFECT
	jr nz, .nextMove
	push hl
	push bc
	push de
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
	ld a, d							; here d contains the number of enemy mons whose HP are not zero
	pop de
	pop bc
	pop hl
	dec a
	jr nz, .nextMove
	ld a, [hl]
	add 20					; highly discourage suicide moves when the user is the last pokemon alive on the team
	ld [hl], a
	jr .nextMove

; AI routine to discourage counter moves when user's HP aren't full or when user is faster
AIMoveChoiceModification8:
	ld hl, wBuffer - 1 ; temp move selection array (-1 byte offset)
	ld de, wEnemyMonMoves ; enemy moves
	ld b, NUM_MOVES + 1
.nextMove
	dec b
	ret z ; processed all 4 moves
	inc hl
	ld a, [de]
	inc de
	and a
	jr z, .nextMove			; instead of not looking further than the first empty slot, just skip those
	call ReadMove
	ld a, [wEnemyMoveEffect]
	cp COUNTER_EFFECT
	jr nz, .nextMove
	call CompareSpeeds
	jr nc, .userIsSlower
	inc [hl]				; if user is faster, slightly discourage the move
.userIsSlower
	call IsUserAtFullHP
	jr z, .nextMove
	inc [hl]							; if user's HP aren't full, discourage the move
	ld a, 2
	call AICheckIfEnemyHPBelowFraction	; if user's HP are below half, discourage move even more
	jr nc, .nextMove
	inc [hl]
	inc [hl]
	jr .nextMove

; AI routine to discourage Bide and 2-turns moves (except when the 1st turn grants invulnerability) when the user is below half HP
AIMoveChoiceModification9:
	ld hl, wBuffer - 1 ; temp move selection array (-1 byte offset)
	ld de, wEnemyMonMoves ; enemy moves
	ld b, NUM_MOVES + 1
.nextMove
	dec b
	ret z ; processed all 4 moves
	inc hl
	ld a, [de]
	inc de
	and a
	jr z, .nextMove			; instead of not looking further than the first empty slot, just skip those
	call ReadMove
	ld a, [wEnemyMoveEffect]
	cp CHARGE_EFFECT
	jr z, .checkHP
	cp SKY_ATTACK_EFFECT
	jr z, .checkHP
	cp BIDE_EFFECT
	jr z, .checkHP
	cp SKULL_BASH_EFFECT
	jr nz, .nextMove
.checkHP
	ld a, 2
	call AICheckIfEnemyHPBelowFraction	; if user's HP are below half, discourage move
	jr nc, .nextMove
	ld a, [hl]
	add 8
	ld [hl], a
	jr .nextMove

; AI routine to discourage/encourage healing moves according to user's HP
AIMoveChoiceModification10:
	ld hl, wBuffer - 1 ; temp move selection array (-1 byte offset)
	ld de, wEnemyMonMoves ; enemy moves
	ld b, NUM_MOVES + 1
.nextMove
	dec b
	ret z ; processed all 4 moves
	inc hl
	ld a, [de]
	inc de
	and a
	jr z, .nextMove			; instead of not looking further than the first empty slot, just skip those
	call ReadMove
	ld a, [wEnemyMoveEffect]
	cp HEAL_EFFECT
	jr z, .healing
	cp REST_EFFECT
	jr z, .resting
	cp DRAIN_HP_EFFECT
	jr z, .draining
	cp DRAIN_HP_EFFECT2
	jr z, .draining
	jr .nextMove
.healing
	ld a, 4
	call AICheckIfEnemyHPBelowFraction	; if user's HP are below 1/4, encourage healing moves
	jr c, .encourage
	ld a, 3
	call AICheckIfEnemyHPBelowFraction	; if user's HP are not below 1/3, discourage healing moves
	jr c, .nextMove
	inc [hl]
	ld a, 2
	call AICheckIfEnemyHPBelowFraction	; if user's HP are not below half, discourage healing moves even more
	jr nc, .discourage
	jr .nextMove
.resting
	ld a, 4
	call AICheckIfEnemyHPBelowFraction	; if user's HP are not below 1/4, discourage REST
	jr c, .checkStatusCondition
	inc [hl]
	ld a, 3
	call AICheckIfEnemyHPBelowFraction	; if user's HP are not below 1/3, discourage REST even more
	jr c, .checkStatusCondition
.discourage
	inc [hl]
	jr .nextMove
.checkStatusCondition
	ld a, [wEnemyMonStatus]
	and (1 << PSN | 1 << BRN | 1 << PAR | 1 << BADLY_POISONED)
	jr z, .nextMove
	dec [hl]							; if user has a status condition that REST can cure, encourage it
	jr .nextMove
.draining
	ld a, 2
	call AICheckIfEnemyHPBelowFraction
	jr nc, .nextMove
.encourage
	dec [hl]							; if user's HP are below half, slightly encourage draining moves
	jr .nextMove

; add this AI routine specifically for trainers in the Battle Facility
AIMoveChoiceModification_BattleFacility:
	call CheckBattleFacility
	ret nz
	call AIMoveChoiceModification1
	call AIMoveChoiceModification2
	call AIMoveChoiceModification3
	call AIMoveChoiceModification4
	call AIMoveChoiceModification5
	call AIMoveChoiceModification6
	call AIMoveChoiceModification7
	call AIMoveChoiceModification8
	call AIMoveChoiceModification9
	jp AIMoveChoiceModification10

; utility function to avoid duplicating code
_AIGetTypeEffectiveness:
	push hl
	push bc
	push de
	callab AIGetTypeEffectiveness
	pop de
	pop bc
	pop hl
	ret

ReadMove:
	push hl
	push de
	push bc
	ld de, wEnemyMoveNum
	push af
	cp SIGNATURE_MOVE_1
	jr z, .signatureMove
	cp SIGNATURE_MOVE_2
	jr nz, .notSignatureMove
.signatureMove
	ld [wd11e], a
	ld a, [wEnemyMonSpecies]
	ld [wMonSpeciesTemp], a
	ld a, [wEnemyMonSpecies + 1]
	ld [wMonSpeciesTemp + 1], a
	call ReadSignatureMoveData
	pop af
	ld [wEnemyMoveNum], a			; restore the move id for other AI routines
	ld hl, wNewBattleFlags
	res USING_SIGNATURE_MOVE, [hl]	; reset it in case we read a Mimicked signature move
	jr .afterReadMove
.notSignatureMove
	call CheckEnemyMimicSlot
	jr nz, .readNonSignatureMove	; if it's not the move slot of a Mimicked signature move, jump
	ld hl, wNewBattleFlags
	set USING_SIGNATURE_MOVE, [hl]	; else set the flag indicating it is an already mapped signature move id
	jr .signatureMove
.readNonSignatureMove
	pop af
	dec a
	ld hl, Moves
	ld bc, MoveEnd - Moves
	call AddNTimes
	call CopyData
.afterReadMove
	pop bc
	pop de
	pop hl
	ret

; add this to check if the move currently being examined by the AI is a Mimicked signature move
; input: b must contain NUM_MOVES_ + 1 - move slot
; sets the z flag if it is, unsets it otherwise
CheckEnemyMimicSlot:
	push bc
	ld c, a
	ld a, NUM_MOVES + 1
	sub b
	ld b, a
	ld a, [wEnemyMimicSlot]
	cp b
	ld a, c
	pop bc
	ret

; move choice modification methods that are applied for each trainer class
; 0 is sentinel value
TrainerClassMoveChoiceModifications:
	db 0      ; YOUNGSTER
	db 1,0    ; BUG CATCHER
	db 1,0    ; LASS
	db 1,3,0  ; SAILOR
	db 1,0    ; JR_TRAINER_M
	db 1,0    ; JR_TRAINER_F
	db 1,2,3,0; POKEMANIAC
	db 1,2,0  ; SUPER_NERD
	db 1,0    ; HIKER
	db 1,0    ; BIKER
	db 1,3,0  ; BURGLAR
	db 1,0    ; ENGINEER
	db 1,2,0  ; JUGGLER_X
	db 1,3,0  ; FISHER
	db 1,3,0  ; SWIMMER
	db 0      ; CUE_BALL
	db 1,0    ; GAMBLER
	db 1,3,0  ; BEAUTY
	db 1,2,0  ; PSYCHIC_TR
	db 1,3,0  ; ROCKER
	db 1,0    ; JUGGLER
	db 1,0    ; TAMER
	db 1,0    ; BIRD_KEEPER
	db 1,0    ; BLACKBELT
	db 1,0    ; SONY1
	db 1,3,0  ; PROF_OAK
	db 1,2,0  ; CHIEF
	db 1,2,0  ; SCIENTIST
	db 1,3,0  ; GIOVANNI
	db 1,0    ; ROCKET
	db 1,3,0  ; COOLTRAINER_M
	db 1,3,0  ; COOLTRAINER_F
	db 1,0    ; BRUNO
	db 1,0    ; BROCK
	db 1,3,0  ; MISTY
	db 1,3,0  ; LT_SURGE
	db 1,3,0  ; ERIKA
	db 1,3,0  ; KOGA
	db 1,3,0  ; BLAINE
	db 1,3,0  ; SABRINA
	db 1,2,0  ; GENTLEMAN
	db 1,3,0  ; SONY2
	db 1,3,0  ; SONY3
	db 1,2,3,0; LORELEI
	db 1,0    ; CHANNELER
	db 1,0    ; AGATHA
	db 1,3,0  ; LANCE
	db 1,3,0  ; BROCK2
	db 1,3,0  ; MISTY2
	db 1,3,0  ; LT_SURGE2
	db 1,3,0  ; ERIKA2
	db 1,3,0  ; KOGA2
	db 1,3,0  ; SABRINA2
	db 1,3,0  ; BLAINE2
	db 1,3,0  ; GIOVANNI2

INCLUDE "engine/battle/trainer_pic_money_pointers.asm"

INCLUDE "text/trainer_names.asm"

INCLUDE "engine/battle/bank_e_misc.asm"

TrainerAI:
	and a
	ld a, [wIsInBattle]
	dec a
	ret z ; if not a trainer, we're done here
	ld a, [wLinkState]
	cp LINK_STATE_BATTLING
	ret z
	ld a, [wEnemyBattleStatus1]
	and ((1 << STORING_ENERGY) | (1 << THRASHING_ABOUT) | (1 << CHARGING_UP) | (1 << INVULNERABLE))	; prevent use of items or switching 
	ret nz																							; when in the middle of a multiturn move
	ld a, [wEnemyBattleStatus2]
	bit NEEDS_TO_RECHARGE, a
	ret nz															; prevent AI from using items or switching after Hyper Beam
	ld a, [wTrainerClass] ; what trainer class is this?
	dec a
	ld c, a
	ld b, 0
	ld hl, TrainerAIPointers
	add hl, bc
	add hl, bc
	add hl, bc
	ld a, [wAICount]
	and a
	ret z ; if no AI uses left, we're done here
	inc hl
	inc a
	jr nz, .getpointer
	dec hl
	ld a, [hli]
	ld [wAICount], a
.getpointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call Random
	jp hl

TrainerAIPointers:
; one entry per trainer class
; first byte, number of times (per Pokémon) it can occur
; next two bytes, pointer to AI subroutine for trainer class
	dbw 3,GenericAI
	dbw 3,GenericAI
	dbw 3,GenericAI
	dbw 3,GenericAI
	dbw 3,GenericAI
	dbw 3,GenericAI
	dbw 3,GenericAI
	dbw 3,GenericAI
	dbw 3,GenericAI
	dbw 3,GenericAI
	dbw 3,GenericAI
	dbw 3,GenericAI
	dbw 3,JugglerAI ; juggler_x
	dbw 3,GenericAI
	dbw 3,GenericAI
	dbw 3,GenericAI
	dbw 3,GenericAI
	dbw 3,GenericAI
	dbw 3,GenericAI
	dbw 3,GenericAI
	dbw 3,JugglerAI ; juggler
	dbw 3,GenericAI
	dbw 3,GenericAI
	dbw 2,BlackbeltAI ; blackbelt
	dbw 3,GenericAI
	dbw 3,GenericAI
	dbw 1,GenericAI ; chief
	dbw 3,GenericAI
	dbw 1,GiovanniAI ; giovanni
	dbw 3,GenericAI
	dbw 2,CooltrainerMAI ; cooltrainerm
	dbw 1,CooltrainerFAI ; cooltrainerf
	dbw 1,BrunoAI ; bruno decreased to 1 since now he uses DIRE HIT instead of X DEFEND
	dbw 5,BrockAI ; brock
	dbw 1,MistyAI ; misty
	dbw 1,LtSurgeAI ; surge
	dbw 1,ErikaAI ; erika
	dbw 1,KogaAI ; koga decreased to 1 since X items now provide +2
	dbw 1,BlaineAI ; blaine decreased to 1 since X items now provide +2
	dbw 1,SabrinaAI ; sabrina
	dbw 3,GenericAI
	dbw 1,Sony2AI ; sony2
	dbw 1,Sony3AI ; sony3
	dbw 2,LoreleiAI ; lorelei
	dbw 3,GenericAI
	dbw 2,AgathaAI ; agatha
	dbw 1,LanceAI ; lance
	dbw 5,BrockAI ; brock rematch
	dbw 1,MistyAI ; misty rematch
	dbw 1,LtSurgeAI ; surge rematch
	dbw 1,ErikaAI ; erika rematch
	dbw 1,KogaAI ; koga rematch
	dbw 1,SabrinaAI ; sabrina rematch
	dbw 1,BlaineAI ; blaine rematch
	dbw 1,GiovanniAI ; giovanni rematch

JugglerAI:
	cp $40
	ret nc
	call CheckBattleFacility		; suppress this behaviour in the Battle Facility
	ret z
	jp AISwitchIfEnoughMons

BlackbeltAI:
	cp $20
	ret nc
	jp AIUseXAttack

GiovanniAI:
	cp $40
	ret nc
	jp AIUseGuardSpec

CooltrainerMAI:
	cp $40
	ret nc
	jp AIUseXAttack

CooltrainerFAI:
	cp $40
	ret nc							; prevent the AI from always performing a switch or potion when on low HP
	ld a, $A
	call AICheckIfEnemyHPBelowFraction
	jp c, AIUseHyperPotion
	ld a, 5
	call AICheckIfEnemyHPBelowFraction
	ret nc
	call CheckBattleFacility		; suppress this behaviour in the Battle Facility
	ret z
	jp AISwitchIfEnoughMons

BrockAI:
; if his active monster has a status condition, use a full heal
	ld a, [wEnemyMonStatus]
	and a
	ret z
	jp AIUseFullHeal

MistyAI:
	cp $40
	ret nc
	jp AIUseXDefend

LtSurgeAI:
	cp $40
	ret nc
	jp AIUseXSpeed

ErikaAI:
	cp $40
	ret nc
	jp AIUseXSpecialDefense

KogaAI:
	cp $40
	ret nc
	jp AIUseXAttack

BlaineAI:
	cp $40
	ret nc
	jp AIUseXSpecialAttack

SabrinaAI:
	cp $40
	ret nc
	ld a, 5					; increased threshold from 10% HP to 20% HP
	call AICheckIfEnemyHPBelowFraction
	ret nc
	ld a, [wTrainerNo]
	cp 2					; check if this is the rematch team
	jp c, AIUseHyperPotion	; if not, use Hyper Potion
	jp AIUseFullRestore		; if yes, use Full Restore

Sony2AI:
	cp $20
	ret nc
	ld a, 5
	call AICheckIfEnemyHPBelowFraction
	ret nc
	ld a, [wTrainerNo]		; use the trainer number to determine which item the rival uses
	cp 4					; so that he uses an item appropriate to his level
	jp c, AIUsePotion		; Potion on the SS Anne
	cp 7
	jp c, AIUseSuperPotion	; Super Potion in the Pokemon Tower
	cp 10
	jp c, AIUseHyperPotion	; Hyper Potion in Silph Co
	jp AIUseMaxPotion		; Max Potion on Route 22 after getting all the badges

Sony3AI:
	cp $20
	ret nc
	ld a, 5
	call AICheckIfEnemyHPBelowFraction
	ret nc
	jp AIUseFullRestore

LoreleiAI:
	cp $80
	ret nc
	ld a, 5
	call AICheckIfEnemyHPBelowFraction
	ret nc
	ld a, [wTrainerNo]
	cp 2					; check if this is the rematch team
	jp c, AIUseSuperPotion	; if not, use Super Potion
	jp AIUseHyperPotion		; if yes, use Hyper Potion

BrunoAI:
	cp $40
	ret nc
	jp AIUseDireHit

AgathaAI:
	cp $14
	jp c, AISwitchIfEnoughMons
	cp $80
	ret nc
	ld a, 4
	call AICheckIfEnemyHPBelowFraction
	ret nc
	ld a, [wTrainerNo]
	cp 2					; check if this is the rematch team
	jp c, AIUseSuperPotion	; if not, use Super Potion
	jp AIUseHyperPotion		; if yes, use Hyper Potion

LanceAI:
	cp $80
	ret nc
	ld a, 5
	call AICheckIfEnemyHPBelowFraction
	ret nc
	ld a, [wTrainerNo]
	cp 2					; check if this is the rematch team
	jp c, AIUseHyperPotion	; if not, use Hyper Potion
	jp AIUseMaxPotion		; if yes, use Max Potion

GenericAI:
	and a ; clear carry
	ret

; end of individual trainer AI routines

DecrementAICount:
	ld hl, wAICount
	dec [hl]
	ld hl, wEnemyBattleStatus3
	set CANT_BE_SUCKER_PUNCHED, [hl]	; Sucker Punch fails when the target uses an item
	scf
	ret

AIPlayRestoringSFX:
	ld a, SFX_HEAL_AILMENT
	jp PlaySoundWaitForCurrent

; added
AIUseMaxPotion:
	call CheckBattleFacility
	ret z
	ld a, MAX_POTION
	ld [wAIItem], a
	jr AIHealHPToFull

AIUseFullRestore:
	call CheckBattleFacility
	ret z
	call AICureStatus
	ld a, FULL_RESTORE
	ld [wAIItem], a
AIHealHPToFull:
	ld de, wHPBarOldHP
	ld hl, wEnemyMonHP + 1
	ld a, [hld]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	inc de
	ld hl, wEnemyMonMaxHP + 1
	ld a, [hld]
	ld [de], a
	inc de
	ld [wHPBarMaxHP], a
	ld [wEnemyMonHP + 1], a
	ld a, [hl]
	ld [de], a
	ld [wHPBarMaxHP+1], a
	ld [wEnemyMonHP], a
	jr AIPrintItemUseAndUpdateHPBar

AIUsePotion:
; enemy trainer heals his monster with a potion
	ld a, POTION
	ld [wAIItem], a					; moved it here from AIRecoverHP because CheckBattleFacility clobbers a
	ld b, POTION_HEAL_AMOUNT
	jr AIRecoverHP

AIUseSuperPotion:
; enemy trainer heals his monster with a super potion
	ld a, SUPER_POTION
	ld [wAIItem], a					; moved it here from AIRecoverHP because CheckBattleFacility clobbers a
	ld b, SUPER_POTION_HEAL_AMOUNT
	jr AIRecoverHP

AIUseHyperPotion:
; enemy trainer heals his monster with a hyper potion
	ld a, HYPER_POTION
	ld [wAIItem], a					; moved it here from AIRecoverHP because CheckBattleFacility clobbers a
	ld b, HYPER_POTION_HEAL_AMOUNT
	; fallthrough

AIRecoverHP:
	call CheckBattleFacility
	ret z
; heal b HP and print "trainer used $(wAIItem) on pokemon!"
	ld hl, wEnemyMonHP + 1
	ld a, [hl]
	ld [wHPBarOldHP], a
	add b
	ld [hld], a
	ld [wHPBarNewHP], a
	ld a, [hl]
	ld [wHPBarOldHP+1], a
	ld [wHPBarNewHP+1], a
	jr nc, .next
	inc a
	ld [hl], a
	ld [wHPBarNewHP+1], a
.next
	inc hl
	ld a, [hld]
	ld b, a
	ld de, wEnemyMonMaxHP + 1
	ld a, [de]
	dec de
	ld [wHPBarMaxHP], a
	sub b
	ld a, [hli]
	ld b, a
	ld a, [de]
	ld [wHPBarMaxHP+1], a
	sbc b
	jr nc, AIPrintItemUseAndUpdateHPBar
	inc de
	ld a, [de]
	dec de
	ld [hld], a
	ld [wHPBarNewHP], a
	ld a, [de]
	ld [hl], a
	ld [wHPBarNewHP+1], a
	; fallthrough

AIPrintItemUseAndUpdateHPBar:
	call AIPrintItemUse_
	coord hl, 2, 2
	xor a
	ld [wHPBarType], a
	predef UpdateHPBar2
	ld hl, wEnemyHPBarColor
	ld b, [hl]
	call GetHealthBarColor
	ld a, [hl]
	cp b
	jr z, .done
	ld b, SET_PAL_BATTLE
	call RunPaletteCommand		; update enemy's HP bar color if needed
.done
	jp DecrementAICount

AISwitchIfEnoughMons:
; enemy trainer switches if there are 2 or more unfainted mons in party
	call CheckAISwitchAllowed		; add a check to see if the opponent can switch
	jr nz, .dontSwitch				; if previous call unset the z flag, it means the opponent is trapped by Wrap or Mean Look
	ld a, [wEnemyPartyCount]
	ld c, a
	ld hl, wEnemyMon1HP

	ld d, 0 ; keep count of unfainted monsters

	; count how many monsters haven't fainted yet
.loop
	ld a, [hli]
	ld b, a
	ld a, [hld]
	or b
	jr z, .Fainted ; has monster fainted?
	inc d
.Fainted
	push bc
	ld bc, wEnemyMon2 - wEnemyMon1
	add hl, bc
	pop bc
	dec c
	jr nz, .loop

	ld a, d ; how many available monsters are there?
	cp 2 ; don't bother if only 1
	jp nc, SwitchEnemyMon
.dontSwitch
	and a
	ret

SwitchEnemyMon:

; prepare to withdraw the active monster: copy hp, number, and status to roster

	ld a, [wEnemyMonPartyPos]
	ld hl, wEnemyMon1HP
	ld bc, wEnemyMon2 - wEnemyMon1
	call AddNTimes
	ld d, h
	ld e, l
	ld hl, wEnemyMonHP
	ld bc, 4
	call CopyData

	ld hl, AIBattleWithdrawText
	ld a, [wNewBattleFlags]			; add a check to see if it's a forced switch
	bit FORCED_SWITCH_OCCURRED, a
	call z, PrintText				; if it isn't, print the text
	; This wFirstMonsNotOutYet variable is abused to prevent the player from
	; switching in a new mon in response to this switch.
	ld a, 1
	ld [wFirstMonsNotOutYet], a
	callab EnemySendOut
	xor a
	ld [wFirstMonsNotOutYet], a
	dec a
	ld [wAILayer2Encouragement], a
	ld a, [wLinkState]
	cp LINK_STATE_BATTLING
	ret z
	scf
	ret

AIBattleWithdrawText:
	TX_FAR _AIBattleWithdrawText
	db "@"

AIUseFullHeal:
	call CheckBattleFacility
	ret z
	call AIPlayRestoringSFX
	call AICureStatus
	ld a, FULL_HEAL
	jp AIPrintItemUse

AICureStatus:
; cures the status of enemy's active pokemon
	ld a, [wEnemyMonPartyPos]
	ld hl, wEnemyMon1Status
	ld bc, wEnemyMon2 - wEnemyMon1
	call AddNTimes
	xor a
	ld [hl], a									; clear status in enemy team roster
	ld [wEnemyMonStatus], a						; clear status of active enemy
	ld bc, wEnemyMon1MaxHP - wEnemyMon1Status
	add hl, bc
	ld de, wEnemyMonMaxHP
	ld bc, NUM_STATS * 2
	call CopyData
	callab UpdateStats							; update stats of healed pokemon to remove stats nerfs due to Burn or Paralysis
	callab DrawEnemyHUDAndHPBar					; update status on screen
	ret

AIUseGuardSpec:
	call CheckBattleFacility
	ret z
	ld a, [wEnemyMistCounter]	; use the counter to check if the enemy is already protected by Mist
	and a
	ret nz						; if enemy is already protected by Mist, don't use Guard Spec.
	call AIPlayRestoringSFX
	ld a, 5						; effect duration
	ld [wEnemyMistCounter], a
	ld a, GUARD_SPEC
	jp AIPrintItemUse

AIUseDireHit:
	call CheckBattleFacility
	ret z
	call AIPlayRestoringSFX
	ld hl, wEnemyBattleStatus2
	set GETTING_PUMPED, [hl]
	ld a, DIRE_HIT
	jp AIPrintItemUse

AICheckIfPlayerHPBelowFraction:
	push hl
	push bc
	push de
	ld hl, wBattleMonMaxHP
	call AICheckIfHPBelowFraction
	pop de
	pop bc
	pop hl
	ret

AICheckIfEnemyHPBelowFraction:
	push hl
	push bc
	push de
	ld hl, wEnemyMonMaxHP
	call AICheckIfHPBelowFraction
	pop de
	pop bc
	pop hl
	ret

AICheckIfHPBelowFraction:
; return carry if enemy trainer's current HP is below 1 / a of the maximum
	ld [H_DIVISOR], a
	ld a, [hli]
	ld [H_DIVIDEND], a
	ld a, [hl]
	ld [H_DIVIDEND + 1], a
	ld b, 2
	call Divide
	ld bc, (wEnemyMonHP + 1) - (wEnemyMonMaxHP + 1)
	add hl, bc
	ld a, [H_QUOTIENT + 3]
	ld c, a
	ld a, [H_QUOTIENT + 2]
	ld b, a
	ld a, [hld]
	ld e, a
	ld a, [hl]
	ld d, a
	ld a, d
	sub b
	ret nz
	ld a, e
	sub c
	ret

AIUseXAttack:
	ld b, ATTACK_UP2_EFFECT
	ld a, X_ATTACK
	ld [wAIItem], a						; moved it here from AIIncreaseStat because CheckBattleFacility clobbers a
	jr AIIncreaseStat

AIUseXDefend:
	ld b, DEFENSE_UP2_EFFECT
	ld a, X_DEFEND
	ld [wAIItem], a						; moved it here from AIIncreaseStat because CheckBattleFacility clobbers a
	jr AIIncreaseStat

AIUseXSpeed:
	ld b, SPEED_UP2_EFFECT
	ld a, X_SPEED
	ld [wAIItem], a						; moved it here from AIIncreaseStat because CheckBattleFacility clobbers a
	jr AIIncreaseStat

AIUseXSpecialAttack:
	ld b, SPECIAL_ATTACK_UP2_EFFECT
	ld a, X_SP.ATK
	ld [wAIItem], a						; moved it here from AIIncreaseStat because CheckBattleFacility clobbers a
	jr AIIncreaseStat

AIUseXSpecialDefense:
	ld b, SPECIAL_DEFENSE_UP2_EFFECT
	ld a, X_SP.DEF
	ld [wAIItem], a						; moved it here from AIIncreaseStat because CheckBattleFacility clobbers a
	jr AIIncreaseStat

; add this function to implement new behaviour of X_ACCURACY:
AIUseXAccuracy:
	ld b, ACCURACY_UP2_EFFECT
	ld a, X_ACCURACY
	ld [wAIItem], a
	; fallthrough

AIIncreaseStat:
	call CheckBattleFacility
	ret z
	push bc
	call AIPrintItemUse_
	pop bc
	ld hl, wEnemyMoveEffect
	ld a, [hld]
	push af
	ld a, [hl]
	push af
	push hl
	ld a, ANIM_AF
	ld [hli], a
	ld [hl], b
	ld hl, wEnemyBattleStatus3
	set USED_XITEM, [hl]			; allows to use the correct animation
	callab StatModifierUpEffect
	ld hl, wEnemyBattleStatus3
	res USED_XITEM, [hl]
	pop hl
	pop af
	ld [hli], a
	pop af
	ld [hl], a
	jp DecrementAICount

AIPrintItemUse:
	ld [wAIItem], a
	call AIPrintItemUse_
	jp DecrementAICount

AIPrintItemUse_:
; print "x used [wAIItem] on z!"
	ld a, [wAIItem]
	ld [wd11e], a
	call GetItemName
	ld hl, AIBattleUseItemText
	jp PrintText

AIBattleUseItemText:
	TX_FAR _AIBattleUseItemText
	db "@"

; add this function to check if the AI can switch
CheckAISwitchAllowed:
	ld hl, wEnemyMonType
	ld a, [hli]						; check type 1
	cp GHOST
	ret z							; GHOST types can't be trapped
	ld a, [hl]						; check type 2
	cp GHOST
	ret z							; GHOST types can't be trapped
	ld hl, wPlayerBattleStatus1
	bit USING_TRAPPING_MOVE, [hl]	; is the pokemon being trapped by Wrap or similar?
	ret nz							; if yes, cannot switch
	ld hl, wEnemyBattleStatus3
	bit TRAPPED, [hl]				; this is to test move effects such as Mean Look
	ret

; This function is used to prevent the AI from choosing a move with no PP left:
ForbidExhaustedMoves:
	ld hl, wEnemyMonPP		; PP of the first move
	ld de, wBuffer			; temp move selection array
	ld c, NUM_MOVES			; loop counter
.loop
	ld a, [hli]				; load the value of the PP of the first move
	and a
	jr nz, .hasMorePP		; if the move has non-null PP, don't disable move slot
	ld [de], a				; else disable move slot
.hasMorePP
	inc de
	dec c					; decrement loop counter
	jr nz, .loop			; if still not null, it means the loop isn't complete, so iterate again
	ret

; sets the z flag if we're in the Battle Facility, unsets it otherwise
CheckBattleFacility:
	ld a, [wBattleType]
	cp BATTLE_TYPE_FACILITY
	ret

; input: move id in wMoveNum, only works for non-signature moves
; output: type id in d
GetTMMoveType:
	ld a, [wMoveNum]
	dec a
	ld hl, Moves + MOVEDATA_TYPE
	ld bc, MoveEnd - Moves
	call AddNTimes
	ld d, [hl]
	ret
