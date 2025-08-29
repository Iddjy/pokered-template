; carbink
SFX_CryEC_Ch4::
	dutycycle 0, 1, 0, 0
	callchannel SFX_CryEC_branch
	squarenote 8, 10, 7, 1800
	squarenote 8, 10, 7, 1804
	squarenote 8, 10, 7, 1800
	squarenote 8, 10, 3, 1804
	endchannel

SFX_CryEC_Ch5::
	dutycycle 0, 0, 0, 1
	callchannel SFX_CryEC_branch
	squarenote 8, 10, 7, 2000
	squarenote 8, 10, 7, 2004
	squarenote 8, 10, 7, 2008
	squarenote 8, 10, 3, 2012
	endchannel

SFX_CryEC_branch:
	squarenote 2, 13, 0, 1700
	squarenote 2, 13, 0, 1720
	squarenote 2, 13, 0, 1740
	squarenote 6, 13, 2, 1760
	squarenote 1, 0, 0, 0
	squarenote 2, 13, 0, 1750
	squarenote 2, 13, 0, 1770
	squarenote 2, 13, 0, 1790
	squarenote 10, 13, 3, 1810

SFX_CryEC_Ch7::
	endchannel
