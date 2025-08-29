ParalyzeEffect_:
	ld hl, wEnemyMonStatus
	ld de, wPlayerMoveType
	ld a, [H_WHOSETURN]
	and a
	jp z, .next
	ld hl, wBattleMonStatus
	ld de, wEnemyMoveType
.next
	ld a, [hli]						; make hl point to defender's type 1
	and a							; does the target already have a status ailment?
	jr nz, .didntAffect
	push hl
	push de
	callab CheckTargetSubstitute 	; add this call to check for substitute
	pop de
	pop hl
	jr nz, .didntAffect				; if target is behind a substitute, the move fails
; check if the target is immune due to types
	ld a, [hli]						; make hl point to defender's type 2
	cp ELECTRIC
	jr z, .doesntAffect				; if defender is electric type, can't paralyze them
	ld a, [hld]						; make hl point to defender's type 1
	cp ELECTRIC
	jr z, .doesntAffect				; if defender is electric type, can't paralyze them
	ld a, [de]
	cp ELECTRIC						; is move type Electric ?
	jr nz, .checkGrassImmunities
	ld a, [hli]						; make hl point to defender's type 2
	cp GROUND						; for Electric moves, check if defender is Ground type
	jr z, .doesntAffect
	ld a, [hld]						; make hl point to defender's type 1
	cp GROUND
	jr z, .doesntAffect
	jr .hitTest
.checkGrassImmunities
	cp GRASS						; is move type Grass ?
	jr nz, .hitTest
	ld a, [hli]						; make hl point to defender's type 2
	cp GRASS						; for Grass moves, check if defender is Grass type
	jr z, .doesntAffect
	ld a, [hld]						; make hl point to defender's type 1
	cp GRASS
	jr z, .doesntAffect
.hitTest
	push hl
	callab MoveHitTest
	pop hl
	ld a, [wMoveMissed]
	and a
	jr nz, .didntAffect
	dec hl							; make hl point to defender's status
	set PAR, [hl]
	callab QuarterSpeedDueToParalysis
	ld c, 30
	call DelayFrames
	callab PlayCurrentMoveAnimation
	callab PrintMayNotAttackText
	jpab DrawHUDsAndHPBars				; update status of target on screen
.didntAffect
	ld c, 50
	call DelayFrames
	jpab PrintDidntAffectText
.doesntAffect
	ld c, 50
	call DelayFrames
	jpab PrintDoesntAffectText
