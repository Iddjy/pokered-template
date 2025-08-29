; data for default hidden/shown
; objects for each map ($00-$F8)

; Structure:
; Map ID, number of entries for this map
; then:
; 3 bytes per object
; [Object_ID][global index][H/S]
;
; Object_ID:
; 1st word = 0 or 1 according to whether the flag is in the first list or the second list
; 2nd word = sprite index on the map
; This Data is loaded into RAM at wd5ce-$D5F?. (wMissableObjectList)

Hide equ $11
Show equ $15

MapHS00:
	db PALLET_TOWN, 1
	db $01,$00,Hide
MapHS01:
	db VIRIDIAN_CITY, 2
	db $05,$01,Show
	db $07,$02,Hide
MapHS02:
	db PEWTER_CITY, 2
	db $03,$03,Show
	db $05,$04,Show
MapHS03:
	db CERULEAN_CITY, 5
	db $01,$05,Hide
	db $02,$06,Show                         ; TM_28 = global index 7
	db $06,$07,Hide
	db $0A,$08,Show
	db $0B,$09,Show
MapHS0A:
	db SAFFRON_CITY, 15
	db $01,$0A,Show
	db $02,$0B,Show
	db $03,$0C,Show
	db $04,$0D,Show
	db $05,$0E,Show
	db $06,$0F,Show
	db $07,$10,Show
	db $08,$11,Hide
	db $09,$12,Hide
	db $0A,$13,Hide
	db $0B,$14,Hide
	db $0C,$15,Hide
	db $0D,$16,Hide
	db $0E,$17,Show
	db $0F,$18,Hide
MapHS0D:
	db ROUTE_2, 2
	db $01,$19,Show
	db $02,$1A,Show
MapHS0F:
	db ROUTE_4, 1
	db $03,$1B,Show			; TM_54 = global index 28
MapHS11:
	db ROUTE_6, 1
	db $07,$1C,Show
MapHS13:
	db ROUTE_8, 1
	db $0A,$1D,Show			; TM_91 global index 29
MapHS14:
	db ROUTE_9, 1
	db $0A,$1E,Show			; TM_30 = global index 30
MapHS16:
	db ROUTE_11, 1
	db $0B,$1F,Show			; TM_40 global index 31
MapHS17:
	db ROUTE_12, 3
	db $01,$20,Show
	db $09,$21,Show			; TM_16 = global index 33
	db $0A,$22,Show
MapHS18:
	db ROUTE_13, 1
	db $0b,$23,Show			; TM_88 global index 35
MapHS1A:
	db ROUTE_15, 1
	db $0B,$24,Show			; TM_02 = global index 36
MapHS1B:
	db ROUTE_16, 3
	db $07,$25,Show
	db $08,$26,Show			; TM_04 global index 38
	db $09,$27,Show			; TM_75 global index 39
MapHS20:
	db ROUTE_21, 1
	db $0a,$28,Hide			; TM_92 global index 40
MapHS21:
	db ROUTE_22, 2
	db $01,$29,Hide
	db $02,$2A,Hide
MapHS23:
	db ROUTE_24, 2
	db $01,$2B,Show
	db $08,$2C,Show			; TM_45 = global index 44
MapHS24:
	db ROUTE_25, 1
	db $0A,$2D,Show			; TM_19 = global index 45
MapHS27:
	db BLUES_HOUSE, 3
	db $01,$2E,Show
	db $02,$2F,Hide
	db $03,$30,Show
MapHS28:
	db OAKS_LAB, 8
	db $01,$31,Show
	db $02,$32,Show
	db $03,$33,Show
	db $04,$34,Show
	db $05,$35,Hide
	db $06,$36,Show
	db $07,$37,Show
	db $08,$38,Hide
MapHS2D:
	db VIRIDIAN_GYM, 2
	db $01,$39,Show
	db $0B,$3A,Show
MapHS34:
	db MUSEUM_1F, 1
	db $05,$3B,Show
MapHSE4:
	db CERULEAN_CAVE_1F, 3
	db $01,$3C,Show
	db $02,$3D,Show
	db $03,$3E,Show
MapHS8F:
	db POKEMON_TOWER_2F, 1
	db $01,$3F,Show
MapHS90:
	db POKEMON_TOWER_3F, 1
	db $04,$40,Show
MapHS91:
	db POKEMON_TOWER_4F, 3
	db $04,$41,Show
	db $05,$42,Show
	db $06,$43,Show
MapHS92:
	db POKEMON_TOWER_5F, 1
	db $06,$44,Show
MapHS93:
	db POKEMON_TOWER_6F, 2
	db $04,$45,Show
	db $05,$46,Show
MapHS94:
	db POKEMON_TOWER_7F, 4
	db $01,$47,Show
	db $02,$48,Show
	db $03,$49,Show
	db $04,$4A,Show
