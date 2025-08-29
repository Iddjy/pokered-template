HealEffect_:
	ld a, [H_WHOSETURN]
	and a
	ld de, wBattleMonHP + 1		; correction of healing moves failing when HP is (n*256)-1
	ld hl, wBattleMonMaxHP + 1	; correction of healing moves failing when HP is (n*256)-1
	ld a, [wPlayerMoveEffect]
	jr z, .healEffect
	ld de, wEnemyMonHP + 1		; correction of healing moves failing when HP is (n*256)-1
	ld hl, wEnemyMonMaxHP + 1	; correction of healing moves failing when HP is (n*256)-1
	ld a, [wEnemyMoveEffect]
.healEffect
	ld b, a
	ld a, [de]
	cp [hl]
	dec de						; correction of healing moves failing when HP is (n*256)-1
	dec hl						; correction of healing moves failing when HP is (n*256)-1
	ld a, [de]
	sbc [hl]
	jp z, .failed ; no effect if user's HP is already at its maximum
	ld a, b
	cp REST_EFFECT				; check move effect instead of move ID
	jr nz, .healHP
	push hl
	push de
	push af
	ld c, 50
	call DelayFrames
	ld hl, wBattleMonStatus
	ld a, [H_WHOSETURN]
	and a
	jr z, .restEffect
	ld hl, wEnemyMonStatus
.restEffect
	ld a, [hl]
	and a
	ld [hl], 3						; increase number of sleep turns by 1 (clear status and set number of turns asleep to 3)
	ld hl, StartedSleepingEffect	; if mon didn't have a status
	jr z, .printRestText
	call UpdateStats					; correction of healing moves failing when HP is (n*256)-1
	ld hl, FellAsleepBecameHealthyText	; if mon had an status
.printRestText
	call PrintText
	pop af
	pop de
	pop hl
.healHP
	ld a, [hli]					; correction of healing moves failing when HP is (n*256)-1
	ld [wHPBarMaxHP + 1], a		; correction of healing moves failing when HP is (n*256)-1
	ld b, a						; correction of healing moves failing when HP is (n*256)-1
	ld a, [hl]
	ld [wHPBarMaxHP], a			; correction of healing moves failing when HP is (n*256)-1
	ld c, a						; correction of healing moves failing when HP is (n*256)-1
	jr z, .gotHPAmountToHeal
; Recover and Softboiled only heal for half the mon's max HP
	srl b
	rr c
.gotHPAmountToHeal
; update HP
	inc de						; correction of healing moves failing when HP is (n*256)-1
	ld a, [de]
	ld [wHPBarOldHP], a
	add c
	ld [de], a
	ld [wHPBarNewHP], a
	dec de
	ld a, [de]
	ld [wHPBarOldHP+1], a
	adc b
	ld [de], a
	ld [wHPBarNewHP+1], a
	inc de
	ld a, [de]
	dec de
	sub [hl]
	dec hl
	ld a, [de]
	sbc [hl]
	jr c, .playAnim
; copy max HP to current HP if an overflow occurred
	ld a, [hli]
	ld [de], a
	ld [wHPBarNewHP+1], a
	inc de
	ld a, [hl]
	ld [de], a
	ld [wHPBarNewHP], a
.playAnim
	ld hl, PlayCurrentMoveAnimation
	call BankswitchEtoF
	ld a, [H_WHOSETURN]
	and a
	coord hl, 10, 9
	ld a, $1
	jr z, .updateHPBar
	coord hl, 2, 2
	xor a
.updateHPBar
	ld [wHPBarType], a
	predef UpdateHPBar2
	ld hl, DrawHUDsAndHPBars
	call BankswitchEtoF
	ld hl, RegainedHealthText
	jp PrintText
.failed
	ld c, 50
	call DelayFrames
	ld hl, PrintButItFailedText_
	jp BankswitchEtoF

StartedSleepingEffect:
	TX_FAR _StartedSleepingEffect
	db "@"

FellAsleepBecameHealthyText:
	TX_FAR _FellAsleepBecameHealthyText
	db "@"

RegainedHealthText:
	TX_FAR _RegainedHealthText
	db "@"

; Function to update stats when healing Paralysis or Burn:
UpdateStats:
	ld hl, wPlayerMonUnmodifiedAttack
	ld de, wBattleMonAttack
	ld a, [H_WHOSETURN]
	ld [wCalculateWhoseStats], a
	and a
	push af								; store condition flags in the stack
	jr z, .main
	ld hl, wEnemyMonUnmodifiedAttack
	ld de, wEnemyMonAttack
.main
	ld bc, (NUM_STATS - 1) * 2			; HP isn't affected and each stat is 2 bytes
	call CopyData						; copies start-of-battle stats values into current stats values
	ld hl, CalculateModifiedStats
	ld b, BANK(CalculateModifiedStats)
	call Bankswitch
	pop af								; restore condition flags
	jr nz, .end							; if it's the enemy's turn, don't apply badge boosts
	callab ApplyBadgeStatBoosts
.end
	ret