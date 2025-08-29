; Draws a "frame block". Frame blocks are blocks of tiles that are put
; together to form frames in battle animations.
DrawFrameBlock_3:
	ld l, c
	ld h, b
	ld a, [hli]
	ld [wNumFBTiles], a
	ld a, [wFBDestAddr + 1]
	ld e, a
	ld a, [wFBDestAddr]
	ld d, a
	xor a
	ld [wFBTileCounter], a ; loop counter
.loop
	ld a, [wFBTileCounter]
	inc a
	ld [wFBTileCounter], a
	ld a, [wSubAnimTransform]
	dec a
	jr z, .flipHorizontalAndVertical   ; 1
	dec a
	jp z, .flipHorizontalTranslateDown ; 2
	dec a
	jr z, .flipBaseCoords              ; 3
.noTransformation
	ld a, [wBaseCoordY]
	add [hl]
	ld [de], a ; store Y
	inc hl
	inc de
	ld a, [wBaseCoordX]
	jr .finishCopying
.flipBaseCoords
	ld a, [wBaseCoordY]
	ld b, a
	ld a, 136
	sub b ; flip Y base coordinate
	add [hl] ; Y offset
	ld [de], a ; store Y
	inc hl
	inc de
	ld a, [wBaseCoordX]
	ld b, a
	ld a, 168
	sub b ; flip X base coordinate
.finishCopying ; finish copying values to OAM (when [wSubAnimTransform] not 1 or 2)
	add [hl] ; X offset
	ld [de], a ; store X
	inc hl
	inc de
	ld a, [hli]
	add $31 ; base tile ID for battle animations
	ld [de], a ; store tile ID
	inc de
	ld a, [hli]
	ld [de], a ; store flags
	inc de
	jp .nextTile
.flipHorizontalAndVertical
	ld a, [wBaseCoordY]
	add [hl] ; Y offset
	ld b, a
	ld a, 136
	sub b ; flip Y coordinate
	ld [de], a ; store Y
	inc hl
	inc de
	ld a, [wBaseCoordX]
	add [hl] ; X offset
	ld b, a
	ld a, 168
	sub b ; flip X coordinate
	ld [de], a ; store X
	inc hl
	inc de
	ld a, [hli]
	add $31 ; base tile ID for battle animations
	ld [de], a ; store tile ID
	inc de
; toggle horizontal and vertical flip
	ld a, [hli] ; flags
	and a
	ld b, OAM_VFLIP | OAM_HFLIP
	jr z, .storeFlags1
	cp OAM_HFLIP
	ld b, OAM_VFLIP
	jr z, .storeFlags1
	cp OAM_VFLIP
	ld b, OAM_HFLIP
	jr z, .storeFlags1
	ld b, 0
.storeFlags1
	ld a, b
	ld [de], a
	inc de
	jp .nextTile
.flipHorizontalTranslateDown
	ld a, [wBaseCoordY]
	add [hl]
	add 40 ; translate Y coordinate downwards
	ld [de], a ; store Y
	inc hl
	inc de
	ld a, [wBaseCoordX]
	add [hl]
	ld b, a
	ld a, 168
	sub b ; flip X coordinate
	ld [de], a ; store X
	inc hl
	inc de
	ld a, [hli]
	add $31 ; base tile ID for battle animations
	ld [de], a ; store tile ID
	inc de
	ld a, [hli]
	bit 5, a ; is horizontal flip enabled?
	jr nz, .disableHorizontalFlip
.enableHorizontalFlip
	set 5, a
	jr .storeFlags2
.disableHorizontalFlip
	res 5, a
.storeFlags2
	ld [de], a
	inc de
.nextTile
	ld a, [wFBTileCounter]
	ld c, a
	ld a, [wNumFBTiles]
	cp c
	jp nz, .loop ; go back up if there are more tiles to draw
.afterDrawingTiles
	ld a, [wFBMode]
	cp 2
	jr z, .advanceFrameBlockDestAddr; skip delay and don't clean OAM buffer
	ld a, [wSubAnimFrameDelay]
	ld c, a
	call DelayFrames
	ld a, [wFBMode]
	cp 3
	jr z, .advanceFrameBlockDestAddr ; skip cleaning OAM buffer
	cp 4
	jr z, .done ; skip cleaning OAM buffer and don't advance the frame block destination address
	ld a, [wAnimationID]
	push hl
	push de
	ld hl, AnimationsWithDuplicatedFrameBlocks_3; use an array instead of comparing only to GROWL
	ld de, 1
	call IsInArray
	pop de
	pop hl
	jr c, .resetFrameBlockDestAddr
	call AnimationCleanOAM_3
.resetFrameBlockDestAddr
	ld hl, wOAMBuffer ; OAM buffer
	ld a, l
	ld [wFBDestAddr + 1], a
	ld a, h
	ld [wFBDestAddr], a ; set destination address to beginning of OAM buffer
	ret
.advanceFrameBlockDestAddr
	ld a, e
	ld [wFBDestAddr + 1], a
	ld a, d
	ld [wFBDestAddr], a
.done
	ret

AnimationsWithDuplicatedFrameBlocks_3:
	db SWEET_SCENT
	db WAVE_CRASH
	db SHOCK_WAVE
	db LEAFAGE
	db VACUUM_WAVE
	db SLUDGE_WAVE
	db MUD_SLAP
	db $FF
	
PlayAnimation_3:
	xor a
	ld [$FF8B], a ; it looks like nothing reads this
	ld [wSubAnimTransform], a
	ld a, [wAnimationID] ; get animation number
	dec a
	ld l, a
	ld h, 0
	add hl, hl
	ld de, AttackAnimationPointers_3  ; animation command stream pointers
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
.animationLoop
	ld a, [hli]
	cp $FF
	ret z
	cp $C0 ; is this subanimation or a special effect?
	jr c, .playSubanimation
.doSpecialEffect
	ld c, a
	ld de, SpecialEffectPointers_3
.searchSpecialEffectTableLoop
	ld a, [de]
	cp c
	jr z, .foundMatch
	inc de
	inc de
	inc de
	jr .searchSpecialEffectTableLoop
.foundMatch
	ld a, [hli]
	cp $FF ; is there a sound to play?
	jr z, .skipPlayingSound
	ld [wAnimSoundID], a ; store sound
	push hl
	push de
	call GetMoveSound_3			; c must not be modified between the call to GetMoveSound and the call to PlayCrySound
	ld b, a						; because PlayCrySound assumes c holds the base cry id's high byte
	call IsCryMove_3			; and GetMoveSound puts it in c as its output
	ld a, b
	jr nc, .notCryMove
	call PlayCrySound
	jr .afterPlaySound
.notCryMove
	call PlaySound
.afterPlaySound
	pop de
	pop hl
.skipPlayingSound
	push hl
	inc de
	ld a, [de]
	ld l, a
	inc de
	ld a, [de]
	ld h, a
	ld de, .nextAnimationCommand
	push de
	jp hl ; jump to special effect function
.playSubanimation
	ld c, a
	and %00111111
	ld [wSubAnimFrameDelay], a
	xor a
	sla c
	rla
	sla c
	rla
	ld [wWhichBattleAnimTileset], a
	ld a, [hli] ; sound
	ld [wAnimSoundID], a ; store sound
	ld a, [hli] ; subanimation ID
	ld c, l
	ld b, h
	ld l, a
	ld h, 0
	add hl, hl
	ld de, SubanimationPointers_3
	add hl, de
	ld a, l
	ld [wSubAnimAddrPtr], a
	ld a, h
	ld [wSubAnimAddrPtr + 1], a
	ld l, c
	ld h, b
	push hl
	ld a, [rOBP0]
	push af
	ld a, [wAnimPalette]
	ld [rOBP0], a
	call LoadAnimationTileset_3
	call LoadSubanimation_3
	call PlaySubanimation_3
	pop af
	ld [rOBP0], a
.nextAnimationCommand
	pop hl
	jp .animationLoop

LoadSubanimation_3:
	ld a, [wSubAnimAddrPtr + 1]
	ld h, a
	ld a, [wSubAnimAddrPtr]
	ld l, a
	ld a, [hli]
	ld e, a
	ld a, [hl]
	ld d, a ; de = address of subanimation
	ld a, [de]
	ld b, a
	and 31
	ld [wSubAnimCounter], a ; number of frame blocks
	ld a, b
	and %11100000
	cp 5 << 5 ; is subanimation type 5?
	jr nz, .isNotType5
.isType5
	call GetSubanimationTransform2_3
	jr .saveTransformation
.isNotType5
	call GetSubanimationTransform1_3
.saveTransformation
; place the upper 3 bits of a into bits 0-2 of a before storing
	srl a
	swap a
	ld [wSubAnimTransform], a
	cp 4 ; is the animation reversed?
	ld hl, 0
	jr nz, .storeSubentryAddr
; if the animation is reversed, then place the initial subentry address at the end of the list of subentries
	ld a, [wSubAnimCounter]
	dec a
	ld bc, 3
.loop
	add hl, bc
	dec a
	jr nz, .loop
.storeSubentryAddr
	inc de
	add hl, de
	ld a, l
	ld [wSubAnimSubEntryAddr], a
	ld a, h
	ld [wSubAnimSubEntryAddr + 1], a
	ret

; called if the subanimation type is not 5
; sets the transform to 0 (i.e. no transform) if it's the player's turn
; sets the transform to the subanimation type if it's the enemy's turn
GetSubanimationTransform1_3:
	ld b, a
	ld a, [H_WHOSETURN]
	and a
	ld a, b
	ret nz
	xor a
	ret

; called if the subanimation type is 5
; sets the transform to 2 (i.e. horizontal and vertical flip) if it's the player's turn
; sets the transform to 0 (i.e. no transform) if it's the enemy's turn
GetSubanimationTransform2_3:
	ld a, [H_WHOSETURN]
	and a
	ld a, 2 << 5
	ret z
	xor a
	ret

; loads tile patterns for battle animations
LoadAnimationTileset_3:
	ld a, [wWhichBattleAnimTileset]
	add a
	add a
	ld hl, AnimationTilesetPointers_3
	ld e, a
	ld d, 0
	add hl, de
	ld a, [hli]
	ld [wTempTilesetNumTiles], a ; number of tiles
	ld a, [hli]
	ld e, a
	ld a, [hl]
	ld d, a ; de = address of tileset
	ld hl, vSprites + $310
	ld b, BANK(AnimationTileset1_3) ; ROM bank
	ld a, [wTempTilesetNumTiles]
	ld c, a ; number of tiles
	jp CopyVideoData ; load tileset

AnimationTilesetPointers_3:
	db 79 ; number of tiles
	dw AnimationTileset1_3
	db $FF

	db 79 ; number of tiles
	dw AnimationTileset2_3
	db $FF

	db 64 ; number of tiles
	dw AnimationTileset1_3
	db $FF

AnimationTileset1_3:
	INCBIN "gfx/attack_anim_1.2bpp"

AnimationTileset2_3:
	INCBIN "gfx/attack_anim_2.2bpp"

MoveAnimation_3:
	push hl
	push de
	push bc
	push af
	call WaitForSoundToFinish
	call SetAnimationPalette_3
	ld a, [wAnimationID]
	and a
	jr z, .animationFinished

.moveAnimation
	; check if battle animations are disabled in the options
	ld a, [wOptions]
	bit 7, a
	jr nz, .animationsDisabled
	call ShareMoveAnimations_3
	call PlayAnimation_3
	jr .next4
.animationsDisabled
	ld c, 30
	call DelayFrames
.next4
	call PlayApplyingAttackAnimation_3 ; shake the screen or flash the pic in and out (to show damage)
.animationFinished
	call WaitForSoundToFinish
	xor a
	ld [wSubAnimSubEntryAddr], a
	ld [wUnusedD09B], a
	ld [wSubAnimTransform], a
	dec a
	ld [wAnimSoundID], a
	pop af
	pop bc
	pop de
	pop hl
	ret

ShareMoveAnimations_3:
	ld a, [H_WHOSETURN]
	and a
	ret z
	; opponent’s turn
	ld a, [wAnimationID]
	cp SLACK_OFF
	ld b, SLACK_OFF_ENEMY
	ret nz
.replaceAnim
	ld a, b
	ld [wAnimationID], a
	ret

