; magmortar
SFX_Cry92_Ch4::
	dutycycle 3, 0, 3, 2
	callchannel SFX_Cry92_branch
	endchannel

SFX_Cry92_Ch5::
	dutycycle 3, 0, 3, 0
SFX_Cry92_branch:
	squarenote 7, 14, 5, 1200
	squarenote 15, 6, -1, 1400
	squarenote 10, 11, 0, 1150
	squarenote 10, 8, 0, 1150
	squarenote 10, 5, 0, 1150
	squarenote 10, 8, 0, 1145
	squarenote 10, 11, 0, 1145
	squarenote 10, 8, 0, 1145
	squarenote 1, 1, 1, 1145
	endchannel

SFX_Cry92_Ch7::
	noisenote 4, 10, 4, $55
	noisenote 15, 6, -1, $45
	noisenote 10, 14, 4, $54
	noisenote 10, 14, 6, $54
	noisenote 4, 10, 3, $54
	noisenote 4, 8, 3, $54
	noisenote 14, 12, 6, $54
	noisenote 4, 10, 3, $54
	endchannel
