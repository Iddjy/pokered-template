; Elemental types
NORMAL   EQU $00
FIRE     EQU $01
WATER    EQU $02
ELECTRIC EQU $03
GRASS    EQU $04
ICE      EQU $05
FIGHTING EQU $06
POISON   EQU $07
GROUND   EQU $08
FLYING   EQU $09
PSYCHIC  EQU $0A
BUG      EQU $0B
ROCK     EQU $0C
GHOST    EQU $0D
DRAGON   EQU $0E
DARK     EQU $0F
STEEL    EQU $10
FAIRY    EQU $11
TYPELESS EQU $12
   


; Type relations
DOES_NOT_AFFECT		EQU $00
DOUBLE_RESISTANCE	EQU $04	; not used in type relations table, equals NOT_VERY_EFFECTIVE right shifted once
NOT_VERY_EFFECTIVE	EQU $08
NEUTRAL				EQU $10	; not used in type relations table, used to intialize damage multiplier and to compare type relations against
SUPER_EFFECTIVE		EQU $20
DOUBLE_WEAKNESS		EQU $40	; not used in type relations table, equals SUPER_EFFECTIVE left shifted once

TYPE_NAME_LENGTH	EQU 8

; STAB bit in wDamageMultipliers (never actually used)
STAB	EQU 7