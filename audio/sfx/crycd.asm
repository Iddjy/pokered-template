; durant
SFX_CryCD_Ch4::
	dutycycle 0, 0, 0, 3
	callchannel SFX_CryCD_branch
	squarenote 15, 13, 0, 1795
	squarenote 10, 13, 0, 1795
	squarenote 5, 13, 1, 1760
	endchannel

SFX_CryCD_Ch5::
	dutycycle 2, 0, 0, 3
	callchannel SFX_CryCD_branch
	squarenote 15, 13, 0, 1850
	squarenote 10, 13, 0, 1850
	squarenote 5, 13, 1, 1760
	endchannel

SFX_CryCD_Ch7::
	noisenote 7, 10, 0, 45
	noisenote 7, 10, 0, 47
	noisenote 10, 7, 0, 46
	noisenote 10, 7, 0, 46
	noisenote 10, 7, 0, 46
	noisenote 1, 0, 0, 0
	endchannel

SFX_CryCD_branch:
	squarenote 5, 13, 0, 1723
	squarenote 3, 13, 0, 1698
	squarenote 3, 13, 0, 1648
	squarenote 3, 13, 0, 1598
	squarenote 3, 13, 0, 1548
	squarenote 3, 13, 0, 1648
	squarenote 3, 13, 0, 1748
	endchannel
