; larvesta
SFX_CryD1_Ch4::
	callchannel SFX_CryD1_branch
	squarenote 2, 10, 0, 1850
	squarenote 2, 10, 0, 1800
	squarenote 10, 8, 1, 1000
	endchannel

SFX_CryD1_Ch5::
	callchannel SFX_CryD1_branch
	squarenote 2, 10, 1, 1850
	endchannel

SFX_CryD1_branch:
	dutycycle 0, 0, 0, 1
	squarenote 2, 13, 0, 1800
	squarenote 2, 13, 0, 1810
	squarenote 2, 13, 0, 1820
	squarenote 2, 13, 0, 1830
	squarenote 2, 13, 0, 1840
	endchannel

SFX_CryD1_Ch7::
	noisenote 8, 0, 0, $00
	noisenote 8, 12, 4, $82
	endchannel
