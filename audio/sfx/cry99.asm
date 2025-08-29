; porygon-z
SFX_Cry99_Ch4::
	dutycycle 3, 3, 3, 3
	squarenote 4, 10, 1, 940
	squarenote 2, 10, 1, 920
	squarenote 5, 10, 1, 910
	squarenote 9, 10, 1, 900
	squarenote 2, 10, 1, 920
	squarenote 2, 10, 1, 900
SFX_Cry99_Ch4_loop:
	squarenote 15, 0, 0, 0		; to make Ch4 at least as long as Ch7
	loopchannel 3, SFX_Cry99_Ch4_loop
	endchannel

SFX_Cry99_Ch5::
	dutycycle 0, 0, 0, 0
	squarenote 10, 13, 0, 1940
	squarenote 2, 12, 0, 1700
	squarenote 2, 12, 0, 1720
	squarenote 2, 12, 0, 1740
	squarenote 2, 12, 2, 1750
	squarenote 2, 12, 1, 1300
	endchannel

SFX_Cry99_Ch7::
	noisenote 15, 0, 0, $00
	noisenote 15, 0, 0, $00
	noisenote 5, 8, 2, $25
	noisenote 7, 10, 1, $1d
	noisenote 5, 10, 1, $1d
	noisenote 9, 10, 1, $1d
	noisenote 5, 10, 1, $1d
	noisenote 5, 10, 1, $1d
	noisenote 2, 10, 1, $1d
	endchannel
