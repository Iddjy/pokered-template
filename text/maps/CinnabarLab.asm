_Lab1Text1::
	text "We study #MON"
	line "extensively here."

	para "People often bring"
	line "us rare #MON"
	cont "for examination."
	done

_Lab1Text2::
	text "A photo of the"
	line "LAB's founder,"
	cont "DR.FUJI!"
	done

_Lab1Text3::
	text "#MON LAB"
	line "Meeting Room"
	done

_Lab1Text4::
	text "#MON LAB"
	line "R-and-D Room"
	done

_Lab1Text5::
	text "#MON LAB"
	line "Testing Room"
	done

_MoveSpecialistIntroText::
	text "Hello! Would you"
	line "like me to make"
	cont "your #MON"
	cont "forget or remember"
	cont "some moves?"
	prompt

_MoveSpecialistWhichMoveToDelete::
	text "Which move shall"
	line "@"
	TX_RAM wcd6d
	text " forget?"
	prompt

_MoveSpecialistCannotForgetLastMove::
	text "I cannot make a"
	line "#MON forget its"
	cont "last move!"
	done

_MoveSpecialistWhichMoveToTeach::
	text "Which move shall"
	line "@"
	TX_RAM wcd6d
	text ""
	cont "remember?"
	prompt

_MoveSpecialistCantTeachAnythingText::
	text "Sorry, I can't"
	line "teach any move to"
	cont "@"
	TX_RAM wcd6d
	text "."
	prompt

_MoveSpecialistOutroText::
	text "If you ever need"
	line "me, just ask!"
	done
