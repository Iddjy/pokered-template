; luxray
SFX_Cry72_Ch4::
	callchannel SFX_Cry72_branch
	squarenote 15, 8, -1, 1540
	squarenote 15, 15, 7, 1540
	squarenote 3, 12, 2, 1539
	squarenote 10, 12, 2, 1538
	squarenote 15, 0, 2, 1538	; to make Ch4 at least as long as Ch7
	squarenote 5, 0, 2, 1538	; to make Ch4 at least as long as Ch7
	endchannel

SFX_Cry72_Ch5::
	callchannel SFX_Cry72_branch
	squarenote 15, 8, -1, 1541
	squarenote 15, 15, 7, 1541
	squarenote 3, 12, 2, 1538
	squarenote 10, 12, 2, 1537
	endchannel

SFX_Cry72_Ch7::
	noisenote 5, 8, 7, $5a
	noisenote 2, 0, 0, $00
	noisenote 8, 8, 7, $5a
	noisenote 6, 0, 0, $00
	noisenote 13, 8, 7, $5a
	noisenote 1, 0, 0, $00
	noisenote 15, 8, 7, $5a
	noisenote 5, 0, 0, $00
	noisenote 13, 8, 7, $5a
	noisenote 1, 0, 0, $00
	noisenote 15, 8, 4, $5a
	endchannel

SFX_Cry72_branch:
	dutycycle 0, 3, 0, 3
	squarenote 3, 12, 5, 1590
	squarenote 4, 13, 5, 1592
	squarenote 1, 14, 1, 1620
	squarenote 1, 14, 1, 1680
	squarenote 7, 15, 7, 1750
	squarenote 1, 14, 1, 1749
	squarenote 1, 14, 1, 1750
	squarenote 1, 13, 1, 1585
	squarenote 1, 12, 1, 1590
	squarenote 1, 12, 1, 1585
	squarenote 1, 12, 1, 1570
	squarenote 1, 12, 1, 1550
	endchannel
