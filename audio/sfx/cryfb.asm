; salazzle
SFX_CryFB_Ch4::
	dutycycle 3, 3, 0, 0
	callchannel SFX_CryFB_branch
	endchannel

SFX_CryFB_Ch5::
	dutycycle 3, 3, 3, 2
SFX_CryFB_branch:
	squarenote 1, 13, 0, 1550
	squarenote 4, 12, 0, 1500
	squarenote 2, 10, 0, 1525
	squarenote 2, 12, 0, 1550
	squarenote 2, 14, 0, 1600
	squarenote 4, 15, 0, 1650
	squarenote 4, 14, 0, 1700
	squarenote 4, 15, 0, 1650
	squarenote 4, 14, 0, 1700
	squarenote 10, 15, 0, 1650
	squarenote 5, 14, 0, 1650
	squarenote 4, 13, 0, 1650
	squarenote 4, 12, 0, 1650
	squarenote 3, 10, 0, 1650
	squarenote 3, 8, 0, 1650
	squarenote 3, 6, 0, 1650
	squarenote 2, 3, 0, 1650
	squarenote 1, 0, 0, 0
	squarenote 8, 11, 1, 1650
	squarenote 2, 0, 0, 0
SFX_CryFB_Ch4_loop:
	squarenote 7, 11, 1, 1630
	squarenote 1, 0, 0, 0
	loopchannel 3, SFX_CryFB_Ch4_loop
	squarenote 2, 11, 1, 1630
	squarenote 15, 0, 0, 0
	squarenote 3, 0, 0, 0
	endchannel

SFX_CryFB_Ch7::
	noisenote 10, 0, 0, $00
	loopchannel 10, SFX_CryFB_Ch7
	noisenote 8, 8, -4, $56
	noisenote 4, 14, 0, $56
	noisenote 4, 12, 2, $56
	endchannel
