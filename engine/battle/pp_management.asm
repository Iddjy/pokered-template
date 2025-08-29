; change this function so that enemy PP can be decremented too
DecrementPP:
	ld a, [de]
	cp STRUGGLE
	ret z							; don't decrement PP for "struggle"
	ld a, [H_WHOSETURN]
	and a
	ld hl, wPlayerBattleStatus1
	ld bc, wBattleMonPP				; PP of first move (in battle)
	ld de, wPlayerMoveListIndex
	jr z, .player
	ld hl, wEnemyBattleStatus1
	ld bc, wEnemyMonPP				; PP of first move (in battle)
	ld de, wEnemyMoveListIndex
	jr .common
.player
	ld a, [wMonIsDisobedient]		; check if the player mon disobeyed and used a different attack than what the player selected
	and a							; wMonIsDisobedient = 0 means mon obeys
	jr z, .common					; if the mon obeyed, do the usual routine
	push af							; save the slot number used by the disobedient mon
	dec a							; decrement it by one since we had to increment it to differentiate the first move slot (index 0) from obedient mon
	ld [wMonIsDisobedient], a		; update wMonIsDisobedient with slot number the mon actually used
	ld de, wMonIsDisobedient
	call .common					; decrement PP for this move slot
	pop af
	ld [wMonIsDisobedient], a		; restore wMonIsDisobedient for the rest of the move execution routine (notably the 'used instead' message)
	ret
.common
	ld a, [hl]
	and (1 << STORING_ENERGY) | (1 << THRASHING_ABOUT) | (1 << ATTACKING_MULTIPLE_TIMES)
	ret nz							; if any of these statuses are true, don't decrement PP
	ld h, b
	ld l, c
	call .DecrementPP				; decrement PP in the battle struct
	ld a, [H_WHOSETURN]
	and a
	ld hl, wPlayerBattleStatus3
	ld bc, wPartyMon1PP				; PP of first move (in party)
	ld a, [wPlayerMonNumber]		; which mon in party is active
	jr z, .playerParty
	ld a, [wIsInBattle]				; check if it's a wild battle
	dec a
	ret z							; don't decrement party PP if it's a wild battle
	ld hl, wEnemyBattleStatus3
	ld bc, wEnemyMon1PP				; PP of first move (in party)
	ld a, [wEnemyMonPartyPos]		; which mon in party is active
.playerParty
	bit TRANSFORMED, [hl]
	ret nz							; Don't decrement party PP when transformed
	ld h, b
	ld l, c
	ld bc, wPartyMon2 - wPartyMon1
	call AddNTimes       			; calculate address of the mon to modify
.DecrementPP:
	ld a, [de]						; which move (0, 1, 2, 3) did we use?
	ld c, a
	ld b, 0
	add hl, bc						; calculate the address in memory of the PP we need to decrement based on the move chosen.
	dec [hl]						; Decrement PP
	ret

; this function increments the current move's PP
; it's used to prevent moves that run another move within the same turn
; (like Mirror Move and Metronome) from losing 2 PP
; moved out of bank F
IncrementMovePP:
	ld a, [H_WHOSETURN]
	and a
; values for player turn
	ld hl, wBattleMonPP
	ld de, wPartyMon1PP
	ld a, [wPlayerMoveListIndex]
	jr z, .next
; values for enemy turn
	ld hl, wEnemyMonPP
	ld de, wEnemyMon1PP
	ld a, [wEnemyMoveListIndex]
.next
	ld b, $00
	ld c, a
	add hl, bc
	inc [hl] ; increment PP in the currently battling pokemon memory location
	ld h, d
	ld l, e
	add hl, bc
	ld a, [H_WHOSETURN]
	and a
	ld a, [wPlayerMonNumber] ; value for player turn
	jr z, .updatePP
	ld a, [wEnemyMonPartyPos] ; value for enemy turn
.updatePP
	ld bc, wEnemyMon2 - wEnemyMon1
	call AddNTimes
	inc [hl] ; increment PP in the party memory location
	ret
