; yanmega
SFX_Cry94_Ch4::
	dutycycle 3, 0, 3, 2
	callchannel SFX_Cry94_branch
	endchannel

SFX_Cry94_Ch5::
	dutycycle 3, 0, 3, 3
SFX_Cry94_branch:
	squarenote 14, 0, 0, 0
	squarenote 15, 0, 0, 0
	squarenote 5, 12, 1, 1800
	squarenote 10, 12, 7, 1765
	squarenote 3, 12, 7, 1775
	squarenote 3, 11, 7, 1800
	dutycycle 3, 3, 3, 2
	squarenote 2, 10, 7, 1825
	squarenote 3, 9, 7, 1850
	squarenote 15, 8, 4, 1890
	squarenote 1, 7, 1, 1890
	endchannel

SFX_Cry94_Ch7::
	noisenote 9, 13, 1, $6b
	noisenote 9, 13, 1, $6b
	noisenote 10, 13, 1, $6b
	noisenote 12, 13, 5, $6b
	endchannel
