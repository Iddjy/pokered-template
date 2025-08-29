; houndour
SFX_Cry2B_Ch4::
	dutycycle $2
	squarenote 9, 2, 15, 238
.loop1
	squarenote 1, 14, 1, 1130
	squarenote 1, 5, 1, 1077
	loopchannel 4, .loop1
.loop2
	squarenote 1, 14, 1, 961
	squarenote 2, 5, 1, 761
	loopchannel 4, .loop2
	endchannel
	
SFX_Cry2B_Ch5::
	dutycycle $2
	squarenote 9, 2, 15, 263
.loop1
	squarenote 1, 14, 1, 1155
	squarenote 1, 5, 1, 1102
	loopchannel 4, .loop1
.loop2
	squarenote 1, 14, 1, 986
	squarenote 2, 5, 1, 786
	loopchannel 4, .loop2
	endchannel

SFX_Cry2B_Ch7::
	noisenote 9, 3, 15, $52
	noisenote 1, 9, 3, $4f
	endchannel
