; haxorus
SFX_CryC5_Ch4::
	dutycycle 0, 1, 0, 0
	squarenote 15, 10, 0, 1350
	callchannel SFX_CryC5_branch
	endchannel

SFX_CryC5_Ch5::
	dutycycle 0, 0, 0, 1
	squarenote 15, 10, 0, 1300
SFX_CryC5_branch:
	squarenote 4, 10, 0, 1100
	squarenote 4, 11, 0, 1110
	squarenote 4, 12, 0, 1120
	squarenote 4, 13, 0, 1125
	squarenote 4, 14, 0, 1130
	squarenote 4, 13, 0, 1125
	squarenote 4, 12, 0, 1120
	squarenote 4, 11, 0, 1110
	squarenote 4, 10, 0, 1100
	squarenote 2, 9, 4, 1100

	squarenote 5, 10, 0, 1110
	squarenote 3, 10, 0, 1115
	squarenote 3, 10, 0, 1110
	squarenote 3, 10, 0, 1100
	squarenote 3, 10, 0, 1090
	squarenote 3, 10, 0, 1080
	squarenote 3, 10, 0, 1070
	squarenote 2, 10, 1, 1060
	endchannel

SFX_CryC5_Ch7::
	noisenote 15, 10, 0, $46
	noisenote 15, 3, 0, $80
	noisenote 15, 3, 0, $80
	noisenote 3, 2, 0, $34
	noisenote 3, 3, 0, $34
	noisenote 3, 4, 0, $34
	noisenote 10, 8, 0, $34
	noisenote 2, 10, 2, $28
	endchannel
