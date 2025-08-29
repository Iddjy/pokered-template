; swadloon
SFX_CryAB_Ch4::
	dutycycle 3, 2, 1, 3
	callchannel SFX_CryAB_Ch5_branch
	endchannel

SFX_CryAB_Ch5::
	dutycycle 2, 2, 2, 2
SFX_CryAB_Ch5_branch:
	squarenote 10, 13, 2, 1600
	squarenote 6, 13, 2, 1500
SFX_CryAB_Ch5_loop:
	squarenote 6, 13, 2, 1550
	loopchannel 2, SFX_CryAB_Ch5_loop
	squarenote 5, 13, 2, 1450
	endchannel

SFX_CryAB_Ch7::
	noisenote 10, 0, 0, $00
	noisenote 3, 8, -1, $30
	noisenote 10, 8, 5, $30
	noisenote 3, 8, -1, $30
	noisenote 3, 8, 2, $30
	endchannel
