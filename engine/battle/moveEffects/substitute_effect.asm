SubstituteEffect_:
	ld c, 50
	call DelayFrames
	ld hl, wBattleMonMaxHP
	ld de, wPlayerSubstituteHP
	ld bc, wPlayerBattleStatus2
	ld a, [H_WHOSETURN]
	and a
	jr z, .notEnemy
	ld hl, wEnemyMonMaxHP
	ld de, wEnemySubstituteHP
	ld bc, wEnemyBattleStatus2
.notEnemy
	ld a, [bc]
	bit HAS_SUBSTITUTE_UP, a			; user already has substitute?
	jr nz, .alreadyHasSubstitute
; quarter health to remove from user
; assumes max HP is 1023 or lower
	push bc
	ld a, [hli]
	ld b, [hl]
	srl a
	rr b
	srl a
	rr b								; max hp / 4
	push de
	ld de, wBattleMonHP - wBattleMonMaxHP
	add hl, de							; point hl to current HP low byte
	pop de
	ld a, b
	ld [de], a							; save copy of HP to subtract in ccd7/ccd8 [how much HP substitute has]
	ld a, [hld]
; subtract [max hp / 4] to current HP
	sub b
	ld d, a
	ld a, [hl]
	sbc 0
	pop bc
	jr c, .notEnoughHP		; underflow means user would be left with negative health
	jr nz, .userHasEnoughHP	; test whether high byte of new HP is null, if not, user has enough HP
							; else (ie. a is zero)
	ld a, d					; 	put low byte of new HP in a
	and a					; 	test if low byte of new HP is zero
	jr z, .notEnoughHP		; 	if low byte of new HP is zero, user doesn't have enough HP
							; 	else
	ld a, $00				; 		since we're in this block, it means a was zero before being overwritten by d
							; 		so this is done in order to return a to its previous value
.userHasEnoughHP
	ldi [hl], a ; save resulting HP after subtraction into current HP
	ld [hl], d
	ld h, b
	ld l, c
	set HAS_SUBSTITUTE_UP, [hl]
	set SUBSTITUTE_SHOWN, [hl]		; set this new flag to indicate the substitute is shown on screen
	ld a, [wOptions]
	bit BATTLE_ANIMATIONS, a
	ld hl, PlayCurrentMoveAnimation
	ld b, BANK(PlayCurrentMoveAnimation)
	jr z, .animationEnabled
	ld hl, AnimationSubstitute
	ld b, BANK(AnimationSubstitute)
.animationEnabled
	call Bankswitch			; jump to routine depending on animation setting
	ld hl, SubstituteText
	call PrintText
	call FreeUserFromBindingMoves
	jpab DrawHUDsAndHPBars
.alreadyHasSubstitute
	ld hl, HasSubstituteText
	jr .printText
.notEnoughHP
	ld hl, TooWeakSubstituteText
.printText
	jp PrintText

SubstituteText:
	TX_FAR _SubstituteText
	db "@"

HasSubstituteText:
	TX_FAR _HasSubstituteText
	db "@"

TooWeakSubstituteText:
	TX_FAR _TooWeakSubstituteText
	db "@"

; function to cancel binding moves on a mon using Substitute
FreeUserFromBindingMoves:
	ld hl, wEnemyTrappingCounter
	ld a, [H_WHOSETURN]
	and a
	jr z, .main
	ld hl, wPlayerTrappingCounter
.main
	ld a, 1
	ld [hl], a
	jpab HandleTrappingMoves
	
	
; moved from core.asm
AttackSubstitute_:
; Unlike the two ApplyAttackToPokemon functions, Attack Substitute is shared by player and enemy.
; Self-confusion damage as well as Hi-Jump Kick and Jump Kick recoil cause a momentary turn swap before being applied.
; If the user has a Substitute up and would take damage because of that,
; damage will be applied to the other player's Substitute.
; Normal recoil such as from Double-Edge isn't affected by this glitch,
; because this function is never called in that case.
	ld hl, wNewBattleFlags				; set a flag indicating that a substitute took damage this turn
	set SUBSTITUTE_TOOK_DAMAGE, [hl]	; set a flag indicating that a substitute took damage this turn
	ld hl, SubstituteTookDamageText
	call PrintText
; values for player turn
	ld de, wEnemySubstituteHP
	ld bc, wEnemyBattleStatus2
	ld a, [H_WHOSETURN]
	and a
	jr z, .applyDamageToSubstitute
; values for enemy turn
	ld de, wPlayerSubstituteHP
	ld bc, wPlayerBattleStatus2
.applyDamageToSubstitute
	ld hl, wDamage
	ld a, [hli]
	and a
	jr nz, .substituteBroke		; damage > 0xFF always breaks substitutes
; subtract damage from HP of substitute
	ld a, [de]
	sub [hl]
	ld [de], a
	jr z, .substituteBroke		; fix the bug that let substitutes live with 0 HP
	jr c, .substituteBroke
	ld a, [H_WHOSETURN]
	jr .checkMoveEffect
.substituteBroke
; If the target's Substitute breaks, wDamage isn't updated with the amount of HP
; the Substitute had before being attacked.
	ld h, b
	ld l, c
	res HAS_SUBSTITUTE_UP, [hl] ; unset the substitute bit
	ld hl, SubstituteBrokeText
	call PrintText
; flip whose turn it is for the next function call
	ld a, [H_WHOSETURN]
	xor $01
	ld [H_WHOSETURN], a
	callab HideSubstituteShowMonAnim ; animate the substitute breaking
; flip the turn back to the way it was
	ld a, [H_WHOSETURN]
	xor $01
	ld [H_WHOSETURN], a
.checkMoveEffect
	ld hl, wPlayerMoveEffect ; value for player's turn
	and a
	jr z, .nullifyEffect
	ld hl, wEnemyMoveEffect ; value for enemy's turn
.nullifyEffect
	ld a, [hl]						; get value of the move effect
	push hl
	ld hl, BlockedEffects
	ld de, 1
	call IsInArray
	pop hl
	ret nc							; if the move effect isn't in the array, don't cancel it
.doNullifyEffect
	xor a
	ld [hl], a						; zero the effect of the attacker's move
	ret

; array of move effects that must be cancelled when hitting a substitute
BlockedEffects:
	db POISON_SIDE_EFFECT1
	db BURN_SIDE_EFFECT1
	db FREEZE_SIDE_EFFECT
	db PARALYZE_SIDE_EFFECT1
	db EJECT_EFFECT
	db FLINCH_SIDE_EFFECT1
	db POISON_SIDE_EFFECT2
	db BURN_SIDE_EFFECT2
	db PARALYZE_SIDE_EFFECT2
	db FLINCH_SIDE_EFFECT2
	db TRAPPING_EFFECT
	db ATTACK_DOWN_SIDE_EFFECT
	db DEFENSE_DOWN_SIDE_EFFECT
	db SPEED_DOWN_SIDE_EFFECT
	db SPECIAL_ATTACK_DOWN_SIDE_EFFECT
	db SPECIAL_DEFENSE_DOWN_SIDE_EFFECT
	db CONFUSION_SIDE_EFFECT
	db TRI_ATTACK_EFFECT

; moved from core.asm
SubstituteTookDamageText:
	TX_FAR _SubstituteTookDamageText
	db "@"

; moved from core.asm
SubstituteBrokeText:
	TX_FAR _SubstituteBrokeText
	db "@"
