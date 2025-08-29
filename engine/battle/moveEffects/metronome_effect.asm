_MetronomePickMove:
; values for player turn
	ld de, wPlayerMoveNum
	ld hl, wPlayerSelectedMove
	ld a, [H_WHOSETURN]
	and a
	jr z, .pickMoveLoop
; values for enemy turn
	ld de, wEnemyMoveNum
	ld hl, wEnemySelectedMove
.pickMoveLoop
	call BattleRandom
	ld b, a
	call BattleRandom		; to allow Metronome to call signature moves, we need to roll a 2nd random number
	add b					; add both random numbers together to get a value between 0 and 510
	jr c, .signatureMove	; numbers rolled > 255 will yield a signature move
	and a
	jr z, .pickMoveLoop		; if number rolled is zero, reroll
	cp NUM_ATTACKS + 1		; max move ID + 1 (now there are 254 moves, only value 255 ($FF) will not set carry, which is an invalid move id)
	jr nc, .pickMoveLoop	; if number rolled is >= to last move id + 1, reroll
	cp METRONOME
	jr z, .pickMoveLoop		; if move rolled is metronome itself, reroll
	cp COUNTER
	jr z, .pickMoveLoop		; if move rolled is Counter, reroll
	cp MIMIC
	jr z, .pickMoveLoop		; if move rolled is Mimic, reroll
	cp MIRROR_MOVE
	jr z, .pickMoveLoop		; if move rolled is Mirror Move, reroll
	cp SNARL
	jr z, .pickMoveLoop		; if move rolled is Snarl, reroll
	cp MIRROR_COAT
	jr z, .pickMoveLoop		; if move rolled is Mirror Coat, reroll
	cp STRUGGLE
	jr z, .pickMoveLoop		; if move rolled is Struggle, reroll
	cp SIGNATURE_MOVE_1
	jr z, .pickMoveLoop		; if move rolled is the placeholder move id for the first signature move, reroll
	cp SIGNATURE_MOVE_2
	jr z, .pickMoveLoop		; if move rolled is the placeholder move id for the second signature move, reroll
	jr .end
.signatureMove
	inc a							; if we get here it means we rolled between 256 and 510
									; since 256 becomes 0 which is an invalid move id, increment the value by 1
									; to get a range of [257-511] which becomes [1-254]
	cp NUM_SIGNATURE_MOVES + 1		; max signature move ID + 1
	jr nc, .pickMoveLoop			; if number rolled is >= to last signature move id + 1, reroll
	cp TRANSFORM
	jr z, .pickMoveLoop				; if move rolled is Transform, reroll
	cp FALSE_SURRENDER
	jr z, .pickMoveLoop				; if move rolled is False Surrender, reroll
	cp RAGING_BULL
	jr z, .pickMoveLoop				; if move rolled is Raging Bull, reroll
	cp SPIRIT_BREAK
	jr z, .pickMoveLoop				; if move rolled is Spirit Break, reroll
	cp TWIN_BEAM
	jr z, .pickMoveLoop				; if move rolled is Twin Beam, reroll
	push hl
	ld b, a
	ld hl, wNewBattleFlags
	set USING_SIGNATURE_MOVE, [hl]	; this will allow the signature move id to not be mapped a second time
	ld a, [H_WHOSETURN]
	and a
	jr z, .player
	set ENEMY_SIGNATURE_MOVE, [hl]
	jr .afterSetFlag
.player
	set PLAYER_SIGNATURE_MOVE, [hl]
.afterSetFlag
	pop hl
	ld a, b
.end
	ld [hl], a
	ld [wd11e], a					; since this function is called through a bankswitch, we can't pass a as output, so store it in wd11e
	ret
