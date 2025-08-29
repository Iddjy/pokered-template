; aron
SFX_Cry50_Ch4::
	dutycycle 3, 3, 0, 0
	callchannel SFX_Cry50_branch
	squarenote 5, 0, 0, 0	; to make Ch4 at least as long as Ch7
	endchannel

SFX_Cry50_Ch5::
	dutycycle 0, 0, 1, 3
SFX_Cry50_branch:
	squarenote 4, 14, 4, 1921
	squarenote 2, 13, 1, 1920
	squarenote 5, 9, 4, 1801
	squarenote 1, 12, 1, 1798
	endchannel

SFX_Cry50_Ch7::
	noisenote 6, 10, 4, $58
	noisenote 5, 8, 1, $5a
	noisenote 5, 10, 1, $59
	endchannel
