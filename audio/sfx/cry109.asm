; cetitan
SFX_Cry109_Ch4::
	callchannel SFX_Cry109_branch
	dutycycle 0, 1, 0, 1
	squarenote 5, 12, 0, 950
	squarenote 2, 13, 0, 930
	squarenote 2, 14, 0, 910
	squarenote 15, 15, 0, 890
	squarenote 5, 14, 0, 900
	squarenote 15, 15, 0, 920
	squarenote 2, 14, 0, 950
	squarenote 2, 13, 0, 950
	squarenote 2, 12, 0, 950
	squarenote 2, 11, 0, 950
	squarenote 2, 10, 0, 950
	squarenote 2, 9, 0, 950
	squarenote 2, 8, 0, 950
	squarenote 2, 7, 0, 950
	squarenote 2, 6, 0, 950
	squarenote 2, 5, 0, 950
	squarenote 2, 4, 0, 950
	squarenote 2, 3, 0, 950
	squarenote 2, 2, 0, 950
	squarenote 2, 1, 1, 950
	endchannel

SFX_Cry109_Ch5::
	callchannel SFX_Cry109_branch
	squarenote 4, 10, 0, 500
	squarenote 4, 9, 0, 500
	squarenote 4, 8, 0, 500
	squarenote 4, 7, 0, 500
	squarenote 4, 6, 0, 500
	squarenote 4, 5, 0, 500
	squarenote 4, 4, 0, 500
	squarenote 4, 3, 0, 500
	squarenote 4, 2, 0, 500
	squarenote 4, 1, 1, 500
	endchannel

SFX_Cry109_Ch7::
	noisenote 5, 0, -1, $0a
	noisenote 15, 9, 0, $0a
	noisenote 15, 9, 5, $0a
	endchannel

SFX_Cry109_branch:
	dutycycle 2, 2, 2, 2
SFX_Cry109_loop:
	squarenote 2, 10, 0, 400
	squarenote 2, 10, 0, 450
	loopchannel 6, SFX_Cry109_loop
	squarenote 2, 10, 0, 400
	squarenote 4, 10, 0, 500
	squarenote 4, 11, 0, 500
	squarenote 4, 12, 0, 500
	squarenote 4, 13, 0, 500
	squarenote 4, 14, 0, 500
	squarenote 4, 15, 0, 500
	squarenote 4, 14, 0, 500
	squarenote 4, 13, 0, 500
	squarenote 4, 12, 0, 500
	squarenote 4, 11, 0, 500
	endchannel