MapHS95:
	db CELADON_MANSION_ROOF_HOUSE, 1
	db $02,$4C,Show
MapHS87:
	db GAME_CORNER, 1
	db $0B,$4D,Show
MapHS9B:
	db WARDENS_HOUSE, 1
	db $02,$4E,Show
MapHSA5:
	db POKEMON_MANSION_1F, 2
	db $02,$4F,Show
	db $03,$50,Show
MapHSB1:
	db FIGHTING_DOJO, 2
	db $06,$51,Show
	db $07,$52,Show
MapHSB5:
	db SILPH_CO_1F, 3
	db $01,$53,Hide
	db $02,$54,Hide					; the ruleset for the Battle Facility = global index 84
	db $03,$55,Hide					; NPC for the Battle Facility shop
MapHS53:
	db POWER_PLANT, 15
	db $01,$56,Show
	db $02,$57,Show
	db $03,$58,Show
	db $04,$59,Show
	db $05,$5A,Show
	db $06,$5B,Show
	db $07,$5C,Show
	db $08,$5D,Show
	db $09,$5E,Show
	db $0A,$5F,Show
	db $0B,$60,Show
	db $0C,$61,Show
	db $0D,$62,Show					; TM_25 = global index 98
	db $0E,$63,Show					; TM_33 = global index 99
	db $1F,$01,Show
MapHSC2:
	db VICTORY_ROAD_2F, 6
	db $06,$64,Show					; MOLTRES
	db $07,$65,Show					; TM_17 = global index 101
	db $08,$66,Show
	db $09,$67,Show					; TM_27 = global index 103
	db $0A,$68,Show
	db $0D,$69,Show
MapHS58:
	db BILLS_HOUSE, 3
	db $01,$6A,Show
	db $02,$6B,Hide
	db $03,$6C,Hide
MapHS33:
	db VIRIDIAN_FOREST, 3
	db $05,$6D,Show
	db $06,$6E,Show
	db $07,$6F,Show
MapHS3B:
	db MT_MOON_1F, 6
	db $08,$70,Show
	db $09,$71,Show
	db $0A,$72,Show
	db $0B,$73,Show
	db $0C,$74,Show
	db $0D,$75,Show						; TM_34 = global index 117
MapHS3C:
	db MT_MOON_B1F, 2
	db $01,$76,Show
	db $02,$77,Show
MapHS3D:
	db MT_MOON_B2F, 5
	db $06,$78,Show
	db $07,$79,Show
	db $08,$7A,Show
	db $09,$7B,Show						; TM_01 = global index 123
	db $0a,$7C,Show						; TM_63 = global index 124
MapHS60:
	db SS_ANNE_2F, 1
	db $02,$7D,Hide
MapHS66:
	db SS_ANNE_1F_ROOMS, 1
	db $0A,$7E,Show						; TM_08 = global index 126
MapHS67:
	db SS_ANNE_2F_ROOMS, 2
	db $06,$7F,Show
	db $09,$80,Show
MapHS68:
	db SS_ANNE_B1F_ROOMS, 3
	db $09,$81,Show
	db $0A,$82,Show						; TM_44 = global index 130
	db $0B,$83,Show
MapHSC6:
	db VICTORY_ROAD_3F, 3
	db $05,$84,Show
	db $06,$85,Show						; TM_47 = global index 133
	db $0A,$86,Show
MapHS52:
	db ROCK_TUNNEL_1F, 3
	db $08,$87,Show						; TM_61 = global index 135
	db $09,$88,Show
	db $0a,$89,Show
MapHSE8:
	db ROCK_TUNNEL_B1F, 1
	db $09,$8A,Show						; TM_76 = global index 138
MapHSC7:
	db ROCKET_HIDEOUT_B1F, 2
	db $06,$8B,Show
	db $07,$8C,Show
MapHSC8:
	db ROCKET_HIDEOUT_B2F, 4
	db $02,$8D,Show
	db $03,$8E,Show
	db $04,$8F,Show						; TM_69 = global index 130
	db $05,$90,Show
MapHSC9:
	db ROCKET_HIDEOUT_B3F, 2
	db $03,$91,Show						; TM_10 = global index 132
	db $04,$92,Show
MapHSCA:
	db ROCKET_HIDEOUT_B4F, 6
	db $01,$93,Show
	db $05,$94,Show
	db $06,$95,Show						; TM_55 = global index 136
	db $07,$96,Show
	db $08,$97,Hide
	db $09,$98,Hide
MapHSCF:
	db SILPH_CO_2F, 5
	db $01,$99,Show
	db $02,$9A,Show
	db $03,$9B,Show
	db $04,$9C,Show
	db $05,$9D,Show
MapHSD0:
	db SILPH_CO_3F, 3
	db $02,$9E,Show
	db $03,$9F,Show
	db $04,$A0,Show
