; makuhita
SFX_Cry4E_Ch4::
	dutycycle 1, 3, 3, 3
	callchannel SFX_Cry4E_Ch5_branch
	endchannel

SFX_Cry4E_Ch5::
	dutycycle 0, 3, 3, 3
SFX_Cry4E_Ch5_branch:
	squarenote 2, 15, 7, 1400
	squarenote 2, 15, 7, 1390
	squarenote 2, 15, 7, 1380
	squarenote 2, 15, 7, 1360
	squarenote 3, 15, 5, 1314
	squarenote 1, 8, 1, 1310

SFX_Cry4E_Ch7::
	endchannel
