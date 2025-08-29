; tentative move effect constants
; {stat}_(UP|DOWN)(1|2) means that the move raises the user's (or lowers the target's) corresponding stat modifier by 1 (or 2) stages
; {status condition}_side_effect means that the move has a side chance of causing that condition
; {status condition}_effect means that the move causes the status condition every time it hits the target
const_value = 0

	const NO_ADDITIONAL_EFFECT             ; $00
	const REST_EFFECT                      ; $01 use this previously unused id for REST
	const POISON_SIDE_EFFECT1              ; $02 10% chance to poison
	const DRAIN_HP_EFFECT                  ; $03
	const BURN_SIDE_EFFECT1                ; $04
	const FREEZE_SIDE_EFFECT               ; $05
	const PARALYZE_SIDE_EFFECT1            ; $06
	const EXPLODE_EFFECT                   ; $07 Explosion, Self Destruct
	const DREAM_EATER_EFFECT               ; $08
	const MIRROR_MOVE_EFFECT               ; $09
	const ATTACK_UP1_EFFECT                ; $0A
	const DEFENSE_UP1_EFFECT               ; $0B
	const SPEED_UP1_EFFECT                 ; $0C
	const SPECIAL_ATTACK_UP1_EFFECT        ; $0D
	const SPECIAL_DEFENSE_UP1_EFFECT       ; $0E
	const ACCURACY_UP1_EFFECT              ; $0F
	const EVASION_UP1_EFFECT               ; $10
	const PAY_DAY_EFFECT                   ; $11
	const ALWAYS_HIT_EFFECT                ; $12
	const ATTACK_DOWN1_EFFECT              ; $13
	const DEFENSE_DOWN1_EFFECT             ; $14
	const SPEED_DOWN1_EFFECT               ; $15
	const SPECIAL_ATTACK_DOWN1_EFFECT      ; $16
	const SPECIAL_DEFENSE_DOWN1_EFFECT     ; $17
	const ACCURACY_DOWN1_EFFECT            ; $18
	const EVASION_DOWN1_EFFECT             ; $19
	const CONVERSION_EFFECT                ; $1A
	const HAZE_EFFECT                      ; $1B
	const BIDE_EFFECT                      ; $1C
	const THRASH_PETAL_DANCE_EFFECT        ; $1D
	const EJECT_EFFECT                     ; $1E Roar and Whirlwind effect
	const TWO_TO_FIVE_ATTACKS_EFFECT       ; $1F
	const UNUSED_EFFECT_1E                 ; $20
	const FLINCH_SIDE_EFFECT1              ; $21 10% chance to flinch
	const SLEEP_EFFECT                     ; $22
	const POISON_SIDE_EFFECT2              ; $23 20% chance to poison
	const BURN_SIDE_EFFECT2                ; $24
	const UNUSED_EFFECT_23                 ; $25
	const PARALYZE_SIDE_EFFECT2            ; $26
	const FLINCH_SIDE_EFFECT2              ; $27 20% chance to flinch
	const OHKO_EFFECT                      ; $28 moves like Horn Drill
	const CHARGE_EFFECT                    ; $29 moves like Solar Beam
	const SUPER_FANG_EFFECT                ; $2A
	const LEVEL_DAMAGE_EFFECT              ; $2B Seismic Toss, Night Shade
	const TRAPPING_SIDE_EFFECT             ; $2C moves like Wrap
	const INVULNERABLE_EFFECT              ; $2D moves like FLY, DIG
	const ATTACK_TWICE_EFFECT              ; $2E
	const JUMP_KICK_EFFECT                 ; $2F Jump Kick and Hi Jump Kick effect
	const MIST_EFFECT                      ; $30
	const FOCUS_ENERGY_EFFECT              ; $31
	const RECOIL_EFFECT                    ; $32 moves like Double Edge
	const CONFUSION_EFFECT                 ; $33 Confuse Ray, Supersonic (not the move Confusion)
	const ATTACK_UP2_EFFECT                ; $34
	const DEFENSE_UP2_EFFECT               ; $35
	const SPEED_UP2_EFFECT                 ; $36
	const SPECIAL_ATTACK_UP2_EFFECT        ; $37
	const SPECIAL_DEFENSE_UP2_EFFECT       ; $38
	const ACCURACY_UP2_EFFECT              ; $39
	const EVASION_UP2_EFFECT               ; $3A
	const HEAL_EFFECT                      ; $3B Recover, Softboiled
	const TRANSFORM_EFFECT                 ; $3C
	const ATTACK_DOWN2_EFFECT              ; $3D
	const DEFENSE_DOWN2_EFFECT             ; $3E
	const SPEED_DOWN2_EFFECT               ; $3F
	const SPECIAL_ATTACK_DOWN2_EFFECT      ; $40
	const SPECIAL_DEFENSE_DOWN2_EFFECT     ; $41
	const ACCURACY_DOWN2_EFFECT            ; $42
	const EVASION_DOWN2_EFFECT             ; $43
	const LIGHT_SCREEN_EFFECT              ; $44
	const REFLECT_EFFECT                   ; $45
	const POISON_EFFECT                    ; $46
	const PARALYZE_EFFECT                  ; $47
	const ATTACK_DOWN_SIDE_EFFECT          ; $48
	const DEFENSE_DOWN_SIDE_EFFECT         ; $49
	const SPEED_DOWN_SIDE_EFFECT           ; $4A
	const SPECIAL_ATTACK_DOWN_SIDE_EFFECT  ; $4B
	const SPECIAL_DEFENSE_DOWN_SIDE_EFFECT ; $4C
	const UNUSED_EFFECT_48                 ; $4D
	const UNUSED_EFFECT_49                 ; $4E
	const UNUSED_EFFECT_4A                 ; $4F
	const UNUSED_EFFECT_4B                 ; $50
	const CONFUSION_SIDE_EFFECT            ; $51
	const TWINEEDLE_EFFECT                 ; $52
	const UNUSED_EFFECT_4E                 ; $53
	const SUBSTITUTE_EFFECT                ; $54
	const HYPER_BEAM_EFFECT                ; $55
	const RAGE_EFFECT                      ; $56
	const MIMIC_EFFECT                     ; $57
	const METRONOME_EFFECT                 ; $58
	const LEECH_SEED_EFFECT                ; $59
	const SPLASH_EFFECT                    ; $5A
	const DISABLE_EFFECT                   ; $5B
	const FIXED_DAMAGE_EFFECT              ; $5C fixed damage moves (Dragon Rage, Sonicboom)
	const PSYWAVE_EFFECT                   ; $5D
	const TELEPORT_EFFECT                  ; $5E
	const STRUGGLE_EFFECT                  ; $5F
	const BAD_POISON_EFFECT                ; $60
	const COUNTER_EFFECT                   ; $61 Counter/Mirror Coat
	const SKY_ATTACK_EFFECT                ; $62
	const SKULL_BASH_EFFECT                ; $63
	const TRI_ATTACK_EFFECT                ; $64
	const WEIGHT_DAMAGE_EFFECT             ; $65 moves that do damage depending on the target's weight

