HandleNewEffect:
	ld a, [H_WHOSETURN]
	and a
	ld a, [wPlayerMoveEffect]
	jr z, .next1
	ld a, [wEnemyMoveEffect]
.next1
	ld d, a							; store move effect in d
	ld b, 0
	sub ATTACK_DOWN_SIDE_EFFECT2
	add a
	jr nc, .next2
	inc b
.next2
	ld hl, NewEffectsPointerTable
	ld c, a
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

NewEffectsPointerTable:
	dw GuaranteedStatLowering
	dw GuaranteedStatLowering
	dw GuaranteedStatLowering
	dw GuaranteedStatLowering
	dw GuaranteedStatLowering
	dw GuaranteedStatLowering
	dw GuaranteedStatLowering
	dw DualStatBoostHandler
	dw DualStatBoostHandler
	dw DualStatBoostHandler
	dw DualStatBoostHandler
	dw DualStatBoostHandler
	dw DualStatBoostHandler
	dw DualStatBoostHandler
	dw DualStatBoostHandler
	dw DualStatBoostHandler
	dw DualStatBoostHandler
	dw DualStatBoostHandler
	dw DualStatBoostHandler
	dw DualStatBoostHandler
	dw DualStatBoostHandler
	dw DualStatBoostHandler
	dw DualStatBoostHandler
	dw DualStatBoostHandler
	dw DualStatBoostHandler
	dw DualStatBoostHandler
	dw DualStatBoostHandler
	dw DualStatBoostHandler
	dw PostDamageStatBoost
	dw PostDamageStatBoost
	dw PostDamageStatBoost
	dw PostDamageStatBoost
	dw PostDamageStatBoost
	dw PostDamageStatBoost
	dw PostDamageStatBoost
	dw PostDamageStatBoost
	dw PostDamageStatBoost
	dw PostDamageStatBoost
	dw PostDamageStatBoost
	dw PostDamageStatBoost
	dw PostDamageStatBoost
	dw PostDamageStatBoost
	dw RecoilDebuffHandler
	dw RecoilDebuffHandler
	dw RecoilDebuffHandler
	dw RecoilDebuffHandler
	dw RecoilDebuffHandler
	dw RecoilDebuffHandler
	dw RecoilDebuffHandler
	dw PostDamageStatBoost		; moves that boost a stat 20% of the time
	dw PostDamageStatBoost
	dw PostDamageStatBoost
	dw PostDamageStatBoost
	dw PostDamageStatBoost
	dw PostDamageStatBoost
	dw PostDamageStatBoost
	dw RecoilDualDebuffHandler
	dw RecoilDualDebuffHandler
	dw RecoilDualDebuffHandler
	dw RecoilDualDebuffHandler
	dw RecoilDualDebuffHandler
	dw RecoilDualDebuffHandler
	dw RecoilDualDebuffHandler
	dw RecoilDualDebuffHandler
	dw RecoilDualDebuffHandler
	dw RecoilDualDebuffHandler
	dw RecoilDualDebuffHandler
	dw RecoilDualDebuffHandler
	dw RecoilDualDebuffHandler
	dw RecoilDualDebuffHandler
	dw RecoilDualDebuffHandler
	dw RecoilDualDebuffHandler
	dw RecoilDualDebuffHandler
	dw RecoilDualDebuffHandler
	dw RecoilDualDebuffHandler
	dw RecoilDualDebuffHandler
	dw RecoilDualDebuffHandler
	dw QuiverDanceEffect
	dw SuperBoostHandler
	dw $0000							; REVENGE_EFFECT
	dw _StatModifierDownEffect
	dw _StatModifierDownEffect
	dw _StatModifierDownEffect
	dw _StatModifierDownEffect
	dw _StatModifierDownEffect
	dw _StatModifierDownEffect
	dw _StatModifierDownEffect
	dw _StatModifierDownEffect
	dw _StatModifierDownEffect
	dw _StatModifierDownEffect
	dw _StatModifierDownEffect
	dw _StatModifierDownEffect
	dw _StatModifierDownEffect
	dw _StatModifierDownEffect
	dw _FlinchSideEffect
	dw _DrainHPEffect
	dw FlinchBurnParalyzeFreezeEffect
	dw FlinchBurnParalyzeFreezeEffect
	dw FlinchBurnParalyzeFreezeEffect
	dw _BurnEffect
	dw _RecoilEffect					; 33% recoil
	dw _RecoilEffect					; 50% recoil
	dw FlareBlitzEffect
	dw PrintWallShatteredText			; BRICK_BREAK_EFFECT
	dw BadPoisonSideEffect
	dw _PoisonEffect					; POISON_SIDE_EFFECT3
	dw _ConfusionEffect					; CONFUSION_SIDE_EFFECT2
	dw _ConfusionEffect					; CONFUSION_SIDE_EFFECT3
	dw $0000							; PSYSHOCK_EFFECT
	dw $0000							; HEX_EFFECT
	dw $0000							; VENOSHOCK_EFFECT
	dw PostDamageStatBoost				; moves that boost a stat 10% of the time
	dw PostDamageStatBoost
	dw PostDamageStatBoost
	dw PostDamageStatBoost
	dw PostDamageStatBoost
	dw PostDamageStatBoost
	dw PostDamageStatBoost
	dw $0000							; JUDGMENT_EFFECT
	dw $0000							; WEIGHT_DIFFERENCE_EFFECT
	dw $0000							; SUCKER_PUNCH_EFFECT
	dw _FreezeBurnParalyzeEffect		; AUTODEFROST_BURN_SIDE_EFFECT1
	dw _FreezeBurnParalyzeEffect		; AUTODEFROST_BURN_SIDE_EFFECT2
	dw _EjectSideEffectHandler			; moves that do damage and force the target to switch out
	dw RecoilSingleDebuffHandler		; moves that drop user's stat by 1 stage
	dw RecoilSingleDebuffHandler
	dw RecoilSingleDebuffHandler
	dw RecoilSingleDebuffHandler
	dw RecoilSingleDebuffHandler
	dw RecoilSingleDebuffHandler
	dw RecoilSingleDebuffHandler
	dw TrappingEffect					; moves like Mean Look
	dw TrickRoomEffect

