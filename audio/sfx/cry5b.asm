; banette
SFX_Cry5B_Ch4::
	dutycycle 0, 0, 0, 0
	squarenote 6, 12, 7, 1600
	dutycycle 0, 0, 1, 3
	callchannel SFX_Cry5B_Ch5_branch
	endchannel

SFX_Cry5B_Ch5::
	dutycycle 0, 3, 0, 1
	squarenote 6, 12, 7, 1600
SFX_Cry5B_Ch5_branch:
	squarenote 5, 12, 1, 1650
	squarenote 7, 12, 3, 1600
	squarenote 5, 12, 1, 1650
	squarenote 5, 12, 1, 1600

SFX_Cry5B_Ch7::
	endchannel
