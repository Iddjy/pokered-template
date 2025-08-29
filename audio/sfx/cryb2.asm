; petilil
SFX_CryB2_Ch4::
	callchannel SFX_CryB2_branch
	squarenote 1, 9, 0, 1970
	squarenote 1, 11, 0, 1971
	squarenote 1, 13, 1, 1972
	squarenote 5, 11, 1, 1973
	endchannel

SFX_CryB2_Ch5::
	callchannel SFX_CryB2_branch
	squarenote 1, 9, 0, 2000
	squarenote 1, 11, 0, 2001
	squarenote 1, 13, 1, 2002
	squarenote 5, 11, 1, 2003
	endchannel

SFX_CryB2_branch:
	dutycycle 0, 0, 0, 1
	squarenote 1, 8, 0, 1950
	squarenote 1, 10, 0, 1949
	squarenote 1, 12, 0, 1948
	squarenote 5, 10, 2, 1947
	squarenote 2, 0, 0, 0
	endchannel

SFX_CryB2_Ch7::
	noisenote 8, 0, 0, $0
	noisenote 4, 9, 3, $21
	noisenote 4, 9, 2, $21
	endchannel
