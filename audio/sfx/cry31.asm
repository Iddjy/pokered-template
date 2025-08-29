; ampharos
; scizor
; heracross
; skarmory
SFX_Cry31_Ch4::
	dutycycle 2, 3, 1, 3
.loop
	squarenote 2, 12, 1, 1312
	squarenote 2, 10, 1, 1056
	loopchannel 4, .loop
	dutycycle $0
	squarenote 5, 7, 8, 1888
	squarenote 5, 7, 8, 1840
	squarenote 9, 2, 1, 1056
	endchannel

SFX_Cry31_Ch5::
	dutycycle 2, 0, 3, 0
	squarenote 9, 15, 8, 1792
	squarenote 8, 15, 8, 1824
	squarenote 5, 15, 8, 1936
	squarenote 5, 15, 8, 1888
	squarenote 9, 15, 2, 1840
	endchannel

SFX_Cry31_Ch7::
	noisenote 5, 8, 8, $6d
	noisenote 5, 13, 8, $68
	noisenote 8, 12, 8, $69
	noisenote 5, 9, 8, $3a
	noisenote 5, 9, 8, $3c
	noisenote 9, 13, 2, $5b
	endchannel
