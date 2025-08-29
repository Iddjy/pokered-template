; piloswine
SFX_Cry3B_Ch4::
	dutycycle 0, 1, 0, 3
	squarenote  5, 10, 15, 1824
	squarenote  3, 15, 8, 1820
	squarenote  3, 15, 8, 1816
	squarenote  3, 15, 8, 1800
	squarenote  3, 15, 8, 1806
	squarenote 13, 12, 8, 1810
	squarenote  5, 9, 1, 1806
	endchannel

SFX_Cry3B_Ch5::
	dutycycle 2, 2, 0, 0
	squarenote  2, 11, 8, 1808
	squarenote  4, 13, 8, 1836
	squarenote  5, 13, 8, 1637
	squarenote  2, 11, 8, 1622
	squarenote  2, 13, 8, 1628
	squarenote 13, 15, 8, 1888
	squarenote  5, 12, 1, 1872
	endchannel

SFX_Cry3B_Ch7::
	noisenote 3, 14, 8, $3b
.loop
	noisenote 2, 15 , 1, $4e
	loopchannel 5, .loop
	noisenote 3, 13, 8, $3f
	noisenote 5, 12, 2, $5f
	endchannel
