; walrein
SFX_Cry63_Ch4::
	dutycycle 1, 1, 2, 1
	squarenote 7, 12, -1, 1008
	squarenote 13, 12, -1, 1018
SFX_Cry63_Ch4_loop:
	squarenote 8, 13, 7, 858
	squarenote 10, 13, 7, 808
	loopchannel 4, SFX_Cry63_Ch4_loop
	squarenote 2, 5, 1, 808
	endchannel

SFX_Cry63_Ch5::
	dutycycle 1, 0, 3, 0
	squarenote 7, 12, -1, 1000
	squarenote 13, 12, -1, 1010
SFX_Cry63_Ch5_loop:
	squarenote 8, 13, 7, 850
	squarenote 9, 13, 7, 830
	loopchannel 4, SFX_Cry63_Ch5_loop
	squarenote 2, 5, 1, 800

SFX_Cry63_Ch7::
	endchannel