PlayApplyingAttackAnimation_3:
; Generic animation that shows after the move's individual animation
; Different animation depending on whether the move has an additional effect and on whose turn it is
	ld a, [wAnimationType]
	and a
	ret z
	cp 4								; if the move makes the enemy's picture blink
	jr nz, .next
	ld hl, wEnemyBattleStatus1
	bit INVULNERABLE, [hl]				; check if the enemy is in a semi-invulnerable turn (hence invisible)
	jr z, .next
	inc a								; if it is, change animation type to shaking instead
.next									; this avoids the blinking making its picture reappear when hitting through invulnerability
	dec a
	add a
	ld c, a
	ld b, 0
	ld hl, AnimationTypePointerTable_3
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

AnimationTypePointerTable_3:
	dw ShakeScreenVertically_3 ; enemy mon has used a damaging move without a side effect
	dw ShakeScreenHorizontallyHeavy_3 ; enemy mon has used a damaging move with a side effect
	dw ShakeScreenHorizontallySlow_3 ; enemy mon has used a non-damaging move
	dw BlinkEnemyMonSprite_3 ; player mon has used a damaging move without a side effect
	dw ShakeScreenHorizontallyLight_3 ; player mon has used a damaging move with a side effect
	dw ShakeScreenHorizontallySlow2_3 ; player mon has used a non-damaging move

ShakeScreenVertically_3:
	call PlayApplyingAttackSound_3
	ld b, 8
	jp AnimationShakeScreenVertically_3

ShakeScreenHorizontallyHeavy_3:
	call PlayApplyingAttackSound_3
	ld b, 8
	jp AnimationShakeScreenHorizontallyFast_3

ShakeScreenHorizontallySlow_3:
	lb bc, 6, 2
	jr AnimationShakeScreenHorizontallySlow_3

BlinkEnemyMonSprite_3:
	call PlayApplyingAttackSound_3
	jp AnimationBlinkEnemyMon_3

ShakeScreenHorizontallyLight_3:
	call PlayApplyingAttackSound_3
	ld b, 2
	jp AnimationShakeScreenHorizontallyFast_3

ShakeScreenHorizontallySlow2_3:
	lb bc, 3, 2

AnimationShakeScreenHorizontallySlow_3:
	push bc
	push bc
.loop1
	ld a, [rWX]
	inc a
	ld [rWX], a
	ld c, 2
	call DelayFrames
	dec b
	jr nz, .loop1
	pop bc
.loop2
	ld a, [rWX]
	dec a
	ld [rWX], a
	ld c, 2
	call DelayFrames
	dec b
	jr nz, .loop2
	pop bc
	dec c
	jr nz, AnimationShakeScreenHorizontallySlow_3
	ret

SetAnimationPalette_3:
	ld a, [wOnSGB]
	and a
	ld a, $e4
	jr z, .notSGB
	ld a, $f0
	ld [wAnimPalette], a
	ld b, $e4
	ld a, b
	ld [rOBP0], a
	ld a, $6c
	ld [rOBP1], a
	ret
.notSGB
	ld a, $e4
	ld [wAnimPalette], a
	ld [rOBP0], a
	ld a, $6c
	ld [rOBP1], a
	ret

PlaySubanimation_3:
	ld a, [wAnimSoundID]
	cp $FF
	jr z, .skipPlayingSound
	call GetMoveSound_3			; c must not be modified between the call to GetMoveSound and the call to PlayCrySound
	ld b, a						; because PlayCrySound assumes c holds the base cry id's high byte
	call IsCryMove_3			; and GetMoveSound puts it in c as its output
	ld a, b
	jr nc, .notCryMove
	call PlayCrySound
	jr .skipPlayingSound
.notCryMove
	call PlaySound
.skipPlayingSound
	ld hl, wOAMBuffer ; base address of OAM buffer
	ld a, l
	ld [wFBDestAddr + 1], a
	ld a, h
	ld [wFBDestAddr], a
	ld a, [wSubAnimSubEntryAddr + 1]
	ld h, a
	ld a, [wSubAnimSubEntryAddr]
	ld l, a
.loop
	push hl
	ld c, [hl] ; frame block ID
	ld b, 0
	ld hl, FrameBlockPointers_3
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	pop hl
	inc hl
	push hl
	ld e, [hl] ; base coordinate ID
	ld d, 0
	ld hl, FrameBlockBaseCoords_3  ; base coordinate table
	add hl, de
	add hl, de
	ld a, [hli]
	ld [wBaseCoordY], a
	ld a, [hl]
	ld [wBaseCoordX], a
	pop hl
	inc hl
	ld a, [hl] ; frame block mode
	ld [wFBMode], a
	call DrawFrameBlock_3
	call DoSpecialEffectByAnimationId_3 ; run animation-specific function (if there is one)
	ld a, [wSubAnimCounter]
	dec a
	ld [wSubAnimCounter], a
	ret z
	ld a, [wSubAnimSubEntryAddr + 1]
	ld h, a
	ld a, [wSubAnimSubEntryAddr]
	ld l, a
	ld a, [wSubAnimTransform]
	cp 4 ; is the animation reversed?
	ld bc, 3
	jr nz, .nextSubanimationSubentry
	ld bc, -3
.nextSubanimationSubentry
	add hl, bc
	ld a, h
	ld [wSubAnimSubEntryAddr + 1], a
	ld a, l
	ld [wSubAnimSubEntryAddr], a
	jp .loop

AnimationCleanOAM_3:
	push hl
	push de
	push bc
	push af
	call DelayFrame
	call ClearSprites
	pop af
	pop bc
	pop de
	pop hl
	ret

; this runs after each frame block is drawn in a subanimation
; it runs a particular special effect based on the animation ID
DoSpecialEffectByAnimationId_3:
	push hl
	push de
	push bc
	ld a, [wAnimationID]
	ld hl, AnimationIdSpecialEffects_3
	ld de, 3
	call IsInArray
	jr nc, .done
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, .done
	push de
	jp hl
.done
	pop bc
	pop de
	pop hl
	ret

; Format: Animation ID (1 byte), Address (2 bytes)
AnimationIdSpecialEffects_3:

	db SWEET_SCENT
	dw DoGrowlSpecialEffects_3
	
	db WAVE_CRASH
	dw DoGrowlSpecialEffects_3

	db BUBBLEBEAM
	dw AnimationFlashScreen_3
	
	db SHOCK_WAVE
	dw DoGrowlSpecialEffects_3
	
	db SPORE
	dw AnimationFlashScreen_3
	
	db LEAFAGE
	dw DoGrowlSpecialEffects_3

	db SHEER_COLD
	dw AnimationFlashScreen_3

	db VACUUM_WAVE
	dw DoGrowlSpecialEffects_3
	
	db SLUDGE_WAVE
	dw DoGrowlSpecialEffects_3
	
	db MUD_SLAP
	dw DoGrowlSpecialEffects_3

	db PSYSTRIKE
	dw AnimationFlashScreen_3

	db $FF ; terminator

; allows to display subanimations on the other side, must be cancelled out by another instance of itself later in the animation to avoid messing with the battle
ReverseTurn_3:
	ld a, [H_WHOSETURN]
	xor $1
	ld [H_WHOSETURN], a
	ret
	
DoRockSlideSpecialEffects_3:
	ld a, [wSubAnimCounter]
	cp 12
	ret nc
	cp 8
	jr nc, .shakeScreen
	cp 1
	jp z, AnimationFlashScreen_3 ; if it's the end of the subanimation, flash the screen
	ret
; if the subanimation counter is between 8 and 11, shake the screen horizontally and vertically
.shakeScreen
	ld b, 1
	predef PredefShakeScreenHorizontally ; shake horizontally
	ld b, 1
	predef_jump PredefShakeScreenVertically ; shake vertically

FlashScreenEverySixteenFrameBlocks_3:
	ld a, [wSubAnimCounter]
	and 15 ; is the subanimation counter exactly 16
	call z, AnimationFlashScreen_3 ; if so, flash the screen
	ret

FlashScreenEveryEightFrameBlocks_3:
	ld a, [wSubAnimCounter]
	and 7 ; is the subanimation counter exactly 8?
	call z, AnimationFlashScreen_3 ; if so, flash the screen
	ret
	
; flashes the screen if the subanimation counter is divisible by 4
FlashScreenEveryFourFrameBlocks_3:
	ld a, [wSubAnimCounter]
	and 3
	call z, AnimationFlashScreen_3
	ret

; used for Explosion and Selfdestruct
DoExplodeSpecialEffects_3:
	ld a, [wSubAnimCounter]
	cp 1 ; is it the end of the subanimation?
	jr nz, FlashScreenEveryFourFrameBlocks_3
; if it's the end of the subanimation, make the attacking pokemon disappear
	coord hl, 1, 5
	jp AnimationHideMonPic_3 ; make pokemon disappear

; flashes the screen when subanimation counter is 1 modulo 4
DoBlizzardSpecialEffects_3:
	ld a, [wSubAnimCounter]
	cp 13
	jp z, AnimationFlashScreen_3
	cp 9
	jp z, AnimationFlashScreen_3
	cp 5
	jp z, AnimationFlashScreen_3
	cp 1
	jp z, AnimationFlashScreen_3
	ret

; this function copies the current musical note graphic
; so that there are two musical notes flying towards the defending pokemon
DoGrowlSpecialEffects_3:
	ld hl, wOAMBuffer ; OAM buffer
	ld de, wOAMBuffer + $10
	ld bc, $10
	call CopyData
	ld a, [wSubAnimCounter]
	dec a
	call z, AnimationCleanOAM_3 ; clean up at the end of the subanimation
	ret

DoLeafStormSpecialEffects_3:
	call DoGrowlSpecialEffects_3
	jp FlashScreenEverySixteenFrameBlocks_3

; Format: Special Effect ID (1 byte), Address (2 bytes)
SpecialEffectPointers_3:
	db SE_DARK_SCREEN_FLASH ; $FE
	dw AnimationFlashScreen_3
	db SE_DARK_SCREEN_PALETTE ; $FD
	dw AnimationDarkScreenPalette_3
	db SE_RESET_SCREEN_PALETTE ; $FC
	dw AnimationResetScreenPalette_3
	db SE_SHAKE_SCREEN ; $FB
	dw AnimationShakeScreen_3
	db SE_WATER_DROPLETS_EVERYWHERE ; $FA
	dw AnimationWaterDropletsEverywhere_3
	db SE_DARKEN_MON_PALETTE ; $F9
	dw AnimationDarkenMonPalette_3
	db SE_FLASH_SCREEN_LONG ; $F8
	dw AnimationFlashScreenLong_3
	db SE_SLIDE_MON_UP ; $F7
	dw AnimationSlideMonUp_3
	db SE_SLIDE_MON_DOWN ; $F6
	dw AnimationSlideMonDown_3
	db SE_FLASH_MON_PIC ; $F5
	dw AnimationFlashMonPic_3
	db SE_SLIDE_MON_OFF ; $F4
	dw AnimationSlideMonOff_3
	db SE_BLINK_MON ; $F3
	dw AnimationBlinkMon_3
	db SE_MOVE_MON_HORIZONTALLY ; $F2
	dw AnimationMoveMonHorizontally_3
	db SE_RESET_MON_POSITION ; $F1
	dw AnimationResetMonPosition_3
	db SE_LIGHT_SCREEN_PALETTE ; $F0
	dw AnimationLightScreenPalette_3
	db SE_HIDE_MON_PIC ; $EF
	dw AnimationHideMonPic_3
	db SE_SQUISH_MON_PIC ; $EE
	dw AnimationSquishMonPic_3
	db SE_SHOOT_BALLS_UPWARD ; $ED
	dw AnimationShootBallsUpward_3
	db SE_SHOOT_MANY_BALLS_UPWARD ; $EC
	dw AnimationShootManyBallsUpward_3
	db SE_BOUNCE_UP_AND_DOWN ; $EB
	dw AnimationBoundUpAndDown_3
	db SE_MINIMIZE_MON ; $EA
	dw AnimationMinimizeMon_3
	db SE_SLIDE_MON_DOWN_AND_HIDE ; $E9
	dw AnimationSlideMonDownAndHide_3
	db SE_TRANSFORM_MON ; $E8
	dw AnimationTransformMon_3
	db SE_LEAVES_FALLING ; $E7
	dw AnimationLeavesFalling_3
	db SE_PETALS_FALLING ; $E6
	dw AnimationPetalsFalling_3
	db SE_SLIDE_MON_HALF_OFF ; $E5
	dw AnimationSlideMonHalfOff_3
	db SE_SHAKE_ENEMY_HUD ; $E4
	dw AnimationShakeEnemyHUD_3
	db SE_SHAKE_ENEMY_HUD_2 ; unused--same pointer as SE_SHAKE_ENEMY_HUD ($E4)
	dw AnimationShakeEnemyHUD_3
	db SE_SPIRAL_BALLS_INWARD ; $E2
	dw AnimationSpiralBallsInward_3
	db SE_DELAY_ANIMATION_10 ; $E1
	dw AnimationDelay10_3
	db SE_FLASH_ENEMY_MON_PIC ; unused--same as SE_FLASH_MON_PIC ($F5), but for the enemy mon
	dw AnimationFlashEnemyMonPic_3
	db SE_HIDE_ENEMY_MON_PIC ; $DF
	dw AnimationHideEnemyMonPic_3
	db SE_BLINK_ENEMY_MON ; $DE
	dw AnimationBlinkEnemyMon_3
	db SE_SHOW_MON_PIC ; $DD
	dw AnimationShowMonPic_3
	db SE_SHOW_ENEMY_MON_PIC ; $DC
	dw AnimationShowEnemyMonPic_3
	db SE_SLIDE_ENEMY_MON_OFF ; $DB
	dw AnimationSlideEnemyMonOff_3
	db SE_SHAKE_BACK_AND_FORTH ; $DA
	dw AnimationShakeBackAndForth_3
	db SE_SUBSTITUTE_MON ; $D9
	dw AnimationSubstitute_3
	db SE_WAVY_SCREEN ; $D8
	dw AnimationWavyScreen_3
	db SE_REVERSE_TURN						; $D7
	dw ReverseTurn_3
	db SE_DARKEN_MON_PALETTE_2				; $D6
	dw AnimationDarkenMonPalette2_3
	db SE_VERY_LIGHT_SCREEN_PALETTE			; $D3
	dw AnimationVeryLightScreenPalette_3
	db SE_SNOW_FLAKES_EVERYWHERE			; $D2
	dw AnimationSnowflakesEverywhere_3
	db SE_PETALS_EVERYWHERE					; $D1
	dw AnimationPetalsEverywhere_3
	db SE_FLAMES_EVERYWHERE					; $D0
	dw AnimationFlamesEverywhere_3
	db SE_SLIDE_MON_DOWN_FAST				; $CE
	dw AnimationSlideMonDownFast_3
	db SE_BOUNCE_UP_AND_DOWN_FAST			; $CD
	dw AnimationBoundUpAndDownFast_3
	db SE_SHAKE_BACK_AND_FORTH_SHORT		; $CC
	dw AnimationShakeBackAndForthShort_3
	db SE_SNOW_FLAKES_EVERYWHERE_SHORT		; $CB
	dw AnimationSnowflakesEverywhereShort_3
	db SE_SLIDE_MON_HALF_DOWN				; $CA
	dw AnimationSlideMonHalfDown_3
	db $FF