; effects that are handled in a different bank
	const ATTACK_DOWN_SIDE_EFFECT2         	       ; $66 moves that do damage and drop attack 100% of the time
	const DEFENSE_DOWN_SIDE_EFFECT2        	       ; $67 moves that do damage and drop defense 100% of the time
	const SPEED_DOWN_SIDE_EFFECT2          	       ; $68 moves that do damage and drop speed 100% of the time
	const SPECIAL_ATTACK_DOWN_SIDE_EFFECT2 	       ; $69 moves that do damage and drop sp.atk 100% of the time
	const SPECIAL_DEFENSE_DOWN_SIDE_EFFECT2	       ; $6A moves that do damage and drop sp.def 100% of the time
	const ACCURACY_DOWN_SIDE_EFFECT2       	       ; $6B moves that do damage and drop accuracy 100% of the time
	const EVASION_DOWN_SIDE_EFFECT2        	       ; $6C moves that do damage and drop evasion 100% of the time

	const ATTACK_DEFENSE_UP_EFFECT                 ; $6D moves that boost both attack and defense
	const ATTACK_SPEED_UP_EFFECT                   ; $6E moves that boost both attack and speed
	const ATTACK_SPECIAL_ATTACK_UP_EFFECT          ; $6F moves that boost both attack and sp.atk
	const ATTACK_SPECIAL_DEFENSE_UP_EFFECT         ; $70 moves that boost both attack and sp.def
	const ATTACK_ACCURACY_UP_EFFECT                ; $71 moves that boost both attack and accuracy
	const ATTACK_EVASION_UP_EFFECT                 ; $72 moves that boost both attack and evasion
	const DEFENSE_SPEED_UP_EFFECT                  ; $73 moves that boost both defense and speed
	const DEFENSE_SPECIAL_ATTACK_UP_EFFECT         ; $74 moves that boost both defense and sp.atk
	const DEFENSE_SPECIAL_DEFENSE_UP_EFFECT        ; $75 moves that boost both defense and sp.def
	const DEFENSE_ACCURACY_UP_EFFECT               ; $76 moves that boost both defense and accuracy
	const DEFENSE_EVASION_UP_EFFECT                ; $77 moves that boost both defense and evasion
	const SPEED_SPECIAL_ATTACK_UP_EFFECT           ; $78 moves that boost both speed and sp.atk
	const SPEED_SPECIAL_DEFENSE_UP_EFFECT          ; $79 moves that boost both speed and sp.def
	const SPEED_ACCURACY_UP_EFFECT                 ; $7A moves that boost both speed and accuracy
	const SPEED_EVASION_UP_EFFECT                  ; $7B moves that boost both speed and evasion
	const SPECIAL_ATTACK_SPECIAL_DEFENSE_UP_EFFECT ; $7C moves that boost both sp.atk and sp.def
	const SPECIAL_ATTACK_ACCURACY_UP_EFFECT        ; $7D moves that boost both sp.atk and accuracy
	const SPECIAL_ATTACK_EVASION_UP_EFFECT         ; $7E moves that boost both sp.atk and evasion
	const SPECIAL_DEFENSE_ACCURACY_UP_EFFECT       ; $7F moves that boost both sp.def and accuracy
	const SPECIAL_DEFENSE_EVASION_UP_EFFECT        ; $80 moves that boost both sp.def and evasion
	const ACCURACY_EVASION_UP_EFFECT               ; $81 moves that boost both accuracy and evasion

	const ATTACK_UP_SIDE_EFFECT            ; $82 moves that do damage and boost attack 100% of the time
	const DEFENSE_UP_SIDE_EFFECT           ; $83 moves that do damage and boost defense 100% of the time
	const SPEED_UP_SIDE_EFFECT             ; $84 moves that do damage and boost speed 100% of the time
	const SPECIAL_ATTACK_UP_SIDE_EFFECT    ; $85 moves that do damage and boost sp.atk 100% of the time
	const SPECIAL_DEFENSE_UP_SIDE_EFFECT   ; $86 moves that do damage and boost sp.def 100% of the time
	const ACCURACY_UP_SIDE_EFFECT          ; $87 moves that do damage and boost accuracy 100% of the time
	const EVASION_UP_SIDE_EFFECT           ; $88 moves that do damage and boost evasion 100% of the time

	const ATTACK_UP_SIDE_EFFECT2           ; $89 moves that do damage and boost attack 70% of the time
	const DEFENSE_UP_SIDE_EFFECT2          ; $8A moves that do damage and boost defense 70% of the time
	const SPEED_UP_SIDE_EFFECT2            ; $8B moves that do damage and boost speed 70% of the time
	const SPECIAL_ATTACK_UP_SIDE_EFFECT2   ; $8C moves that do damage and boost sp.atk 70% of the time
	const SPECIAL_DEFENSE_UP_SIDE_EFFECT2  ; $8D moves that do damage and boost sp.def 70% of the time
	const ACCURACY_UP_SIDE_EFFECT2         ; $8E moves that do damage and boost accuracy 70% of the time
	const EVASION_UP_SIDE_EFFECT2          ; $8F moves that do damage and boost evasion 70% of the time

	const ATTACK_DOWN2_RECOIL_EFFECT          ; $90 moves that do damage and reduce user's attack by 2 stages
	const DEFENSE_DOWN2_RECOIL_EFFECT         ; $91 moves that do damage and reduce user's defense by 2 stages
	const SPEED_DOWN2_RECOIL_EFFECT           ; $92 moves that do damage and reduce user's speed by 2 stages
	const SPECIAL_ATTACK_DOWN2_RECOIL_EFFECT  ; $93 moves that do damage and reduce user's sp.atk by 2 stages
	const SPECIAL_DEFENSE_DOWN2_RECOIL_EFFECT ; $94 moves that do damage and reduce user's sp.def by 2 stages
	const ACCURACY_DOWN2_RECOIL_EFFECT        ; $95 moves that do damage and reduce user's accuracy by 2 stages
	const EVASION_DOWN2_RECOIL_EFFECT         ; $96 moves that do damage and reduce user's evasion by 2 stages

	const ATTACK_UP_SIDE_EFFECT3           ; $97 moves that do damage and boost attack 20% of the time
	const DEFENSE_UP_SIDE_EFFECT3          ; $98 moves that do damage and boost defense 20% of the time
	const SPEED_UP_SIDE_EFFECT3            ; $99 moves that do damage and boost speed 20% of the time
	const SPECIAL_ATTACK_UP_SIDE_EFFECT3   ; $9A moves that do damage and boost sp.atk 20% of the time
	const SPECIAL_DEFENSE_UP_SIDE_EFFECT3  ; $9B moves that do damage and boost sp.def 20% of the time
	const ACCURACY_UP_SIDE_EFFECT3         ; $9C moves that do damage and boost accuracy 20% of the time
	const EVASION_UP_SIDE_EFFECT3          ; $9D moves that do damage and boost evasion 20% of the time

	const ATTACK_DEFENSE_DOWN_RECOIL_EFFECT                 ; $9E moves that do damage and reduce the user's attack and defense
	const ATTACK_SPEED_DOWN_RECOIL_EFFECT                   ; $9F moves that do damage and reduce the user's attack and speed
	const ATTACK_SPECIAL_ATTACK_DOWN_RECOIL_EFFECT          ; $A0 moves that do damage and reduce the user's attack and sp.atk
	const ATTACK_SPECIAL_DEFENSE_DOWN_RECOIL_EFFECT         ; $A1 moves that do damage and reduce the user's attack and sp.def
	const ATTACK_ACCURACY_DOWN_RECOIL_EFFECT                ; $A2 moves that do damage and reduce the user's attack and accuracy
	const ATTACK_EVASION_DOWN_RECOIL_EFFECT                 ; $A3 moves that do damage and reduce the user's attack and evasion
	const DEFENSE_SPEED_DOWN_RECOIL_EFFECT                  ; $A4 moves that do damage and reduce the user's defense and speed
	const DEFENSE_SPECIAL_ATTACK_DOWN_RECOIL_EFFECT         ; $A5 moves that do damage and reduce the user's defense and sp.atk
	const DEFENSE_SPECIAL_DEFENSE_DOWN_RECOIL_EFFECT        ; $A6 moves that do damage and reduce the user's defense and sp.def
	const DEFENSE_ACCURACY_DOWN_RECOIL_EFFECT               ; $A7 moves that do damage and reduce the user's defense and accuracy
	const DEFENSE_EVASION_DOWN_RECOIL_EFFECT                ; $A8 moves that do damage and reduce the user's defense and evasion
	const SPEED_SPECIAL_ATTACK_DOWN_RECOIL_EFFECT           ; $A9 moves that do damage and reduce the user's speed and sp.atk
	const SPEED_SPECIAL_DEFENSE_DOWN_RECOIL_EFFECT          ; $AA moves that do damage and reduce the user's speed and sp.def
	const SPEED_ACCURACY_DOWN_RECOIL_EFFECT                 ; $AB moves that do damage and reduce the user's speed and accuracy
	const SPEED_EVASION_DOWN_RECOIL_EFFECT                  ; $AC moves that do damage and reduce the user's speed and evasion
	const SPECIAL_ATTACK_SPECIAL_DEFENSE_DOWN_RECOIL_EFFECT ; $AD moves that do damage and reduce the user's sp.atk and sp.def
	const SPECIAL_ATTACK_ACCURACY_DOWN_RECOIL_EFFECT        ; $AE moves that do damage and reduce the user's sp.atk and accuracy
	const SPECIAL_ATTACK_EVASION_DOWN_RECOIL_EFFECT         ; $AF moves that do damage and reduce the user's sp.atk and evasion
	const SPECIAL_DEFENSE_ACCURACY_DOWN_RECOIL_EFFECT       ; $B0 moves that do damage and reduce the user's sp.def and accuracy
	const SPECIAL_DEFENSE_EVASION_DOWN_RECOIL_EFFECT        ; $B1 moves that do damage and reduce the user's sp.def and evasion
	const ACCURACY_EVASION_DOWN_RECOIL_EFFECT               ; $B2 moves that do damage and reduce the user's accuracy and evasion
	
	const QUIVER_DANCE_EFFECT								; $B3 increases Special Attack, Special Defense and Speed by 1 stage
	
	const ALL_STATS_UP_EFFECT								; $B4 moves that do damage and boost all stats 10% of the time
	
	const REVENGE_EFFECT									; $B5 moves that do double damage if the user was hit during the turn

	const ATTACK_DOWN_SIDE_EFFECT3							; $B6 moves that do damage and drop attack 20% of the time
	const DEFENSE_DOWN_SIDE_EFFECT3							; $B7 moves that do damage and drop defense 20% of the time
	const SPEED_DOWN_SIDE_EFFECT3							; $B8 moves that do damage and drop speed 20% of the time
	const SPECIAL_ATTACK_DOWN_SIDE_EFFECT3					; $B9 moves that do damage and drop sp.atk 20% of the time
	const SPECIAL_DEFENSE_DOWN_SIDE_EFFECT3					; $BA moves that do damage and drop sp.def 20% of the time
	const ACCURACY_DOWN_SIDE_EFFECT3						; $BB moves that do damage and drop accuracy 20% of the time
	const EVASION_DOWN_SIDE_EFFECT3							; $BC moves that do damage and drop evasion 20% of the time
	
	const ATTACK_DOWN_SIDE_EFFECT4							; $BD moves that do damage and drop attack 30% of the time
	const DEFENSE_DOWN_SIDE_EFFECT4							; $BE moves that do damage and drop defense 30% of the time
	const SPEED_DOWN_SIDE_EFFECT4							; $BF moves that do damage and drop speed 30% of the time
	const SPECIAL_ATTACK_DOWN_SIDE_EFFECT4					; $C0 moves that do damage and drop sp.atk 30% of the time
	const SPECIAL_DEFENSE_DOWN_SIDE_EFFECT4					; $C1 moves that do damage and drop sp.def 30% of the time
	const ACCURACY_DOWN_SIDE_EFFECT4						; $C2 moves that do damage and drop accuracy 30% of the time
	const EVASION_DOWN_SIDE_EFFECT4							; $C3 moves that do damage and drop evasion 30% of the time

	const FLINCH_SIDE_EFFECT3								; $C4 30% chance to flinch
	const DRAIN_HP_EFFECT2									; $C5 drains 75% of the damage inflicted
	const FLINCH_BURN_SIDE_EFFECT							; $C6 for Fire Fang
	const FLINCH_PARALYZE_SIDE_EFFECT						; $C7 for Thunder Fang
	const FLINCH_FREEZE_SIDE_EFFECT							; $C8 for Ice Fang
	const BURN_EFFECT										; $C9 for Will-O-Wisp
	const RECOIL_EFFECT2									; $CA for moves that do 1/3 recoil damage
	const RECOIL_EFFECT3									; $CB for moves that do 1/2 recoil damage
	const FLARE_BLITZ_EFFECT								; $CC 10% chance to burn + 1/3 recoil damage
	const BRICK_BREAK_EFFECT								; $CD breaks protective walls (Light Screen, Reflect)
	const BAD_POISON_SIDE_EFFECT							; $CE 50% chance to badly poison the target (Poison Fang)
	const POISON_SIDE_EFFECT3								; $CF 40% chance to poison the target
	const CONFUSION_SIDE_EFFECT2							; $D0 20% chance to confuse the target
	const CONFUSION_SIDE_EFFECT3							; $D1 30% chance to confuse the target
	const PSYSHOCK_EFFECT									; $D2 uses target's physical Defense even if the move is Special
	const HEX_EFFECT										; $D3 double damage if the target already has a status condition
	const VENOSHOCK_EFFECT									; $D4 double damage if the target is already poisoned 

	const ATTACK_UP_SIDE_EFFECT4           					; $D5 moves that do damage and boost attack 10% of the time
	const DEFENSE_UP_SIDE_EFFECT4          					; $D6 moves that do damage and boost defense 10% of the time
	const SPEED_UP_SIDE_EFFECT4            					; $D7 moves that do damage and boost speed 10% of the time
	const SPECIAL_ATTACK_UP_SIDE_EFFECT4   					; $D8 moves that do damage and boost sp.atk 10% of the time
	const SPECIAL_DEFENSE_UP_SIDE_EFFECT4  					; $D9 moves that do damage and boost sp.def 10% of the time
	const ACCURACY_UP_SIDE_EFFECT4         					; $DA moves that do damage and boost accuracy 10% of the time
	const EVASION_UP_SIDE_EFFECT4          					; $DB moves that do damage and boost evasion 10% of the time
	
	const JUDGMENT_EFFECT									; $DC move type changes according to user's first type
	
	const WEIGHT_DIFFERENCE_EFFECT							; $DD the higher the ratio between the user's weight and the target's weight, the higher the damage
	
	const SUCKER_PUNCH_EFFECT								; $DE fails if the user attacks after the target or if the target has selected a status move
	
	const AUTODEFROST_BURN_SIDE_EFFECT1						; $DF for FLAME_WHEEL
	const AUTODEFROST_BURN_SIDE_EFFECT2						; $E0 for SCALD
	                                                           
	const EJECT_SIDE_EFFECT									; $E1 for DRAGON_TAIL
                                                               
	const ATTACK_DOWN_RECOIL_EFFECT          				; $E2 moves that do damage and reduce user's attack by 1 stage
	const DEFENSE_DOWN_RECOIL_EFFECT         				; $E3 moves that do damage and reduce user's defense by 1 stage
	const SPEED_DOWN_RECOIL_EFFECT           				; $E4 moves that do damage and reduce user's speed by 1 stage
	const SPECIAL_ATTACK_DOWN_RECOIL_EFFECT  				; $E5 moves that do damage and reduce user's sp.atk by 1 stage
	const SPECIAL_DEFENSE_DOWN_RECOIL_EFFECT 				; $E6 moves that do damage and reduce user's sp.def by 1 stage
	const ACCURACY_DOWN_RECOIL_EFFECT        				; $E7 moves that do damage and reduce user's accuracy by 1 stage
	const EVASION_DOWN_RECOIL_EFFECT         				; $E8 moves that do damage and reduce user's evasion by 1 stage
	
	const TRAPPING_EFFECT									; $E9 moves like Mean Look
	const TRICK_ROOM_EFFECT									; $EA
	
; other effects related constants
DISABLE_DURATION	EQU $4
