; moved out of bank F
_PrintGhostText:
; print the ghost battle messages
	callab IsGhostBattle
	ret nz
	ld a, [H_WHOSETURN]
	and a
	jr nz, .ghost
	ld a, [wBattleMonStatus] ; player’s turn
	and SLP | (1 << FRZ)
	ret nz
	ld hl, ScaredText
	call PrintText
	xor a
	ret
.ghost ; ghost’s turn
	call IsInteriorMap
	ld hl, GetOutText
	jr nz, .printText
	ld hl, GoAwayText
.printText
	call PrintText
	xor a
	ret

ScaredText:
	TX_FAR _ScaredText
	db "@"

GetOutText:
	TX_FAR _GetOutText
	db "@"

GoAwayText:
	TX_FAR _GoAwayText
	db "@"
