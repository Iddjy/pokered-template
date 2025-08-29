; annihilape
SFX_Cry10A_Ch4::
	dutycycle 0, 0, 0, 3
	squarenote 10, 15, 0, 950
	squarenote 5, 14, 0, 940
	squarenote 5, 14, 0, 930
	squarenote 5, 13, 0, 920
	squarenote 5, 13, 0, 910
	squarenote 15, 12, 5, 900
	squarenote 10, 13, 0, 820
	squarenote 5, 13, 0, 840
	squarenote 15, 13, 3, 820
	squarenote 10, 14, 0, 845
	squarenote 5, 14, 0, 825
	squarenote 5, 14, 2, 820
	endchannel

SFX_Cry10A_Ch5::
	dutycycle 0, 0, 0, 3
	squarenote 10, 15, 0, 1150
	squarenote 5, 14, 0, 1140
	squarenote 5, 14, 0, 1130
	squarenote 5, 13, 0, 1120
	squarenote 5, 13, 0, 1110
	squarenote 15, 12, 5, 1100
	squarenote 10, 13, 0, 1020
	squarenote 5, 13, 0, 1040
	squarenote 15, 13, 3, 1020
	squarenote 10, 14, 0, 1045
	squarenote 5, 14, 0, 1025
	squarenote 5, 14, 2, 1020
	endchannel

SFX_Cry10A_Ch7::
	noisenote 15, 0, 0, $00
	loopchannel 3, SFX_Cry10A_Ch7
SFX_Cry10A_loop:
	noisenote 5, 13, 1, $3c
	noisenote 5, 13, 1, $3b
	loopchannel 2, SFX_Cry10A_loop
	noisenote 15, 0, 0, $00
	noisenote 2, 15, 1, $21
	endchannel
