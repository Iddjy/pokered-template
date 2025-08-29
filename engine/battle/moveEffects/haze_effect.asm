HazeEffect_:
	ld a, STAT_MODIFIER_DEFAULT
	ld hl, wPlayerMonAttackMod
	call ResetStatMods
	ld hl, wEnemyMonAttackMod
	call ResetStatMods
; copy unmodified stats to battle stats
	ld hl, wPlayerMonUnmodifiedAttack
	ld de, wBattleMonAttack
	call ResetStats
	ld hl, wEnemyMonUnmodifiedAttack
	ld de, wEnemyMonAttack
	call ResetStats
; delete the whole part resetting statuses
; replace it with this block to reapply badge boosts and Paralysis/Burn stat nerfs
	ld a, [wLinkState]										; check whether this is a link battle
	cp LINK_STATE_BATTLING
	jr z, .skipBadgeBoosts
	callab ApplyBadgeStatBoosts								; apply stats boosts provided by the badges obtained if not in Link
.skipBadgeBoosts
	ld hl, ApplyBurnAndParalysisPenaltiesToCurrentTarget	; ApplyBurnAndParalysisPenaltiesToCurrentTarget
	call CallBankF											; CallBankF apply stats nerfs to attacking pokemon if it is Paralysed or Burned
	ld a, [H_WHOSETURN]										; reverse the turn
	xor $1													; reverse the turn
	ld [H_WHOSETURN], a 									; reverse the turn
	ld hl, ApplyBurnAndParalysisPenaltiesToCurrentTarget	; ApplyBurnAndParalysisPenaltiesToCurrentTarget
	call CallBankF											; CallBankF apply stats nerfs to defending pokemon if it is Paralysed or Burned
	ld a, [H_WHOSETURN]										; reverse the turn
	xor $1													; reverse the turn
	ld [H_WHOSETURN], a 									; reverse the turn
	ld hl, PlayCurrentMoveAnimation
	call CallBankF
	ld hl, StatsChangesEliminatedText
	jp PrintText

ResetStatMods:
	ld b, NUM_STAT_MODS
.loop
	ld [hli], a
	dec b
	jr nz, .loop
	ret

ResetStats:
	ld b, (NUM_STATS - 1) * 2		; replace $8 with (NUM_STATS - 1) * 2 because HP isn't affected and each stat is 2 bytes
.loop
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .loop
	ret

StatsChangesEliminatedText:
	TX_FAR _StatsChangesEliminatedText
	db "@"
