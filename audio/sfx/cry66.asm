; metagross
SFX_Cry66_Ch4::
	dutycycle 0, 0, 0, 0
	squarenote 13, 15, 3, 1420
	squarenote 15, 15, 5, 1530
	squarenote 15, 15, 5, 1530
	squarenote 10, 13, 7, 1450
	squarenote 10, 13, 7, 1530
	squarenote 10, 13, 7, 1530
	squarenote 4, 13, 7, 1450
	squarenote 15, 13, 7, 1530
	squarenote 15, 10, 0, 1530
	squarenote 15, 8, 0, 1530
	squarenote 8, 6, 0, 1530
	squarenote 8, 4, 0, 1530
	squarenote 8, 2, 1, 1530
	endchannel

SFX_Cry66_Ch5::
	dutycycle 0, 3, 0, 3
	squarenote 13, 15, 3, 1400
	squarenote 15, 15, 5, 1500
	squarenote 15, 15, 5, 1500
	squarenote 10, 13, 7, 1400
	squarenote 10, 13, 7, 1500
	squarenote 10, 13, 7, 1500
	squarenote 4, 13, 7, 1450
	squarenote 15, 13, 7, 1500
	squarenote 15, 10, 0, 1500
	squarenote 15, 8, 0, 1500
	squarenote 8, 6, 0, 1500
	squarenote 8, 4, 0, 1500
	squarenote 8, 2, 1, 1500
	endchannel

SFX_Cry66_Ch7::
	noisenote 9, 9, 6, $5c
	noisenote 1, 0, 0, $0
SFX_Cry66_Ch7_loop:
	noisenote 13, 9, 6, $5b
	noisenote 15, 8, 7, $5c
	loopchannel 3, SFX_Cry66_Ch7_loop
	endchannel
