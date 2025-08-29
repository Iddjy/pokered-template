; riolu
SFX_Cry85_Ch4::
	dutycycle 2, 0, 0, 3
	callchannel SFX_Cry85_branch
	endchannel

SFX_Cry85_Ch5::
	dutycycle 1, 0, 1, 0
SFX_Cry85_branch:
	squarenote 1, 12, 7, 1650
	squarenote 2, 12, 7, 1655
	squarenote 3, 12, 1, 1500
	squarenote 3, 5, 1, 1500
	squarenote 3, 0, 0, 0
	squarenote 5, 14, 0, 1750
	squarenote 5, 15, 1, 1760
	endchannel

SFX_Cry85_Ch7::
	noisenote 8, 10, 4, $54
	noisenote 4, 0, 0, $00
	noisenote 4, 10, 1, $52
	endchannel
