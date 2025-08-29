; calculates the level a mon should be based on its current exp
CalcLevelFromExperience:
	ld a, [wLoadedMonSpecies]
	ld [wMonSpeciesTemp], a					; to handle 2 bytes species IDs
	ld a, [wLoadedMonSpecies  + 1]			; to handle 2 bytes species IDs
	ld [wMonSpeciesTemp + 1], a				; to handle 2 bytes species IDs
	call GetMonHeader
	ld d, $1 ; init level to 1
.loop
	inc d ; increment level
	call CalcExperience
	push hl
	ld hl, wLoadedMonExp + 2 ; current exp
; compare exp needed for level d with current exp
	ld a, [hExperience + 2]
	ld c, a
	ld a, [hld]
	sub c
	ld a, [hExperience + 1]
	ld c, a
	ld a, [hld]
	sbc c
	ld a, [hExperience]
	ld c, a
	ld a, [hl]
	sbc c
	pop hl
	jr nc, .loop ; if exp needed for level d is not greater than exp, try the next level
	dec d ; since the exp was too high on the last loop iteration, go back to the previous value and return
	ret

; calculates the amount of experience needed for level d
CalcExperience:
	ld a, d
	cp 2					; check if the Pokemon is less than level 2
	jr nc, .atLeastLevelTwo	; if not, do the normal calculation
	ld hl, hExperience + 2	; if it is, set its experience to 1
	ld a, 1					; in order to fix the experience underflow bug
	ld [hld], a				; for level 1 or level 0 pokemon
	xor a
	ld [hld], a
	ld [hl], a
	ret
.atLeastLevelTwo
	ld a, [wMonHGrowthRate]
	cp ERRATIC						; for the ERRATIC group, use lookup table instead of equation
	jp z, .lookupErraticTable
	cp FLUCTUATING					; for the FLUCTUATING group, use lookup table instead of equation
	jp z, .lookupFluctuatingTable
	add a
	add a
	ld c, a
	ld b, 0
	ld hl, GrowthRateTable
	add hl, bc
	call CalcDSquared
	ld a, d
	ld [H_MULTIPLIER], a
	call Multiply
	ld a, [hl]
	and $f0
	swap a
	ld [H_MULTIPLIER], a
	call Multiply
	ld a, [hli]
	and $f
	ld [H_DIVISOR], a
	ld b, $4
	call Divide
	ld a, [H_QUOTIENT + 1]
	push af
	ld a, [H_QUOTIENT + 2]
	push af
	ld a, [H_QUOTIENT + 3]
	push af
	call CalcDSquared
	ld a, [hl]
	and $7f
	ld [H_MULTIPLIER], a
	call Multiply
	ld a, [H_PRODUCT + 1]
	push af
	ld a, [H_PRODUCT + 2]
	push af
	ld a, [H_PRODUCT + 3]
	push af
	ld a, [hli]
	push af
	xor a
	ld [H_MULTIPLICAND], a
	ld [H_MULTIPLICAND + 1], a
	ld a, d
	ld [H_MULTIPLICAND + 2], a
	ld a, [hli]
	ld [H_MULTIPLIER], a
	call Multiply
	ld b, [hl]
	ld a, [H_PRODUCT + 3]
	sub b
	ld [H_PRODUCT + 3], a
	ld b, $0
	ld a, [H_PRODUCT + 2]
	sbc b
	ld [H_PRODUCT + 2], a
	ld a, [H_PRODUCT + 1]
	sbc b
	ld [H_PRODUCT + 1], a
; The difference of the linear term and the constant term consists of 3 bytes
; starting at H_PRODUCT + 1. Below, hExperience (an alias of that address) will
; be used instead for the further work of adding or subtracting the squared
; term and adding the cubed term.
	pop af
	and $80
	jr nz, .subtractSquaredTerm ; check sign
	pop bc
	ld a, [hExperience + 2]
	add b
	ld [hExperience + 2], a
	pop bc
	ld a, [hExperience + 1]
	adc b
	ld [hExperience + 1], a
	pop bc
	ld a, [hExperience]
	adc b
	ld [hExperience], a
	jr .addCubedTerm
