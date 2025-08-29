; fletchling
SFX_CryD6_Ch4::
	dutycycle 0, 0, 0, 0
	callchannel SFX_CryD6_branch
	endchannel

SFX_CryD6_Ch5::
	dutycycle 3, 3, 3, 3
SFX_CryD6_branch:
	squarenote 6, 13, 2, 1950
	loopchannel 3, SFX_CryD6_branch
SFX_CryD6_loop:
	squarenote 6, 13, 2, 1910
	loopchannel 4, SFX_CryD6_loop

SFX_CryD6_Ch7::
	endchannel
