; non-volatile statuses
SLP EQU %111 ; sleep counter
PSN EQU 3
BRN EQU 4
FRZ EQU 5
PAR EQU 6
BADLY_POISONED EQU 7	; use this bit to store toxic flag so that it persists through switches

; volatile statuses 1
STORING_ENERGY           EQU 0 ; Bide
THRASHING_ABOUT          EQU 1 ; e.g. Thrash
ATTACKING_MULTIPLE_TIMES EQU 2 ; e.g. Double Kick, Fury Attack
FLINCHED                 EQU 3
CHARGING_UP              EQU 4 ; e.g. Solar Beam, Fly
USING_TRAPPING_MOVE      EQU 5 ; e.g. Wrap
INVULNERABLE             EQU 6 ; charging up Fly/Dig
CONFUSED                 EQU 7

; volatile statuses 2
USING_X_ACCURACY    EQU 0
PROTECTED_BY_MIST   EQU 1
GETTING_PUMPED      EQU 2 ; Focus Energy
SUBSTITUTE_SHOWN    EQU 3 ; flag to indicate whether the substitute is currently displayed on screen
HAS_SUBSTITUTE_UP   EQU 4
NEEDS_TO_RECHARGE   EQU 5 ; Hyper Beam
USING_RAGE          EQU 6
SEEDED              EQU 7

; volatile statuses 3
CANT_BE_SUCKER_PUNCHED		EQU 0	; set this flag when the pokemon does not meet the conditions for Sucker Punch to work on it
HAS_LIGHT_SCREEN_UP 		EQU 1
HAS_REFLECT_UP      		EQU 2
TRANSFORMED         		EQU 3
TRAPPED						EQU 4	; use this flag for trapping moves such as MEAN LOOK (not used for moves like FIRE SPIN)
USED_XITEM					EQU 5
BETWEEN_TURNS_PHASE_DONE	EQU 6	; use this flag to keep track of between turns events execution
SUICIDED					EQU 7	; use this flag to indicate that a mon used a suicide move this turn

; in-battle flags stored in wNewBattleFlags
ALTERNATING_BIT       		EQU 0	; this bit is used to alternate which side is first to undergo between turns effects (poison, burn, etc.)
USING_SIGNATURE_MOVE		EQU 1	; indicates that the move being used is a signature move whose id was already mapped (for Metronome, Mimic, Mirror Move)
ENEMY_SIGNATURE_MOVE		EQU 2	; indicates that the last attacked received by the enemy was a signature move whose id was already mapped (for Mirror Move and Mimic)
PLAYER_SIGNATURE_MOVE		EQU 3	; indicates that the last attacked received by the player was a signature move whose id was already mapped (for Mirror Move and Mimic)
SUBSTITUTE_TOOK_DAMAGE		EQU 4	; indicates that a substitute took damage this turn
FORCED_SWITCH_OCCURRED		EQU 5	; indicates that a forced switch happened this turn (because of Roar, Whirlwind, Dragon Tail...)

; values to distinguish non-volatile status damage from other types of damage over time.
CAN_BE_TOXIC		EQU $00
CANNOT_BE_TOXIC		EQU $01
