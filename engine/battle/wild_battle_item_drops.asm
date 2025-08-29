CheckItemDrop_:
	call Random
	cp TWENTY_PERCENT
	ret nc
	ld c, 1						; give 1 item
	ld b, TINYMUSHROOM
	ld a, [wEnemyMonLevel]
	cp 16
	jr c, .gotItem
	ld b, STARDUST
	cp 36
	jr c, .gotItem
	ld b, NUGGET
	cp 51
	jr c, .gotItem
	ld b, BIG_NUGGET
.gotItem
	call GiveItem
	ret nc
	ld a, b
	ld [wd11e], a
	call GetItemName
	ld hl, WildItemDropText
	call PrintText
	ld a, SFX_GET_ITEM_1
	call PlaySoundWaitForCurrent
	call WaitForSoundToFinish
	ret

WildItemDropText:
	TX_FAR _FoundHiddenItemText
	db "@"
