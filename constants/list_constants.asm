; list menu ID's
PCPOKEMONLISTMENU  		EQU $00 ; PC pokemon withdraw/deposit lists
MOVESLISTMENU     		EQU $01 ; move relearner menu
PRICEDITEMLISTMENU		EQU $02 ; Pokemart buy menu / Pokemart buy/sell choose quantity menu
SPECIALLISTMENU    		EQU $03 ; list of special "items" e.g. floor list in elevators / list of badges
ITEMLISTMENU_NOQUANTITY	EQU $04	; TMs and Key Items pages
ITEMLISTMENU     		EQU $05 ; Start menu Item menu / Pokemart sell menu
ITEMLISTMENU_NOPAGES	EQU $06 ; item menus restricted to the first page (Sell menu)

; pages of the items menu
const_value set 0

	const ITEMS_PAGE_NUMBER			; items page of the item menu
	const TM_PAGE_NUMBER			; TM page of the item menu
	const KEY_ITEMS_PAGE_NUMBER		; Key Items page of the item menu

NUM_PAGES_ITEMS_MENU EQU const_value + -1

CURRENCY_POKEDOLLARS	EQU 1
CURRENCY_BATTLE_POINTS	EQU 2

MONSTER_NAME		EQU 1
MOVE_NAME			EQU 2
SIGNATURE_MOVE_NAME	EQU 3
ITEM_NAME			EQU 4
PLAYEROT_NAME		EQU 5
ENEMYOT_NAME		EQU 6
TRAINER_NAME		EQU 7

INIT_ENEMYOT_LIST    EQU 1
INIT_BAG_ITEM_LIST   EQU 2
INIT_OTHER_ITEM_LIST EQU 3
INIT_PLAYEROT_LIST   EQU 4
INIT_MON_LIST        EQU 5
