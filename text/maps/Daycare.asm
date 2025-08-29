_DayCareIntroText::
	text "I run a DAYCARE."
	line "Would you like me"
	cont "to raise one of"
	cont "your #MON?"
	done

_DayCareWhichMonText::
	text "Which #MON"
	line "should I raise?"
	prompt

_DayCareWillLookAfterMonText::
	text "Fine, I'll look"
	line "after @"
	TX_RAM wcd6d
	text ""
	cont "for a while."
	prompt

_DayCareComeSeeMeInAWhileText::
	text "Come see me in"
	line "a while."
	done

_DayCareMonHasGrownText::
	text "Your @"
	TX_RAM wcd6d
	text ""
	line "has grown a lot!"

	para "By level, it's"
	line "grown by @"
	TX_NUM wDayCareNumLevelsGrown,$1,$3
	text "!"

	para "Aren't I great?"
	prompt

_DayCareOweMoneyText::
	text "You owe me ¥@"
	TX_BCD wDayCareTotalCost, $c2
	text ""
	line "for the return"
	cont "of this #MON."
	done

_DayCareGotMonBackText::
	text "<PLAYER> got"
	line "@"
	TX_RAM wDayCareMonName
	text " back!"
	done

_DayCareMonNeedsMoreTimeText::
	text "Back already?"
	line "Your @"
	TX_RAM wcd6d
	text ""
	cont "needs some more"
	cont "time with me."
	prompt

_DayCareLetMonsPlayTogetherText::
	text "Would you like to"
	line "let one of your"
	cont "#MON play with"
	cont "@"
	TX_RAM wDayCareMonName
	text "?"
	prompt

_DayCareYouShouldTryItText::
	text "#MON can"
	line "sometimes learn"
	cont "new tricks from"
	cont "playing with"
	cont "each other."
	
	para "You should give"
	line "it a try!"
	done

_DayCareWhichMonPlayText::
	text "Which #MON"
	line "do you want to"
	cont "let out to play?"
	prompt

_DayCarePlayerLetOutMonText::
	text "<PLAYER> let"
	line "out @"
	TX_RAM wcd6d
	text "!"
	done

_DayCareMonsIgnoreEachOtherText::
	TX_RAM wcd6d
	text " and"
	line "@"
	TX_RAM wDayCareMonName
	text ""
	cont "ignore each other."
	done

_DayCareMonObservesAttentivelyText::
	TX_RAM wcd6d
	text ""
	line "observes"
	cont "@"
	TX_RAM wDayCareMonName
	text ""
	cont "attentively..."
	done

_DayCareMonGivesBlankLookText::
	TX_RAM wcd6d
	text "'s look"
	line "is a solid blank."
	done
