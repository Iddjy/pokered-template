MistEffect_:
	ld hl, wPlayerMistCounter
	ld a, [H_WHOSETURN]
	and a
	jr z, .mistEffect
	ld hl, wEnemyMistCounter
.mistEffect
	ld a, [hl]
	and a
	jr nz, .mistAlreadyInUse			; if counter is not zero, then Mist is already in effect
	ld a, 5								; effect duration
	ld [hl], a
	callab PlayCurrentMoveAnimation
	ld hl, ShroudedInMistText
	jp PrintText
.mistAlreadyInUse
	jpab PrintButItFailedText_

ShroudedInMistText:
	TX_FAR _ShroudedInMistText
	db "@"
