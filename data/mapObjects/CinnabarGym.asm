CinnabarGym_Object:
	db $2e ; border block

	db 2 ; warps
	warp 16, 17, 1, -1
	warp 17, 17, 1, -1

	db 0 ; signs

	db 9 ; objects
	object SPRITE_FAT_BALD_GUY, 3, 3, STAY, DOWN, 1, BLAINE, 1
	object SPRITE_BLACK_HAIR_BOY_2, 17, 2, STAY, DOWN, 2, SUPER_NERD, 6		; decreased by 3 since 3 unused trainers were removed
	object SPRITE_BLACK_HAIR_BOY_2, 17, 8, STAY, DOWN, 3, BURGLAR, 1		; decreased by 3 since 3 unused trainers were removed
	object SPRITE_BLACK_HAIR_BOY_2, 11, 4, STAY, DOWN, 4, SUPER_NERD, 7		; decreased by 3 since 3 unused trainers were removed
	object SPRITE_BLACK_HAIR_BOY_2, 11, 8, STAY, DOWN, 5, BURGLAR, 2		; decreased by 3 since 3 unused trainers were removed
	object SPRITE_BLACK_HAIR_BOY_2, 11, 14, STAY, DOWN, 6, SUPER_NERD, 8	; decreased by 3 since 3 unused trainers were removed
	object SPRITE_BLACK_HAIR_BOY_2, 3, 14, STAY, DOWN, 7, BURGLAR, 3		; decreased by 3 since 3 unused trainers were removed
	object SPRITE_BLACK_HAIR_BOY_2, 3, 8, STAY, DOWN, 8, SUPER_NERD, 9		; decreased by 3 since 3 unused trainers were removed
	object SPRITE_GYM_HELPER, 16, 13, STAY, DOWN, 9 ; person

	; warp-to
	warp_to 16, 17, CINNABAR_GYM_WIDTH
	warp_to 17, 17, CINNABAR_GYM_WIDTH