; sets z flag if target doesn't have a substitute, unsets it otherwise
CheckTargetSubstitute_Bis:
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

; input : stat boost effect ID in a
; output : if multiplier is maxed out, unsets the carry flag, else sets it
checkAttackerStatMultiplierMax:
	sub ATTACK_UP1_EFFECT
	call loadStatMultiplier
	cp STAT_MODIFIER_PLUS_6
	ret

; input : stat index in a
; output : if multiplier is at its lowest, sets the z flag, else unsets it
checkAttackerStatMultiplierMin:
	call loadStatMultiplier
	cp STAT_MODIFIER_MINUS_6
	ret

loadStatMultiplier:
	ld c, a
	ld hl, wPlayerMonStatMods
	ld a, [H_WHOSETURN]
	and a
	jr z, .next2
	ld hl, wEnemyMonStatMods
.next2
	ld b, $0
	add hl, bc
	ld a, [hl]
	ret

PreCheckDefenderStatMultiplierMin:
	cp NUM_STAT_MODS
	jr c, checkDefenderStatMultiplierMin
	sub ATTACK_UP2_EFFECT - ATTACK_UP1_EFFECT
	
; input: stat index in a
; output: if stat is at its minimum, sets the z flag, else unsets it
checkDefenderStatMultiplierMin:
	ld b, a
	ld a, [H_WHOSETURN]
	xor $1						;  reverse turn
	ld [H_WHOSETURN], a
	ld a, b
	call checkAttackerStatMultiplierMin
	push af
	ld a, [H_WHOSETURN]
	xor $1						;  reverse turn
	ld [H_WHOSETURN], a
	pop af
	ret

