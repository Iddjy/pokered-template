; talonflame
SFX_CryD8_Ch4::
	dutycycle 1, 2, 1, 2
	squarenote 15, 13, 0, 1850
	squarenote 6, 13, 0, 1850
	squarenote 1, 13, 0, 1860
	squarenote 1, 13, 0, 1870
	squarenote 1, 13, 0, 1880
SFX_CryD8_Ch4_loop:
	squarenote 15, 13, 0, 1890
	loopchannel 3, SFX_CryD8_Ch4_loop
	squarenote 6, 13, 1, 1885
	endchannel

SFX_CryD8_Ch5::
	dutycycle 1, 2, 1, 2
	squarenote 15, 13, 0, 1800
	squarenote 6, 13, 0, 1800
	squarenote 1, 13, 0, 1810
	squarenote 1, 13, 0, 1820
	squarenote 1, 13, 0, 1830
SFX_CryD8_Ch5_loop:
	squarenote 15, 13, 0, 1840
	loopchannel 3, SFX_CryD8_Ch5_loop
	squarenote 6, 13, 1, 1835
	endchannel

SFX_CryD8_Ch7::
	noisenote 8, 8, -1, $66
	noisenote 8, 13, 5, $66
	noisenote 8, 10, 5, $66
	noisenote 8, 13, 5, $66
	endchannel
