; lanturn
SFX_Cry29_Ch4::
	dutycycle $2
	squarenote 9, 2, 15, 1623
.loop1
	squarenote 1, 14, 1, 467
	squarenote 1, 5, 1, 414
	loopchannel 4, .loop1
.loop2
	squarenote 1, 14, 1, 298
	squarenote 2, 5, 1, 98
	loopchannel 4, .loop2
	endchannel

SFX_Cry29_Ch5::
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

SFX_Cry29_Ch7::
	noisenote 9, 3, 15, $52
	noisenote 1, 9, 3, $4f
	endchannel