GuaranteedStatLowering:
	call CheckTargetSubstitute_Bis			; call the local function
	ret nz									; can't lower stat of a target behind a substitute
	ld hl, wEnemyMistCounter
	ld a, [H_WHOSETURN]
	and a
	jr z, .next
	ld hl, wPlayerMistCounter
.next
	ld a, [hl]
	and a									; check whether target's Mist counter is null
	ret nz									; return if it isn't
DoStatLowering:
	ld a, d									; put move effect in a
	sub ATTACK_DOWN_SIDE_EFFECT2			; make move effect ID coincide with stat index for next function
	call PreCheckDefenderStatMultiplierMin
	ret z									; if stat multiplier is at its min, return
LowerStatNoAnim:
	ld a, [wOptions]
	push af
	or (1 << BATTLE_ANIMATIONS)				; set bit BATTLE_ANIMATIONS of the Options (turn battle animations off)
	ld [wOptions], a
	callab LowerStat
	pop af
	ld [wOptions], a						; restore the options
	ret

DualStatBoostHandler:
	ld hl, wPlayerMoveEffect
	ld a, [H_WHOSETURN]
	and a
	jr z, .next
	ld hl, wEnemyMoveEffect
.next
	ld a, [wOptions]
	push af
	ld a, [hl]											; move effect
	sub ATTACK_DEFENSE_UP_EFFECT - DEFENSE_UP1_EFFECT	; make first dual boost effect (Atk+Def) coincide with $b (+1 Def)
	ld e, ATTACK_UP1_EFFECT
	ld c, NUM_STAT_MODS - 2
.loop							; this loop seeks the first stat to be raised
	cp EVASION_UP1_EFFECT + 1
	jr c, .firstBoostFound		; while a is decremented until it's <= EVASION_UP1_EFFECT
	inc e						; in this loop, e contains effect for first boost
	sub c						; at the end of the loop, a will contain effect for 2nd boost
	dec c
	jr .loop
.firstBoostFound
	ld d, a					; store value for second boost
	ld a, e
	ld [hl], a				; put value for 1st boost in move effect
	push hl
	push de
	call checkAttackerStatMultiplierMax
	jr c, .doFirstBoost						; if first stat is not maxed, boost it
	ld a, d									; else check if second stat is also maxed
	call checkAttackerStatMultiplierMax
	jr c, .doSecondBoost					; if both stats are maxed, call the stat raising function to display "Nothing happened!"
											; else just skip the first call to stat raising function
.doFirstBoost
	callab StatModifierUpEffect
	ld a, [wOptions]
	or (1 << BATTLE_ANIMATIONS)				; set bit BATTLE_ANIMATIONS of the Options (turn battle animations off)
	ld [wOptions], a
.doSecondBoost
	pop de
	pop hl
	ld a, d									; put second boost value in a
	ld [hl], a								; hl points to move effect
	call checkAttackerStatMultiplierMax
	jr nc, .end								; if second stat is maxed, skip the boost
	callab StatModifierUpEffect
.end
	pop af
	ld [wOptions], a		; restore the options
	ret

PostDamageStatBoost:
	ld hl, wPlayerMoveEffect
	ld a, [H_WHOSETURN]
	and a
	jr z, .next
	ld hl, wEnemyMoveEffect
