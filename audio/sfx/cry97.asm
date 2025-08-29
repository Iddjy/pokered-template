; gliscor
SFX_Cry97_Ch4::
	dutycycle 0, 0, 0, 0
	squarenote 2, 9, -1, 1790
	squarenote 6, 12, 7, 1790
	squarenote 1, 12, 7, 1745
	squarenote 1, 12, 7, 1730
	squarenote 1, 12, 7, 1725
	squarenote 1, 12, 7, 1710
	squarenote 10, 12, 3, 1705
	callchannel SFX_Cry97_branch
	squarenote 15, 0, 0, 0			; to make Ch4 at least as long as Ch7
	squarenote 10, 0, 0, 0			; to make Ch4 at least as long as Ch7
	endchannel

SFX_Cry97_Ch5::
	dutycycle 0, 0, 0, 0
	squarenote 2, 9, -1, 1790
	squarenote 6, 12, 7, 1790
	squarenote 1, 12, 7, 1740
	squarenote 1, 12, 7, 1735
	squarenote 1, 12, 7, 1720
	squarenote 1, 12, 7, 1715
	squarenote 10, 12, 3, 1700
SFX_Cry97_branch:
	squarenote 6, 12, 2, 1790
	squarenote 1, 12, 1, 1770
	squarenote 6, 12, 2, 1790
	squarenote 3, 12, 1, 1790
	endchannel

SFX_Cry97_Ch7::
	noisenote 15, 11, -7, $26
	noisenote 15, 11, 7, $26
	noisenote 15, 8, 7, $26
	noisenote 5, 5, 7, $26
	noisenote 7, 11, 1, $2c
	noisenote 7, 11, 1, $2b
	noisenote 3, 11, 1, $2d
	endchannel
