BurnEffect:
	callab CheckTargetSubstitute
	jr nz, .didntAffect
	ld hl, wEnemyMonStatus
	ld a, [H_WHOSETURN]
	and a
	jr z, .main
	ld hl, wBattleMonStatus
.main
	ld a, [hl]					; load target's status
	and a
	jr nz, .didntAffect
	inc hl						; make hl point to the target's type 1
	ld a, [hli]					; load type 1 of the target and make hl point to type 2
	cp FIRE						; compare it with immune type
	jr z, .doesntAffect  		; return if they match [can't burn a fire type or freeze an ice type]
	ld a, [hld]					; load type 2 of the target and make hl point back to type 1
	cp FIRE						; compare it with immune type
	jr z, .doesntAffect			; return if they match (can't burn a fire type)
	dec hl						; make hl point back to target's status
	push hl
	callab MoveHitTest
	pop hl
	ld a, [wMoveMissed]
	and a
	jr nz, .didntAffect
	ld a, 1 << BRN
	ld [hl], a
	ld c, 30
	call DelayFrames
	callab PlayCurrentMoveAnimation
	call HalveAttackDueToBurn_
	call ScreenShake
	ld hl, BurnedText
	call PrintText
	jpab DrawHUDsAndHPBars
.didntAffect
	ld c, 50
	call DelayFrames
	jpab PrintDidntAffectText
.doesntAffect
	ld c, 50
	call DelayFrames
	jpab PrintDoesntAffectText
