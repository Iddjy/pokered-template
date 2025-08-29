; noibat
SFX_CryEF_Ch4::
	dutycycle 0, 0, 0, 0
	squarenote 3, 10, 2, 1751
	callchannel SFX_CryEF_branch
	endchannel

SFX_CryEF_Ch5::
	dutycycle 0, 0, 0, 1
	squarenote 3, 10, 2, 1750
SFX_CryEF_branch:
	squarenote 3, 0, 0, 0
	squarenote 3, 10, 2, 1680
	squarenote 3, 0, 0, 0
	squarenote 3, 10, 2, 1790
	squarenote 3, 0, 0, 0
	squarenote 6, 8, 2, 1850
	squarenote 10, 6, 0, 1850
	dutycycle 0, 0, 0, 3
	squarenote 8, 6, 0, 1850
	squarenote 2, 7, 2, 1840

SFX_CryEF_Ch7::
	endchannel
