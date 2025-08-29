; pelipper
SFX_Cry46_Ch4::
	dutycycle 0, 3, 0, 3
	callchannel SFX_Cry46_branch
	endchannel

SFX_Cry46_Ch5::
	dutycycle 0, 0, 0, 2
SFX_Cry46_branch:
	squarenote 12, 10, 0, 1615
	squarenote 10, 7, 0, 1630
	squarenote 10, 10, 0, 1630
	squarenote 5, 1, 1, 1630
	endchannel

SFX_Cry46_Ch7::
	noisenote 5, 8, 3, $36
	endchannel
