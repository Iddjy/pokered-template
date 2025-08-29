; multiplies damage by a random percentage from ~85% to 100%
; moved out of bank F
_RandomizeDamage:
	ld hl, wDamage
	ld a, [hli]
	and a
	jr nz, .DamageGreaterThanOne
	ld a, [hl]
	cp 2
	ret c ; return if damage is equal to 0 or 1
.DamageGreaterThanOne
	xor a
	ld [H_MULTIPLICAND], a
	dec hl
	ld a, [hli]
	ld [H_MULTIPLICAND + 1], a
	ld a, [hl]
	ld [H_MULTIPLICAND + 2], a
; loop until a random number greater than or equal to 217 is generated
.loop
	call BattleRandom
	rrca
	cp 217
	jr c, .loop
	ld [H_MULTIPLIER], a
	call Multiply ; multiply damage by the random number, which is in the range [217, 255]
	ld a, 255
	ld [H_DIVISOR], a
	ld b, $4
	call Divide ; divide the result by 255
; store the modified damage
	ld a, [H_QUOTIENT + 2]
	ld hl, wDamage
	ld [hli], a
	ld a, [H_QUOTIENT + 3]
	ld [hl], a
	ret