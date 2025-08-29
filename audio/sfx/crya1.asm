; zebstrika
SFX_CryA1_Ch4::
	dutycycle 0, 1, 0, 1
	callchannel SFX_CryA1_branch
	endchannel

SFX_CryA1_Ch5::
	dutycycle 0, 0, 0, 0
SFX_CryA1_branch:
	squarenote 1, 12, 2, 1750
	squarenote 1, 12, 2, 1790
	squarenote 1, 12, 2, 1830
	squarenote 1, 13, 2, 1870
	squarenote 2, 14, 2, 1910
	squarenote 2, 15, 2, 1950
	squarenote 15, 15, 0, 1900
	squarenote 15, 14, 0, 1900
	squarenote 15, 13, 0, 1898
	squarenote 15, 12, 3, 1895
	endchannel

SFX_CryA1_Ch7::
	noisenote 8, 5, -7, $21
	noisenote 15, 15, 0, $21
	noisenote 15, 13, 0, $21
	noisenote 15, 10, 0, $21
	noisenote 15, 6, 2, $21
	endchannel