AnimationDelay10_3:
	ld c, 10
	jp DelayFrames

; calls a function with the turn flipped from player to enemy or vice versa
; input - hl - address of function to call
CallWithTurnFlipped_3:
	ld a, [H_WHOSETURN]
	push af
	xor 1
	ld [H_WHOSETURN], a
	ld de, .returnAddress
	push de
	jp hl
.returnAddress
	pop af
	ld [H_WHOSETURN], a
	ret

; flashes the screen for an extended period (48 frames)
AnimationFlashScreenLong_3:
	ld a, 3 ; cycle through the palettes 3 times
	ld [wFlashScreenLongCounter], a
	ld a, [wOnSGB] ; running on SGB?
	and a
	ld hl, FlashScreenLongMonochrome_3
	jr z, .loop
	ld hl, FlashScreenLongSGB_3
.loop
	push hl
.innerLoop
	ld a, [hli]
	cp $01 ; is it the end of the palettes?
	jr z, .endOfPalettes
	ld [rBGP], a
	call FlashScreenLongDelay_3
	jr .innerLoop
.endOfPalettes
	ld a, [wFlashScreenLongCounter]
	dec a
	ld [wFlashScreenLongCounter], a
	pop hl
	jr nz, .loop
	ret

; BG palettes
FlashScreenLongMonochrome_3:
	db %11111001 ; 3, 3, 2, 1
	db %11111110 ; 3, 3, 3, 2
	db %11111111 ; 3, 3, 3, 3
	db %11111110 ; 3, 3, 3, 2
	db %11111001 ; 3, 3, 2, 1
	db %11100100 ; 3, 2, 1, 0
	db %10010000 ; 2, 1, 0, 0
	db %01000000 ; 1, 0, 0, 0
	db %00000000 ; 0, 0, 0, 0
	db %01000000 ; 1, 0, 0, 0
	db %10010000 ; 2, 1, 0, 0
	db %11100100 ; 3, 2, 1, 0
	db $01 ; terminator

; BG palettes
FlashScreenLongSGB_3:
	db %11111000 ; 3, 3, 2, 0
	db %11111100 ; 3, 3, 3, 0
	db %11111111 ; 3, 3, 3, 3
	db %11111100 ; 3, 3, 3, 0
	db %11111000 ; 3, 3, 2, 0
	db %11100100 ; 3, 2, 1, 0
	db %10010000 ; 2, 1, 0, 0
	db %01000000 ; 1, 0, 0, 0
	db %00000000 ; 0, 0, 0, 0
	db %01000000 ; 1, 0, 0, 0
	db %10010000 ; 2, 1, 0, 0
	db %11100100 ; 3, 2, 1, 0
	db $01 ; terminator

; causes a delay of 2 frames for the first cycle
; causes a delay of 1 frame for the second and third cycles
FlashScreenLongDelay_3:
	ld a, [wFlashScreenLongCounter]
	cp 4 ; never true since [wFlashScreenLongCounter] starts at 3
	ld c, 4
	jr z, .delayFrames
	cp 3
	ld c, 2
	jr z, .delayFrames
	cp 2 ; nothing is done with this
	ld c, 1
.delayFrames
	jp DelayFrames

AnimationFlashScreen_3:
	ld a, [rBGP]
	push af ; save initial palette
	ld a, %00011011 ; 0, 1, 2, 3 (inverted colors)
	ld [rBGP], a
	ld c, 2
	call DelayFrames
	xor a ; white out background
	ld [rBGP], a
	ld c, 2
	call DelayFrames
	pop af
	ld [rBGP], a ; restore initial palette
	ret

AnimationDarkScreenPalette_3:
; Changes the screen's palette to a dark palette.
	lb bc, $6f, $6f
	jr SetAnimationBGPalette_3

AnimationDarkenMonPalette_3:
; Darkens the mon sprite's palette.
	lb bc, $f9, $f4
	jr SetAnimationBGPalette_3

AnimationDarkenMonPalette2_3:
	lb bc, $fe, $f8
	jr SetAnimationBGPalette_3

AnimationResetScreenPalette_3:
; Restores the screen's palette to the normal palette.
	lb bc, $e4, $e4
	jr SetAnimationBGPalette_3

AnimationLightScreenPalette_3:
; Changes the screen to use a palette with light colors.
	lb bc, $90, $90
	jr SetAnimationBGPalette_3

AnimationVeryLightScreenPalette_3:
	lb bc, $40, $40

SetAnimationBGPalette_3:
	ld a, [wOnSGB]
	and a
	ld a, b
	jr z, .next
	ld a, c
.next
	ld [rBGP], a
	ret

	ld b, $5

AnimationShakeScreenVertically_3:
	predef_jump PredefShakeScreenVertically

AnimationShakeScreen_3:
; Shakes the screen for a while. Used in Earthquake/Fissure/etc. animations.
	ld b, $8

AnimationShakeScreenHorizontallyFast_3:
	predef_jump PredefShakeScreenHorizontally

AnimationPetalsEverywhere_3:
	ld a, 1
	ld [wWhichBattleAnimTileset], a
	call LoadAnimationTileset_3
	ld b, $71							; petal tile
	ld d, 20							; duration of the animation in frames
	jr AnimationTileEverywhere_3

AnimationSnowflakesEverywhereShort_3:
	xor a
	ld [wWhichBattleAnimTileset], a
	call LoadAnimationTileset_3
	ld b, $4d							; snowflake tile
	ld d, 12							; duration of the animation in frames
	jr AnimationTileEverywhere_3

AnimationSnowflakesEverywhere_3:
	xor a
	ld [wWhichBattleAnimTileset], a
	call LoadAnimationTileset_3
	ld b, $4d							; snowflake tile
	ld d, 24							; duration of the animation in frames
	jr AnimationTileEverywhere_3

AnimationFlamesEverywhere_3:
	ld a, 1
	ld [wWhichBattleAnimTileset], a
	call LoadAnimationTileset_3
	ld b, $72							; flame tile
	ld d, 18							; duration of the animation in frames
	jr AnimationTileEverywhere_3

AnimationWaterDropletsEverywhere_3:
; Draws water droplets all over the screen and makes them
; scroll. It's hard to describe, but it's the main animation
; in Surf/Mist/Toxic.
	xor a
	ld [wWhichBattleAnimTileset], a
	call LoadAnimationTileset_3
	ld b, $71							; water droplet tile
	ld d, 32							; duration of the animation in frames
AnimationTileEverywhere_3:
	ld a, -16
	ld [wBaseCoordX], a
	ld a, b
	ld [wDropletTile], a
.loop
	ld a, 16
	ld [wBaseCoordY], a
	ld a, 0
	ld [wUnusedD08A], a
	call _AnimationWaterDroplets_3
	ld a, 24
	ld [wBaseCoordY], a
	ld a, 32
	ld [wUnusedD08A], a
	call _AnimationWaterDroplets_3
	dec d
	jr nz, .loop
	ret

_AnimationWaterDroplets_3:
	ld hl, wOAMBuffer
.loop
	ld a, [wBaseCoordY]
	ld [hli], a ; Y
	ld a, [wBaseCoordX]
	add 27
	ld [wBaseCoordX], a
	ld [hli], a ; X
	ld a, [wDropletTile]
	ld [hli], a ; tile
	xor a
	ld [hli], a ; attribute
	ld a, [wBaseCoordX]
	cp 144
	jr c, .loop
	sub 168
	ld [wBaseCoordX], a
	ld a, [wBaseCoordY]
	add 16
	ld [wBaseCoordY], a
	cp 112
	jr c, .loop
	call AnimationCleanOAM_3
	jp DelayFrame

AnimationSlideMonUp_3:
; Slides the mon's sprite upwards.
	ld c, 7
	ld a, [H_WHOSETURN]
	and a
	coord hl, 1, 6
	coord de, 1, 5
	ld a, $30
	jr z, .next
	coord hl, 12, 1
	coord de, 12, 0
	ld a, $ff
.next
	ld [wSlideMonUpBottomRowLeftTile], a
	jp _AnimationSlideMonUp_3

AnimationSlideMonDown_3:
; Slides the mon's sprite down out of the screen.
	xor a
	call GetTileIDList_3
.loop
	call GetMonSpriteTileMapPointerFromRowCount_3
	push bc
	push de
	call CopyPicTiles_3
	call Delay3
	call AnimationHideMonPic_3
	pop de
	pop bc
	dec b
	jr nz, .loop
	ret

; slide the mon pic halfway down
AnimationSlideMonHalfDown_3:
	xor a
	call GetTileIDList_3
.loop
	call GetMonSpriteTileMapPointerFromRowCount_3
	push bc
	push de
	call CopyPicTiles_3
	call Delay3
	pop de
	pop bc
	dec b
	ld a, b
	cp 4
	jr nz, .loop
	ret

AnimationSlideMonDownFast_3:
; Slides the mon's sprite down out of the screen.
	xor a
	call GetTileIDList_3
.loop
	call GetMonSpriteTileMapPointerFromRowCount_3
	push bc
	push de
	call CopyPicTiles_3
	call DelayFrame
	call AnimationHideMonPic_3
	pop de
	pop bc
	dec b
	jr nz, .loop
	ret

AnimationSlideMonOff_3:
; Slides the mon's sprite off the screen horizontally.
	ld e, 8
	ld a, 3
	ld [wSlideMonDelay], a
	jp _AnimationSlideMonOff_3

AnimationSlideEnemyMonOff_3:
; Slides the enemy mon off the screen horizontally.
	ld hl, AnimationSlideMonOff_3
	jp CallWithTurnFlipped_3

_AnimationSlideMonUp_3:
	push de
	push hl
	push bc

