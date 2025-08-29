MtMoonB1F_Script:
	call EnableAutoTextBoxDrawing
	ret

MtMoonB1F_TextPointers:
	dw BoulderText
	dw BoulderText
	dw MtMoonText1

MtMoonText1:
	TX_FAR _MtMoonText1
	db "@"
