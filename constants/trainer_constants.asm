
const_value = 1

	const YOUNGSTER     ; $01
	const BUG_CATCHER   ; $02
	const LASS          ; $03
	const SAILOR        ; $04
	const JR_TRAINER_M  ; $05
	const JR_TRAINER_F  ; $06
	const POKEMANIAC    ; $07
	const SUPER_NERD    ; $08
	const HIKER         ; $09
	const BIKER         ; $0A
	const BURGLAR       ; $0B
	const ENGINEER      ; $0C
	const JUGGLER_X     ; $0D
	const FISHER        ; $0E
	const SWIMMER       ; $0F
	const CUE_BALL      ; $10
	const GAMBLER       ; $11
	const BEAUTY        ; $12
	const PSYCHIC_TR    ; $13
	const ROCKER        ; $14
	const JUGGLER       ; $15
	const TAMER         ; $16
	const BIRD_KEEPER   ; $17
	const BLACKBELT     ; $18
	const SONY1         ; $19
	const PROF_OAK      ; $1A
	const CHIEF         ; $1B
	const SCIENTIST     ; $1C
	const GIOVANNI      ; $1D
	const ROCKET        ; $1E
	const COOLTRAINER_M ; $1F
	const COOLTRAINER_F ; $20
	const BRUNO         ; $21
	const BROCK         ; $22
	const MISTY         ; $23
	const LT_SURGE      ; $24
	const ERIKA         ; $25
	const KOGA          ; $26
	const BLAINE        ; $27
	const SABRINA       ; $28
	const GENTLEMAN     ; $29
	const SONY2         ; $2A
	const SONY3         ; $2B
	const LORELEI       ; $2C
	const CHANNELER     ; $2D
	const AGATHA        ; $2E
	const LANCE         ; $2F
	const BROCK2 		; $30
	const MISTY2        ; $31
	const LT_SURGE2     ; $32
	const ERIKA2        ; $33
	const KOGA2         ; $34
	const SABRINA2      ; $35
	const BLAINE2       ; $36
	const GIOVANNI2     ; $37

NUM_TRAINER_CLASSES EQU const_value + -1

; add these for AI trainers DVs/EVs computations
AI_TRAINER_DV_INCREMENT		EQU $11
AI_TRAINER_EV_INCREMENT		EQU 5

; used to set EVs for Battle Facility pokemon
HP_EV				EQU 0
ATTACK_EV			EQU 2
DEFENSE_EV			EQU 4
SPEED_EV			EQU 6
SPECIAL_ATTACK_EV	EQU 8
SPECIAL_DEFENSE_EV	EQU 10
