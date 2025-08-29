; this is a list of the sprites that can be enabled/disabled during the game
; sprites marked with an X are constants that are never used
; because those sprites are not (de)activated in a map's script
; (they are either items or sprites that deactivate after battle
; and are detected in wMissableObjectList)

const_value = 0

	const HS_PALLET_TOWN_OAK               ; 00
	const HS_LYING_OLD_MAN                 ; 01
	const HS_OLD_MAN                       ; 02
	const HS_MUSEUM_GUY                    ; 03
	const HS_GYM_GUY                       ; 04
	const HS_CERULEAN_RIVAL                ; 05
	const HS_CERULEAN_ROCKET               ; 06 used it for the TMs menu (TM 28)
	const HS_CERULEAN_GUARD_1              ; 07
	const HS_CERULEAN_CAVE_GUY             ; 08
	const HS_CERULEAN_GUARD_2              ; 09
	const HS_SAFFRON_CITY_1                ; 0A
	const HS_SAFFRON_CITY_2                ; 0B
	const HS_SAFFRON_CITY_3                ; 0C
	const HS_SAFFRON_CITY_4                ; 0D
	const HS_SAFFRON_CITY_5                ; 0E
	const HS_SAFFRON_CITY_6                ; 0F
	const HS_SAFFRON_CITY_7                ; 10
	const HS_SAFFRON_CITY_8                ; 11
	const HS_SAFFRON_CITY_9                ; 12
	const HS_SAFFRON_CITY_A                ; 13
	const HS_SAFFRON_CITY_B                ; 14
	const HS_SAFFRON_CITY_C                ; 15
	const HS_SAFFRON_CITY_D                ; 16
	const HS_SAFFRON_CITY_E                ; 17
	const HS_SAFFRON_CITY_F                ; 18
	const HS_ROUTE_2_ITEM_1                ; 19 X
	const HS_ROUTE_2_ITEM_2                ; 1A X
	const HS_ROUTE_4_ITEM                  ; 1B X used it for the TMs menu (TM 04)
	const HS_ROUTE_6_ITEM                  ; 1C
	const HS_ROUTE_8_ITEM                  ; 1D
	const HS_ROUTE_9_ITEM                  ; 1E X used it for the TMs menu (TM 30)
	const HS_ROUTE_11_ITEM_1               ; 1F
	const HS_ROUTE_12_SNORLAX              ; 20 
	const HS_ROUTE_12_ITEM_1               ; 21 X used it for the TMs menu (TM 16)
	const HS_ROUTE_12_ITEM_2               ; 22 X
	const HS_ROUTE_13_ITEM_1               ; 23 X
	const HS_ROUTE_15_ITEM                 ; 24 X used it for the TMs menu (TM 20)
	const HS_ROUTE_16_SNORLAX              ; 25 
	const HS_ROUTE_16_ITEM_1               ; 26
	const HS_ROUTE_16_ITEM_2               ; 27
	const HS_ROUTE_21_ITEM_1               ; 28
	const HS_ROUTE_22_RIVAL_1              ; 29 
	const HS_ROUTE_22_RIVAL_2              ; 2A  
	const HS_NUGGET_BRIDGE_GUY             ; 2B 
	const HS_ROUTE_24_ITEM                 ; 2C X used it for the TMs menu (TM 45) 
	const HS_ROUTE_25_ITEM                 ; 2D X used it for the TMs menu (TM 19) 
	const HS_DAISY_SITTING                 ; 2E  
	const HS_DAISY_WALKING                 ; 2F  
	const HS_TOWN_MAP                      ; 30  
	const HS_OAKS_LAB_RIVAL                ; 31  
	const HS_STARTER_BALL_1                ; 32  
	const HS_STARTER_BALL_2                ; 33  
	const HS_STARTER_BALL_3                ; 34  
	const HS_OAKS_LAB_OAK_1                ; 35  
	const HS_POKEDEX_1                     ; 36  
	const HS_POKEDEX_2                     ; 37  
	const HS_OAKS_LAB_OAK_2                ; 38  X
	const HS_VIRIDIAN_GYM_GIOVANNI         ; 39  
	const HS_VIRIDIAN_GYM_ITEM             ; 3A  X
	const HS_OLD_AMBER                     ; 3B  X
	const HS_CERULEAN_CAVE_1F_ITEM_1       ; 3C  X
	const HS_CERULEAN_CAVE_1F_ITEM_2       ; 3D  
	const HS_CERULEAN_CAVE_1F_ITEM_3       ; 3E  X
	const HS_POKEMON_TOWER_2F_RIVAL        ; 3F  X
	const HS_POKEMON_TOWER_3F_ITEM         ; 40  X
	const HS_POKEMON_TOWER_4F_ITEM_1       ; 41  X
	const HS_POKEMON_TOWER_4F_ITEM_2       ; 42  X
	const HS_POKEMON_TOWER_4F_ITEM_3       ; 43  X
	const HS_POKEMON_TOWER_5F_ITEM         ; 44  X
	const HS_POKEMON_TOWER_6F_ITEM_1       ; 45  X
	const HS_POKEMON_TOWER_6F_ITEM_2       ; 46  X
	const HS_POKEMON_TOWER_7F_ROCKET_1     ; 47  X
	const HS_POKEMON_TOWER_7F_ROCKET_2     ; 48  
	const HS_POKEMON_TOWER_7F_ROCKET_3     ; 49  
	const HS_POKEMON_TOWER_7F_MR_FUJI      ; 4A  
	const HS_MR_FUJIS_HOUSE_MR_FUJI        ; 4B  
	const HS_CELADON_MANSION_EEVEE_GIFT    ; 4C  X
	const HS_GAME_CORNER_ROCKET            ; 4D  X
	const HS_WARDENS_HOUSE_ITEM            ; 4E  X
	const HS_POKEMON_MANSION_1F_ITEM_1     ; 4F  
	const HS_POKEMON_MANSION_1F_ITEM_2     ; 50  
	const HS_FIGHTING_DOJO_GIFT_1          ; 51  
	const HS_FIGHTING_DOJO_GIFT_2          ; 52  X
	const HS_SILPH_CO_1F_RECEPTIONIST      ; 53  X
	const HS_SILPH_CO_1F_1                 ; 54 Battle Facility rules
	const HS_SILPH_CO_1F_CLERK             ; 55 NPC for the Battle Facility shop
	const HS_VOLTORB_1                     ; 56  X
	const HS_VOLTORB_2                     ; 57  X
	const HS_VOLTORB_3                     ; 58  X
	const HS_ELECTRODE_1                   ; 59  X
	const HS_VOLTORB_4                     ; 5A  X
	const HS_VOLTORB_5                     ; 5B  X
	const HS_ELECTRODE_2                   ; 5C  X
	const HS_VOLTORB_6                     ; 5D  X
	const HS_ZAPDOS                        ; 5E  X
	const HS_POWER_PLANT_ITEM_1            ; 5F  X used it for the TMs menu (TM 25)
	const HS_POWER_PLANT_ITEM_2            ; 60  X used it for the TMs menu (TM 33)
	const HS_POWER_PLANT_ITEM_3            ; 61  X
	const HS_POWER_PLANT_ITEM_4            ; 62  X used it for the TMs menu (TM 62)
	const HS_POWER_PLANT_ITEM_5            ; 63  X
	const HS_MOLTRES                       ; 64  X
	const HS_VICTORY_ROAD_2F_ITEM_1        ; 65  
	const HS_VICTORY_ROAD_2F_ITEM_2        ; 66  
	const HS_VICTORY_ROAD_2F_ITEM_3        ; 67 used it for the TMs menu (TM 27)
	const HS_VICTORY_ROAD_2F_ITEM_4        ; 68  
	const HS_VICTORY_ROAD_2F_BOULDER       ; 69  X
	const HS_BILL_POKEMON                  ; 6A  X
	const HS_BILL_1                        ; 6B  X
	const HS_BILL_2                        ; 6C  X
	const HS_VIRIDIAN_FOREST_ITEM_1        ; 6D  X
	const HS_VIRIDIAN_FOREST_ITEM_2        ; 6E  X
	const HS_VIRIDIAN_FOREST_ITEM_3        ; 6F  X
	const HS_MT_MOON_1F_ITEM_1             ; 70  X
	const HS_MT_MOON_1F_ITEM_2             ; 71  X used it for the TMs menu (TM 34)
	const HS_MT_MOON_1F_ITEM_3             ; 72  
	const HS_MT_MOON_1F_ITEM_4             ; 73  
	const HS_MT_MOON_1F_ITEM_5             ; 74
	const HS_MT_MOON_1F_ITEM_6             ; 75
	const HS_MT_MOON_B1F_BOULDER_1         ; 76 
	const HS_MT_MOON_B1F_BOULDER_2         ; 77 
	const HS_MT_MOON_B2F_FOSSIL_1          ; 78  X 
	const HS_MT_MOON_B2F_FOSSIL_2          ; 79  X  
	const HS_MT_MOON_B2F_ITEM_1            ; 7A
	const HS_MT_MOON_B2F_ITEM_2            ; 7B used it for the TMs menu (TM 63)
	const HS_MT_MOON_B2F_ITEM_3            ; 7C used it for the TMs menu (TM 01)
	const HS_SS_ANNE_2F_RIVAL              ; 7D  
	const HS_SS_ANNE_1F_ROOMS_ITEM         ; 7E X used it for the TMs menu (TM 44) 
	const HS_SS_ANNE_2F_ROOMS_ITEM_1       ; 7F X 
	const HS_SS_ANNE_2F_ROOMS_ITEM_2       ; 80 X 
	const HS_SS_ANNE_B1F_ROOMS_ITEM_1      ; 81 X used it for the TMs menu (TM 47) 
	const HS_SS_ANNE_B1F_ROOMS_ITEM_2      ; 82 X 
	const HS_SS_ANNE_B1F_ROOMS_ITEM_3      ; 83 X 
	const HS_VICTORY_ROAD_3F_ITEM_1        ; 84 X
	const HS_VICTORY_ROAD_3F_ITEM_2        ; 85 X
	const HS_VICTORY_ROAD_3F_BOULDER       ; 86
	const HS_ROCK_TUNNEL_ITEM_1            ; 87
	const HS_ROCK_TUNNEL_BOULDER_1         ; 88 X
	const HS_ROCK_TUNNEL_BOULDER_2         ; 89  
	const HS_ROCK_TUNNEL_ITEM_2            ; 8A  
	const HS_ROCKET_HIDEOUT_B1F_ITEM_1     ; 8B X 
	const HS_ROCKET_HIDEOUT_B1F_ITEM_2     ; 8C X used it for the TMs menu (TM 10) 
	const HS_ROCKET_HIDEOUT_B2F_ITEM_1     ; 8D X 
	const HS_ROCKET_HIDEOUT_B2F_ITEM_2     ; 8E X 
	const HS_ROCKET_HIDEOUT_B2F_ITEM_3     ; 8F X used it for the TMs menu (TM 02) 
	const HS_ROCKET_HIDEOUT_B2F_ITEM_4     ; 90 X used it for the TMs menu (TM 07) 
	const HS_ROCKET_HIDEOUT_B3F_ITEM_1     ; 91 used it for the Key Items menu (Silph Scope) 
	const HS_ROCKET_HIDEOUT_B3F_ITEM_2     ; 92 used it for the Key Items menu (Lift Key) 
	const HS_ROCKET_HIDEOUT_B4F_GIOVANNI   ; 93 XXX never (de)activated? 
	const HS_ROCKET_HIDEOUT_B4F_ITEM_1     ; 94  
	const HS_ROCKET_HIDEOUT_B4F_ITEM_2     ; 95  
	const HS_ROCKET_HIDEOUT_B4F_ITEM_3     ; 96
	const HS_ROCKET_HIDEOUT_B4F_ITEM_4     ; 97
	const HS_ROCKET_HIDEOUT_B4F_ITEM_5     ; 98    
	const HS_SILPH_CO_2F_1                 ; 99  
	const HS_SILPH_CO_2F_2                 ; 9A  
	const HS_SILPH_CO_2F_3                 ; 9B  
	const HS_SILPH_CO_2F_4                 ; 9C X 
	const HS_SILPH_CO_2F_5                 ; 9D  
	const HS_SILPH_CO_3F_1                 ; 9E  
	const HS_SILPH_CO_3F_2                 ; 9F  
	const HS_SILPH_CO_3F_ITEM              ; A0 X 
	const HS_SILPH_CO_4F_1                 ; A1 X 
	const HS_SILPH_CO_4F_2                 ; A2 X 
	const HS_SILPH_CO_4F_3                 ; A3  
	const HS_SILPH_CO_4F_ITEM_1            ; A4  
	const HS_SILPH_CO_4F_ITEM_2            ; A5  
	const HS_SILPH_CO_4F_ITEM_3            ; A6  
	const HS_SILPH_CO_5F_1                 ; A7  
	const HS_SILPH_CO_5F_2                 ; A8  
	const HS_SILPH_CO_5F_3                 ; A9 X used it for the TMs menu (TM 09) 
	const HS_SILPH_CO_5F_4                 ; AA X 
	const HS_SILPH_CO_5F_ITEM_1            ; AB X used it for the Key Items menu (Card Key) 
	const HS_SILPH_CO_5F_ITEM_2            ; AC  
	const HS_SILPH_CO_5F_ITEM_3            ; AD  
	const HS_SILPH_CO_6F_1                 ; AE  
	const HS_SILPH_CO_6F_2                 ; AF X 
	const HS_SILPH_CO_6F_3                 ; B0 X 
	const HS_SILPH_CO_6F_ITEM_1            ; B1  
	const HS_SILPH_CO_6F_ITEM_2            ; B2  
	const HS_SILPH_CO_7F_1                 ; B3  
	const HS_SILPH_CO_7F_2                 ; B4  
	const HS_SILPH_CO_7F_3                 ; B5  
	const HS_SILPH_CO_7F_4                 ; B6 X 
	const HS_SILPH_CO_7F_RIVAL             ; B7 X
	const HS_SILPH_CO_7F_ITEM_1            ; B8 XXX sprite doesn't exist 
	const HS_SILPH_CO_7F_ITEM_2            ; B9 used it for the TMs menu (TM 03) 
	const HS_SILPH_CO_7F_8                 ; BA  
	const HS_SILPH_CO_8F_1                 ; BB  
	const HS_SILPH_CO_8F_2                 ; BC  
	const HS_SILPH_CO_8F_3                 ; BD  
	const HS_SILPH_CO_9F_1                 ; BE  
	const HS_SILPH_CO_9F_2                 ; BF used it for the TMs menu (TM 26) 
	const HS_SILPH_CO_9F_3                 ; C0  
	const HS_SILPH_CO_10F_1                ; C1 XXX never (de)activated? 
	const HS_SILPH_CO_10F_2                ; C2 X 
	const HS_SILPH_CO_10F_3                ; C3 X 
	const HS_SILPH_CO_10F_ITEM_1           ; C4 X 
	const HS_SILPH_CO_10F_ITEM_2           ; C5  
	const HS_SILPH_CO_10F_ITEM_3           ; C6  
	const HS_SILPH_CO_11F_1                ; C7  
	const HS_SILPH_CO_11F_2                ; C8
	const HS_SILPH_CO_11F_3                ; C9 X 
	const HS_UNUSED_MAP_F4_1               ; CA 
	const HS_POKEMON_MANSION_2F_ITEM       ; CB X
	const HS_POKEMON_MANSION_2F_ITEM_2     ; CC X 
	const HS_POKEMON_MANSION_3F_ITEM_1     ; CD X 
	const HS_POKEMON_MANSION_3F_ITEM_2     ; CE X 
	const HS_POKEMON_MANSION_B1F_ITEM_1    ; CF X used it for the TMs menu (TM 14) 
	const HS_POKEMON_MANSION_B1F_ITEM_2    ; D0 X used it for the TMs menu (TM 22) 
	const HS_POKEMON_MANSION_B1F_ITEM_3    ; D1 X used it for the Key Items menu (Secret Key) 
	const HS_POKEMON_MANSION_B1F_ITEM_4    ; D2 X 
	const HS_POKEMON_MANSION_B1F_ITEM_5    ; D3 X 
	const HS_SAFARI_ZONE_EAST_ITEM_1       ; D4 X 
	const HS_SAFARI_ZONE_EAST_ITEM_2       ; D5 X used it for the TMs menu (TM 37) 
	const HS_SAFARI_ZONE_EAST_ITEM_3       ; D6 X 
	const HS_SAFARI_ZONE_EAST_ITEM_4       ; D7 X used it for the TMs menu (TM 40) 
	const HS_SAFARI_ZONE_NORTH_ITEM_1      ; D8 X 
	const HS_SAFARI_ZONE_NORTH_ITEM_2      ; D9 X used it for the TMs menu (TM 32) 
	const HS_SAFARI_ZONE_WEST_ITEM_1       ; DA X 
	const HS_SAFARI_ZONE_WEST_ITEM_2       ; DB X used it for the Key Items menu (Gold Teeth) 
	const HS_SAFARI_ZONE_WEST_ITEM_3       ; DC X 
	const HS_SAFARI_ZONE_WEST_ITEM_4       ; DD X 
	const HS_SAFARI_ZONE_CENTER_ITEM       ; DE X 
	const HS_CERULEAN_CAVE_2F_ITEM_1       ; DF X 
	const HS_CERULEAN_CAVE_2F_ITEM_2       ; E0 X
	const HS_CERULEAN_CAVE_2F_ITEM_3       ; E1 X
	const HS_CERULEAN_CAVE_2F_ITEM_4       ; E2 
	const HS_CERULEAN_CAVE_2F_BOULDER_1    ; E3 X 
	const HS_MEWTWO                        ; E4 X
	const HS_CERULEAN_CAVE_B1F_ITEM_1      ; E5 X 
	const HS_CERULEAN_CAVE_B1F_ITEM_2      ; E6  
	const HS_VICTORY_ROAD_1F_ITEM_1        ; E7 used it for the TMs menu (TM 43)  
	const HS_VICTORY_ROAD_1F_ITEM_2        ; E8  
	const HS_CHAMPIONS_ROOM_OAK            ; E9 
	const HS_SEAFOAM_ISLANDS_1F_BOULDER_1  ; EA  
	const HS_SEAFOAM_ISLANDS_1F_BOULDER_2  ; EB  
	const HS_SEAFOAM_ISLANDS_B1F_BOULDER_1 ; EC  
	const HS_SEAFOAM_ISLANDS_B1F_BOULDER_2 ; ED  
	const HS_SEAFOAM_ISLANDS_B2F_BOULDER_1 ; EE  
	const HS_SEAFOAM_ISLANDS_B2F_BOULDER_2 ; EF  
	const HS_SEAFOAM_ISLANDS_B2F_ITEM_1    ; F0
	const HS_SEAFOAM_ISLANDS_B3F_BOULDER_1 ; F1 
	const HS_SEAFOAM_ISLANDS_B3F_BOULDER_2 ; F2  
	const HS_SEAFOAM_ISLANDS_B3F_BOULDER_3 ; F3 
	const HS_SEAFOAM_ISLANDS_B3F_BOULDER_4 ; F4 
	const HS_SEAFOAM_ISLANDS_B3F_ITEM_1    ; F5
	const HS_SEAFOAM_ISLANDS_B3F_BOULDER_5 ; F6
	const HS_SEAFOAM_ISLANDS_B4F_BOULDER_1 ; F7  
	const HS_SEAFOAM_ISLANDS_B4F_BOULDER_2 ; F8
	const HS_ARTICUNO                      ; F9
	const HS_SEAFOAM_ISLANDS_B4F_ITEM_1    ; FA
	const HS_BATTLE_FACILITY_OPPONENT      ; FB the opponent's sprite in the Battle Facility
