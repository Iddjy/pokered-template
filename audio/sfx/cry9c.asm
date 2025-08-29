; froslass
SFX_Cry9C_Ch4::
	dutycycle 1, 1, 1, 1
	squarenote 2, 14, 2, 1810
	squarenote 15, 14, 0, 1800
	squarenote 12, 14, 0, 1802
	squarenote 1, 14, 0, 1805
	squarenote 1, 14, 0, 1810
	squarenote 1, 14, 0, 1815
	squarenote 1, 14, 0, 1820
	squarenote 1, 14, 0, 1825
	squarenote 1, 14, 0, 1830
	squarenote 1, 14, 0, 1835
	squarenote 1, 14, 0, 1840
	squarenote 1, 14, 0, 1845
	squarenote 1, 14, 0, 1850
	squarenote 1, 14, 0, 1855
	squarenote 1, 14, 0, 1860
	squarenote 1, 14, 0, 1865
	squarenote 1, 14, 0, 1870
	squarenote 1, 14, 0, 1875
	squarenote 1, 13, 0, 1880
	squarenote 3, 12, 3, 1900
SFX_Cry9C_loop:
	squarenote 15, 0, 0, 0		; to make Ch4 at least as long as Ch7
	loopchannel 3, SFX_Cry9C_loop
	endchannel

SFX_Cry9C_Ch5::
	dutycycle 0, 0, 0, 0
	squarenote 2, 14, 2, 1810
	squarenote 15, 14, 0, 1801
	squarenote 12, 14, 0, 1799
	squarenote 1, 14, 0, 1807
	squarenote 1, 14, 0, 1811
	squarenote 1, 14, 0, 1815
	squarenote 1, 14, 0, 1820
	squarenote 1, 14, 0, 1825
	squarenote 1, 14, 0, 1830
	squarenote 1, 14, 0, 1835
	squarenote 1, 14, 0, 1840
	squarenote 1, 14, 0, 1845
	squarenote 1, 14, 0, 1850
	squarenote 1, 14, 0, 1855
	squarenote 1, 14, 0, 1860
	squarenote 1, 14, 0, 1865
	squarenote 1, 14, 0, 1870
	squarenote 1, 14, 0, 1875
	squarenote 1, 13, 0, 1880
	squarenote 3, 12, 3, 1902
	endchannel

SFX_Cry9C_Ch7::
	noisenote 10, 0, 0, $0
	noisenote 15, 6, 0, $45
	noisenote 15, 7, 0, $45
	noisenote 15, 8, 0, $45
	noisenote 15, 14, 0, $45
	noisenote 4, 12, 0, $45
	noisenote 4, 10, 0, $45
	noisenote 4, 8, 0, $45
	noisenote 4, 6, 0, $45
	noisenote 4, 4, 2, $45
	endchannel
