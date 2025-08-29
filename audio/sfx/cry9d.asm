; arceus
SFX_Cry9D_Ch4::
	dutycycle 0, 3, 0, 3
	squarenote 3, 12, 3, 1900
	squarenote 3, 12, 3, 1850
	squarenote 3, 12, 3, 1800
	squarenote 3, 12, 3, 1850
	squarenote 15, 12, 5, 1900
	squarenote 4, 6, 3, 1900
	squarenote 2, 10, 3, 1800
	squarenote 3, 10, 3, 1850
	squarenote 2, 10, 3, 1800
	squarenote 3, 10, 3, 1750
	squarenote 2, 10, 3, 1850
	squarenote 10, 10, 5, 1900
	squarenote 4, 6, 3, 1900
	squarenote 3, 10, 3, 1800
	squarenote 4, 10, 3, 1850
	squarenote 3, 9, 3, 1800
	squarenote 4, 9, 3, 1750
	squarenote 3, 8, 3, 1700
	squarenote 10, 8, 5, 1650
	squarenote 5, 6, 1, 1650
	endchannel

SFX_Cry9D_Ch5::
	dutycycle 3, 3, 3, 3
	squarenote 10, 0, 0, 0
SFX_Cry9D_loop:
	squarenote 15, 6, 0, 2000
	loopchannel 5, SFX_Cry9D_loop
	squarenote 1, 1, 1, 2000
	endchannel

SFX_Cry9D_Ch7::
	noisenote 5, 13, 0, $80
	loopchannel 4, SFX_Cry9D_Ch7
	noisenote 15, 15, 0, $81
	noisenote 5, 15, 0, $81
	noisenote 8, 13, 0, $82
	noisenote 8, 12, 0, $82
	noisenote 8, 11, 0, $82
	noisenote 8, 10, 0, $82
	noisenote 8, 9, 0, $82
	noisenote 5, 5, 1, $82
	endchannel