; In each iteration, slide up all rows but the top one (which is overwritten).
	ld b, 6
.slideLoop
	push bc
	push de
	push hl
	ld bc, 7
	call CopyData
; Note that de and hl are popped in the same order they are pushed, swapping
; their values. When CopyData is called, hl points to a tile 1 row below
; the one de points to. To maintain this relationship, after swapping, we add 2
; rows to hl so that it is 1 row below again.
	pop de
	pop hl
	ld bc, SCREEN_WIDTH * 2
	add hl, bc
	pop bc
	dec b
	jr nz, .slideLoop

; Fill in the bottom row of the mon pic with the next row's tile IDs.
	ld a, [H_WHOSETURN]
	and a
	coord hl, 1, 11
	jr z, .next
	coord hl, 12, 6
.next
	ld a, [wSlideMonUpBottomRowLeftTile]
	inc a
	ld [wSlideMonUpBottomRowLeftTile], a
	ld c, 7
.fillBottomRowLoop
	ld [hli], a
	add 7
	dec c
	jr nz, .fillBottomRowLoop

	ld c, 2
	call DelayFrames
	pop bc
	pop hl
	pop de
	dec c
	jr nz, _AnimationSlideMonUp_3
	ret

ShakeEnemyHUD_WritePlayerMonPicOAM_3:
; Writes the OAM entries for a copy of the player mon's pic in OAM.
; The top 5 rows are reproduced in OAM, although only 2 are actually needed.
	ld a, $10
	ld [wBaseCoordX], a
	ld a, $30
	ld [wBaseCoordY], a
	ld hl, wOAMBuffer
	ld d, 0
	ld c, 7
.loop
	ld a, [wBaseCoordY]
	ld e, a
	ld b, 5
.innerLoop
	call BattleAnimWriteOAMEntry_3
	inc d
	dec b
	jr nz, .innerLoop
	dec c
	ret z
	inc d
	inc d
	ld a, [wBaseCoordX]
	add 8
	ld [wBaseCoordX], a
	jr .loop

BattleAnimWriteOAMEntry_3:
; Y coordinate = e (increased by 8 each call, before the write to OAM)
; X coordinate = [wBaseCoordX]
; tile = d
; attributes = 0
	ld a, e
	add 8
	ld e, a
	ld [hli], a
	ld a, [wBaseCoordX]
	ld [hli], a
	ld a, d
	ld [hli], a
	xor a
	ld [hli], a
	ret

AdjustOAMBlockXPos_3:
	ld l, e
	ld h, d

AdjustOAMBlockXPos2_3:
	ld de, 4
.loop
	ld a, [wCoordAdjustmentAmount]
	ld b, a
	ld a, [hl]
	add b
	cp 168
	jr c, .skipPuttingEntryOffScreen
; put off-screen if X >= 168
	dec hl
	ld a, 160
	ld [hli], a
.skipPuttingEntryOffScreen
	ld [hl], a
	add hl, de
	dec c
	jr nz, .loop
	ret

AdjustOAMBlockYPos_3:
	ld l, e
	ld h, d

AdjustOAMBlockYPos2_3:
	ld de, 4
.loop
	ld a, [wCoordAdjustmentAmount]
	ld b, a
	ld a, [hl]
	add b
	cp 112
	jr c, .skipSettingPreviousEntrysAttribute
	dec hl
	ld a, 160 ; bug, sets previous OAM entry's attribute
	ld [hli], a
.skipSettingPreviousEntrysAttribute
	ld [hl], a
	add hl, de
	dec c
	jr nz, .loop
	ret

AnimationBlinkEnemyMon_3:
; Make the enemy mon's sprite blink on and off for a second or two
	ld hl, AnimationBlinkMon_3
	jp CallWithTurnFlipped_3

AnimationBlinkMon_3:
; Make the mon's sprite blink on and off for a second or two.
	push af
	ld c, 6
.loop
	push bc
	call AnimationHideMonPic_3
	ld c, 5
	call DelayFrames
	call AnimationShowMonPic_3
	ld c, 5
	call DelayFrames
	pop bc
	dec c
	jr nz, .loop
	pop af
	ret

AnimationFlashMonPic_3:
; Flashes the mon's sprite on and off
	ld a, [wBattleMonSpecies]
	ld [wChangeMonPicPlayerTurnSpecies], a
	ld a, [wEnemyMonSpecies]
	ld [wChangeMonPicEnemyTurnSpecies], a
	ld a, [wBattleMonSpecies + 1]					; to handle 2 bytes species IDs
	ld [wChangeMonPicPlayerTurnSpecies + 1], a		; to handle 2 bytes species IDs
	ld a, [wEnemyMonSpecies + 1]					; to handle 2 bytes species IDs
	ld [wChangeMonPicEnemyTurnSpecies + 1], a		; to handle 2 bytes species IDs
	jp ChangeMonPic_3

AnimationFlashEnemyMonPic_3:
; Flashes the enemy mon's sprite on and off
	ld hl, AnimationFlashMonPic_3
	jp CallWithTurnFlipped_3

AnimationShowMonPic_3:
	xor a
	call GetTileIDList_3
	call GetMonSpriteTileMapPointerFromRowCount_3
	call CopyPicTiles_3
	jp Delay3

AnimationShowEnemyMonPic_3:
; Shows the enemy mon's front sprite. Used in animations like Seismic Toss
; to make the mon's sprite reappear after disappears offscreen.
	ld hl, AnimationShowMonPic_3
	jp CallWithTurnFlipped_3

AnimationShakeBackAndForthShort_3:
	ld c, 8
	jr AnimationShakeBackAndForth_3.gotDuration
	
AnimationShakeBackAndForth_3:
; Shakes the mon's sprite back and forth rapidly. This is used in Double Team.
; The mon's sprite disappears after this animation.
	ld c, $10
.gotDuration
	ld a, [H_WHOSETURN]
	and a
	coord hl, 0, 5
	coord de, 2, 5
	jr z, .next
	coord hl, 11, 0
	coord de, 13, 0

.next
	xor a
.loop
	push af
	push bc
	push de
	push hl
	push hl
	push de
	push af
	push hl
	push hl
	call GetTileIDList_3
	pop hl
	call CopyPicTiles_3
	call Delay3
	pop hl
	lb bc, 7, 9
	call ClearScreenArea
	pop af
	call GetTileIDList_3
	pop hl
	call CopyPicTiles_3
	call Delay3
	pop hl
	lb bc, 7, 9
	call ClearScreenArea
	pop hl
	pop de
	pop bc
	pop af
	dec c
	jr nz, .loop
	ret

AnimationMoveMonHorizontally_3:
; Shifts the mon's sprite horizontally to a fixed location. Used by lots of
; animations like Tackle/Body Slam.
	call AnimationHideMonPic_3
	ld a, [H_WHOSETURN]
	and a
	coord hl, 2, 5
	jr z, .next
	coord hl, 11, 0
.next
	xor a
	push hl
	call GetTileIDList_3
	pop hl
	call CopyPicTiles_3
	ld c, 3
	jp DelayFrames

AnimationResetMonPosition_3:
; Resets the mon's sprites to be located at the normal coordinates.
	ld a, [H_WHOSETURN]
	and a
	ld a, 5 * SCREEN_WIDTH + 2
	jr z, .next
	ld a, 11
.next
	call ClearMonPicFromTileMap_3
	jp AnimationShowMonPic_3

AnimationSpiralBallsInward_3:
; Creates an effect that looks like energy balls spiralling into the
; player mon's sprite.  Used in Focus Energy, for example.
	ld a, [H_WHOSETURN]
	and a
	jr z, .playerTurn
	ld a, -40
	ld [wSpiralBallsBaseY], a
	ld a, 80
	ld [wSpiralBallsBaseX], a
	jr .next
.playerTurn
	xor a
	ld [wSpiralBallsBaseY], a
	ld [wSpiralBallsBaseX], a
.next
	ld d, $7a ; ball tile
	ld c, 3 ; number of balls
	xor a
	call InitMultipleObjectsOAM_3
	ld hl, SpiralBallAnimationCoordinates_3
.loop
	push hl
	ld c, 3
	ld de, wOAMBuffer
.innerLoop
	ld a, [hl]
	cp $ff
	jr z, .done
	ld a, [wSpiralBallsBaseY]
	add [hl]
	ld [de], a ; Y
	inc de
	inc hl
	ld a, [wSpiralBallsBaseX]
	add [hl]
	ld [de], a ; X
	inc hl
	inc de
	inc de
	inc de
	dec c
	jr nz, .innerLoop
	ld c, 5
	call DelayFrames
	pop hl
	inc hl
	inc hl
	jr .loop
.done
	pop hl
	call AnimationCleanOAM_3
	jp AnimationFlashScreen_3

SpiralBallAnimationCoordinates_3:
; y, x pairs
; This is the sequence of screen coordinates that the spiralling
; balls are positioned at.
	db $38, $28
	db $40, $18
	db $50, $10
	db $60, $18
	db $68, $28
	db $60, $38
	db $50, $40
	db $40, $38
	db $40, $28
	db $46, $1E
	db $50, $18
	db $5B, $1E
	db $60, $28
	db $5B, $32
	db $50, $38
	db $46, $32
	db $48, $28
	db $50, $20
	db $58, $28
	db $50, $30
	db $50, $28
	db $FF ; list terminator

AnimationSquishMonPic_3:
; Squishes the mon's sprite horizontally making it
; disappear. Used by Teleport/Sky Attack animations.
	ld c, 4
.loop
	push bc
	ld a, [H_WHOSETURN]
	and a
	jr z, .playerTurn
	coord hl, 16, 0
	coord de, 14, 0
	jr .next
.playerTurn
	coord hl, 5, 5
	coord de, 3, 5
.next
	push de
	xor a ; left
	ld [wSquishMonCurrentDirection], a
	call _AnimationSquishMonPic_3
	pop hl
	ld a, 1 ; right
	ld [wSquishMonCurrentDirection], a
	call _AnimationSquishMonPic_3
	pop bc
	dec c
	jr nz, .loop
	call AnimationHideMonPic_3
	ld c, 2
	jp DelayFrame

_AnimationSquishMonPic_3:
	ld c, 7
.loop
	push bc
	push hl
	ld c, 3
	ld a, [wSquishMonCurrentDirection]
	cp 0
	jr nz, .right
	call AnimCopyRowLeft_3
	dec hl
	jr .next
.right
	call AnimCopyRowRight_3
	inc hl
.next
	ld [hl], " "
	pop hl
	ld de, SCREEN_WIDTH
	add hl, de
	pop bc
	dec c
	jr nz, .loop
	jp Delay3

AnimationShootBallsUpward_3:
; Shoots one pillar of "energy" balls upwards. Used in Teleport/Sky Attack
; animations.
	ld a, [H_WHOSETURN]
	and a
	jr z, .playerTurn
	lb bc, 0, 16 * 8
	jr .next
.playerTurn
	lb bc, 6 * 8, 5 * 8
.next
	ld a, b
	ld [wBaseCoordY], a
	ld a, c
	ld [wBaseCoordX], a
	lb bc, 5, 1
	call _AnimationShootBallsUpward_3
	jp AnimationCleanOAM_3

_AnimationShootBallsUpward_3:
	push bc
	xor a
	ld [wWhichBattleAnimTileset], a
	call LoadAnimationTileset_3
	pop bc
	ld d, $7a ; ball tile
	ld hl, wOAMBuffer
	push bc
	ld a, [wBaseCoordY]
	ld e, a
.initOAMLoop
	call BattleAnimWriteOAMEntry_3
	dec b
	jr nz, .initOAMLoop
	call DelayFrame
	pop bc
	ld a, b
	ld [wNumShootingBalls], a
.loop
	push bc
	ld hl, wOAMBuffer
.innerLoop
	ld a, [wBaseCoordY]
	add 8
	ld e, a
	ld a, [hl]
	cp e ; has the ball reached the top?
	jr z, .reachedTop
	add -4 ; ball hasn't reached the top. move it up 4 pixels
	ld [hl], a
	jr .next
.reachedTop
; remove the ball once it has reached the top
	ld [hl], 0 ; put it off-screen
	ld a, [wNumShootingBalls]
	dec a
	ld [wNumShootingBalls], a
.next
	ld de, 4
	add hl, de ; next OAM entry
	dec b
	jr nz, .innerLoop
	call DelayFrames
	pop bc
	ld a, [wNumShootingBalls]
	and a
	jr nz, .loop
	ret