.next
	ld a, [hl]
	cp ATTACK_UP_SIDE_EFFECT2							; check whether effect is guaranteed stat boost or potential stat boost
	jr c, .doStatBoost
	sub ATTACK_UP_SIDE_EFFECT2 - ATTACK_UP_SIDE_EFFECT	; makes effects that have 70% chance to raise stat point to effects that always raise stat
	ld d, a
	ld b, SEVENTY_PERCENT
	cp ATTACK_UP_SIDE_EFFECT2
	jr c, .test
	sub ATTACK_UP_SIDE_EFFECT3 - ATTACK_UP_SIDE_EFFECT2	; makes effects that have 20% chance to raise stat point to effects that always raise stat
	ld d, a
	ld b, TWENTY_PERCENT
	cp ATTACK_UP_SIDE_EFFECT3
	jr c, .test
	sub ATTACK_UP_SIDE_EFFECT4 - ATTACK_UP_SIDE_EFFECT3	; makes effects that have 10% chance to raise stat point to effects that always raise stat
	ld d, a
	ld b, TEN_PERCENT
.test
	call Random
	cp b							; test if effect happens
	ret nc
.doStatBoost
	push hl
	ld hl, wPlayerMonStatMods
	ld a, [H_WHOSETURN]
	and a
	jr z, .next2
	ld hl, wEnemyMonStatMods
.next2
	ld a, d
	sub ATTACK_UP_SIDE_EFFECT		; convert effect ID into stat index
	ld c, a
	ld b, $0
	add hl, bc
	ld a, [hl]
	cp STAT_MODIFIER_PLUS_6
	pop hl							; hl now points to move effect
	ret nc							; if stat modifier already maxed out, return
	push hl
	ld a, [hl]
	ld e, a
	push de											; store initial move effect for later
	ld a, d
	sub ATTACK_UP_SIDE_EFFECT - ATTACK_UP1_EFFECT	; makes new effect ID point to stat raising effects
	ld [hl], a										; overwrite move effect before calling StatModifierUpEffect
	ld a, [wOptions]
	push af
	or (1 << BATTLE_ANIMATIONS)						; set bit BATTLE_ANIMATIONS of the Options (turn battle animations off)
	ld [wOptions], a
	callab StatModifierUpEffect
	pop af
	ld [wOptions], a				; restore the options
	pop de
	pop hl
	ld a, e							; initial move effect
	ld [hl], a						; restore initial move effect
	ret

RecoilDebuffHandler:
	ld hl, wEnemyMoveNum
	ld a, [H_WHOSETURN]
	and a
	jr z, .next
	ld hl, wPlayerMoveNum
.next
	push af
	xor $1						; reverse turn to apply stat drop to attacker
	ld [H_WHOSETURN], a
	ld a, [hl]
	ld [hl], 1					; set move id to non-null value so that screen wavering effect
								; plays even during 1st turn of battle (see Func_3fb89)
								; since turn is reversed, Func_3fb89 checks if the move id of the defender
								; is not null before doing the animation, so if it's the first turn of the
								; battle and the attacker is going first, the animation won't be played
								; because the move id of the defender will still be zero
	push hl
	push af
	call DoStatLowering
	pop af
	pop hl
	ld [hl], a					; restore move id
	pop af						; restore turn
	ld [H_WHOSETURN], a
	ret

RecoilDualDebuffHandler:
	ld hl, wEnemyMoveNum
	ld bc, wPlayerMoveEffect
	ld a, [H_WHOSETURN]
	and a
	jr z, .next
	ld hl, wPlayerMoveNum
	ld bc, wEnemyMoveEffect
.next
	ld a, [bc]
	push af
	push bc
	ld a, d																; move effect
	sub ATTACK_DEFENSE_DOWN_RECOIL_EFFECT - DEFENSE_DOWN_SIDE_EFFECT2	; make Atk/Def drop coincide with DEFENSE_DOWN_SIDE_EFFECT2
	ld e, ATTACK_DOWN_SIDE_EFFECT2
	ld c, NUM_STAT_MODS - 2
.loop								; this loop seeks the first stat to be decreased
	cp EVASION_DOWN_SIDE_EFFECT2 + 1
	jr c, .firstDropFound			; while a is decremented until it's <= EVASION_DOWN_SIDE_EFFECT2
	inc e							; in this loop, e contains effect ID for first drop
	sub c							; at the end of the loop, a will contain effect ID for 2nd drop
	dec c
	jr .loop
