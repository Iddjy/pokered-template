; This function must be added in order to update Bide damage counter when damage are inflicted to a Biding pokemon:
UpdateBideDamage_:
	ld hl, wDamage								; last damage inflicted
	ld a,[hli]
	ld b,a
	ld c,[hl]
	ld hl, wPlayerBideAccumulatedDamage + 1		; damage counter for Bide damage for the player
	ld de, wPlayerBattleStatus1
	ld a,[H_WHOSETURN]
	and a
	jr nz, .main
	ld hl, wEnemyBideAccumulatedDamage + 1		; damage counter for Bide damage for the enemy
	ld de, wEnemyBattleStatus1
.main
	ld a, [de]					; test Bide flag
	bit STORING_ENERGY, a		; test Bide flag
	ret z						; return if Bide flag is not set
	ld a,[hl]
	add c
	ld [hld],a
	ld a,[hl]
	adc b
	ld [hl],a
	ret
