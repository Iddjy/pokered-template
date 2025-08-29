TMsShops:
	ld a, [wCurMap]
	cp CELADON_MART_2F
	jr nz, .notCeladonMart2F
	EventFlagAddress hl, EVENT_TM_MART_1_BOUGHT_TM1	; first byte of the flag array for this mart
	ld de, CeladonMartTMShopEntries
	jr .gotShopData
.notCeladonMart2F
	cp CINNABAR_LAB
	jr nz, .notCinnabarLab
	EventFlagAddress hl, EVENT_TM_MART_2_BOUGHT_TM1	; first byte of the flag array for this mart
	ld de, CinnabarLabTMShopEntries
	jr .gotShopData
.notCinnabarLab
	ret
.gotShopData
	ld a, l
	ld [wTMShopEventFlags], a
	ld a, h
	ld [wTMShopEventFlags + 1], a
	ld a, e
	ld [wListPointer], a
	ld a, d
	ld [wListPointer + 1], a
	jpab TMShopMenu