AnimationShootManyBallsUpward_3:
; Shoots several pillars of "energy" balls upward.
	ld a, [H_WHOSETURN]
	and a
	ld hl, UpwardBallsAnimXCoordinatesPlayerTurn_3
	ld a, $50 ; y coordinate for "energy" ball pillar
	jr z, .player
	ld hl, UpwardBallsAnimXCoordinatesEnemyTurn_3
	ld a, $28 ; y coordinate for "energy" ball pillar
.player
	ld [wSavedY], a
.loop
	ld a, [wSavedY]
	ld [wBaseCoordY], a
	ld a, [hli]
	cp $ff
	jp z, AnimationCleanOAM_3
	ld [wBaseCoordX], a
	lb bc, 4, 1
	push hl
	call _AnimationShootBallsUpward_3
	pop hl
	jr .loop

UpwardBallsAnimXCoordinatesPlayerTurn_3:
; List of x coordinates for each pillar of "energy" balls in the
; AnimationShootManyBallsUpward animation. It's unused in the game.
	db $10, $40, $28, $18, $38, $30
	db $FF ; list terminator

UpwardBallsAnimXCoordinatesEnemyTurn_3:
; List of x coordinates for each pillar of "energy" balls in the
; AnimationShootManyBallsUpward animation. It's unused in the game.
	db $60, $90, $78, $68, $88, $80
	db $FF ; list terminator

AnimationMinimizeMon_3:
; Changes the mon's sprite to a mini black sprite. Used by the
; Minimize animation.
	call LoadMiniSprite_3			; replace the body of the function by this call to avoid code duplication
	call Delay3
	jp AnimationShowMonPic_3

MinimizedMonSprite_3:
	INCBIN "gfx/minimized_mon_sprite.1bpp"
MinimizedMonSpriteEnd_3:

; used by HideSubstituteShowMonAnim
LoadMiniSprite_3:
	ld hl, wTempPic
	push hl
	xor a
	ld bc, 7 * 7 * $10
	call FillMemory
	pop hl
	ld de, $194
	add hl, de
	ld de, MinimizedMonSprite_3
	ld c, MinimizedMonSpriteEnd_3 - MinimizedMonSprite_3
.loop
	ld a, [de]
	ld [hli], a
	ld [hli], a
	inc de
	dec c
	jr nz, .loop
	jp CopyTempPicToMonPic_3

AnimationSlideMonDownAndHide_3:
; Slides the mon's sprite down and disappears. Used in Acid Armor.
	ld a, $1
	ld c, $2
.loop
	push bc
	push af
	call AnimationHideMonPic_3
	pop af
	push af
	call GetTileIDList_3
	call GetMonSpriteTileMapPointerFromRowCount_3
	call CopyPicTiles_3
	ld c, 8
	call DelayFrames
	pop af
	inc a
	pop bc
	dec c
	jr nz, .loop
	jp AnimationHideMonPic_3

_AnimationSlideMonOff_3:
; Slides the mon's sprite off the screen horizontally by e tiles and waits
; [wSlideMonDelay] V-blanks each time the pic is slid by one tile.
	ld a, [H_WHOSETURN]
	and a
	jr z, .playerTurn
	coord hl, 12, 0
	jr .next
.playerTurn
	coord hl, 0, 5
.next
	ld d, 8 ; d's value is unused
.slideLoop ; iterates once for each time the pic slides by one tile
	push hl
	ld b, 7
.rowLoop ; iterates once for each row
	ld c, 8
.tileLoop ; iterates once for each tile in the row
	ld a, [H_WHOSETURN]
	and a
	jr z, .playerTurn2
	call .EnemyNextTile
	jr .next2
.playerTurn2
	call .PlayerNextTile
.next2
	ld [hli], a
	dec c
	jr nz, .tileLoop
	push de
	ld de, SCREEN_WIDTH - 8
	add hl, de
	pop de
	dec b
	jr nz, .rowLoop
	ld a, [wSlideMonDelay]
	ld c, a
	call DelayFrames
	pop hl
	dec d
	dec e
	jr nz, .slideLoop
	ret

; Since mon pic tile numbers go from top to bottom, left to right in order,
; adding the height of the mon pic in tiles to a tile number gives the tile
; number of the tile one column to the right (and thus subtracting the height
; gives the reverse). If the next tile would be past the edge of the pic, the 2
; functions below catch it by checking if the tile number is within the valid
; range and if not, replacing it with a blank tile.

.PlayerNextTile
	ld a, [hl]
	add 7
; This is a bug. The lower right corner tile of the mon back pic is blanked
; while the mon is sliding off the screen. It should compare with the max tile
; plus one instead.
	cp $62			; fix above bug
	ret c
	ld a, " "
	ret

.EnemyNextTile
	ld a, [hl]
	sub 7
; This has the same problem as above, but it has no visible effect because
; the lower right tile is in the first column to slide off the screen.
	cp $30
	ret c
	ld a, " "
	ret
	
AnimationSlideMonHalfOff_3:
; Slides the mon's sprite halfway off the screen. It's used in Softboiled.
	ld e, 4
	ld a, 4
	ld [wSlideMonDelay], a
	call _AnimationSlideMonOff_3
	jp Delay3

CopyTempPicToMonPic_3:
	ld a, [H_WHOSETURN]
	and a
	ld hl, vBackPic ; player turn
	jr z, .next
	ld hl, vFrontPic ; enemy turn
.next
	ld de, wTempPic
	ld bc, 7 * 7
	jp CopyVideoData

AnimationWavyScreen_3:
; used in Psywave/Psychic etc.
	ld hl, vBGMap0
	call BattleAnimCopyTileMapToVRAM_3
	call Delay3
	xor a
	ld [H_AUTOBGTRANSFERENABLED], a
	ld a, SCREEN_HEIGHT_PIXELS
	ld [hWY], a
	ld d, $80 ; terminator
	ld e, SCREEN_HEIGHT_PIXELS - 1
	ld c, $ff
	ld hl, WavyScreenLineOffsets_3
.loop
	push hl
.innerLoop
	call WavyScreen_SetSCX_3
	ld a, [rLY]
	cp e ; is it the last visible line in the frame?
	jr nz, .innerLoop ; keep going if not
	pop hl
	inc hl
	ld a, [hl]
	cp d ; have we reached the end?
	jr nz, .next
	ld hl, WavyScreenLineOffsets_3 ; go back to the beginning if so
.next
	dec c
	jr nz, .loop
	xor a
	ld [hWY], a
	call SaveScreenTilesToBuffer2
	call ClearScreen
	ld a, 1
	ld [H_AUTOBGTRANSFERENABLED], a
	call Delay3
	call LoadScreenTilesFromBuffer2
	ld hl, vBGMap1
	call BattleAnimCopyTileMapToVRAM_3
	ret

WavyScreen_SetSCX_3:
	ld a, [rSTAT]
	and $3 ; is it H-blank?
	jr nz, WavyScreen_SetSCX_3 ; wait until it's H-blank
	ld a, [hl]
	ld [rSCX], a
	inc hl
	ld a, [hl]
	cp d ; have we reached the end?
	ret nz
	ld hl, WavyScreenLineOffsets_3 ; go back to the beginning if so
	ret

WavyScreenLineOffsets_3:
; Sequence of horizontal line pixel offsets for the wavy screen animation.
; This sequence vaguely resembles a sine wave.
	db 0, 0, 0, 0, 0,  1,  1,  1,  2,  2,  2,  2,  2,  1,  1,  1
	db 0, 0, 0, 0, 0, -1, -1, -1, -2, -2, -2, -2, -2, -1, -1, -1
	db $80 ; terminator

AnimationSubstitute_3:
; Changes the pokemon's sprite to the mini sprite
	ld hl, wTempPic
	xor a
	ld bc, $0310
	call FillMemory
	ld a, [H_WHOSETURN]
	and a
	jr z, .playerTurn
	ld hl, SlowbroSprite ; facing down sprite
	ld de, wTempPic + $120
	call CopySlowbroSpriteData_3
	ld hl, SlowbroSprite + $10
	ld de, wTempPic + $120 + $70
	call CopySlowbroSpriteData_3
	ld hl, SlowbroSprite + $20
	ld de, wTempPic + $120 + $10
	call CopySlowbroSpriteData_3
	ld hl, SlowbroSprite + $30
	ld de, wTempPic + $120 + $10 + $70
	call CopySlowbroSpriteData_3
	jr .next
.playerTurn
	ld hl, SlowbroSprite + $40 ; facing up sprite
	ld de, wTempPic + $120 + $70
	call CopySlowbroSpriteData_3
	ld hl, SlowbroSprite + $50
	ld de, wTempPic + $120 + $e0
	call CopySlowbroSpriteData_3
	ld hl, SlowbroSprite + $60
	ld de, wTempPic + $120 + $80
	call CopySlowbroSpriteData_3
	ld hl, SlowbroSprite + $70
	ld de, wTempPic + $120 + $f0
	call CopySlowbroSpriteData_3
.next
	call CopyTempPicToMonPic_3
	jp AnimationShowMonPic_3

CopySlowbroSpriteData_3:
	ld bc, $0010
	ld a, BANK(SlowbroSprite)
	jp FarCopyData2

HideSubstituteShowMonAnim_3:
	ld a, [H_WHOSETURN]
	and a
	ld de, wBattleMonSpecies
	ld bc, wPlayerMonMinimized
	ld hl, wPlayerBattleStatus2
	jr z, .next1
	ld de, wEnemyMonSpecies
	ld bc, wEnemyMonMinimized
	ld hl, wEnemyBattleStatus2
.next1
	bit SUBSTITUTE_SHOWN, [hl]	; add this to avoid playing the sliding animation when the mon is already on screen
	ret z
	res SUBSTITUTE_SHOWN, [hl]
	push bc
	push hl
	push de
; if the substitute broke, slide it down, else slide it offscreen horizontally
	bit HAS_SUBSTITUTE_UP, [hl]
	jr nz, .substituteStillUp
	call AnimationSlideMonDown_3
	jr .next2
.substituteStillUp
	call AnimationSlideMonOff_3
.next2
	pop de
	pop hl
	pop bc
	dec hl							; make hl point to BattleStatus1
	bit INVULNERABLE, [hl]
	jr z, .showMonPic				; if mon isn't in the middle of Fly/Dig, show its picture
	ld a, [bc]						; check if mon is minimized
	and a
	jp nz, LoadMiniSprite_3			; if it is, load mini sprite instead of mon pic
	ld a, [de]
	ld [wMonSpeciesTemp], a			; to handle 2 bytes species IDs
	inc de							; to handle 2 bytes species IDs
	ld a, [de]						; to handle 2 bytes species IDs
	ld [wMonSpeciesTemp + 1], a		; to handle 2 bytes species IDs
	ld a, [H_WHOSETURN]				; otherwise, just load it in place of the substitute picture
	and a							; but don't display it yet
	jr z, .loadPlayerMonBackSprite
	xor a
	ld [wSpriteFlipped], a
	call GetMonHeader
	coord hl, 12, 0
	ld de, vFrontPic
	jp LoadMonFrontSprite
.loadPlayerMonBackSprite
	call GetMonHeader
	predef_jump LoadMonBackPic
.showMonPic
	ld a, [bc]
	and a
	jp nz, AnimationMinimizeMon_3
	call AnimationFlashMonPic_3
	jp AnimationShowMonPic_3

ReshowSubstituteAnim_3:
	ld hl, wPlayerBattleStatus2
	ld bc, wBattleMonHP
	ld a, [H_WHOSETURN]
	and a
	jr z, .animate
	ld hl, wEnemyBattleStatus2
	ld bc, wEnemyMonHP
.animate
	bit SUBSTITUTE_SHOWN, [hl]		; only reshow the substitute if it's not already on screen
	ret nz
	ld a, [bc]
	inc bc
	ld d, a
	ld a, [bc]
	or d
	ret z							; if the mon behind the substitute has zero HP, don't redraw the substitute
	set SUBSTITUTE_SHOWN, [hl]
	call AnimationSlideMonOff_3
	call AnimationSubstitute_3
	jp AnimationShowMonPic_3

AnimationBoundUpAndDown_3:
; Bounces the mon's sprite up and down several times. It is used
; by Splash's animation.
	ld c, 5
.loop
	push bc
	call AnimationSlideMonDown_3
	pop bc
	dec c
	jr nz, .loop
	jp AnimationShowMonPic_3

