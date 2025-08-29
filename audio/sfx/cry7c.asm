; drifblim
SFX_Cry7C_Ch4::
	dutycycle 3, 3, 3, 3
	callchannel SFX_Cry7C_branch
	squarenote 10, 14, 7, 1400
	squarenote 10, 14, 2, 1300
	endchannel

SFX_Cry7C_Ch5::
	dutycycle 3, 3, 3, 3
	callchannel SFX_Cry7C_branch
	squarenote 10, 14, 7, 1500
	squarenote 10, 14, 7, 1600
SFX_Cry7C_loop:
	squarenote 2, 6, 2, 2000
	squarenote 2, 6, 2, 2002
	loopchannel 2, SFX_Cry7C_loop
	endchannel

SFX_Cry7C_Ch7::
	noisenote 12, 7, -1, $89
	noisenote 8, 10, 7, $89
	noisenote 8, 10, 7, $8a
	noisenote 8, 10, 4, $8b
	endchannel

SFX_Cry7C_branch:
	squarenote 10, 14, 7, 1500
	squarenote 10, 14, 7, 1300
	squarenote 3, 14, 3, 1200
	squarenote 3, 14, 3, 1175
	squarenote 1, 0, 0, 0
	squarenote 3, 14, 3, 1300
	squarenote 9, 14, 3, 1275
	endchannel
