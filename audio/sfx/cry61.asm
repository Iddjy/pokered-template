; spheal
SFX_Cry61_Ch4::
	dutycycle 1, 2, 1, 2
	callchannel SFX_Cry61_Ch5_branch
	endchannel

SFX_Cry61_Ch5::
	dutycycle 0, 0, 0, 0
SFX_Cry61_Ch5_branch:
	squarenote 5, 13, 0, 1490
	squarenote 3, 13, 1, 1488

SFX_Cry61_Ch7::
	endchannel
