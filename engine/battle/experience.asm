GainExperience:
	ld a, [wLinkState]
	cp LINK_STATE_BATTLING
	ret z ; return if link battle
	ld a, [wBattleType]
	cp BATTLE_TYPE_FACILITY
	ret z ; return if Battle Facility battle
	ld hl, wPartyMon1
	xor a
	ld [wWhichPokemon], a
.partyMonLoop ; loop over each mon and add gained exp
	inc hl
	inc hl											; to handle 2 bytes species IDs
	ld a, [hli]
	or [hl]											; is mon's HP 0?
	jp z, .nextMon									; if so, go to next mon
	push hl
	ld hl, wPartyGainExpFlags
	ld a, [wWhichPokemon]
	ld c, a
	ld b, FLAG_TEST
	predef FlagActionPredef
	ld a, c
	and a											; is mon's gain exp flag set?
	pop hl
	jp z, .nextMon									; if mon's gain exp flag not set, go to next mon
	call getEVYieldsAddressFromSpeciesID			; retrieves address of enemy's EV yields in de
	push de
	ld bc, wPartyMon1HPEV - (wPartyMon1HP + 1)		; removed the +1 after wPartyMon1HPEV since now EV are stored on 1 byte
	add hl, bc
	ld c, NUM_STATS
.EVGainLoop
	call checkGlobalEVLimit							; check if mon's total EVs are >= MAX_EV_GLOBAL
	jr z, .alreadyMaxed
	jr nc, .notMaxed
.alreadyMaxed
	pop de
	jr .EVGainDone									; if mon already has max EVs, skip EV gain
