; joltik
SFX_CryBC_Ch4::
	dutycycle 0, 3, 0, 3
SFX_CryBC_branch:
	squarenote 3, 13, 1, 1795
	squarenote 3, 13, 1, 1810
	squarenote 1, 0, 0, 0
	endchannel

SFX_CryBC_Ch5::
	dutycycle 0, 0, 0, 0
	callchannel SFX_CryBC_branch
	squarenote 2, 12, 0, 1950
	squarenote 2, 12, 0, 1945
	squarenote 1, 12, 0, 1940
	squarenote 1, 12, 1, 1935
	endchannel

SFX_CryBC_Ch7::
	noisenote 7, 0, 0, $00
	noisenote 3, 6, -1, $0b
	noisenote 1, 10, 1, $0b
	endchannel
