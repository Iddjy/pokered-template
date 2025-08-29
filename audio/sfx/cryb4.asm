; sandile
SFX_CryB4_Ch4::
	dutycycle 0, 0, 0, 0
	callchannel SFX_CryB4_branch
	endchannel

SFX_CryB4_Ch5::
	dutycycle 1, 1, 0, 1
SFX_CryB4_branch:
	squarenote 7, 13, 4, 1650
	squarenote 12, 14, 4, 1800
	squarenote 1, 10, 1, 1810

SFX_CryB4_Ch7::
	endchannel
