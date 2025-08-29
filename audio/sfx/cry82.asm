; gible
SFX_Cry82_Ch4::
	dutycycle 0, 0, 0, 0
	squarenote 3, 14, 7, 1690
	squarenote 15, 15, -7, 1700
	squarenote 2, 14, 1, 1700
	endchannel
	
SFX_Cry82_Ch5::
	dutycycle 1, 1, 1, 1
SFX_Cry82_branch:
	squarenote 5, 8, 0, 1420
	squarenote 5, 8, 2, 1445
	loopchannel 2, SFX_Cry82_branch
	
SFX_Cry82_Ch7::
	endchannel
