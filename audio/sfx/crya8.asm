; palpitoad
SFX_CryA8_Ch4::
	dutycycle 3, 0, 3, 0
	squarenote 6, 12, 0, 1700
	squarenote 15, 12, 0, 1700
	squarenote 10, 12, 0, 1705
	squarenote 15, 12, 0, 1700
	squarenote 10, 12, 1, 1697
	endchannel

SFX_CryA8_Ch5::
	dutycycle 1, 3, 3, 3
SFX_CryA8_Ch5_loop:
	squarenote 15, 9, 0, 1000
	loopchannel 3, SFX_CryA8_Ch5_loop
	squarenote 1, 5, 1, 1000
	endchannel

SFX_CryA8_Ch7::
	endchannel
