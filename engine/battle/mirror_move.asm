; function to update the variable holding the last attack received by the player
; apply blacklist of move effects that don't register for Mirror Move
StorePlayerLastAttackReceived:
	ld a, [wEnemyMoveEffect]
	ld hl, MirrorMoveBlackList
	ld de, 1
	call IsInArray
	ret c
	ld a, [wEnemyMoveNum]
	ld [wPlayerLastAttackReceived], a
	ld hl, wNewBattleFlags
	bit USING_SIGNATURE_MOVE, [hl]
	jr z, .resetFlag
	set PLAYER_SIGNATURE_MOVE, [hl]
	ret
.resetFlag
	res PLAYER_SIGNATURE_MOVE, [hl]
	ret

; function to update the variable holding the last attack received by the enemy
; apply blacklist of move effects that don't register for Mirror Move
StoreEnemyLastAttackReceived:
	ld a, [wPlayerMoveEffect]
	ld hl, MirrorMoveBlackList
	ld de, 1
	call IsInArray
	ret c
	ld a, [wPlayerMoveNum]
	ld [wEnemyLastAttackReceived], a
	ld hl, wNewBattleFlags
	bit USING_SIGNATURE_MOVE, [hl]
	jr z, .resetFlag
	set ENEMY_SIGNATURE_MOVE, [hl]
	ret
.resetFlag
	res ENEMY_SIGNATURE_MOVE, [hl]
	ret

; blacklist of move effects whose moves don't register for Mirror Move
MirrorMoveBlackList:
	db REST_EFFECT
	db MIRROR_MOVE_EFFECT
	db ATTACK_UP1_EFFECT
	db DEFENSE_UP1_EFFECT
	db SPEED_UP1_EFFECT
	db SPECIAL_ATTACK_UP1_EFFECT
	db SPECIAL_DEFENSE_UP1_EFFECT
	db ACCURACY_UP1_EFFECT
	db EVASION_UP1_EFFECT
	db HAZE_EFFECT
	db BIDE_EFFECT
	db MIST_EFFECT
	db FOCUS_ENERGY_EFFECT
	db ATTACK_UP2_EFFECT
	db DEFENSE_UP2_EFFECT
	db SPEED_UP2_EFFECT
	db SPECIAL_ATTACK_UP2_EFFECT
	db SPECIAL_DEFENSE_UP2_EFFECT
	db ACCURACY_UP2_EFFECT
	db EVASION_UP2_EFFECT
	db HEAL_EFFECT
	db TRANSFORM_EFFECT
	db LIGHT_SCREEN_EFFECT
	db REFLECT_EFFECT
	db SUBSTITUTE_EFFECT
	db MIMIC_EFFECT
	db METRONOME_EFFECT
	db SPLASH_EFFECT
	db TELEPORT_EFFECT
	db STRUGGLE_EFFECT
	db COUNTER_EFFECT
	db ATTACK_DEFENSE_UP_EFFECT
	db ATTACK_SPEED_UP_EFFECT
    db ATTACK_SPECIAL_ATTACK_UP_EFFECT
    db ATTACK_SPECIAL_DEFENSE_UP_EFFECT
    db ATTACK_ACCURACY_UP_EFFECT
    db ATTACK_EVASION_UP_EFFECT
    db DEFENSE_SPEED_UP_EFFECT
    db DEFENSE_SPECIAL_ATTACK_UP_EFFECT
    db DEFENSE_SPECIAL_DEFENSE_UP_EFFECT
    db DEFENSE_ACCURACY_UP_EFFECT
    db DEFENSE_EVASION_UP_EFFECT
    db SPEED_SPECIAL_ATTACK_UP_EFFECT
    db SPEED_SPECIAL_DEFENSE_UP_EFFECT
    db SPEED_ACCURACY_UP_EFFECT
    db SPEED_EVASION_UP_EFFECT
    db SPECIAL_ATTACK_SPECIAL_DEFENSE_UP_EFFECT
    db SPECIAL_ATTACK_ACCURACY_UP_EFFECT
    db SPECIAL_ATTACK_EVASION_UP_EFFECT
    db SPECIAL_DEFENSE_ACCURACY_UP_EFFECT
    db SPECIAL_DEFENSE_EVASION_UP_EFFECT
    db ACCURACY_EVASION_UP_EFFECT
	db QUIVER_DANCE_EFFECT
	db -1