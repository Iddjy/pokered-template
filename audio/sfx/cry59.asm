; camerupt
SFX_Cry59_Ch4::
	dutycycle 0, 0, 0, 0
	callchannel SFX_Cry43_Ch5_branch
	endchannel

SFX_Cry59_Ch5::
	dutycycle 0, 0, 0, 1
SFX_Cry43_Ch5_branch:
	squarenote 9, 15, 7, 836
	squarenote 3, 15, 7, 868
	squarenote 2, 14, 7, 900
	squarenote 2, 14, 7, 932
	squarenote 10, 13, 1, 964
	squarenote 8, 15, 7, 836
	squarenote 7, 14, 7, 824
	squarenote 5, 13, 6, 812
	squarenote 15, 12, 1, 800
	endchannel

SFX_Cry59_Ch7::
	noisenote 15, 13, 7, $64
	noisenote 11, 13, 5, $64
	noisenote 15, 12, 6, $63
	noisenote 15, 12, 3, $64
	noisenote 5, 9, 6, $65
	endchannel