AnimationBoundUpAndDownFast_3:
; Bounces the mon's sprite up and down several times. It is used
; by Splash's animation.
	ld c, 2
.loop
	push bc
	call AnimationSlideMonDownFast_3
	pop bc
	dec c
	jr nz, .loop
	jp AnimationShowMonPic_3
	
AnimationTransformMon_3:
; Redraws this mon's sprite as the back/front sprite of the opposing mon.
; Used in Transform.
	ld a, [wEnemyMonSpecies]
	ld [wChangeMonPicPlayerTurnSpecies], a
	ld a, [wBattleMonSpecies]
	ld [wChangeMonPicEnemyTurnSpecies], a
	ld a, [wEnemyMonSpecies + 1]					; to handle 2 bytes species IDs
	ld [wChangeMonPicPlayerTurnSpecies + 1], a		; to handle 2 bytes species IDs
	ld a, [wBattleMonSpecies + 1]					; to handle 2 bytes species IDs
	ld [wChangeMonPicEnemyTurnSpecies + 1], a		; to handle 2 bytes species IDs

ChangeMonPic_3:
	ld a, [H_WHOSETURN]
	and a
	jr z, .playerTurn
	ld a, [wChangeMonPicEnemyTurnSpecies]
	ld [wMonSpeciesTemp], a							; to handle 2 bytes species IDs
	ld a, [wChangeMonPicEnemyTurnSpecies + 1]		; to handle 2 bytes species IDs
	ld [wMonSpeciesTemp + 1], a						; to handle 2 bytes species IDs
	xor a
	ld [wSpriteFlipped], a
	call GetMonHeader
	coord hl, 12, 0
	call LoadFrontSpriteByMonIndex
	jr .done
.playerTurn
	ld a, [wBattleMonSpecies2]
	push af
	ld a, [wChangeMonPicPlayerTurnSpecies]
	ld [wBattleMonSpecies2], a
	ld [wMonSpeciesTemp], a							; to handle 2 bytes species IDs
	ld a, [wChangeMonPicPlayerTurnSpecies + 1]		; to handle 2 bytes species IDs
	ld [wBattleMonSpecies2 + 1], a					; to handle 2 bytes species IDs
	ld [wMonSpeciesTemp + 1], a						; to handle 2 bytes species IDs
	call GetMonHeader
	predef LoadMonBackPic
	xor a
	call GetTileIDList_3
	call GetMonSpriteTileMapPointerFromRowCount_3
	call CopyPicTiles_3
	pop af
	ld [wBattleMonSpecies2], a
.done
	ld b, SET_PAL_BATTLE
	jp RunPaletteCommand

AnimationHideEnemyMonPic_3:
; Hides the enemy mon's sprite
	xor a
	ld [H_AUTOBGTRANSFERENABLED], a
	ld hl, AnimationHideMonPic_3
	call CallWithTurnFlipped_3
	ld a, $1
	ld [H_AUTOBGTRANSFERENABLED], a
	jp Delay3

InitMultipleObjectsOAM_3:
; Writes c OAM entries with tile d.
; Sets their Y coordinates to sequential multiples of 8, starting from 0.
; Sets their X coordinates to 0.
; Loads animation tileset a.
	push bc
	push de
	ld [wWhichBattleAnimTileset], a
	call LoadAnimationTileset_3
	pop de
	pop bc
	xor a
	ld e, a
	ld [wBaseCoordX], a
	ld hl, wOAMBuffer
.loop
	call BattleAnimWriteOAMEntry_3
	dec c
	jr nz, .loop
	ret

AnimationHideMonPic_3:
; Hides the mon's sprite.
	ld a, [H_WHOSETURN]
	and a
	jr z, .playerTurn
	ld a, 12
	jr ClearMonPicFromTileMap_3
.playerTurn
	ld a, 5 * SCREEN_WIDTH + 1

ClearMonPicFromTileMap_3:
	push hl
	push de
	push bc
	ld e, a
	ld d, 0
	coord hl, 0, 0
	add hl, de
	lb bc, 7, 7
	call ClearScreenArea
	pop bc
	pop de
	pop hl
	ret

; puts the tile map destination address of a mon sprite in hl, given the row count in b
; The usual row count is 7, but it may be smaller when sliding a mon sprite in/out,
; in order to show only a portion of the mon sprite.
GetMonSpriteTileMapPointerFromRowCount_3:
	push de
	ld a, [H_WHOSETURN]
	and a
	jr nz, .enemyTurn
	ld a, 20 * 5 + 1
	jr .next
.enemyTurn
	ld a, 12
.next
	coord hl, 0, 0
	ld e, a
	ld d, 0
	add hl, de
	ld a, 7
	sub b
	and a
	jr z, .done
	ld de, 20
.loop
	add hl, de
	dec a
	jr nz, .loop
.done
	pop de
	ret

; Input:
; a = tile ID list index
; Output:
; de = tile ID list pointer
; b = number of rows
; c = number of columns
GetTileIDList_3:
	ld hl, TileIDListPointerTable_3
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	add hl, de
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [hli]
	ld b, a
	and $f
	ld c, a
	ld a, b
	swap a
	and $f
	ld b, a
	ret

AnimCopyRowLeft_3:
; copy a row of c tiles 1 tile left
	ld a, [hld]
	ld [hli], a
	inc hl
	dec c
	jr nz, AnimCopyRowLeft_3
	ret

AnimCopyRowRight_3:
; copy a row of c tiles 1 tile right
	ld a, [hli]
	ld [hld], a
	dec hl
	dec c
	jr nz, AnimCopyRowRight_3
	ret

; get the sound of the move id in b
GetMoveSoundB_3:
	ld a, b
	call GetMoveSound_3
	ld b, a
	ret

; input: the animation id in a
; output:
; the move's sound id in a
; when the move is a Cry move, c contains the base cry id's high byte, otherwise it contains the input
GetMoveSound_3:
	ld hl, MoveSoundTable_3
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	add hl, de
	ld a, [hli]
	ld d, a
	call IsCryMove_3
	jr nc, .notCryMove
	ld a, [H_WHOSETURN]
	and a
	jr nz, .next
	ld a, [wBattleMonSpecies]		; get number of current monster
	ld b, a							; to handle 2 bytes species IDs
	ld a, [wBattleMonSpecies + 1]	; to handle 2 bytes species IDs
	ld c, a							; to handle 2 bytes species IDs
	jr .continue
.next
	ld a, [wEnemyMonSpecies]
	ld b, a							; to handle 2 bytes species IDs
	ld a, [wEnemyMonSpecies + 1]	; to handle 2 bytes species IDs
	ld c, a							; to handle 2 bytes species IDs
.continue
	push hl
	call ConvertSpeciesIDtoDexNumber; now we use dex number as input for GetCryData
	call GetCryData
	pop hl
	ld d, a
	ld a, [wFrequencyModifier]
	add [hl]
	ld [wFrequencyModifier], a
	jr nc, .noCarry
	ld a, [wFrequencyModifier + 1]
	inc a
	ld [wFrequencyModifier + 1], a
.noCarry
	inc hl
	ld a, [wTempoModifier]			; for 1st gen cries, do not use 2nd byte so that the sound produced remains the same
	add [hl]						; in the original games, the modifier rolls over for some cries, if we use 2 bytes, that doesn't happen
	ld [wTempoModifier], a
	jr nc, .noCarry2
	ld a, [wTempoModifier + 1]
	inc a
	ld [wTempoModifier + 1], a
.noCarry2
	ld a, c							; this part checks if cry id corresponds to a gen 1 cry, for which we need to reset modifiers high bytes
	and a							; because they only used 1 byte in gen 1. Requires that gen cry ids are not reused by post gen 1 cries!
	jr nz, .done					; if cry id high byte is not zero, then it's not a gen 1 cry, no need to reset modifiers high bytes
	ld a, b							; if cry id high byte is zero, check low byte
	cp $26 + 1						; compare it to the last base cry id of the original gen 1 pokemon + 1
	jr nc, .done					; if cry id low byte is higher than the last gen 1 cry id, then it's not a gen 1 cry, no need to reset modifiers high bytes
	jr .resetModsHighBytes
.notCryMove
	ld a, [hli]
	ld [wFrequencyModifier], a
	ld a, [hli]
	ld [wTempoModifier], a
.resetModsHighBytes
	xor a
	ld [wFrequencyModifier + 1], a	; reset the high byte since it's not used for battle sfx
	ld [wTempoModifier + 1], a		; reset the high byte since it's not used for battle sfx
.done
	ld a, d
	ret

IsCryMove_3:
; set carry if the move animation involves playing a monster cry
	ld a, [wAnimationID]
	cp HOWL
	jr z, .CryMove
	and a ; clear carry
	ret
.CryMove
	scf
	ret

