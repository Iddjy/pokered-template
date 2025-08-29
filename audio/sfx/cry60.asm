; glalie
SFX_Cry60_Ch4::
	dutycycle 0, 3, 0, 3
	callchannel SFX_Cry60_branch_1
	dutycycle 3, 0, 3, 0
	callchannel SFX_Cry60_branch_2
	endchannel

SFX_Cry60_Ch5::
	dutycycle 2, 3, 0, 2
	callchannel SFX_Cry60_branch_1
	dutycycle 2, 2, 2, 1
	callchannel SFX_Cry60_branch_2
	endchannel

SFX_Cry60_Ch7::
	noisenote 7, 5, 6, 77
	noisenote 10, 1, 0, 77
	noisenote 15, 4, -2, 77
	noisenote 7, 7, 1, 77
	endchannel

SFX_Cry60_branch_1:
	squarenote 9, 10, 7, 1800
	squarenote 8, 10, 7, 1650
	endchannel
SFX_Cry60_branch_2:
	squarenote 13, 9, -1, 1890
	squarenote 7, 8, 4, 1875
	squarenote 5, 8, 2, 1875
	endchannel
