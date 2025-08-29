; monochrome palette color ids
	const_def
	const WHITE
	const LIGHT_GRAY
	const DARK_GRAY
	const BLACK

SET_PAL_BATTLE_BLACK         EQU $00
SET_PAL_BATTLE               EQU $01
SET_PAL_TOWN_MAP             EQU $02
SET_PAL_STATUS_SCREEN        EQU $03
SET_PAL_POKEDEX              EQU $04
SET_PAL_SLOTS                EQU $05
SET_PAL_TITLE_SCREEN         EQU $06
SET_PAL_NIDORINO_INTRO       EQU $07
SET_PAL_GENERIC              EQU $08
SET_PAL_OVERWORLD            EQU $09
SET_PAL_PARTY_MENU           EQU $0A
SET_PAL_POKEMON_WHOLE_SCREEN EQU $0B
SET_PAL_GAME_FREAK_INTRO     EQU $0C
SET_PAL_TRAINER_CARD         EQU $0D
SET_PAL_LINK_START           EQU $0E	; add this to make the pokeballs red in the Link battle versus screen
SET_PAL_LINK_END             EQU $0F	; add this to make the pokeballs red in the Link battle versus screen
UPDATE_PARTY_MENU_BLK_PACKET EQU $FC

; super game boy palettes
const_value = 0

	const PAL_ROUTE     		; $00
	const PAL_PALLET    		; $01
	const PAL_VIRIDIAN  		; $02
	const PAL_PEWTER    		; $03
	const PAL_CERULEAN  		; $04
	const PAL_LAVENDER  		; $05
	const PAL_VERMILION 		; $06
	const PAL_CELADON   		; $07
	const PAL_FUCHSIA   		; $08
	const PAL_CINNABAR  		; $09
	const PAL_INDIGO    		; $0A
	const PAL_SAFFRON   		; $0B
	const PAL_TOWNMAP   		; $0C
	const PAL_LOGO1     		; $0D
	const PAL_LOGO2     		; $0E
	const PAL_0F        		; $0F
	const PAL_MEWMON    		; $10
	const PAL_BLUEMON   		; $11
	const PAL_REDMON    		; $12
	const PAL_CYANMON   		; $13
	const PAL_PURPLEMON 		; $14
	const PAL_BROWNMON  		; $15
	const PAL_GREENMON  		; $16
	const PAL_PINKMON   		; $17
	const PAL_YELLOWMON 		; $18
	const PAL_GREYMON   		; $19
	const PAL_SLOTS1    		; $1A
	const PAL_SLOTS2    		; $1B
	const PAL_SLOTS3    		; $1C
	const PAL_SLOTS4    		; $1D
	const PAL_BLACK     		; $1E
	const PAL_GREENBAR  		; $1F
	const PAL_YELLOWBAR 		; $20
	const PAL_REDBAR    		; $21
	const PAL_BADGE     		; $22
	const PAL_CAVE      		; $23
	const PAL_GAMEFREAK 		; $24
	const PAL_POKEBALL			; $25
	const PAL_REDANDGOLD		; $26
	const PAL_BADGE2			; $27
	const PAL_DARKBLUE			; $27
	const PAL_DARKRED			; $28
	const PAL_YELLOWBLUE		; $29
	const PAL_YELLOWGREY		; $2A
	const PAL_ORANGEMON			; $2B
	const PAL_FUSCHIAMON		; $2C
	const PAL_SKYBLUEMON		; $2D
	const PAL_ROSEMON			; $2E
	const PAL_KAKIMON			; $2F
	const PAL_BEIGEMON			; $30
	const PAL_WEIRDMON			; $31
	const PAL_SILVERMON			; $32
	const PAL_GREENISHMON		; $33
	const PAL_ORANGEMON2		; $34
	const PAL_BLOODRED			; $35
	; palettes for trainer sprites
	const PAL_PLAYER			; $36
	const PAL_RIVAL				; $37
	const PAL_OLDMAN			; $38
	const PAL_PROF_OAK			; $39
	const PAL_YOUNGSTER			; $3A
	const PAL_BUG_CATCHER  		; $3B
	const PAL_LASS         		; $3C
	const PAL_SAILOR       		; $3D
	const PAL_JR_TRAINER_M 		; $3E
	const PAL_JR_TRAINER_F 		; $3F
	const PAL_POKEMANIAC   		; $40
	const PAL_SUPER_NERD   		; $41
	const PAL_HIKER        		; $42
	const PAL_BIKER        		; $43
	const PAL_BURGLAR      		; $44
	const PAL_ENGINEER     		; $45
	const PAL_FISHERMAN    		; $46
	const PAL_SWIMMER      		; $47
	const PAL_CUE_BALL     		; $48
	const PAL_GAMBLER      		; $49
	const PAL_BEAUTY       		; $4A
	const PAL_PSYCHIC   		; $4B
	const PAL_ROCKER       		; $4C
	const PAL_JUGGLER      		; $4D
	const PAL_TAMER        		; $4E
	const PAL_BIRD_KEEPER  		; $4F
	const PAL_BLACKBELT    		; $50
	const PAL_SCIENTIST    		; $51
	const PAL_GIOVANNI     		; $52
	const PAL_ROCKET       		; $53
	const PAL_COOLTRAINER_M		; $54
	const PAL_COOLTRAINER_F		; $55
	const PAL_BRUNO        		; $56
	const PAL_BROCK        		; $57
	const PAL_MISTY        		; $58
	const PAL_LT_SURGE     		; $59
	const PAL_ERIKA        		; $5A
	const PAL_KOGA         		; $5B
	const PAL_BLAINE       		; $5C
	const PAL_SABRINA      		; $5D
	const PAL_GENTLEMAN    		; $5E
	const PAL_LORELEI      		; $5F
	const PAL_CHANNELER    		; $60
	const PAL_AGATHA       		; $61
	const PAL_LANCE        		; $62
