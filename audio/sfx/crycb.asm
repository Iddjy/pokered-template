; pawniard
SFX_CryCB_Ch4::
SFX_CryCB_Ch5::
; these imperceptible notes are there to prevent the volume lowering occurring in the dex menu and status screen to affect the noise channel
; without these, a cry made up of only noisenotes has its volume lowered dramatically when viewed in those menus
; they need to add up to the same duration as the noise channel, if they end before it, the volume lowering will kick in
	squarenote 15, 0, 0, 0
	squarenote 10, 0, 0, 0
	endchannel
	
SFX_CryCB_Ch7::
	noisenote 15, 7, -1, $2c
	noisenote 3, 10, -1, $2b
	noisenote 1, 14, 0, $2a
	noisenote 1, 14, 0, $29
	noisenote 5, 14, 2, $28
	endchannel
