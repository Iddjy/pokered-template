; espeon
SFX_Cry33_Ch4::
	dutycycle 2, 0, 1, 3
	squarenote 4, 15, 8, 1712
	squarenote 2, 15, 8, 1701
	squarenote 2, 15, 8, 1693
	squarenote 8, 15, 1, 1674
	squarenote 4, 15, 8, 1846
	squarenote 4, 15, 8, 1824
	squarenote 5, 15, 2, 1806
	endchannel

SFX_Cry33_Ch5::
	dutycycle 3, 1, 2, 0
.loop1
	squarenote 2, 15, 1, 1972
	loopchannel 8, .loop1
.loop2
	squarenote 2, 12, 1, 1936
	loopchannel 3, .loop2
.loop3
	squarenote 2, 11, 1, 1933
	loopchannel 2, .loop3
	squarenote 1, 9, 2, 1941
	endchannel

SFX_Cry33_Ch7::
	noisenote 1, 15, 1, $28
	loopchannel 4, SFX_Cry33_Ch7
	noisenote 1, 9, 1, $49
	noisenote 2, 10, 8, $4a
	noisenote 1, 15, 1, $4b
	noisenote 6, 14, 2, $4f
	noisenote 4, 12, 2, $4e
	noisenote 4, 11, 2, $4d
	noisenote 5, 10, 3, $4c
	endchannel
