; marshtomp
; swampert
SFX_Cry41_Ch4::
	dutycycle 2, 0, 2, 0
	callchannel SFX_Cry41_branch
	endchannel

SFX_Cry41_Ch5::
	dutycycle 3, 0, 3, 0
SFX_Cry41_branch:
	squarenote 3, 15, 7, 1180
	squarenote 5, 15, 2, 1200
	squarenote 2, 12, 7, 1000
	squarenote 2, 12, 7, 950
	squarenote 4, 15, 7, 1190
	squarenote 3, 14, 6, 1240
	squarenote 3, 14, 0, 975
	squarenote 5, 13, 3, 950
	squarenote 7, 14, 0, 975
	squarenote 5, 13, 2, 950
	squarenote 1, 1, 1, 850
	endchannel

SFX_Cry41_Ch7::
	noisenote 15, 13, 0, $B7
	noisenote 15, 12, 0, $B7
	noisenote 1, 10, 1, $B7
	endchannel
