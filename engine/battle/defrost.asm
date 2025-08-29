CheckDefrost_:
	ld a, [H_WHOSETURN]
	and a
	jr nz, .opponent
	ld a, [wEnemyMonStatus]
	and 1 << FRZ						; are they frozen?
	ret z								; return if not
	ld a, [wPlayerMoveEffect]
	cp AUTODEFROST_BURN_SIDE_EFFECT2	; this is so that Scald defrosts frozen targets
	jr z, .defrostEnemy
	ld a, [wPlayerMoveType]
	sub FIRE
	ret nz ; return if type of move used isn't fire
.defrostEnemy
	ld [wEnemyMonStatus], a ; set opponent status to 00 ["defrost" a frozen monster]
	ld hl, wEnemyMon1Status
	ld a, [wEnemyMonPartyPos]
	ld bc, wEnemyMon2 - wEnemyMon1
	call AddNTimes
	xor a
	ld [hl], a ; clear status in roster
	ld hl, HeatDefrostedText
	jr .common
.opponent
	ld a, [wBattleMonStatus]
	and 1 << FRZ						; are they frozen?
	ret z								; return if not
	ld a, [wEnemyMoveEffect]
	cp AUTODEFROST_BURN_SIDE_EFFECT2	; this is so that Scald defrosts frozen targets
	jr z, .defrostPlayer
	ld a, [wEnemyMoveType] ; same as above with addresses swapped
	sub FIRE
	ret nz
.defrostPlayer
	ld [wBattleMonStatus], a
	ld hl, wPartyMon1Status
	ld a, [wPlayerMonNumber]
	ld bc, wPartyMon2 - wPartyMon1
	call AddNTimes
	xor a
	ld [hl], a
	ld hl, HeatDefrostedText
.common
	jp PrintText

HeatDefrostedText:
	TX_FAR _HeatDefrostedText
	db "@"
