; drapion
SFX_Cry88_Ch4::
	dutycycle 3, 0, 3, 3
	callchannel SFX_Cry88_branch
	squarenote 8, 14, 0, 1400
	squarenote 15, 12, 1, 1399
	endchannel

SFX_Cry88_Ch5::
	dutycycle 3, 0, 3, 0
	callchannel SFX_Cry88_branch
	squarenote 8, 14, 0, 1399
	squarenote 15, 12, 1, 1399
	endchannel

SFX_Cry88_Ch7::
	noisenote 9, 15, 0, $61
	noisenote 15, 15, 2, $60
	endchannel

SFX_Cry88_branch:
	squarenote 15, 0, 0, 0
	squarenote 8, 0, 0, 0
	squarenote 15, 12, 0, 1400
	endchannel
