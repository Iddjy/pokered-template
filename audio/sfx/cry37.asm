; steelix
SFX_Cry37_Ch4::
	dutycycle 2, 0, 1, 0
.loop1
	squarenote 4, 12, 1, 1937
	loopchannel 3, .loop1
.loop2
	squarenote 4, 13, 1, 1201
	loopchannel 6, .loop2
.loop3
	squarenote 2, 13, 1, 1169
	squarenote 2, 11, 1, 1105
	loopchannel 6, .loop3
; removed that last part because otherwise the cries don't sound exactly like in Gen 2
; the question is...why???
;.loop4
;	squarenote 2, 10, 3, 1137
;	squarenote 2, 8, 1, 1089
;	loopchannel 6, .loop4
;.loop5
;	squarenote 2, 4, 1, 1057
;	squarenote 2, 2, 1, 1025
;	loopchannel 4, .loop5
	endchannel

SFX_Cry37_Ch5::
	dutycycle 0, 2, 3, 1
	squarenote 9, 9, 9, 1856
	squarenote 9, 7, 9, 1862
	squarenote 15, 15, 6, 1933
	squarenote 9, 15, 8, 1937
	squarenote 9, 15, 8, 1933
	squarenote 9, 15, 8, 1927
	squarenote 9, 14, 2, 1923
	endchannel

; had to increase the length of notes who had pitch C by 15 and C# by 23
; so made 2 notes with the first one having 0 volfade
SFX_Cry37_Ch7::
	noisenote 15, 10, 6, $16
	noisenote 15, 9, 0, $3d
	noisenote 9, 9, 8, $3d
	noisenote 15, 9, 0, $5c
	noisenote 8, 9, 8, $5c
	noisenote 15, 7, 0, $5f
	noisenote 8, 7, 5, $5f
	endchannel
