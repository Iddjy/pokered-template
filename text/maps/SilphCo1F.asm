_SilphCo1FWelcomeText::
	text "Welcome!"
	done

_SilphCo1FPresidentText::
	text "The PRESIDENT is"
	line "in the boardroom"
	cont "on 11F!"
	done

_ElevatorCantBeCalledText::
	text "This elevator"
	line "can't be called"
	cont "from here."
	done

_BattleFacilityIntroText::
	text "I see you have a"
	line "BATTLE PASS."
	
	para "With it, you can"
	line "enter our Battle"
	cont "Facility."
	
	para "It is a place for"
	line "trainers to face"
	cont "off against each"
	cont "other in intense"
	cont "battles!"
	done

_BattleFacilityRulesText::
	text "These are the"
	line "rules of the"
	cont "Battle Facility:"
	
	para "Each contestant"
	line "brings 3 #MON"
	cont "of different"
	cont "species, and all"
	cont "#MON above"
	cont "level 50 are"
	cont "temporarily"
	cont "brought down to"
	cont "that level."
	
	para "With each win,"
	line "you get Battle"
	cont "Points, or BPs."
	
	para "If you manage to"
	line "keep a winning"
	cont "streak, your gains"
	cont "as well as the"
	cont "strength of your"
	cont "opponents will"
	cont "increase."
	
	para "You can stop at"
	line "anytime between"
	cont "two battles."
	
	para "You can redeem"
	line "your BPs for items"
	cont "by talking to the"
	cont "clerk over there."
	done

_BattleFacilityIntroEndText::
	text "Here is a leaflet"
	line "with the rules"
	cont "if you need a"
	cont "reminder."
	done

_BattleFacilityNoWinningStreakText::
	text "You currently have"
	line "no winning streak."
	done

_BattleFacilityCurrentStreakText::
	text "Your current"
	line "streak is @"
	TX_NUM wBattleFacilityCurrentStreak,2,5
	text "."
	done

_BattleFacilityRecordStreakText::
	text "Your record"
	line "streak is @"
	TX_NUM wBattleFacilityRecordStreak,2,5
	text "."
	done

_BattleFacilityCantHandleCurrentStreakText::
	text "Oh..."
	
	para "Our system cannot"
	line "handle your"
	cont "current streak!"
	done

_BattleFacilityCantHandleRecordStreakText::
	text "Your record streak"
	line "is over 65534!"
	done

_BattleFacilityEnterText::
	text "Would you like to"
	line "make use of our"
	cont "Battle Facility?"
	done

_BattleFacilityGoodbyeText::
	text "Come back anytime!"
	done

_BattleFacilityValidatedText::
	text "All is in order."

	para "Please proceed to"
	line "the nearby"
	cont "elevator."
	done

_BattleFacilitySorryText::
	text "I'm sorry!"
	done

_BattleFacilityMustHave3MonsText::
	text "You must have"
	line "exactly 3 #MON"
	cont "on your team."
	done

_BattleFacilityPokemonIsBannedText::
	TX_RAM wcd6d
	text " is"
	line "not allowed to"
	cont "fight here."
	done

_BattleFacilityMustBeDifferentSpeciesText::
	text "All #MON on"
	line "your team must"
	cont "be different"
	cont "species."
	done

_BattleFacilityPleaseAdjustText::
	text "Please come back"
	line "after making the"
	cont "necessary"
	cont "adjustments."
	done

_BattleFacilityNeedToSaveText::
	text "The game must be"
	line "saved first."
	cont "Is that okay?"
	done

_BattleFacilityRunWasInterruptedText::
	text "Your previous run"
	line "was interrupted"
	cont "abruptly!"
	
	para "As a result, you"
	line "were disqualified."
	
	para "Next time, please"
	line "ask the attendant"
	cont "to stop if you"
	cont "need to leave."
	done