.firstDropFound
	ld d, e							; store value for first drop in d
	ld e, a							; store value for second drop in e
	ld a, d							; put effect ID for 1st drop in a
	sub ATTACK_DOWN_SIDE_EFFECT2	; make a coincide with stat index for 1st drop
	push hl
	call checkAttackerStatMultiplierMin
	pop hl
	jr z, .testSecondDrop			; if first stat is min, skip the first drop
	ld a, [H_WHOSETURN]
	xor $1							; reverse turn
	ld [H_WHOSETURN], a
	ld a, [hl]
	ld [hl], $1					; set move id to non-null value so that screen wavering effect
								; plays even during 1st turn of battle (see Func_3fb89)
								; since turn is reversed, Func_3fb89 checks if the move id of the defender
								; is not null before doing the animation, so if it's the first turn of the
								; battle and the attacker is going first, the animation won't be played
								; because the move id of the defender will still be zero
	push hl
	push af
	push de
	call LowerStatNoAnim
	pop de
	pop af
	pop hl
	ld [hl], a							; restore move id
	ld a, [H_WHOSETURN]
	xor $1								; reverse turn
	ld [H_WHOSETURN], a
	ld a, e								; a = effect id for 2nd drop
	add ATTACK_DOWN_SIDE_EFFECT - ATTACK_DOWN1_EFFECT
	ld d, a
	ld a, e
	jr .doSecondDrop					; a = effect id for 2nd drop; d = effect id for 2nd drop + ATTACK_DOWN_SIDE_EFFECT - ATTACK_DOWN1_EFFECT
.testSecondDrop
	ld d, e								; put effect ID for second drop in d
	ld a, d								; put effect ID for second drop in a
.doSecondDrop
	sub ATTACK_DOWN_SIDE_EFFECT2		; make a coincide with stat index for second drop
	call checkAttackerStatMultiplierMin
	jr z, .finish						; if second stat is min, skip the second drop
	ld a, [H_WHOSETURN]
	xor $1								; reverse turn
	ld [H_WHOSETURN], a
	call LowerStatNoAnim
	ld a, [H_WHOSETURN]
	xor $1								; reverse turn
	ld [H_WHOSETURN], a
.finish
	pop bc
	pop af
	ld [bc], a							; restore move effect
	ret

RecoilSingleDebuffHandler:
	ld hl, wEnemyMoveNum
	ld bc, wPlayerMoveEffect
	ld a, [H_WHOSETURN]
	and a
	jr z, .next
	ld hl, wPlayerMoveNum
	ld bc, wEnemyMoveEffect
.next
	ld a, [bc]
	push af
	push bc
	sub ATTACK_DOWN_RECOIL_EFFECT - ATTACK_DOWN_SIDE_EFFECT2
	ld d, a								; make move id coincide with stat down side effects for LowerStat
	sub ATTACK_DOWN_SIDE_EFFECT2		; make a coincide with stat index
	call checkAttackerStatMultiplierMin
	jr z, .finish						; if stat is already at min, nothing to do
	ld a, [H_WHOSETURN]
	xor $1								; reverse turn
	ld [H_WHOSETURN], a
	call LowerStatNoAnim
	ld a, [H_WHOSETURN]
	xor $1								; reverse turn
	ld [H_WHOSETURN], a
.finish
	pop bc
	pop af
	ld [bc], a							; restore move effect
	ret

SuperBoostHandler:
	ld b, TEN_PERCENT
	call Random
	cp b
	ret nc
BoostAllStats:
	ld hl, wPlayerMoveEffect
	ld a, [H_WHOSETURN]
	and a
	jr z, .main
	ld hl, wEnemyMoveEffect
.main
	ld a, [wOptions]					; save the options
	push af
	or (1 << BATTLE_ANIMATIONS)			; set bit BATTLE_ANIMATIONS of the Options (turn battle animations off)
	ld [wOptions], a
	ld d, ATTACK_UP1_EFFECT
