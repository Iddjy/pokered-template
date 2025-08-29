; snorunt
SFX_Cry5F_Ch4::
	dutycycle 2, 1, 2, 1
	callchannel SFX_Cry5F_Ch5_branch
	endchannel

SFX_Cry5F_Ch5::
	dutycycle 3, 0, 3, 1
SFX_Cry5F_Ch5_branch:
	squarenote 6, 10, 4, 1900
	squarenote 6, 10, 4, 1850
	squarenote 6, 10, 4, 1800
	squarenote 6, 10, 4, 1750
	squarenote 6, 10, 4, 1700
	squarenote 1, 10, 1, 1700
	endchannel

SFX_Cry5F_Ch7::
	noisenote 6, 10, 0, $60
	noisenote 6, 10, 0, $61
	noisenote 6, 10, 0, $62
	noisenote 6, 10, 0, $63
	noisenote 6, 10, 1, $64
	endchannel
