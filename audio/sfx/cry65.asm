; metang
SFX_Cry65_Ch7::
	noisenote 4, 12, 3, $4e
	noisenote 4, 12, 3, $4d
	noisenote 4, 12, 3, $4c
	noisenote 4, 12, 3, $4b
	noisenote 4, 12, 3, $4a
	noisenote 4, 12, 3, $4b
	noisenote 4, 12, 3, $4c
	noisenote 2, 12, 1, $4d
	endchannel

SFX_Cry65_Ch4::
SFX_Cry65_Ch5::
; these imperceptible notes are there to prevent the volume lowering occurring in the dex menu and status screen to affect the noise channel
; without these, a cry made up of only noisenotes has its volume lowered dramatically when viewed in those menus
; they need to add up to the same duration as the noise channel, if they end before it, the volume lowering will kick in
	squarenote 15, 0, 0, 0
	squarenote 15, 0, 0, 0
	endchannel
