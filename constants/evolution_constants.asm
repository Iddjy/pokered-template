; See data/evos_moves.asm

; Evolution types
EV_LEVEL  EQU 1
EV_ITEM   EQU 2
EV_TRADE  EQU 3
EV_EFFORT EQU 4					; evolution by Effort Values threshold (approximates friendship)
EV_MOVE   EQU 5					; evolution by level up while knowing a certain move

EVOLUTION_SIZE EQU 5 			; changed from 4 to 5 to take into account the new format
MAX_EVO_MOVES  EQU 2			; maximum number of evolution moves for a single evolution
EFFORT_VALUE_THRESHOLD EQU 150	; common value for EV threshold evolution
