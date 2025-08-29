; This function is used for moves that allow the user to switch out afterwards (U-Turn, Volt Switch)
ChooseNewPokemon:
	ld bc, wPartyMon2 - wPartyMon1 - 1	; minus one because we inc hl once in the loop
	ld a, [H_WHOSETURN]
	and a
	ld a, [wPlayerMonNumber]
	ld d, a
	ld a, [wPartyCount]
	ld e, a
	ld hl, wPartyMon1HP
	jr z, .next
	ld a, [wEnemyMonPartyPos]
	ld d, a
	ld a, [wEnemyPartyCount]
	ld e, a
	ld hl, wEnemyMon1HP
.next
	push de								; save party count in e
	ld e, 0
.partyMonsLoop
	ld a, e								; put current index in a temporarily
	pop de								; restore party count in e
	cp e								; compare current index to party count
	ret	z								; if we reached the end of the party and no pokemon is available, do nothing
	push de								; save party count in e
	ld e, a								; restore current index to e
	cp d								; compare current index to index of battling mon
	jr nz, .notAlreadyOut				; if current mon is already out, skip it
	inc hl								; we have to inc hl here to be consistent with the other branch
.nextMon
	add hl, bc
	inc e
	jr .partyMonsLoop
.notAlreadyOut
	xor a
	or [hl]
	inc hl
	or [hl]
	jr z, .nextMon						; if current mon is fainted, skip it
	ld a, e
	ld [wWhichPokemon], a				; sets the index of the chosen pokemon (only useful for the AI)
	pop de
	ld hl, wNewBattleFlags
	set FORCED_SWITCH_OCCURRED, [hl]	; sets the flag indicating that a forced switch occurred during this turn
	ret