MapHSD1:
	db SILPH_CO_4F, 6
	db $02,$A1,Show
	db $03,$A2,Show
	db $04,$A3,Show
	db $05,$A4,Show
	db $06,$A5,Show
	db $07,$A6,Show
MapHSD2:
	db SILPH_CO_5F, 7
	db $02,$A7,Show
	db $03,$A8,Show
	db $04,$A9,Show
	db $05,$AA,Show
	db $06,$AB,Show						; TM_09 = global index 171
	db $07,$AC,Show
	db $08,$AD,Show						; Card Key = global index 173
MapHSD3:
	db SILPH_CO_6F, 5
	db $06,$AE,Show
	db $07,$AF,Show
	db $08,$B0,Show
	db $09,$B1,Show
	db $0A,$B2,Show
MapHSD4:
	db SILPH_CO_7F, 8
	db $05,$B3,Show
	db $06,$B4,Show
	db $07,$B5,Show
	db $08,$B6,Show
	db $09,$B7,Show
	db $0A,$B8,Show
	db $0B,$B9,Show						; TM_03 = global index 185
	db $0C,$BA,Show
MapHSD5:
	db SILPH_CO_8F, 3
	db $02,$BB,Show
	db $03,$BC,Show
	db $04,$BD,Show
MapHSE9:
	db SILPH_CO_9F, 3
	db $02,$BE,Show
	db $03,$BF,Show
	db $04,$C0,Show
MapHSEA:
	db SILPH_CO_10F, 6
	db $01,$C1,Show
	db $02,$C2,Show
	db $03,$C3,Show
	db $04,$C4,Show						; TM_26 = global index 196
	db $05,$C5,Show
	db $06,$C6,Show
MapHSEB:
	db SILPH_CO_11F, 3
	db $03,$C7,Show
	db $04,$C8,Show
	db $05,$C9,Show
MapHSF4:
	db UNUSED_MAP_F4, 1
	db $02,$CA,Show
MapHSD6:
	db POKEMON_MANSION_2F, 2
	db $02,$CB,Show
	db $05,$CC,Show
MapHSD7:
	db POKEMON_MANSION_3F, 2
	db $03,$CD,Show
	db $04,$CE,Show
MapHSD8:
	db POKEMON_MANSION_B1F, 5
	db $03,$CF,Show
	db $04,$D0,Show
	db $05,$D1,Show						; TM_14 = global index 210
	db $06,$D2,Show						; TM_22 = global index 211
	db $08,$D3,Show						; SECRET_KEY = global index 212
MapHSD9:
	db SAFARI_ZONE_EAST, 4
	db $01,$D4,Show
	db $02,$D5,Show
	db $03,$D6,Show
	db $04,$D7,Show						; TM_37 = global index 216
MapHSDA:
	db SAFARI_ZONE_NORTH, 2
	db $01,$D8,Show
	db $02,$D9,Show						; TM_41 = global index 218
MapHSDB:
	db SAFARI_ZONE_WEST, 4
	db $01,$DA,Show
	db $02,$DB,Show						; TM_32 = global index 220
	db $03,$DC,Show
	db $04,$DD,Show
MapHSDC:
	db SAFARI_ZONE_CENTER, 1
	db $01,$DE,Show
MapHSE2:
	db CERULEAN_CAVE_2F, 5
	db $01,$DF,Show
	db $02,$E0,Show
	db $03,$E1,Show
	db $04,$E2,Show						; TM_81 = global index 227
	db $05,$E3,Show
MapHSE3:
	db CERULEAN_CAVE_B1F, 3
	db $01,$E4,Show
	db $02,$E5,Show
	db $03,$E6,Show
MapHS6C:
	db VICTORY_ROAD_1F, 2
	db $03,$E7,Show						; TM_43 = global index 232
	db $04,$E8,Show
MapHS78:
	db CHAMPIONS_ROOM, 1
	db $02,$E9,Hide
MapHSC0:
	db SEAFOAM_ISLANDS_1F, 2
	db $01,$EA,Show
	db $02,$EB,Show
MapHS9F:
	db SEAFOAM_ISLANDS_B1F, 2
	db $01,$EC,Hide
	db $02,$ED,Hide
MapHSA0:
	db SEAFOAM_ISLANDS_B2F, 3
	db $01,$EE,Hide
	db $02,$EF,Hide
	db $03,$F0,Show
MapHSA1:
	db SEAFOAM_ISLANDS_B3F, 6
	db $02,$F1,Show
	db $03,$F2,Show
	db $05,$F3,Hide
	db $06,$F4,Hide
	db $07,$F5,Show
	db $08,$F6,Show
MapHSA2:
	db SEAFOAM_ISLANDS_B4F, 4
	db $01,$F7,Hide
	db $02,$F8,Hide
	db $03,$F9,Show
	db $04,$FA,Show
MapHSF8:
	db BATTLE_FACILITY, 1
	db $03,$FB,Hide

	db $FF
