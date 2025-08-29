; blitzle
SFX_CryA0_Ch4::
SFX_CryA0_Ch5::
	dutycycle 0, 0, 0, 1
	squarenote 6, 13, 0, 1700
	squarenote 8, 15, 7, 1870
	squarenote 15, 0, 0, 0
	squarenote 9, 0, 0, 0
	endchannel

SFX_CryA0_Ch7::
	noisenote 6, 12, 2, $35
	noisenote 4, 12, 1, $25
	noisenote 5, 0, 0, $00
SFX_CryA0_Ch7_loop:
	noisenote 1, 8, 1, $4c
	noisenote 1, 0, 0, $00
	loopchannel 6, SFX_CryA0_Ch7_loop
	noisenote 10, 8, 2, $4c
	endchannel
