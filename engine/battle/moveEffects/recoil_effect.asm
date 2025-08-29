RecoilEffect_:
	ld a, [H_WHOSETURN]
	and a
	ld hl, wBattleMonMaxHP
	ld a, [wPlayerMoveEffect]
	jr z, .recoilEffect
	ld hl, wEnemyMonMaxHP
	ld a, [wEnemyMoveEffect]
.recoilEffect
	ld d, a
	ld a, [wDamage]
	ld b, a
	ld a, [wDamage + 1]
	ld c, a
	ld a, d
	cp RECOIL_EFFECT
	jr z, .oneFourth					; if it's the original recoil effect, divide damage by 4
	cp RECOIL_EFFECT3
	jr z, .oneHalf						; if it's the last recoil effect, divide damage by 2
	ld a, b
	ld [H_DIVIDEND], a
	ld a, c
	ld [H_DIVIDEND + 1], a
	ld a, 3								; else divide damage by 3
	ld [H_DIVISOR], a
	ld b, 2								; number of bytes in the dividend
	call Divide
	ld a, [H_QUOTIENT + 2]
	ld b, a
	ld a, [H_QUOTIENT + 3]
	ld c, a
	jr GotRecoilDamage
.oneFourth
	srl b
	rr c
.oneHalf
	srl b
	rr c
GotRecoilDamage
	ld a, b
	or c
	jr nz, .updateHP
	inc c ; minimum recoil damage is 1
.updateHP
; subtract HP from user due to the recoil damage
	ld a, [hli]
	ld [wHPBarMaxHP+1], a
	ld a, [hl]
	ld [wHPBarMaxHP], a
	push bc
	ld bc, wBattleMonHP - wBattleMonMaxHP
	add hl, bc
	pop bc
	ld a, [hl]
	ld [wHPBarOldHP], a
	sub c
	ld [hld], a
	ld [wHPBarNewHP], a
	ld a, [hl]
	ld [wHPBarOldHP+1], a
	sbc b
	ld [hl], a
	ld [wHPBarNewHP+1], a
	jr nc, .getHPBarCoords
; if recoil damage is higher than the Pokemon's HP, set its HP to 0
	xor a
	ld [hli], a
	ld [hl], a
	ld hl, wHPBarNewHP
	ld [hli], a
	ld [hl], a
.getHPBarCoords
	coord hl, 10, 9
	ld a, [H_WHOSETURN]
	and a
	ld a, $1
	jr z, .updateHPBar
	coord hl, 2, 2
	xor a
.updateHPBar
	ld [wHPBarType], a
	predef UpdateHPBar2
	ld hl, HitWithRecoilText
	jp PrintText
HitWithRecoilText:
	TX_FAR _HitWithRecoilText
	db "@"

; add this to distinguish Struggle from other recoil moves
StruggleEffect_:
	ld a, [H_WHOSETURN]
	and a
	ld hl, wBattleMonMaxHP
	jr z, .recoilEffect
	ld hl, wEnemyMonMaxHP
.recoilEffect
	ld a, [hli]
	ld b, a
	ld a, [hld]
	ld c, a				; bc = user's MaxHP
	srl b				; divide bc by 4
	rr c				; divide bc by 4
	srl b				; divide bc by 4
	rr c				; divide bc by 4
	jp GotRecoilDamage	; jump into RecoilEffect_ after recoil damage calculations are done