.subtractSquaredTerm
	pop bc
	ld a, [hExperience + 2]
	sub b
	ld [hExperience + 2], a
	pop bc
	ld a, [hExperience + 1]
	sbc b
	ld [hExperience + 1], a
	pop bc
	ld a, [hExperience]
	sbc b
	ld [hExperience], a
.addCubedTerm
	pop bc
	ld a, [hExperience + 2]
	add b
	ld [hExperience + 2], a
	pop bc
	ld a, [hExperience + 1]
	adc b
	ld [hExperience + 1], a
	pop bc
	ld a, [hExperience]
	adc b
	ld [hExperience], a
	ret
.lookupErraticTable
	ld hl, ErraticLookupTable
	jr .lookup
.lookupFluctuatingTable
	ld hl, FluctuatingLookupTable
.lookup
	ld a, d							; level is in d
	cp MAX_LEVEL + 1
	jr c, .notAboveMaxLevel
	ld d, MAX_LEVEL					; if level is above MAX_LEVEL, use the experience amount for MAX_LEVEL (avoids reading garbage data in case level gets above MAX_LEVEL)
.notAboveMaxLevel
	ld c, d
	ld b, 0
	add hl, bc						; each entry is 3 bytes long, so add 3 times the level to hl
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld [hExperience], a
	ld a, [hli]
	ld [hExperience + 1], a
	ld a, [hl]
	ld [hExperience + 2], a
	ret

; calculates d*d
CalcDSquared:
	xor a
	ld [H_MULTIPLICAND], a
	ld [H_MULTIPLICAND + 1], a
	ld a, d
	ld [H_MULTIPLICAND + 2], a
	ld [H_MULTIPLIER], a
	jp Multiply

; each entry has the following scheme:
; %AAAABBBB %SCCCCCCC %DDDDDDDD %EEEEEEEE
; resulting in
;  (a*n^3)/b + sign*c*n^2 + d*n - e
; where sign = -1 <=> S=1
GrowthRateTable:
	db $11,$00,$00,$00 ; medium fast      n^3
	db $34,$0A,$00,$1E ; (unused?)    3/4 n^3 + 10 n^2         - 30
	db $34,$14,$00,$46 ; (unused?)    3/4 n^3 + 20 n^2         - 70
	db $65,$8F,$64,$8C ; medium slow: 6/5 n^3 - 15 n^2 + 100 n - 140
	db $45,$00,$00,$00 ; fast:        4/5 n^3
	db $54,$00,$00,$00 ; slow:        5/4 n^3

; the equation for the ERRATIC level up group is too complex, so I use a lookup table instead
; each entry is 3 bytes (from most significant to least significant) since the amount of experience can go above 2^16
ErraticLookupTable:
	db 0,	0,		0		; experience at level 0
	db 0,	0,		0		; experience at level 1
	db 0,	0,		15		; experience at level 2
	db 0,	0,		52		; ...
	db 0,	0,		122
	db 0,	0,		237
	db 0,	1,		150
	db 0,	2,		125
	db 0,	3,		174
	db 0,	5,		46
	db 0,	7,		8
	db 0,	9,		65
	db 0,	11,		225
	db 0,	14,		238
	db 0,	18,		111
	db 0,	22,		105
	db 0,	26,		225
	db 0,	31,		219
	db 0,	37,		92
	db 0,	43,		103
	db 0,	50,		0
	db 0,	57,		40
	db 0,	64,		226
	db 0,	73,		49
	db 0,	82,		20
	db 0,	91,		141
	db 0,	101,	156
	db 0,	112,	65
	db 0,	123,	122
	db 0,	135,	72
	db 0,	147,	168
	db 0,	160,	151
	db 0,	174,	20
	db 0,	188,	27
	db 0,	202,	169
	db 0,	217,	185
	db 0,	233,	71
	db 0,	249,	78
	db 1,	9,		201
	db 1,	26,		177
	db 1,	44,		0
	db 1,	61,		174
	db 1,	79,		182
	db 1,	98,		13
	db 1,	116,	174
	db 1,	135,	141
	db 1,	154,	162
	db 1,	173,	228
	db 1,	193,	71
	db 1,	212,	193
	db 1,	232,	72
	db 2,	0,		252
	db 2,	26,		67
	db 2,	52,		26
	db 2,	78,		125
	db 2,	105,	104
	db 2,	132,	215
	db 2,	160,	197
	db 2,	189,	47
	db 2,	218,	14
	db 2,	247,	96
	db 3,	21,		29
	db 3,	51,		64
	db 3,	81,		196
	db 3,	112,	163
	db 3,	143,	215
	db 3,	175,	88
	db 3,	207,	33
	db 3,	239,	42
	db 4,	20,		142
	db 4,	55,		234
	db 4,	94,		120
	db 4,	133,	166
	db 4,	170,	103
	db 4,	210,	170
	db 4,	251,	131
	db 5,	33,		127
	db 5,	75,		85
	db 5,	117,	180
	db 5,	156,	191
	db 5,	200,	0
	db 5,	243,	189
	db 6,	27,		165
	db 6,	72,		38
	db 6,	117,	22
	db 6,	157,	164
	db 6,	203,	55
	db 6,	249,	41
	db 7,	34,		33
	db 7,	80,		146
	db 7,	127,	82
	db 7,	168,	118
	db 7,	215,	142
	db 8,	6,		225
	db 8,	47,		237
	db 8,	95,		112
	db 8,	143,	26
	db 8,	183,	197
	db 8,	231,	115
	db 9,	8,		10
	db 9,	39,		192

