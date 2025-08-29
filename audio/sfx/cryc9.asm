; golett
SFX_CryC9_Ch4::
	dutycycle 1, 1, 1, 1
	squarenote 8, 15, 0, 850
	squarenote 4, 0, 0, 0
SFX_CryC9_Ch4_loop:
	squarenote 5, 15, 1, 900
	squarenote 5, 15, 1, 930
	loopchannel 2, SFX_CryC9_Ch4_loop
	squarenote 5, 15, 1, 900
	endchannel

SFX_CryC9_Ch5::
	dutycycle 0, 0, 0, 1
	squarenote 6, 9, 0, 1550
	squarenote 7, 9, 3, 1550
	squarenote 6, 9, 0, 1500
	squarenote 7, 9, 3, 1600
	squarenote 2, 9, 0, 1575
	squarenote 2, 9, 1, 1525
	endchannel

SFX_CryC9_Ch7::
	noisenote 4, 14, 0, $40
	noisenote 2, 12, 0, $44
	noisenote 4, 8, 0, $40
	noisenote 2, 6, 0, $43
	noisenote 2, 0, 0, $00
	noisenote 4, 6, 0, $40
	noisenote 2, 6, 0, $44
	noisenote 4, 6, 0, $40
	noisenote 2, 6, 0, $43
	noisenote 2, 0, 0, $00
	endchannel
