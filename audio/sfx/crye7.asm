; tyrunt
SFX_CryE7_Ch4::
	dutycycle 1, 3, 0, 3
	callchannel SFX_CryE7_branch
	endchannel

SFX_CryE7_Ch5::
	dutycycle 1, 3, 1, 3
SFX_CryE7_branch:
	squarenote 3, 12, 0, 1520
	squarenote 12, 13, 0, 1610
	squarenote 3, 12, 1, 1420
	endchannel

SFX_CryE7_Ch7::
	noisenote 15, 14, 0, 83
	noisenote 4, 4, 1, 83
	endchannel
