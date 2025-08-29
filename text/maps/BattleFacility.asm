_BattleFacilityText1::
	text "Uh? There is no"
	line "battle scheduled"
	cont "right now."
	prompt

_BattleFacilityText2::
	text "This job is so"
	line "cool, I get paid"
	cont "to watch amazing"
	cont "#MON battles!"
	prompt

_DoYouWantToForfeitText::
	text "Do you want to"
	line "forfeit the match?"
	prompt

_BattleFacilityText4::
	text "Let me heal your"
	line "#MON."
	done

_NextBattleText::
	text "Next battle is"
	line "number @"
	TX_NUM wBattleFacilityCurrentStreak,2,5
	text "."
	prompt

_LostCountText::
	text "Sorry, I've lost"
	line "count of which"
	cont "battle it is!"
	prompt

_BattleFacilitySpecialOpponentText::
	text "The next opponent"
	line "is a special"
	cont "guest!"
	prompt

_DoYouWantToStopText::
	text "Would you like to"
	line "stop now?"
	done

_BattleFacilityText6::
	text "Are you ready?"
	done

_BattleFacilityText7::
	text "<PLAYER> got"
	line "@"
	TX_NUM wd0b5,1,2
	text " BPs!"
	done

_BattleFacilityText8::
	text "Here are your"
	line "Battle Points!"
	done

_BattleFacilityText9::
	text "You have the"
	line "maximum amount"
	cont "of Battle Points."
	done

_BattleFacilityText10::
	text "To celebrate your"
	line "achievement here,"
	cont "let me give you"
	cont "this!"
	done
	
_BattleFacilityText11::
	text "<PLAYER> received"
	line "GOLDBOTTLECAP!"
	done

_BattleFacilityText12::
	text "Oh, you have no"
	line "room in your bag."
	
	para "I'll keep it for"
	line "you. But I can"
	cont "only hold one at"
	cont "a time!"
	done

_BattleFacilityShopWelcomeText::
	text "Welcome to"
	line "SILPH CO.!"
	done

_TradeBattlePointsText::
	text "You can trade"
	line "Battle Points"
	cont "here."
	done

_WhichItemText::
	text "Which item do"
	line "you want?"
	done

_SoYouWantText::
	text "So, you want"
	line "@"
	TX_RAM wcd6d
	text "?"
	done

_SorryNeedMoreBattlePointsText::
	text "Sorry, you need"
	line "more BPs for"
	cont "this item."
	done
