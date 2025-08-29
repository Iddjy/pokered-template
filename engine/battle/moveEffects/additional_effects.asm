; function to apply damage modifications that apply after damage value is computed (like stomp on a minimized target)
ApplyOtherModificators_:
	ld hl, wPlayerMoveNum
	ld bc, wEnemyBattleStatus1
	ld de, wEnemyMoveNum
	ld a, [H_WHOSETURN]
	and a
	ld a, [wEnemyMonMinimized]
	jr z, .playersTurn
	ld hl, wEnemyMoveNum
	ld bc, wPlayerBattleStatus1
	ld de, wPlayerMoveNum
	ld a, [wPlayerMonMinimized]
.playersTurn
	and a
	jr z, .targetNotMinimized
	inc hl								; move hl from move id to move effect
	ld a, [hld]							; read move effect and make hl point back to move id
	cp WEIGHT_DIFFERENCE_EFFECT
	jp z, DoubleDamage
	push hl
	ld hl, wNewBattleFlags
	bit USING_SIGNATURE_MOVE, [hl]
	pop hl
	ld a, [hl]
	jr nz, .usingSignatureMove
	cp STOMP
	jp z, DoubleDamage
	cp BODY_SLAM
	jp z, DoubleDamage
	cp DRAGON_RUSH
	jp z, DoubleDamage
	cp SIGNATURE_MOVE_1
	jr z, .mapSignatureMove
	cp SIGNATURE_MOVE_2
	jr nz, .targetNotMinimized
.mapSignatureMove
	ld [wd11e], a
	push hl
	push bc
	push de
	callab MapAttackerSignatureMove
	ld a, d
	pop de
	pop bc
	pop hl
.usingSignatureMove
	cp STEAMROLLER
	jp z, DoubleDamage
.targetNotMinimized
	ld a, [bc]
	bit INVULNERABLE, a
	jr z, .notInvulnerable
	push hl
	ld hl, wNewBattleFlags
	bit USING_SIGNATURE_MOVE, [hl]		; no signature move can hit during semi-invulnerable turns
	pop hl
	ret nz
	ld a, [de]
	cp FLY
	jr nz, .notHighInTheAir
	ld a, [hl]
	cp GUST
	jp z, DoubleDamage
	cp TWISTER
	jp z, DoubleDamage
.notHighInTheAir
	cp DIG
	jr nz, .notUnderground
	ld a, [hl]
	cp EARTHQUAKE
	jp z, DoubleDamage
.notUnderground
.notInvulnerable
	ret

; function used to double the value stored in wDamage
DoubleDamage:
	ld hl, wDamage
	ld a, [hli]
	ld b, a
	ld a, [hld]
	ld c, a
	sla c						; double damage
	rl b						; double damage
	ld [hl], b					; update damage variable
	inc hl						; update damage variable
	ld [hl], c					; update damage variable
	ret
