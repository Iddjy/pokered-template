; monferno
SFX_Cry6B_Ch4::
	dutycycle 2, 3, 1, 2
	callchannel SFX_Cry6B_branch
	squarenote 6, 0, 1, 1778		; to make ch4 at least as long as Ch7
	endchannel

SFX_Cry6B_Ch5::
	dutycycle 0, 3, 0, 3
SFX_Cry6B_branch:
	squarenote 10, 14, 7, 1650
	squarenote 8, 13, 3, 1725
	squarenote 10, 10, -1, 1690
	squarenote 8, 12, 3, 1750
	squarenote 15, 10, -1, 1775
	squarenote 1, 12, 1, 1778
	endchannel

SFX_Cry6B_Ch7::
	noisenote 15, 0, 0, $00
	noisenote 15, 0, 0, $00
	noisenote 15, 0, 0, $00
	noisenote 6, 0, 0, $00
	noisenote 6, 15, 4, $39
	endchannel
