; rampardos
SFX_Cry76_Ch4::
	dutycycle 0, 1, 3, 3
	squarenote 14, 7, -1, 1100
SFX_Cry76_Ch4_loop:
	squarenote 15, 14, 7, 1500
	squarenote 15, 10, -7, 1500
	loopchannel 2, SFX_Cry76_Ch4_loop
	squarenote 5, 14, 2, 1500
	endchannel

SFX_Cry76_Ch5::
	dutycycle 0, 0, 0, 3
	squarenote 14, 7, -1, 904
SFX_Cry76_Ch5_loop:
	squarenote 15, 14, 7, 1204
	squarenote 15, 10, -7, 1204
	loopchannel 2, SFX_Cry76_Ch5_loop
	squarenote 5, 14, 2, 1204
	endchannel

SFX_Cry76_Ch7::
	noisenote 15, 15, 7, $57
	endchannel