.loop
	ld [hl], d
	push hl
	push de
	ld a, d								; input for checkStatMultiplierMax
	call checkAttackerStatMultiplierMax
	jr nc, .nextStat					; if current stat is maxed, skip it
	callab StatModifierUpEffect
.nextStat
	pop de
	pop hl
	inc d
	ld a, d
	cp ACCURACY_UP1_EFFECT				; compare d to effect ID that boosts Accuracy
	jr c, .loop							; if d < ACCURACY_UP1_EFFECT, that means we're not done looping
										; else that means we went over every stat (except Accuracy and Evasion)
.end
	pop af
	ld [wOptions], a					; restore the options
	ld [hl], ALL_STATS_UP_EFFECT		; restore the move effect ID
	ret

QuiverDanceEffect:
	ld hl, wPlayerMoveEffect
	ld a, [H_WHOSETURN]
	and a
	jr z, .next
	ld hl, wEnemyMoveEffect
.next
	ld a, [wOptions]
	push af
	ld a, SPEED_UP1_EFFECT
	ld e, a									; save move effect for 3rd boost in e
	ld a, SPECIAL_DEFENSE_UP1_EFFECT
	ld d, a									; save move effect for 2nd boost in d
	ld a, SPECIAL_ATTACK_UP1_EFFECT
	ld [hl], a								; put value for 1st boost in move effect
	push hl
	push de
	call checkAttackerStatMultiplierMax
	jr c, .doFirstBoost						; if first stat is not maxed, boost it
	ld a, SPECIAL_DEFENSE_UP1_EFFECT		; else check if second stat is also maxed
	call checkAttackerStatMultiplierMax
	jr c, .doSecondBoost					; if second stat is not maxed, boost it
	ld a, SPEED_UP1_EFFECT					; else check if third stat is also maxed
	call checkAttackerStatMultiplierMax
	jr c, .doThirdBoost						; if all stats are maxed, call the stat raising function to display "Nothing happened!"
											; else just skip the first calls to stat raising function
.doFirstBoost
	callab StatModifierUpEffect
	ld a, [wOptions]
	or (1 << BATTLE_ANIMATIONS)				; set bit BATTLE_ANIMATIONS of the Options (turn battle animations off)
	ld [wOptions], a
.doSecondBoost
	pop de
	pop hl
	ld a, d									; put second boost value in a
	ld [hl], a								; hl points to move effect
	push hl
	push de
	call checkAttackerStatMultiplierMax
	jr nc, .doThirdBoost
	callab StatModifierUpEffect
	ld a, [wOptions]
	or (1 << BATTLE_ANIMATIONS)				; turn battle animations off in case the first stat was already maxed
	ld [wOptions], a
.doThirdBoost
	pop de
	pop hl
	ld a, e									; put second boost value in a
	ld [hl], a								; hl points to move effect
	push hl
	call checkAttackerStatMultiplierMax
	jr nc, .end								; if third stat is maxed, skip the boost
	callab StatModifierUpEffect
.end
	pop hl
	ld a, QUIVER_DANCE_EFFECT
	ld [hl], a				; restore original move effect
	pop af
	ld [wOptions], a		; restore the options
	ret

_StatModifierDownEffect:
	jpab StatModifierDownEffect
	
_FlinchSideEffect:
	jpab FlinchSideEffect
	
_DrainHPEffect:
	jpab DrainHPEffect_

_FreezeBurnParalyzeEffect:
	jpab FreezeBurnParalyzeEffect_

FlinchBurnParalyzeFreezeEffect:
	ld hl, wPlayerMoveEffect
	ld a, [H_WHOSETURN]
	and a
	jr z, .main
	ld hl, wEnemyMoveEffect
