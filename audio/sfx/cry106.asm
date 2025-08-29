; frosmoth
SFX_Cry106_Ch4::
	dutycycle 0, 1, 0, 0
	callchannel SFX_Cry106_branch
	squarenote 3, 11, 0, 2025
	squarenote 3, 11, 0, 2020
	squarenote 3, 11, 0, 2015
	squarenote 2, 10, 0, 2010
	squarenote 2, 10, 0, 2005
	squarenote 2, 10, 2, 2000
	endchannel

SFX_Cry106_Ch5::
	dutycycle 0, 1, 0, 0
	squarenote 3, 0, 0, 0
	callchannel SFX_Cry106_branch
	squarenote 3, 11, 0, 2020
	squarenote 3, 11, 0, 2010
	squarenote 3, 11, 0, 2000
	squarenote 2, 10, 2, 1995
	endchannel

SFX_Cry106_branch:
	squarenote 6, 12, 0, 2005
	squarenote 6, 12, 0, 2015
	squarenote 6, 12, 0, 2000
	squarenote 6, 12, 0, 2010
	squarenote 3, 10, 0, 1990
	squarenote 3, 10, 0, 1995
	squarenote 3, 10, 0, 2000
	squarenote 3, 11, 0, 2005
	squarenote 3, 11, 0, 2010
	squarenote 3, 11, 0, 2015
	squarenote 3, 12, 0, 2020
	squarenote 3, 12, 0, 2025
	squarenote 3, 12, 0, 2030
	endchannel

SFX_Cry106_Ch7::
	noisenote 15, 10, 7, $21
	endchannel
