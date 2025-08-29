; coalossal
SFX_Cry101_Ch4::
SFX_Cry101_Ch5::
	dutycycle 2, 3, 2, 3
	squarenote 4, 4, -1, 1100
	squarenote 15, 10, 0, 1200
	squarenote 8, 8, 0, 1200
	squarenote 8, 12, 0, 1100
	squarenote 6, 8, 0, 1200
	squarenote 4, 4, 0, 1100
	squarenote 2, 2, 1, 1000
	squarenote 1, 0, 0, 0
	squarenote 8, 3, -1, 1000
	squarenote 6, 8, 0, 1100
	squarenote 12, 4, 0, 1200
	squarenote 4, 6, 0, 1100
	squarenote 8, 8, 0, 1000
	squarenote 4, 8, 0, 1100
	squarenote 8, 8, 0, 1200
	squarenote 4, 4, 0, 1200
	squarenote 2, 2, 0, 1200
	squarenote 1, 1, 1, 1200
	endchannel

SFX_Cry101_Ch7::
	noisenote 15, 10, 7, $54
	noisenote 7, 10, 2, $53
	noisenote 7, 10, 2, $53
	noisenote 7, 10, 2, $54
	noisenote 10, 10, 2, $54
SFX_Cry101_Ch7_loop:
	noisenote 7, 10, 2, $53
	loopchannel 3, SFX_Cry101_Ch7_loop
	noisenote 10, 10, 3, $53
	endchannel
