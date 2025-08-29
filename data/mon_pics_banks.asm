; since this part grows when adding more species, I moved it outside of home bank
; since it is called through a bankswitch, we return the output in d, which survives bank switches
; Fossils and Ghost pics must be placed in the last bank since their dex number is hardcoded to NUM_POKEMON + 1
GetMonPicsBank:
	ld a, [wMonHIndex]
	ld b, a
	ld a, [wMonHIndex + 1]
	ld c, a
	ld hl, DEX_NIDOKING + 1
	call CompareBCtoHL
	ld a, BANK(NidokingPicFront)
	jr c, .GotBank
	ld hl, DEX_ALAKAZAM + 1
	call CompareBCtoHL
	ld a, BANK(AlakazamPicFront)
	jr c, .GotBank
	ld hl, DEX_GENGAR + 1
	call CompareBCtoHL
	ld a, BANK(GengarPicFront)
	jr c, .GotBank
	ld hl, DEX_SEADRA + 1
	call CompareBCtoHL
	ld a, BANK(SeadraPicFront)
	jr c, .GotBank
	ld hl, DEX_GLACEON + 1
	call CompareBCtoHL
	ld a, BANK(GlaceonPicFront)
	jr c, .GotBank
	ld hl, DEX_GRANBULL + 1
	call CompareBCtoHL
	ld a, BANK(GranbullPicFront)
	jr c, .GotBank
	ld hl, DEX_HARIYAMA + 1
	call CompareBCtoHL
	ld a, BANK(HariyamaPicFront)
	jr c, .GotBank
	ld hl, DEX_SHINX + 1
	call CompareBCtoHL
	ld a, BANK(ShinxPicFront)
	jr c, .GotBank
	ld hl, DEX_SWADLOON + 1
	call CompareBCtoHL
	ld a, BANK(SwadloonPicFront)
	jr c, .GotBank
	ld hl, DEX_PAWNIARD + 1
	call CompareBCtoHL
	ld a, BANK(PawniardPicFront)
	jr c, .GotBank
	ld hl, DEX_ROWLET + 1
	call CompareBCtoHL
	ld a, BANK(RowletPicFront)
	jr c, .GotBank
	ld hl, DEX_BASTIODON + 1
	call CompareBCtoHL
	ld a, BANK(BastiodonPicFront)
	jr c, .GotBank
	ld hl, NUM_POKEMON + 1
	call CompareBCtoHL
	ld a, BANK(ArceusPicFront)
	jr c, .GotBank
	ld a, BANK(FossilKabutopsPic)
.GotBank
	ld d, a
	ret
