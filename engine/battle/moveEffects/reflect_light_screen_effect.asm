ReflectLightScreenEffect_:
	ld bc, wPlayerReflectCounter
	ld de, wPlayerMoveEffect
	ld a, [H_WHOSETURN]
	and a
	jr z, .reflectLightScreenEffect
	ld bc, wEnemyReflectCounter
	ld de, wEnemyMoveEffect
.reflectLightScreenEffect
	ld a, [de]
	cp LIGHT_SCREEN_EFFECT			; is move Light Screen?
	jr nz, .reflect					; if not, jump
	inc bc							; make bc point to the Light Screen counter
	ld hl, LightScreenProtectedText
	jr .isEffectAlreadyActive
.reflect
	ld hl, ReflectGainedArmorText
.isEffectAlreadyActive
	ld a, [bc]
	and a
	jr nz, .moveFailed				; if counter is not zero, then effect is already active, so fail
	ld a, 5							; effect duration
	ld [bc], a
.playAnim
	push hl
	ld hl, PlayCurrentMoveAnimation
	call BankswitchEtoF
	pop hl
	jp PrintText
.moveFailed
	ld c, 50
	call DelayFrames
	ld hl, PrintButItFailedText_
	jp BankswitchEtoF

LightScreenProtectedText:
	TX_FAR _LightScreenProtectedText
	db "@"

ReflectGainedArmorText:
	TX_FAR _ReflectGainedArmorText
	db "@"

BankswitchEtoF:
	ld b, BANK(BattleCore)
	jp Bankswitch