.main
	ld a, [hl]
	push af								; save the move effect in the stack
	push hl
	cp FLINCH_BURN_SIDE_EFFECT
	ld b, BURN_SIDE_EFFECT1
	jr z, .gotEffect
	cp FLINCH_PARALYZE_SIDE_EFFECT
	ld b, PARALYZE_SIDE_EFFECT1
	jr z, .gotEffect
	ld b, FREEZE_SIDE_EFFECT
.gotEffect
	ld a, b
	ld [hl], a
	callab FreezeBurnParalyzeEffect
	pop hl
	push hl
	ld a, FLINCH_SIDE_EFFECT1
	ld [hl], a
	call _FlinchSideEffect
	pop hl
	pop af
	ld [hl], a							; restore the move effect
	ret

; this one has to be in the same bank as FreezBurnParalyzeEffect
_BurnEffect:
	jpab BurnEffect

_RecoilEffect:
	jpab RecoilEffect

FlareBlitzEffect:
	ld hl, wPlayerMoveEffect
	ld a, [H_WHOSETURN]
	and a
	jr z, .main
	ld hl, wEnemyMoveEffect
.main
	push hl
	ld a, RECOIL_EFFECT2
	ld [hl], a
	call _RecoilEffect
	pop hl
	ld a, BURN_SIDE_EFFECT1			; since recoil effect is executed before burn side effect, just change the move effect and let the routine proceed
	ld [hl], a
	ret

PrintWallShatteredText:
	ld c, 30
	call DelayFrames
	ld hl, WallShatteredText
	jp PrintText

WallShatteredText:
	TX_FAR _WallShatteredText
	db "@"

BadPoisonSideEffect:
	jpab PoisonEffect

_PoisonEffect:
	jpab PoisonEffect

_ConfusionEffect:
	jpab ConfusionEffect

_EjectSideEffectHandler:
	jpab EjectSideEffectHandler

TrappingEffect:
	call CheckTargetSubstitute_Bis	; call the local function
	jr nz, .fail					; can't trap a target that is behind a substitute
	ld hl, wEnemyBattleStatus3
	ld bc, wEnemyMonType
	ld de, wEnemyBattleStatus1
	ld a, [H_WHOSETURN]
	and a
	jr z, .trappingEffect
	ld hl, wPlayerBattleStatus3
	ld bc, wBattleMonType
	ld de, wPlayerBattleStatus1
.trappingEffect
	ld a, [bc]						; check first type
	cp GHOST
	jr z, .fail						; can't trap GHOST types
	inc bc							; check second type
	ld a, [bc]
	cp GHOST
	jr z, .fail						; can't trap GHOST types
	ld a, [de]
	bit INVULNERABLE, a
	jr nz, .fail					; can't trap a target that is in a semi-invulnerable turn
	bit TRAPPED, [hl]
	jr nz, .fail					; make the move fail if target is already under the effect
	set TRAPPED, [hl]
	callab PlayCurrentMoveAnimation2
	ld hl, CantEscapeNowText
	jr .printText
.fail
	ld c, 50
	call DelayFrames
	ld hl, TrappingEffectFailureText
.printText
	jp PrintText

TrappingEffectFailureText:
	TX_FAR _DoesntAffectMonText
	db "@"

CantEscapeNowText:
	TX_FAR _CantEscapeNowText
	db "@"

TrickRoomEffect:
	callab PlayCurrentMoveAnimation
	ld a, [wTrickRoomCounter]
	and a
	jr nz, .alreadyActive
	ld hl, TwistedDimensionsText
	ld a, 5
	jr .finish
.alreadyActive
	ld hl, TwistedDimenssionsReturnedToNormalText
	xor a
.finish
	ld [wTrickRoomCounter], a
	call PrintText
	ret

TwistedDimensionsText:
	TX_FAR _TwistedDimensionsText
	db "@"

TwistedDimenssionsReturnedToNormalText:
	TX_FAR _TrickRoomOver
	db "@"
