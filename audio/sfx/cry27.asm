; hoothoot
; noctowl
; misdreavus
SFX_Cry27_Ch4::
	dutycycle 2, 1, 2, 1
	squarenote 5, 7, 8, 1616
	squarenote 5, 15, 8, 1632
	squarenote 5, 15, 8, 1628
	squarenote 2, 15, 8, 1660
	squarenote 5, 15, 8, 1664
	squarenote 5, 15, 8, 1660
	squarenote 5, 15, 8, 1656
	squarenote 5, 15, 1, 1652
	endchannel

SFX_Cry27_Ch5::
	dutycycle 2, 0, 2, 0
.loop1
	squarenote 3, 10, 1, 1536
	loopchannel 3, .loop1
.loop2
	squarenote 3, 10, 1, 1584
	loopchannel 4, .loop2
	squarenote 5, 10, 2, 1588
	squarenote 5, 9, 1, 1592
	endchannel

SFX_Cry27_Ch7::
	noisenote 2, 6, 8, $36
	noisenote 1, 8, 8, $6a
	noisenote 2, 9, 8, $5e
	noisenote 1, 10, 7, $6e
	endchannel
