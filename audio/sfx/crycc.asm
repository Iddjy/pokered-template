; bisharp
SFX_CryCC_Ch4::
SFX_CryCC_Ch5::
; these imperceptible notes are there to prevent the volume lowering occurring in the dex menu and status screen to affect the noise channel
; without these, a cry made up of only noisenotes has its volume lowered dramatically when viewed in those menus
; they need to add up to the same duration as the noise channel, if they end before it, the volume lowering will kick in
	squarenote 10, 0, 0, 0
	loopchannel 4, SFX_CryCC_Ch5
	endchannel

SFX_CryCC_Ch7::
	noisenote 15, 15, 0, $36
	noisenote 15, 15, 7, $36
	noisenote 3, 12, -1, $35
	noisenote 2, 15, 0, $34
	noisenote 2, 15, 0, $33
	noisenote 1, 15, 3, $09
	endchannel
