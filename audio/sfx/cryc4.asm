; fraxure
SFX_CryC4_Ch4::
	dutycycle 0, 1, 0, 0
	callchannel SFX_CryC4_branch
	endchannel

SFX_CryC4_Ch5::
	dutycycle 0, 0, 0, 1
SFX_CryC4_branch:
	squarenote 5, 13, 0, 1350
	squarenote 2, 13, 0, 1330
	squarenote 2, 13, 0, 1310
	squarenote 2, 13, 0, 1290
	squarenote 2, 13, 0, 1270
	squarenote 2, 13, 1, 1250
	squarenote 10, 13, 4, 1325
	squarenote 5, 13, 0, 1360
	squarenote 3, 13, 0, 1355
	squarenote 3, 13, 0, 1350
	squarenote 3, 13, 0, 1340
	squarenote 3, 13, 0, 1330
	squarenote 3, 13, 0, 1320
	squarenote 3, 13, 0, 1310
	squarenote 2, 13, 1, 1300
	endchannel

SFX_CryC4_Ch7::
	noisenote 8, 8, 5, $43
	endchannel
