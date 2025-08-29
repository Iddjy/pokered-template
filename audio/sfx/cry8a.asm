; toxicroak
SFX_Cry8A_Ch4::
	dutycycle 0, 0, 3, 3
	callchannel SFX_Cry8A_branch1
	squarenote 15, 14, 7, 1750
	callchannel SFX_Cry8A_branch2
	endchannel

SFX_Cry8A_Ch5::
	dutycycle 3, 0, 3, 0
	callchannel SFX_Cry8A_branch1
	squarenote 15, 14, 7, 1751
	callchannel SFX_Cry8A_branch2

SFX_Cry8A_Ch7::
	endchannel

SFX_Cry8A_branch1:
	squarenote 5, 12, 7, 1650
	squarenote 5, 12, 7, 1675
	squarenote 5, 12, 7, 1700
	endchannel

SFX_Cry8A_branch2:
	squarenote 3, 12, 7, 1675
	squarenote 3, 12, 7, 1650
	squarenote 3, 12, 7, 1649
	squarenote 3, 12, 7, 1625
	squarenote 3, 12, 7, 1635
	squarenote 3, 12, 7, 1649
	squarenote 3, 12, 7, 1650
	squarenote 2, 12, 7, 1665
	squarenote 2, 12, 7, 1660
	squarenote 3, 12, 1, 1650
	endchannel
