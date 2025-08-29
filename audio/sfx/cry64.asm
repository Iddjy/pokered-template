; beldum
SFX_Cry64_Ch7::
	noisenote 5, 12, 3, $2d
	noisenote 5, 12, 3, $2e
	loopchannel 2, SFX_Cry64_Ch7
	noisenote 5, 12, 2, $2d
	endchannel

SFX_Cry64_Ch4::
SFX_Cry64_Ch5::
; these imperceptible notes are there to prevent the volume lowering occurring in the dex menu and status screen to affect the noise channel
; without these, a cry made up of only noisenotes has its volume lowered dramatically when viewed in those menus
; they need to add up to the same duration as the noise channel, if they end before it, the volume lowering will kick in
	squarenote 15, 0, 0, 0
	squarenote 10, 0, 0, 0
	endchannel
