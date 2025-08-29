; whirlipede
SFX_CryAE_Ch4::
	dutycycle 0, 3, 0, 3
	squarenote 5, 12, 0, 1794
	callchannel SFX_CryAE_branch
	endchannel

SFX_CryAE_Ch5::
	dutycycle 0, 3, 0, 3
	squarenote 5, 12, 0, 1790
SFX_CryAE_branch:
	squarenote 10, 12, 0, 1800
	squarenote 5, 12, 0, 1795
	squarenote 8, 12, 0, 1800
	squarenote 5, 12, 0, 1795
	squarenote 8, 12, 0, 1760
	squarenote 4, 10, 1, 1760
	endchannel

SFX_CryAE_Ch7::
	noisenote 15, 0, -1, $35
	noisenote 15, 15, 0, $35
	noisenote 4, 10, 2, $35
	endchannel
