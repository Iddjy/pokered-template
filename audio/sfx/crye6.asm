; dragalge
SFX_CryE6_Ch4::
	dutycycle 1, 3, 0, 3
	callchannel SFX_CryE6_branch
	endchannel

SFX_CryE6_Ch5::
	dutycycle 1, 3, 1, 3
SFX_CryE6_branch:
	squarenote 6, 13, 0, 1520
	squarenote 15, 14, 0, 1600
	squarenote 6, 13, 0, 1420
	squarenote 15, 14, 0, 1400
	squarenote 6, 13, 0, 1620
	squarenote 15, 14, 0, 1660
	squarenote 5, 13, 0, 1450
	squarenote 15, 14, 2, 1430
	endchannel

SFX_CryE6_Ch7::
	noisenote 6, 12, 0, $44
	noisenote 15, 13, 0, $42
	noisenote 6, 12, 0, $46
	noisenote 15, 13, 0, $47
	noisenote 6, 12, 0, $36
	noisenote 15, 13, 0, $33
	noisenote 6, 12, 0, $45
	noisenote 15, 13, 2, $46
	endchannel