; the equation for the FLUCTUATING level up group is too complex, so I use a lookup table instead
; each entry is 3 bytes (from most significant to least significant) since the amount of experience can go above 2^16
FluctuatingLookupTable:
	db 0,	0,		0		; experience at level 0
	db 0,	0,		0		; experience at level 1
	db 0,	0,		4		; experience at level 2
	db 0,	0,		13		; ...
	db 0,	0,		32
	db 0,	0,		65
	db 0,	0,		112
	db 0,	0,		178
	db 0,	1,		20
	db 0,	1,		137
	db 0,	2,		28
	db 0,	2,		233
	db 0,	3,		199
	db 0,	4,		206
	db 0,	6,		55
	db 0,	7,		165
	db 0,	9,		153
	db 0,	11,		230
	db 0,	14,		148
	db 0,	17,		174
	db 0,	21,		64
	db 0,	25,		82
	db 0,	29,		242
	db 0,	35,		43
	db 0,	41,		10
	db 0,	47,		155
	db 0,	54,		236
	db 0,	63,		12
	db 0,	72,		7
	db 0,	81,		238
	db 0,	92,		208
	db 0,	104,	187
	db 0,	117,	194
	db 0,	131,	244
	db 0,	147,	99
	db 0,	164,	33
	db 0,	182,	64
	db 0,	197,	221
	db 0,	218,	161
	db 0,	236,	89
	db 1,	4,		0
	db 1,	23,		253
	db 1,	50,		197
	db 1,	73,		53
	db 1,	103,	94
	db 1,	128,	111
	db 1,	162,	61
	db 1,	190,	29
	db 1,	227,	215
	db 2,	2,		182
	db 2,	44,		164
	db 2,	78,		182
	db 2,	125,	33
	db 2,	162,	153
	db 2,	213,	207
	db 2,	254,	226
	db 3,	55,		51
	db 3,	100,	23
	db 3,	161,	212
	db 3,	210,	194
	db 4,	22,		64
	db 4,	75,		112
	db 4,	149,	5
	db 4,	206,	179
	db 5,	30,		184
	db 5,	93,		32
	db 5,	179,	240
	db 5,	247,	79
	db 6,	85,		74
	db 6,	157,	223
	db 7,	3,		100
	db 7,	81,		112
	db 7,	190,	225
	db 8,	18,		167
	db 8,	136,	105
	db 8,	226,	43
	db 9,	96,		166
	db 9,	192,	170
	db 10,	72,		71
	db 10,	174,	211
	db 11,	64,		0
	db 11,	173,	91
	db 12,	72,		133
	db 12,	188,	249
	db 13,	98,		145
	db 13,	222,	105
	db 14,	142,	228
	db 15,	18,		106
	db 15,	206,	61
	db 16,	89,		192
	db 17,	33,		100
	db 17,	181,	51
	db 18,	137,	33
	db 19,	37,		140
	db 20,	6,		66
	db 20,	171,	156
	db 21,	153,	153
	db 22,	72,		52
	db 23,	67,		251
	db 23,	252,	44
	db 25,	6,		64
