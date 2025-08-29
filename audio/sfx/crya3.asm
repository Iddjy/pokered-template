; boldore
SFX_CryA3_Ch4::
	dutycycle 0, 0, 0, 3
	squarenote 3, 9, 7, 600
	squarenote 7, 9, 2, 1000
	squarenote 10, 0, 0, 0
	dutycycle 0, 3, 0, 3
SFX_CryA3_Ch4_loop:
	squarenote 4, 9, 2, 1405
	squarenote 4, 9, 2, 1400
	loopchannel 2, SFX_CryA3_Ch4_loop
	squarenote 4, 10, 1, 1405
	squarenote 4, 10, 1, 1400
	squarenote 4, 12, 1, 1405
	squarenote 5, 12, 1, 1400
	squarenote 5, 9, 1, 1405
	squarenote 5, 9, 1, 1400
	endchannel

SFX_CryA3_Ch5::
	dutycycle 1, 1, 1, 1
	squarenote 4, 12, 7, 500
	squarenote 15, 14, 7, 600
	squarenote 5, 9, 7, 600
	squarenote 10, 13, 7, 550
	squarenote 10, 14, 7, 560
	squarenote 10, 13, 7, 550
	squarenote 8, 14, 2, 540
	endchannel

SFX_CryA3_Ch7::
	noisenote 5, 10, 5, $75
	endchannel