MoveSoundTable_3:
	; ID, pitch mod, tempo mod
	db SFX_POUND,             $00,$80 ; POUND
	db SFX_BATTLE_0C,         $10,$80 ; KARATE_CHOP
	db SFX_DOUBLESLAP,        $00,$80 ; DOUBLESLAP
	db SFX_BATTLE_0B,         $01,$80 ; COMET_PUNCH
	db SFX_BATTLE_0D,         $00,$40 ; MEGA_PUNCH
	db SFX_SILPH_SCOPE,       $00,$ff ; PAY_DAY
	db SFX_BATTLE_0D,         $10,$60 ; FIRE_PUNCH
	db SFX_BATTLE_0D,         $20,$80 ; ICE_PUNCH
	db SFX_BATTLE_0D,         $00,$a0 ; THUNDERPUNCH
	db SFX_DAMAGE,            $00,$80 ; SCRATCH
	db SFX_BATTLE_0F,         $20,$40 ; VICEGRIP
	db SFX_BATTLE_0F,         $00,$80 ; GUILLOTINE
	db SFX_BATTLE_0E,         $00,$a0 ; RAZOR_WIND
	db SFX_NOT_VERY_EFFECTIVE,$10,$c0 ; SWORDS_DANCE
	db SFX_NOT_VERY_EFFECTIVE,$00,$a0 ; CUT
	db SFX_BATTLE_12,         $00,$c0 ; GUST
	db SFX_BATTLE_12,         $10,$a0 ; WING_ATTACK
	db SFX_BATTLE_13,         $00,$e0 ; WHIRLWIND
	db SFX_NOT_VERY_EFFECTIVE,$20,$c0 ; FLY
	db SFX_BATTLE_14,         $00,$80 ; BIND
	db SFX_BATTLE_22,         $00,$80 ; SLAM
	db SFX_VINE_WHIP,         $01,$80 ; VINE_WHIP
	db SFX_BATTLE_20,         $00,$80 ; STOMP
	db SFX_BATTLE_17,         $f0,$40 ; DOUBLE_KICK
	db SFX_SUPER_EFFECTIVE,   $00,$80 ; MEGA_KICK
	db SFX_BATTLE_17,         $00,$80 ; JUMP_KICK
	db SFX_BATTLE_21,         $10,$80 ; ROLLING_KICK
	db SFX_BATTLE_1B,         $01,$a0 ; SAND_ATTACK
	db SFX_BATTLE_18,         $00,$80 ; HEADBUTT
	db SFX_BATTLE_1E,         $00,$60 ; HORN_ATTACK
	db SFX_BATTLE_1E,         $01,$40 ; FURY_ATTACK
	db SFX_HORN_DRILL,        $00,$a0 ; HORN_DRILL
	db SFX_SUPER_EFFECTIVE,   $10,$a0 ; TACKLE
	db SFX_BATTLE_20,         $00,$c0 ; BODY_SLAM
	db SFX_BATTLE_14,         $10,$60 ; WRAP
	db SFX_SUPER_EFFECTIVE,   $00,$a0 ; TAKE_DOWN
	db SFX_BATTLE_22,         $11,$c0 ; THRASH
	db SFX_SUPER_EFFECTIVE,   $20,$c0 ; DOUBLE_EDGE
	db SFX_BATTLE_21,         $00,$80 ; TAIL_WHIP
	db SFX_BATTLE_1B,         $00,$80 ; POISON_STING
	db SFX_BATTLE_1B,         $20,$c0 ; TWINEEDLE
	db SFX_BATTLE_19,         $00,$80 ; PIN_MISSILE
	db SFX_BATTLE_31,         $ff,$40 ; LEER
	db SFX_BATTLE_1E,         $00,$80 ; BITE
	db SFX_BATTLE_0B,         $00,$c0 ; GROWL
	db SFX_BATTLE_0B,         $00,$40 ; ROAR
	db SFX_BATTLE_35,         $00,$80 ; SING
	db SFX_BATTLE_27,         $40,$60 ; SUPERSONIC
	db SFX_BATTLE_27,         $00,$80 ; SONICBOOM
	db SFX_BATTLE_27,         $ff,$40 ; DISABLE
	db SFX_BATTLE_2A,         $80,$c0 ; ACID
	db SFX_BATTLE_19,         $10,$a0 ; EMBER
	db SFX_BATTLE_19,         $21,$e0 ; FLAMETHROWER
	db SFX_BATTLE_29,         $00,$80 ; MIST
	db SFX_BATTLE_24,         $20,$60 ; WATER_GUN
	db SFX_BATTLE_2A,         $00,$80 ; HYDRO_PUMP
	db SFX_BATTLE_2C,         $00,$80 ; SURF
	db SFX_BATTLE_28,         $40,$80 ; ICE_BEAM
	db SFX_BATTLE_29,         $f0,$e0 ; BLIZZARD
	db SFX_PSYBEAM,           $00,$80 ; PSYBEAM
	db SFX_BATTLE_2A,         $f0,$60 ; BUBBLEBEAM
	db SFX_BATTLE_28,         $00,$80 ; AURORA_BEAM
	db SFX_BATTLE_36,         $00,$80 ; HYPER_BEAM
	db SFX_PECK,              $01,$a0 ; PECK
	db SFX_BATTLE_13,         $f0,$20 ; DRILL_PECK
	db SFX_BATTLE_23,         $01,$c0 ; SUBMISSION
	db SFX_BATTLE_23,         $00,$80 ; LOW_KICK
	db SFX_SUPER_EFFECTIVE,   $00,$e0 ; COUNTER
	db SFX_BATTLE_26,         $01,$60 ; SEISMIC_TOSS
	db SFX_BATTLE_26,         $20,$40 ; STRENGTH
	db SFX_BATTLE_24,         $00,$80 ; ABSORB
	db SFX_BATTLE_24,         $40,$c0 ; MEGA_DRAIN
	db SFX_BATTLE_1B,         $03,$60 ; LEECH_SEED
	db SFX_BATTLE_25,         $11,$e0 ; GROWTH
	db SFX_BATTLE_12,         $20,$e0 ; RAZOR_LEAF
	db SFX_BATTLE_2E,         $00,$80 ; SOLARBEAM
	db SFX_BATTLE_1C,         $00,$80 ; POISONPOWDER
	db SFX_BATTLE_1C,         $11,$a0 ; STUN_SPORE
	db SFX_BATTLE_1C,         $01,$c0 ; SLEEP_POWDER
	db SFX_BATTLE_13,         $14,$c0 ; PETAL_DANCE
	db SFX_BATTLE_1B,         $02,$a0 ; STRING_SHOT
	db SFX_BATTLE_29,         $f0,$80 ; DRAGON_RAGE
	db SFX_BATTLE_29,         $20,$c0 ; FIRE_SPIN
	db SFX_BATTLE_2F,         $00,$20 ; THUNDERSHOCK
	db SFX_BATTLE_2F,         $20,$80 ; THUNDERBOLT
	db SFX_BATTLE_2E,         $12,$60 ; THUNDER_WAVE
	db SFX_BATTLE_26,         $00,$80 ; THUNDER
	db SFX_BATTLE_14,         $01,$e0 ; ROCK_THROW
	db SFX_BATTLE_29,         $0f,$e0 ; EARTHQUAKE
	db SFX_BATTLE_29,         $11,$20 ; FISSURE
	db SFX_DAMAGE,            $10,$40 ; DIG
	db SFX_BATTLE_0F,         $10,$c0 ; TOXIC
	db SFX_BATTLE_14,         $00,$20 ; CONFUSION
	db SFX_PSYCHIC_M,         $00,$80 ; PSYCHIC_M
	db SFX_BATTLE_35,         $11,$18 ; HYPNOSIS
	db SFX_BATTLE_09,         $20,$c0 ; MEDITATE
	db SFX_FAINT_FALL,        $20,$c0 ; AGILITY
	db SFX_BATTLE_25,         $00,$10 ; QUICK_ATTACK
	db SFX_BATTLE_26,         $f0,$20 ; RAGE
	db SFX_BATTLE_33,         $f0,$c0 ; TELEPORT
	db SFX_NOT_VERY_EFFECTIVE,$f0,$e0 ; NIGHT_SHADE
	db SFX_BATTLE_09,         $f0,$40 ; MIMIC
	db SFX_BATTLE_31,         $00,$80 ; SCREECH
	db SFX_BATTLE_33,         $80,$40 ; DOUBLE_TEAM
	db SFX_BATTLE_33,         $00,$80 ; RECOVER
	db SFX_BATTLE_14,         $11,$20 ; HARDEN
	db SFX_BATTLE_14,         $22,$10 ; MINIMIZE
	db SFX_BATTLE_1B,         $f1,$ff ; SMOKESCREEN
	db SFX_BATTLE_13,         $f1,$ff ; CONFUSE_RAY
	db SFX_BATTLE_14,         $33,$30 ; WITHDRAW
	db SFX_BATTLE_32,         $40,$c0 ; DEFENSE_CURL
	db SFX_BATTLE_0E,         $20,$20 ; BARRIER
	db SFX_BATTLE_0E,         $f0,$10 ; LIGHT_SCREEN
	db SFX_BATTLE_0F,         $f8,$10 ; HAZE
	db SFX_NOT_VERY_EFFECTIVE,$f0,$10 ; REFLECT
	db SFX_BATTLE_25,         $00,$80 ; FOCUS_ENERGY
	db SFX_BATTLE_18,         $00,$c0 ; BIDE
	db SFX_BATTLE_32,         $c0,$ff ; METRONOME
	db SFX_BATTLE_09,         $f2,$20 ; MIRROR_MOVE
	db SFX_BATTLE_34,         $00,$80 ; SELFDESTRUCT
	db SFX_BATTLE_34,         $00,$40 ; EGG_BOMB
	db SFX_BATTLE_09,         $00,$40 ; LICK
	db SFX_NOT_VERY_EFFECTIVE,$10,$ff ; SMOG
	db SFX_BATTLE_2A,         $20,$20 ; SLUDGE
	db SFX_BATTLE_32,         $00,$80 ; BONE_CLUB
	db SFX_BATTLE_29,         $1f,$20 ; FIRE_BLAST
	db SFX_BATTLE_25,         $2f,$80 ; WATERFALL
	db SFX_BATTLE_0F,         $1f,$ff ; CLAMP
	db SFX_BATTLE_2B,         $1f,$60 ; SWIFT
	db SFX_BATTLE_26,         $1e,$20 ; SKULL_BASH
	db SFX_BATTLE_26,         $1f,$18 ; SPIKE_CANNON
	db SFX_BATTLE_14,         $0f,$80 ; CONSTRICT
	db SFX_BATTLE_09,         $f8,$10 ; AMNESIA
	db SFX_FAINT_FALL,        $18,$20 ; KINESIS
	db SFX_BATTLE_32,         $08,$40 ; SOFTBOILED
	db SFX_BATTLE_17,         $01,$e0 ; HI_JUMP_KICK
	db SFX_NOT_VERY_EFFECTIVE,$09,$ff ; GLARE
	db SFX_BATTLE_35,         $42,$01 ; DREAM_EATER
	db SFX_BATTLE_1C,         $00,$ff ; POISON_GAS
	db SFX_BATTLE_32,         $08,$e0 ; BARRAGE
	db SFX_BATTLE_24,         $00,$80 ; LEECH_LIFE
	db SFX_BATTLE_09,         $88,$10 ; LOVELY_KISS
	db SFX_BATTLE_25,         $48,$ff ; SKY_ATTACK
	db SFX_FAINT_FALL,        $ff,$ff ; TRANSFORM
	db SFX_BATTLE_24,         $ff,$10 ; BUBBLE
	db SFX_FAINT_FALL,        $ff,$04 ; DIZZY_PUNCH
	db SFX_BATTLE_1C,         $01,$ff ; SPORE
	db SFX_BATTLE_13,         $f8,$ff ; FLASH
	db SFX_BATTLE_0C,         $f0,$f0 ; PSYWAVE
	db SFX_BATTLE_0F,         $08,$10 ; SPLASH
	db SFX_BATTLE_0D,         $f0,$ff ; ACID_ARMOR
	db SFX_SUPER_EFFECTIVE,   $f0,$ff ; CRABHAMMER
	db SFX_BATTLE_34,         $10,$ff ; EXPLOSION
	db SFX_BATTLE_0E,         $f0,$20 ; FURY_SWIPES
	db SFX_BATTLE_2B,         $f0,$60 ; BONEMERANG
	db SFX_BATTLE_21,         $12,$10 ; REST
	db SFX_BATTLE_36,         $f0,$20 ; ROCK_SLIDE
	db SFX_BATTLE_1E,         $12,$ff ; HYPER_FANG
	db SFX_BATTLE_31,         $80,$04 ; SHARPEN
	db SFX_BATTLE_33,         $f0,$10 ; CONVERSION
	db SFX_BATTLE_29,         $f8,$ff ; TRI_ATTACK
	db SFX_BATTLE_26,         $f0,$ff ; SUPER_FANG
	db SFX_NOT_VERY_EFFECTIVE,$01,$ff ; SLASH
	db SFX_BATTLE_2C,         $d8,$04 ; SUBSTITUTE
	db SFX_BATTLE_0B,         $00,$80 ; STRUGGLE
	db SFX_PSYCHIC_M,         $20,$a0 ; FAIRY_WIND
	db SFX_PSYCHIC_M,         $05,$f0 ; MOONBLAST ($a6)
	db SFX_PSYBEAM,           $20,$20 ; NASTY_PLOT
	db SFX_BATTLE_2F,         $10,$50 ; SHOCK_WAVE
	db SFX_BATTLE_2E,         $f0,$b0 ; ENERGY_BALL also used by HYPER_VOICE to get frequency and tempo modifiers for the cry
	db SFX_BATTLE_2B,         $10,$60 ; LEAF_STORM
	db SFX_BATTLE_12,         $21,$d0 ; LEAF_STORM
	db SFX_BATTLE_27,         $48,$80 ; DRILL_RUN
	db SFX_BATTLE_2A,         $20,$00 ; MUD_BOMB
	db SFX_SILPH_SCOPE,       $10,$ff ; CALM_MIND
	db SFX_FAINT_THUD,        $00,$80 ; AQUA_JET
	db SFX_PSYBEAM,           $30,$00 ; SIGNAL_BEAM ($b0)
	db SFX_BATTLE_27,         $40,$ff ; BUG_BUZZ
	db SFX_BATTLE_25,         $00,$60 ; SILVER_WIND
	db SFX_BATTLE_36,         $30,$00 ; POWER_GEM
	db SFX_BATTLE_2F,         $2c,$80 ; DRAGON_PULSE
	db SFX_BATTLE_2F,         $1c,$80 ; DRAGON_DANCE
	db SFX_BATTLE_0E,         $10,$80 ; FLASH_CANNON
	db SFX_BATTLE_2F,         $24,$80
	db SFX_PSYCHIC_M,         $42,$01 ; DARK_PULSE
	db SFX_BATTLE_31,         $10,$80 ; METAL SOUND

CopyPicTiles_3:
	ld a, [H_WHOSETURN]
	and a
	ld a, $31 ; base tile ID of player mon sprite
	jr z, .next
; enemy turn
	xor a ; base tile ID of enemy mon sprite
.next
	ld [hBaseTileID], a
	jr CopyTileIDs_NoBGTransfer_3

; copy the tiles used when a mon is being sent out of or into a pokeball
CopyDownscaledMonTiles_3:
	call GetPredefRegisters
	ld a, [wDownscaledMonSize]
	and a
	jr nz, .smallerSize
	ld de, DownscaledMonTiles_5x5_3
	jr CopyTileIDs_NoBGTransfer_3
.smallerSize
	ld de, DownscaledMonTiles_3x3_3
; fall through

CopyTileIDs_NoBGTransfer_3:
	xor a
	ld [H_AUTOBGTRANSFERENABLED], a
; fall through

; b = number of rows
; c = number of columns
CopyTileIDs_3:
	push hl
.rowLoop
	push bc
	push hl
	ld a, [hBaseTileID]
	ld b, a