.notMaxed
	ld a, e											; e contains high byte of the difference between the mon's total EVs and MAX_EV_GLOBAL
	and a
	ld b, MAX_EV_PER_STAT + 1						; if high byte of the difference is not null, set b higher than any possible EV yield
													; (this could be any number as long as it's higher than all possible EV yields values)
	jr nz, .checkIndividualStatMaxed				; if the difference between total EVs and global limit is > 255, don't check low byte
	ld b, d											; store the low byte of the difference in b
.checkIndividualStatMaxed
	pop de
	ld a, [de]										; enemy mon EV yield
	cp b											; compare it to the difference between total EVs and global limit
	jr nc, .addEV									; if the EV yield would put the total EVs above global limit, use the difference instead
	ld b, a											; if not, use EV yield value
.addEV
	ld a, [hl]										; current EV
	add b											; add enemy mon EV yield to current EV
	jr c, .maxEV									; shouldn't happen, but in case EV gets over 255, prevents rollover
	cp MAX_EV_PER_STAT
	jr nc, .maxEV
	ld [hl], a
	jr .nextStat
.maxEV
	ld a, MAX_EV_PER_STAT
	ld [hl], a
.nextStat
	inc hl
	dec c
	jr z, .EVGainDone
	inc de
	push de
	jr .EVGainLoop

.EVGainDone
	xor a
	ld [H_MULTIPLICAND], a
	push hl
	ld hl, ExpYieldLookupTable									; use a lookup table for enemy exp yield to handle 2-bytes exp yields
	ld a, [wEnemyMonBaseExp]									; the value in the pokemon's base stats is now an id for fetching the actual exp yield
	ld e, a
	ld d, 0
	add hl, de													; each entry being 2 bytes, add the id twice to hl
	add hl, de
	ld a, [hli]													; read the value from the lookup table and put it in the multiplicand
	ld [H_MULTIPLICAND + 2], a
	ld a, [hl]
	ld [H_MULTIPLICAND + 1], a
	pop hl
	ld a, [wEnemyMonLevel]
	ld [H_MULTIPLIER], a
	call Multiply
	ld a, 7
	ld [H_DIVISOR], a
	ld b, 4
	call Divide
	ld b, 0														; add c to hl in case we left the EV loop early,
	add hl, bc													; so that hl points to wPartyMon1SpecialDefenseEV + 1
	ld de, wPartyMon1OTID - (wPartyMon1SpecialDefenseEV + 1)	; hl is now pointing to the next byte after EVs
	add hl, de													; make hl point to OTID
	ld b, [hl]
	inc hl
	ld a, [wPlayerID]
	cp b
	jr nz, .tradedMon
	ld b, [hl]
	ld a, [wPlayerID + 1]
	cp b
	ld a, 0
	jr z, .next
.tradedMon
	call BoostExp ; traded mon exp boost
	ld a, 1
.next
	ld [wGainBoostedExp], a
	ld a, [wIsInBattle]
	dec a												; is it a trainer battle?
	call nz, BoostExp									; if so, boost exp
	ld bc, (wPartyMon1Exp + 2) - (wPartyMon1OTID + 1)	; here hl points to second byte of OTID
	add hl, bc											; make hl point to third byte of Exp
	push hl
	ld hl, wPartyMon1Level
	ld a, [wWhichPokemon]
	ld bc, wPartyMon2 - wPartyMon1
	call AddNTimes										; make hl point to the mon level
	ld a, [hl]
	cp MAX_LEVEL
	pop hl
	jp nc, .nextMon										; if the mon is already at or over MAX_LEVEL, skip giving it exp.
; add the gained exp to the party mon's exp
	ld b, [hl]
	ld a, [H_QUOTIENT + 3]
	ld [wExpAmountGained + 1], a
	add b
	ld [hld], a
	ld b, [hl]
	ld a, [H_QUOTIENT + 2]
	ld [wExpAmountGained], a
	adc b
	ld [hl], a
	jr nc, .noCarry
	dec hl
	inc [hl]
	inc hl
.noCarry
; calculate exp for the mon at max level, and cap the exp at that value
	inc hl
	push hl
	ld a, [wWhichPokemon]
	ld c, a
	ld b, 0
	ld hl, wPartySpecies
	add hl, bc
	add hl, bc								; to handle 2 bytes species IDs
	ld a, [hli]								; to handle 2 bytes species IDs
	ld [wMonSpeciesTemp], a					; to handle 2 bytes species IDs
	ld a, [hl]								; to handle 2 bytes species IDs
	ld [wMonSpeciesTemp + 1], a				; to handle 2 bytes species IDs
	call GetMonHeader
	ld d, MAX_LEVEL
	callab CalcExperience					; get max exp
; compare max exp with current exp
	ld a, [hExperience]
	ld b, a
	ld a, [hExperience + 1]
	ld c, a
	ld a, [hExperience + 2]
	ld d, a
	pop hl
	ld a, [hld]
	sub d
	ld a, [hld]
	sbc c
	ld a, [hl]
	sbc b
	jr c, .next2
; the mon's exp is greater than the max exp, so overwrite it with the max exp
	ld a, b
	ld [hli], a
	ld a, c
	ld [hli], a
	ld a, d
	ld [hld], a
	dec hl
.next2
	push hl
	ld a, [wWhichPokemon]
	ld hl, wPartyMonNicks
	call GetPartyMonName
	ld hl, GainedText
	call PrintText
	xor a ; PLAYER_PARTY_DATA
	ld [wMonDataLocation], a
	call LoadMonData
	pop hl
	ld bc, wPartyMon1Level - wPartyMon1Exp
	add hl, bc
	push hl
	callba CalcLevelFromExperience			; sets the new level reached by the pokemon in d
	pop hl
.levelUpLoop
	ld a, [hl]								; current level
	cp d									; compare it to the new level
	jp z, .nextMon							; if the pokemon has reached its new level, go to next mon
	push de
	ld a, [wCurEnemyLVL]
	push af
	push hl
	inc [hl]								; increase the level by one
	ld a, [hl]
	ld [wCurEnemyLVL], a
	call GetMonHeader								; since wMonSpeciesTemp is already set, no need to fetch the species from party data
	ld bc, (wPartyMon1MaxHP + 1) - wPartyMon1Level
	add hl, bc
	push hl
	ld a, [hld]
	ld c, a
	ld b, [hl]
	push bc									; push max HP (from before levelling up)
	ld d, h
	ld e, l
	ld bc, (wPartyMon1HPEV - 1) - wPartyMon1MaxHP
	add hl, bc
	ld b, $1								; consider stat exp when calculating stats
	call CalcStats
	pop bc									; pop max HP (from before levelling up)
	pop hl
	ld a, [hld]
	sub c
	ld c, a
	ld a, [hl]
	sbc b
	ld b, a									; bc = difference between old max HP and new max HP after levelling
	ld de, (wPartyMon1HP + 1) - wPartyMon1MaxHP
	add hl, de
; add to the current HP the amount of max HP gained when levelling
	ld a, [hl] ; wPartyMon1HP + 1
	add c
	ld [hld], a
	ld a, [hl] ; wPartyMon1HP + 1
	adc b
	ld [hl], a ; wPartyMon1HP
	ld a, [wPlayerMonNumber]
	ld b, a
	ld a, [wWhichPokemon]
	cp b ; is the current mon in battle?
	jr nz, .printGrewLevelText
; current mon is in battle
	ld de, wBattleMonHP
; copy party mon HP to battle mon HP
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
; copy other stats from party mon to battle mon
	ld bc, wPartyMon1Level - (wPartyMon1HP + 1)
	add hl, bc
	push hl
	ld de, wBattleMonLevel
	ld bc, 1 + NUM_STATS * 2 ; size of stats
	call CopyData
	pop hl
	ld a, [wPlayerBattleStatus3]
	bit TRANSFORMED, a								; is the mon transformed?
	jr nz, .recalcStatChanges
; the mon is not transformed, so update the unmodified stats
	ld de, wPlayerMonUnmodifiedLevel
	ld bc, 1 + NUM_STATS * 2
	call CopyData
.recalcStatChanges
	xor a ; battle mon
	ld [wCalculateWhoseStats], a
	callab CalculateModifiedStats
	callab ApplyBurnAndParalysisPenaltiesToPlayer	; apply stat nerfs to recalculated stats
	xor a											; cancel the turn switch that occurred in previous call
	ld [H_WHOSETURN], a								; cancel the turn switch that occurred in previous call
	ld a, [wPlayerBattleStatus3]
	bit TRANSFORMED, a
	jr nz, .skipBadgeBoosts							; if the mon is Transformed, don't apply badge boosts
	callab ApplyBadgeStatBoosts
.skipBadgeBoosts
	callab DrawPlayerHUDAndHPBar
	callab PrintEmptyString
	call SaveScreenTilesToBuffer1
.printGrewLevelText
	ld a, [wWhichPokemon]
	ld hl, wPartyMonNicks
	call GetPartyMonName			; get Pokemon nickname for level up text
	ld hl, GrewLevelText
	call PrintText
	xor a							; PLAYER_PARTY_DATA
	ld [wMonDataLocation], a
	call LoadMonData
	ld d, $1
	callab PrintStatsBox
	call WaitForTextScrollButtonPress
	call LoadScreenTilesFromBuffer1
	xor a ; PLAYER_PARTY_DATA
	ld [wMonDataLocation], a
	predef LearnMoveFromLevelUp
	ld hl, wCanEvolveFlags
	ld a, [wWhichPokemon]
	ld c, a
	ld b, FLAG_SET
	predef FlagActionPredef
	pop hl
	pop af
	ld [wCurEnemyLVL], a
	pop de
	jp .levelUpLoop					; keep leveling up until the pokemon reaches its new level

.nextMon
	ld a, [wPartyCount]
	ld b, a
	ld a, [wWhichPokemon]
	inc a
	cp b
	jr z, .done
	ld [wWhichPokemon], a
	ld bc, wPartyMon2 - wPartyMon1
	ld hl, wPartyMon1
	call AddNTimes
	jp .partyMonLoop
.done
	ld hl, wPartyGainExpFlags
	xor a
	ld [hl], a ; clear gain exp flags
	ld a, [wPlayerMonNumber]
	ld c, a
	ld b, FLAG_SET
	push bc
	predef FlagActionPredef ; set the gain exp flag for the mon that is currently out
	ld hl, wPartyFoughtCurrentEnemyFlags
	xor a
	ld [hl], a
	pop bc
	predef_jump FlagActionPredef ; set the fought current enemy flag for the mon that is currently out

; divide enemy base stats, catch rate, and base exp by the number of mons gaining exp
DivideExpDataByNumMonsGainingExp:
	ld a, [wPartyGainExpFlags]
	ld b, a
	xor a
	ld c, $8
	ld d, $0
.countSetBitsLoop ; loop to count set bits in wPartyGainExpFlags
	xor a
	srl b
	adc d
	ld d, a
	dec c
	jr nz, .countSetBitsLoop
	cp $2
	ret c ; return if only one mon is gaining exp
	ld [wd11e], a ; store number of mons gaining exp
	ld hl, wEnemyMonBaseStats
	ld c, wEnemyMonBaseExp + 1 - wEnemyMonBaseStats
.divideLoop
	xor a
	ld [H_DIVIDEND], a
	ld a, [hl]
	ld [H_DIVIDEND + 1], a
	ld a, [wd11e]
	ld [H_DIVISOR], a
	ld b, $2
	call Divide ; divide value by number of mons gaining exp
	ld a, [H_QUOTIENT + 3]
	ld [hli], a
	dec c
	jr nz, .divideLoop
	ret

; multiplies exp by 1.5
BoostExp:
	ld a, [H_QUOTIENT + 2]
	ld b, a
	ld a, [H_QUOTIENT + 3]
	ld c, a
	srl b
	rr c
	add c
	ld [H_QUOTIENT + 3], a
	ld a, [H_QUOTIENT + 2]
	adc b
	ld [H_QUOTIENT + 2], a
	ret

; use a lookup table for the actual exp yield, since now some mons have exp yields > 255, but there are less than 256 possible values for exp yields
; that way no need to alter the pokemon base stats data structure, which now holds the index of the mon's exp yield in this table
ExpYieldLookupTable:
	dw 37
	dw 39
	dw 40
	dw 44
	dw 47
	dw 48
	dw 49
	dw 50
	dw 51
	dw 52
	dw 53
	dw 54
	dw 55
	dw 56
	dw 57
	dw 58
	dw 59
	dw 60
	dw 61
	dw 62
	dw 63
	dw 64
	dw 65
	dw 66
	dw 67
	dw 68
	dw 69
	dw 70
	dw 71
	dw 72
	dw 73
	dw 77
	dw 78
	dw 79
	dw 81
	dw 82
	dw 86
	dw 87
	dw 88
	dw 95
	dw 97
	dw 100
	dw 101
	dw 104
	dw 112
	dw 113
	dw 119
	dw 122
	dw 123
	dw 126
	dw 127
	dw 128
	dw 130
	dw 132
	dw 133
	dw 134
	dw 135
	dw 137
	dw 138
	dw 140
	dw 142
	dw 143
	dw 144
	dw 145
	dw 147
	dw 149
	dw 151
	dw 154
	dw 155
	dw 157
	dw 158
	dw 159
	dw 161
	dw 162
	dw 163
	dw 165
	dw 166
	dw 168
	dw 169
	dw 170
	dw 171
	dw 172
	dw 173
	dw 174
	dw 175
	dw 177
	dw 178
	dw 179
	dw 180
	dw 182
	dw 184
	dw 186
	dw 187
	dw 189
	dw 194
	dw 196
	dw 216
	dw 217
	dw 218
	dw 221
	dw 223
	dw 225
	dw 227
	dw 229
	dw 230
	dw 232
	dw 233
	dw 234
	dw 235
	dw 236
	dw 239
	dw 240
	dw 241
	dw 243
	dw 245
	dw 248
	dw 255
	dw 260
	dw 261
	dw 268
	dw 270
	dw 275
	dw 306
	dw 324
	dw 395
	dw 608

GainedText:
	TX_FAR _GainedText
	TX_ASM
	ld a, [wBoostExpByExpAll]
	ld hl, WithExpAllText
	and a
	ret nz
	ld hl, ExpPointsText
	ld a, [wGainBoostedExp]
	and a
	ret z
	ld hl, BoostedText
	ret

WithExpAllText:
	TX_FAR _WithExpAllText
	TX_ASM
	ld hl, ExpPointsText
	ret

BoostedText:
	TX_FAR _BoostedText

ExpPointsText:
	TX_FAR _ExpPointsText
	db "@"

GrewLevelText:
	TX_FAR _GrewLevelText
	TX_SFX_LEVEL_UP
	db "@"

; add this function to check whether a mon has already reached the global EV limit
; output:
; EV sum = MAX_EV_GLOBAL : z flag set, carry flag unset
; EV sum < MAX_EV_GLOBAL : z flag unset, carry flag unset
; EV sum > MAX_EV_GLOBAL : z flag unset, carry flag set
; de = MAX_EV_GLOBAL - EV sum
checkGlobalEVLimit:
	push hl
	push bc
	ld hl, wUsedItemOnWhichPokemon
	ld a, [wIsInBattle]
	and a
	jr z, .main
	ld hl, wWhichPokemon
.main
	ld a, [hl]
	ld bc, wPartyMon2 - wPartyMon1
	ld hl, wPartyMon1HPEV
	call AddNTimes
	ld d, NUM_STATS
	xor a
	ld c, a
	ld b, a
.loop						; this loop computes total EVs and stores it in bc
	ld a, [hli]
	ld e, a					; put current EV in e
	ld a, b
	add e					; add it to the sum's low byte
	ld b, a					; keep track of the sum's low byte in b
	jr nc, .noOverflow
	inc c					; increase the sum's high byte in c
.noOverflow
	dec d
	jr nz, .loop
	ld a, MAX_EV_GLOBAL / 256
	sub c
	ld e, a					; store high byte difference in e
	jr nz, .done			; if high byte is either greater or lower than MAX_EV_GLOBAL / 255, then we don't even need to check the low byte
	ld a, MAX_EV_GLOBAL % 256
	sub b
	ld d, a					; store low byte difference in d
.done
	pop bc
	pop hl
	ret

; function to get the address of an enemy's EV yields in de from the enemy's species ID
getEVYieldsAddressFromSpeciesID:
	push hl
	ld hl, EVYields
	ld bc, EVYieldEnd - EVYields
	ld a, [wEnemyMonSpecies]		; to handle 2 bytes species IDs
	ld d, a							; to handle 2 bytes species IDs
	ld a, [wEnemyMonSpecies + 1]	; to handle 2 bytes species IDs
	ld e, a							; to handle 2 bytes species IDs
	dec de							; to handle 2 bytes species IDs
	call AddNTimes16Bits			; to handle 2 bytes species IDs
	ld d, h
	ld e, l
	pop hl
	ret

INCLUDE "data/ev_yields.asm"
