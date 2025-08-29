; teddiursa
; ursaring
SFX_Cry3A_Ch4::
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
	squarenote 2, 1, 1, 1105
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

SFX_Cry3A_Ch5::
	dutycycle 0, 2, 3, 1
	squarenote 9, 9, 9, 1856
	squarenote 9, 7, 9, 1862
	squarenote 15, 15, 6, 1933	; had to increase the length of this note because it had pitch C in the original
	squarenote 9, 15, 8, 1937
	squarenote 9, 15, 8, 1933
	squarenote 9, 15, 8, 1927
	squarenote 9, 14, 2, 1923
	squarenote 2, 1, 1, 1923
	endchannel

SFX_Cry3A_Ch7::
	noisenote 9, 10, 6, $3a
	noisenote 9, 10, 1, $5a
	endchannel
