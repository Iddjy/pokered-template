; salandit
SFX_CryFA_Ch4::
SFX_CryFA_Ch5::
; these imperceptible notes are there to prevent the volume lowering occurring in the dex menu and status screen to affect the noise channel
; without these, a cry made up of only noisenotes has its volume lowered dramatically when viewed in those menus
; they need to add up to the same duration as the noise channel, if they end before it, the volume lowering will kick in
	squarenote 13, 0, 0, 0
	loopchannel 4, SFX_CryFA_Ch5
	endchannel

SFX_CryFA_Ch7::
	noisenote 5, 12, 2, $55
	noisenote 1, 0, 0, $00
	noisenote 8, 15, 3, $55
	noisenote 1, 0, 0, $00
	noisenote 5, 10, 2, $55
	noisenote 1, 0, 0, $00
	noisenote 5, 9, 2, $55
	noisenote 1, 0, 0, $00
	noisenote 5, 8, 2, $55
	noisenote 1, 0, 0, $00
	noisenote 8, 5, 7, $55
	noisenote 10, 15, 3, $71
	endchannel