.columnLoop
	ld a, [de]
	add b
	inc de
	ld [hli], a
	dec c
	jr nz, .columnLoop
	pop hl
	ld bc, 20
	add hl, bc
	pop bc
	dec b
	jr nz, .rowLoop
	ld a, $1
	ld [H_AUTOBGTRANSFERENABLED], a
	pop hl
	ret

TileIDListPointerTable_3:
	dw Unknown_79b24_3
	dn 7, 7
	dw Unknown_79b55_3
	dn 5, 7
	dw Unknown_79b78_3
	dn 3, 7
	dw Unknown_79c20_3
	dn 8, 6
	dw Unknown_79c50_3
	dn 3, 12

DownscaledMonTiles_5x5_3:
	db $31,$38,$46,$54,$5B
	db $32,$39,$47,$55,$5C
	db $34,$3B,$49,$57,$5E
	db $36,$3D,$4B,$59,$60
	db $37,$3E,$4C,$5A,$61

DownscaledMonTiles_3x3_3:
	db $31,$46,$5B
	db $34,$49,$5E
	db $37,$4C,$61

Unknown_79b24_3:
	db $00,$07,$0E,$15,$1C,$23,$2A
	db $01,$08,$0F,$16,$1D,$24,$2B
	db $02,$09,$10,$17,$1E,$25,$2C
	db $03,$0A,$11,$18,$1F,$26,$2D
	db $04,$0B,$12,$19,$20,$27,$2E
	db $05,$0C,$13,$1A,$21,$28,$2F
	db $06,$0D,$14,$1B,$22,$29,$30

Unknown_79b55_3:
	db $00,$07,$0E,$15,$1C,$23,$2A
	db $01,$08,$0F,$16,$1D,$24,$2B
	db $03,$0A,$11,$18,$1F,$26,$2D
	db $04,$0B,$12,$19,$20,$27,$2E
	db $05,$0C,$13,$1A,$21,$28,$2F

Unknown_79b78_3:
	db $00,$07,$0E,$15,$1C,$23,$2A
	db $02,$09,$10,$17,$1E,$25,$2C
	db $04,$0B,$12,$19,$20,$27,$2E

Unknown_79c20_3:
	db $31,$32,$32,$32,$32,$33
	db $34,$35,$36,$36,$37,$38
	db $34,$39,$3A,$3A,$3B,$38
	db $3C,$3D,$3E,$3E,$3F,$40
	db $41,$42,$43,$43,$44,$45
	db $46,$47,$43,$48,$49,$4A
	db $41,$43,$4B,$4C,$4D,$4E
	db $4F,$50,$50,$50,$51,$52

Unknown_79c50_3:
	db $43,$55,$56,$53,$53,$53,$53,$53,$53,$53,$53,$53
	db $43,$57,$58,$54,$54,$54,$54,$54,$54,$54,$54,$54
	db $43,$59,$5A,$43,$43,$43,$43,$43,$43,$43,$43,$43

AnimationLeavesFalling_3:
; Makes leaves float down from the top of the screen. This is used
; in Razor Leaf's animation.
	ld a, [rOBP0]
	push af
	ld a, [wAnimPalette]
	ld [rOBP0], a
	ld d, $37 ; leaf tile
	ld a, 3 ; number of leaves
	ld [wNumFallingObjects], a
	call AnimationFallingObjects_3
	pop af
	ld [rOBP0], a
	ret

AnimationPetalsFalling_3:
; Makes lots of petals fall down from the top of the screen. It's used in
; the animation for Petal Dance.
	ld d, $71 ; petal tile
	ld a, 20 ; number of petals
	ld [wNumFallingObjects], a
	call AnimationFallingObjects_3
	jp ClearSprites

AnimationFallingObjects_3:
	ld c, a
	ld a, 1
	call InitMultipleObjectsOAM_3
	call FallingObjects_InitXCoords_3
	call FallingObjects_InitMovementData_3
	ld hl, wOAMBuffer
	ld [hl], 0
.loop
	ld hl, wFallingObjectsMovementData
	ld de, 0
	ld a, [wNumFallingObjects]
	ld c, a
.innerLoop
	push bc
	push hl
	push de
	ld a, [hl]
	ld [wFallingObjectMovementByte], a
	call FallingObjects_UpdateMovementByte_3
	call FallingObjects_UpdateOAMEntry_3
	pop de
	ld hl, 4
	add hl, de
	ld e, l
	ld d, h
	pop hl
	ld a, [wFallingObjectMovementByte]
	ld [hli], a
	pop bc
	dec c
	jr nz, .innerLoop
	call Delay3
	ld hl, wOAMBuffer
	ld a, [hl] ; Y
	cp 104 ; has the top falling object reached 104 yet?
	jr nz, .loop ; keep moving the falling objects down until it does
	ret

FallingObjects_UpdateOAMEntry_3:
; Increases Y by 2 pixels and adjusts X and X flip based on the falling object's
; movement byte.
	ld hl, wOAMBuffer
	add hl, de
	ld a, [hl]
	inc a
	inc a
	cp 112
	jr c, .next
	ld a, 160 ; if Y >= 112, put it off-screen
.next
	ld [hli], a ; Y
	ld a, [wFallingObjectMovementByte]
	ld b, a
	ld de, FallingObjects_DeltaXs_3
	and $7f
	add e
	jr nc, .noCarry
	inc d
.noCarry
	ld e, a
	ld a, b
	and $80
	jr nz, .movingLeft
; moving right
	ld a, [de]
	add [hl]
	ld [hli], a ; X
	inc hl
	xor a ; no horizontal flip
	jr .next2
.movingLeft
	ld a, [de]
	ld b, a
	ld a, [hl]
	sub b
	ld [hli], a ; X
	inc hl
	ld a, (1 << OAM_X_FLIP)
.next2
	ld [hl], a ; attribute
	ret

FallingObjects_DeltaXs_3:
	db 0, 1, 3, 5, 7, 9, 11, 13, 15

FallingObjects_UpdateMovementByte_3:
	ld a, [wFallingObjectMovementByte]
	inc a
	ld b, a
	and $7f
	cp 9 ; have we reached the end of the delta-Xs?
	ld a, b
	jr nz, .next
; We've reached the end of the delta-Xs, so wrap to the start and change
; direction from right to left or vice versa.
	and $80
	xor $80
.next
	ld [wFallingObjectMovementByte], a
	ret

FallingObjects_InitXCoords_3:
	ld hl, wOAMBuffer + $01
	ld de, FallingObjects_InitialXCoords_3
	ld a, [wNumFallingObjects]
	ld c, a
.loop
	ld a, [de]
	ld [hli], a
	inc hl
	inc hl
	inc hl
	inc de
	dec c
	jr nz, .loop
	ret

FallingObjects_InitialXCoords_3:
	db $38,$40,$50,$60,$70,$88,$90,$56,$67,$4A,$77,$84,$98,$32,$22,$5C,$6C,$7D,$8E,$99

FallingObjects_InitMovementData_3:
	ld hl, wFallingObjectsMovementData
	ld de, FallingObjects_InitialMovementData_3
	ld a, [wNumFallingObjects]
	ld c, a
.loop
	ld a, [de]
	ld [hli], a
	inc de
	dec c
	jr nz, .loop
	ret

FallingObjects_InitialMovementData_3:
	db $00,$84,$06,$81,$02,$88,$01,$83,$05,$89,$09,$80,$07,$87,$03,$82,$04,$85,$08,$86

AnimationShakeEnemyHUD_3:
; Shakes the enemy HUD.

; Make a copy of the back pic's tile patterns in sprite tile pattern VRAM.
	ld de, vBackPic
	ld hl, vSprites
	ld bc, 7 * 7
	call CopyVideoData

	xor a
	ld [hSCX], a

; Copy wTileMap to BG map 0. The regular BG (not the window) is set to use
; map 0 and can be scrolled with SCX, which allows a shaking effect.
	ld hl, vBGMap0
	call BattleAnimCopyTileMapToVRAM_3

; Now that the regular BG is showing the same thing the window was, move the
; window off the screen so that we can modify its contents below.
	ld a, SCREEN_HEIGHT_PIXELS
	ld [hWY], a

; Copy wTileMap to VRAM such that the row below the enemy HUD (in wTileMap) is
; lined up with row 0 of the window.
	ld hl, vBGMap1 - $20 * 7
	call BattleAnimCopyTileMapToVRAM_3

; Move the window so that the row below the enemy HUD (in BG map 0) lines up
; with the top row of the window on the screen. This makes it so that the window
; covers everything below the enemy HD with a copy that looks just like what
; was there before.
	ld a, 7 * 8
	ld [hWY], a

; Write OAM entries so that the copy of the back pic from the top of this
; function shows up on screen. We need this because the back pic's Y coordinates
; range overlaps with that of the enemy HUD and we don't want to shake the top
; of the back pic when we shake the enemy HUD. The OAM copy won't be affected
; by SCX.
	call ShakeEnemyHUD_WritePlayerMonPicOAM_3

	ld hl, vBGMap0
	call BattleAnimCopyTileMapToVRAM_3

; Remove the back pic from the BG map.
	call AnimationHideMonPic_3
	call Delay3

; Use SCX to shake the regular BG. The window and the back pic OAM copy are
; not affected.
	lb de, 2, 8
	call ShakeEnemyHUD_ShakeBG_3

; Restore the original graphics.
	call AnimationShowMonPic_3
	call ClearSprites
	ld a, SCREEN_HEIGHT_PIXELS
	ld [hWY], a
	ld hl, vBGMap1
	call BattleAnimCopyTileMapToVRAM_3
	xor a
	ld [hWY], a
	call SaveScreenTilesToBuffer1
	ld hl, vBGMap0
	call BattleAnimCopyTileMapToVRAM_3
	call ClearScreen
	call Delay3
	call LoadScreenTilesFromBuffer1
	ld hl, vBGMap1
	jp BattleAnimCopyTileMapToVRAM_3

; b = tile ID list index
; c = base tile ID
CopyTileIDsFromList_3:
	call GetPredefRegisters
	ld a, c
	ld [hBaseTileID], a
	ld a, b
	push hl
	call GetTileIDList_3
	pop hl
	jp CopyTileIDs_3

ShakeEnemyHUD_ShakeBG_3:
	ld a, [hSCX]
	ld [wTempSCX], a
.loop
	ld a, [wTempSCX]
	add d
	ld [hSCX], a
	ld c, 2
	call DelayFrames
	ld a, [wTempSCX]
	sub d
	ld [hSCX], a
	ld c, 2
	call DelayFrames
	dec e
	jr nz, .loop
	ld a, [wTempSCX]
	ld [hSCX], a
	ret

BattleAnimCopyTileMapToVRAM_3:
	ld a, h
	ld [H_AUTOBGTRANSFERDEST + 1], a
	ld a, l
	ld [H_AUTOBGTRANSFERDEST], a
	jp Delay3

PlayApplyingAttackSound_3:
; play a different sound depending if move is not very effective, neutral, or super-effective
; don't play any sound at all if move is ineffective
	call WaitForSoundToFinish
	ld a, [wDamageMultipliers]
	and $7f
	ret z
	cp NEUTRAL
	ld a, $20
	ld b, $30
	ld c, SFX_DAMAGE
	jr z, .playSound
	ld a, $e0
	ld b, $ff
	ld c, SFX_SUPER_EFFECTIVE
	jr nc, .playSound
	ld a, $50
	ld b, $1
	ld c, SFX_NOT_VERY_EFFECTIVE
.playSound
	ld [wFrequencyModifier], a
	ld a, b
	ld [wTempoModifier], a
	xor a
	ld [wFrequencyModifier + 1], a	; reset the high byte since it's not used for battle sfx
	ld [wTempoModifier + 1], a		; reset the high byte since it's not used for battle sfx
	ld a, c
	jp PlaySound

CallHideSubstituteShowMonAnim__3:
	ld a, [H_WHOSETURN]
	and a
	ld a, [wPlayerBattleStatus2]
	jr z, .main
	ld a, [wEnemyBattleStatus2]
.main
	bit HAS_SUBSTITUTE_UP, a
	call nz, HideSubstituteShowMonAnim_3
	ret

CallReshowSubstituteAnim__3:
	ld a, [H_WHOSETURN]
	and a
	ld a, [wPlayerBattleStatus2]
	jr z, .main
	ld a, [wEnemyBattleStatus2]
.main
	bit HAS_SUBSTITUTE_UP, a
	call nz, ReshowSubstituteAnim_3
	ret
