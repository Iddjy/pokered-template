INCLUDE "constants.asm"

flag_array: MACRO
	ds ((\1) + 7) / 8
ENDM

box_struct_length EQU 22 + NUM_MOVES * 2	; updated the length after adding Special Defense
box_struct: MACRO
\1Species::          dw
\1HP::               dw
\1BoxLevel::         db
\1Status::           db
\1Type::
\1Type1::            db
\1Type2::            db
\1Moves::            ds NUM_MOVES
\1OTID::             dw
\1EVs::
\1HPEV::             db
\1AttackEV::         db
\1DefenseEV::        db
\1SpeedEV::          db
\1SpecialAttackEV::  db
\1SpecialDefenseEV:: db
\1Exp::              ds 3			; moved after EVs so that wEnemyMonDVs - wEnemyMonHP in battle_struct remains the same distance as
									; wPartyMon1DVs - (wPartyMon1HPEV - 1) in party_struct after adding Special Defense stat exp,
									; because CalcStat relies on the fact that these 2 distances are equal to work both when it is
									; called with a party_struct and with a battle_struct
\1DVs::              ds 3			; added one more byte to hold special defense DV, DVs are now stored in the following order:
									; Attack/Defense - Speed/HP - Special Defense/Special Attack
\1PP::               ds NUM_MOVES
ENDM

party_struct: MACRO
	box_struct \1
\1Level::             db
\1Stats::
\1MaxHP::             dw
\1Attack::            dw
\1Defense::           dw
\1Speed::             dw
\1SpecialAttack::     dw
\1SpecialDefense::    dw
ENDM

battle_struct: MACRO
\1Species::           dw
\1HP::                dw
\1PartyPos::
\1BoxLevel::          db
\1Status::            db
\1Type::
\1Type1::             db
\1Type2::             db
\1Moves::             ds NUM_MOVES
\1DVs::               ds 3				; added one more byte to hold special defense DV
\1Level::             db
\1Stats::
\1MaxHP::             dw
\1Attack::            dw
\1Defense::           dw
\1Speed::             dw
\1SpecialAttack::     dw
\1SpecialDefense::    dw
\1PP::                ds NUM_MOVES
ENDM


SECTION "WRAM Bank 0", WRAM0

wUnusedC000:: ; c000
	ds 1

wSoundID:: ; c001
	ds 1

wMuteAudioAndPauseMusic:: ; c002
; bit 7: whether sound has been muted
; all bits: whether the effective is active
; Store 1 to activate effect (any value in the range [1, 127] works).
; All audio is muted and music is paused. Sfx continues playing until it
; ends normally.
; Store 0 to resume music.
	ds 1

wDisableChannelOutputWhenSfxEnds:: ; c003
	ds 1

wStereoPanning:: ; c004
	ds 1

wSavedVolume:: ; c005
	ds 1

wChannelCommandPointers:: ; c006
	ds 16

wChannelReturnAddresses:: ; c016
	ds 16

wChannelSoundIDs:: ; c026
	ds 8

wChannelFlags1:: ; c02e
	ds 8

wChannelFlags2:: ; c036
	ds 8

wChannelDuties:: ; c03e
	ds 8

wChannelDutyCycles:: ; c046
	ds 8

wChannelVibratoDelayCounters:: ; c04e
; reloaded at the beginning of a note. counts down until the vibrato begins.
	ds 8

wChannelVibratoExtents:: ; c056
	ds 8

wChannelVibratoRates:: ; c05e
; high nybble is rate (counter reload value) and low nybble is counter.
; time between applications of vibrato.
	ds 8

wChannelFrequencyLowBytes:: ; c066
	ds 8

wChannelVibratoDelayCounterReloadValues:: ; c06e
; delay of the beginning of the vibrato from the start of the note
	ds 8

wChannelPitchBendLengthModifiers:: ; c076
	ds 8

wChannelPitchBendFrequencySteps:: ; c07e
	ds 8

wChannelPitchBendFrequencyStepsFractionalPart:: ; c086
	ds 8

wChannelPitchBendCurrentFrequencyFractionalPart:: ; c08e
	ds 8

wChannelPitchBendCurrentFrequencyHighBytes:: ; c096
	ds 8

wChannelPitchBendCurrentFrequencyLowBytes:: ; c09e
	ds 8

wChannelPitchBendTargetFrequencyHighBytes:: ; c0a6
	ds 8

wChannelPitchBendTargetFrequencyLowBytes:: ; c0ae
	ds 8

wChannelNoteDelayCounters:: ; c0b6
; Note delays are stored as 16-bit fixed-point numbers where the integer part
; is 8 bits and the fractional part is 8 bits.
	ds 8

wChannelLoopCounters:: ; c0be
	ds 8

wChannelNoteSpeeds:: ; c0c6
	ds 8

wChannelNoteDelayCountersFractionalPart:: ; c0ce
	ds 8

wChannelOctaves:: ; c0d6
	ds 8

wChannelVolumes:: ; c0de
; also includes fade for hardware channels that support it
	ds 8

wMusicWaveInstrument::
	ds 1

wSfxWaveInstrument::
	ds 1

wMusicTempo:: ; c0e8
	ds 2

wSfxTempo:: ; c0ea
	ds 2

wSfxHeaderPointer:: ; c0ec
	ds 2

wNewSoundID:: ; c0ee
	ds 1

wFrequencyModifier:: ; c0f1
	ds 2

wTempoModifier:: ; c0f2
	ds 2

wCurMusicByte::				; add this variable to allow reading cry data from any bank
	ds 1

wSfxBank::					; add this variable to allow reading cry data from any bank
	ds 1

wMusicBank::				; add this variable to allow reading music data from any bank
	ds 1

wInstrumentBank::			; add this variable to allow reading instrument data from any bank
	ds 1					; (instruments are sfx used in songs, they share channels with other sfx, so we need a dedicated variable to avoid clobbering wSfxBank)
	
wCryBank::					; apparently the low health alarm causes some kind of problem with cries, the channelsoundIDs sometimes are not reset after playing a cry
	ds 1					; and when playing another sfx that modifies wSfxBank, that causes the engine to try and read cry data from the wrong bank
							; using a distinct variable for cries should fix that

wAudioSavedROMBank::		; use a dedicated variable to save the rom bank in LoadMusicByte
	ds 1					; to avoid clobbering hSavedROMBank during calls to UpdateMusic
							; since we save the bank there in PlaySound
							
wPlayingCry::				; add this variable to signal to the audio engine that we're playing a cry
	ds 1					; allows to reuse sound ids for cries and have a whole 256 values available
	
	ds 6


SECTION "Sprite State Data", WRAM0

wSpriteDataStart::

wSpriteStateData1:: ; c100
; data for all sprites on the current map
; holds info for 16 sprites with $10 bytes each
; player sprite is always sprite 0
; C1x0: picture ID (fixed, loaded at map init)
; C1x1: movement status (0: uninitialized, 1: ready, 2: delayed, 3: moving)
; C1x2: sprite image index (changed on update, $ff if off screen, includes facing direction, progress in walking animation and a sprite-specific offset)
; C1x3: Y screen position delta (-1,0 or 1; added to c1x4 on each walking animation update)
; C1x4: Y screen position (in pixels, always 4 pixels above grid which makes sprites appear to be in the center of a tile)
; C1x5: X screen position delta (-1,0 or 1; added to c1x6 on each walking animation update)
; C1x6: X screen position (in pixels, snaps to grid if not currently walking)
; C1x7: intra-animation-frame counter (counting upwards to 4 until c1x8 is incremented)
; C1x8: animation frame counter (increased every 4 updates, hold four states (totalling to 16 walking frames)
; C1x9: facing direction (0: down, 4: up, 8: left, $c: right)
; C1xA
; C1xB
; C1xC
; C1xD
; C1xE
; C1xF
spritestatedata1: MACRO
\1PictureID:: db
\1MovementStatus:: db
\1ImageIndex:: db
\1YStepVector:: db
\1YPixels:: db
\1XStepVector:: db
\1XPixels:: db
\1IntraAnimFrameCounter:: db
\1AnimFrameCounter:: db
\1FacingDirection:: db
	ds 6
\1End::
endm

wSpritePlayerStateData1::  spritestatedata1 wSpritePlayerStateData1
wSprite01StateData1::      spritestatedata1 wSprite01StateData1
wSprite02StateData1::      spritestatedata1 wSprite02StateData1
wSprite03StateData1::      spritestatedata1 wSprite03StateData1
wSprite04StateData1::      spritestatedata1 wSprite04StateData1
wSprite05StateData1::      spritestatedata1 wSprite05StateData1
wSprite06StateData1::      spritestatedata1 wSprite06StateData1
wSprite07StateData1::      spritestatedata1 wSprite07StateData1
wSprite08StateData1::      spritestatedata1 wSprite08StateData1
wSprite09StateData1::      spritestatedata1 wSprite09StateData1
wSprite10StateData1::      spritestatedata1 wSprite10StateData1
wSprite11StateData1::      spritestatedata1 wSprite11StateData1
wSprite12StateData1::      spritestatedata1 wSprite12StateData1
wSprite13StateData1::      spritestatedata1 wSprite13StateData1
wSprite14StateData1::      spritestatedata1 wSprite14StateData1
wSprite15StateData1::      spritestatedata1 wSprite15StateData1

wSpriteStateData2:: ; c200
; more data for all sprites on the current map
; holds info for 16 sprites with $10 bytes each
; player sprite is always sprite 0
; C2x0: walk animation counter (counting from $10 backwards when moving)
; C2x1:
; C2x2: Y displacement (initialized at 8, supposed to keep moving sprites from moving too far, but bugged)
; C2x3: X displacement (initialized at 8, supposed to keep moving sprites from moving too far, but bugged)
; C2x4: Y position (in 2x2 tile grid steps, topmost 2x2 tile has value 4)
; C2x5: X position (in 2x2 tile grid steps, leftmost 2x2 tile has value 4)
; C2x6: movement byte 1 (determines whether a sprite can move, $ff:not moving, $fe:random movements, others unknown)
; C2x7: (?) (set to $80 when in grass, else $0; may be used to draw grass above the sprite)
; C2x8: delay until next movement (counted downwards, status (c1x1) is set to ready if reached 0)
; C2x9
; C2xA
; C2xB
; C2xC
; C2xD
; C2xE: sprite image base offset (in video ram, player always has value 1, used to compute c1x2)
; C2xF
spritestatedata2: MACRO
\1WalkAnimationCounter:: db
	ds 1
\1YDisplacement:: db
\1XDisplacement:: db
\1MapY:: db
\1MapX:: db
\1MovementByte1:: db
\1GrassPriority:: db
\1MovementDelay:: db
	ds 5
\1ImageBaseOffset:: db
	ds 1
\1End::
endm

wSpritePlayerStateData2::  spritestatedata2 wSpritePlayerStateData2
wSprite01StateData2::      spritestatedata2 wSprite01StateData2
wSprite02StateData2::      spritestatedata2 wSprite02StateData2
wSprite03StateData2::      spritestatedata2 wSprite03StateData2
wSprite04StateData2::      spritestatedata2 wSprite04StateData2
wSprite05StateData2::      spritestatedata2 wSprite05StateData2
wSprite06StateData2::      spritestatedata2 wSprite06StateData2
wSprite07StateData2::      spritestatedata2 wSprite07StateData2
wSprite08StateData2::      spritestatedata2 wSprite08StateData2
wSprite09StateData2::      spritestatedata2 wSprite09StateData2
wSprite10StateData2::      spritestatedata2 wSprite10StateData2
wSprite11StateData2::      spritestatedata2 wSprite11StateData2
wSprite12StateData2::      spritestatedata2 wSprite12StateData2
wSprite13StateData2::      spritestatedata2 wSprite13StateData2
wSprite14StateData2::      spritestatedata2 wSprite14StateData2
wSprite15StateData2::      spritestatedata2 wSprite15StateData2


wSpriteDataEnd::


SECTION "OAM Buffer", WRAM0

wOAMBuffer:: ; c300
; buffer for OAM data. Copied to OAM by DMA
	ds 4 * 40

wTileMap:: ; c3a0
; buffer for tiles that are visible on screen (20 columns by 18 rows)
	ds 20 * 18

wSerialPartyMonsPatchList:: ; c508
; list of indexes to patch with SERIAL_NO_DATA_BYTE after transfer
; 200 bytes

wTileMapBackup:: ; c508
; buffer for temporarily saving and restoring current screen's tiles
; (e.g. if menus are drawn on top)
;	ds 20 * 18

	ds 200

wSerialEnemyMonsPatchList:: ; c5d0
; list of indexes to patch with SERIAL_NO_DATA_BYTE after transfer
	ds 200

	ds 80

wTempPic::
wOverworldMap:: ; c6e8
	ds 1300
wOverworldMapEnd::

wRedrawRowOrColumnSrcTiles:: ; cbfc
; the tiles of the row or column to be redrawn by RedrawRowOrColumn
	ds SCREEN_WIDTH * 2

; coordinates of the position of the cursor for the top menu item (id 0)
wTopMenuItemY:: ; cc24
	ds 1
wTopMenuItemX:: ; cc25
	ds 1

wCurrentMenuItem:: ; cc26
; the id of the currently selected menu item
; the top item has id 0, the one below that has id 1, etc.
; note that the "top item" means the top item currently visible on the screen
; add this value to [wListScrollOffset] to get the item's position within the list
	ds 1

wTileBehindCursor:: ; cc27
; the tile that was behind the menu cursor's current location
	ds 1

wMaxMenuItem:: ; cc28
; id of the bottom menu item
	ds 1

wMenuWatchedKeys:: ; cc29
; bit mask of keys that the menu will respond to
	ds 1

wLastMenuItem:: ; cc2a
; id of previously selected menu item
	ds 1

wPartyAndBillsPCSavedMenuItem:: ; cc2b
; It is mainly used by the party menu to remember the cursor position while the
; menu isn't active.
; It is also used to remember the cursor position of mon lists (for the
; withdraw/deposit/release actions) in Bill's PC so that it doesn't get lost
; when you choose a mon from the list and a sub-menu is shown. It's reset when
; you return to the main Bill's PC menu.
	ds 1

wBagSavedMenuItem:: ; cc2c
; It is used by the bag list to remember the cursor position while the menu
; isn't active.
	ds 1

wBattleAndStartSavedMenuItem:: ; cc2d
; It is used by the start menu to remember the cursor position while the menu
; isn't active.
; The battle menu uses it so that the cursor position doesn't get lost when
; a sub-menu is shown. It's reset at the start of each battle.
	ds 1

wPlayerMoveListIndex:: ; cc2e
	ds 1

wPlayerMonNumber:: ; cc2f
; index in party of currently battling mon
	ds 1

wMenuCursorLocation:: ; cc30
; the address of the menu cursor's current location within wTileMap
	ds 2

	ds 2

wMenuJoypadPollCount:: ; cc34
; how many times should HandleMenuInput poll the joypad state before it returns?
	ds 1

wMenuItemToSwap:: ; cc35
; id of menu item selected for swapping (counts from 1) (0 means that no menu item has been selected for swapping)
	ds 1

wListScrollOffset:: ; cc36
; offset of the current top menu item from the beginning of the list
; keeps track of what section of the list is on screen
	ds 2			;  to handle 2 bytes species IDs (in the pokedex menu)

wMenuWatchMovingOutOfBounds:: ; cc37
; If non-zero, then when wrapping is disabled and the player tries to go past
; the top or bottom of the menu, return from HandleMenuInput. This is useful for
; menus that have too many items to display at once on the screen because it
; allows the caller to scroll the entire menu up or down when this happens.
	ds 1

wTradeCenterPointerTableIndex:: ; cc38
	ds 1

	ds 1

wTextDest:: ; cc3a
; destination pointer for text output
; this variable is written to, but is never read from
	ds 2

wDoNotWaitForButtonPressAfterDisplayingText:: ; cc3c
; if non-zero, skip waiting for a button press after displaying text in DisplayTextID
	ds 1

wSerialSyncAndExchangeNybbleReceiveData:: ; cc3d
; the final received nybble is stored here by Serial_SyncAndExchangeNybble

wSerialExchangeNybbleTempReceiveData:: ; cc3d
; temporary nybble used by Serial_ExchangeNybble

wLinkMenuSelectionReceiveBuffer:: ; cc3d
; two byte buffer
; the received menu selection is stored twice
	ds 1

wSerialExchangeNybbleReceiveData:: ; cc3e
; the final received nybble is stored here by Serial_ExchangeNybble
	ds 1

	ds 3

wSerialExchangeNybbleSendData:: ; cc42
; this nybble is sent when using Serial_SyncAndExchangeNybble or Serial_ExchangeNybble

wLinkMenuSelectionSendBuffer:: ; cc42
; two byte buffer
; the menu selection byte is stored twice before sending

	ds 5

wLinkTimeoutCounter:: ; cc47
; 1 byte

wUnknownSerialCounter:: ; cc47
; 2 bytes

wEnteringCableClub:: ; cc47
	ds 1

	ds 1

wWhichTradeMonSelectionMenu:: ; cc49
; $00 = player mons
; $01 = enemy mons

wMonDataLocation:: ; cc49
; 0 = player's party
; 1 = enemy party
; 2 = current box
; 3 = daycare
; 4 = in-battle mon
;
; AddPartyMon uses it slightly differently.
; If the lower nybble is 0, the mon is added to the player's party, else the enemy's.
; If the entire value is 0, then the player is allowed to name the mon.
	ds 1

wMenuWrappingEnabled:: ; cc4a
; set to 1 if you can go from the bottom to the top or top to bottom of a menu
; set to 0 if you can't go past the top or bottom of the menu
	ds 1

wCheckFor180DegreeTurn:: ; cc4b
; whether to check for 180-degree turn (0 = don't, 1 = do)
	ds 1

	ds 1

wMissableObjectIndex:: ; cc4d
	ds 1

wPredefID:: ; cc4e
	ds 1
wPredefRegisters:: ; cc4f
	ds 6

wTrainerHeaderFlagBit:: ; cc55
	ds 1

	ds 1

wNPCMovementScriptPointerTableNum:: ; cc57
; which NPC movement script pointer is being used
; 0 if an NPC movement script is not running
	ds 1

wNPCMovementScriptBank:: ; cc58
; ROM bank of current NPC movement script
	ds 1

	ds 2

wUnusedCC5B:: ; cc5b

wVermilionDockTileMapBuffer:: ; cc5b
; 180 bytes (ends at cd0f)

wOaksAideRewardItemName:: ; cc5b

wFilteredBagItems:: ; cc5b
; List of bag items that has been filtered to a certain type of items,
; such as drinks or fossils.

wElevatorWarpMaps:: ; cc5b

wMonPartySpritesSavedOAM:: ; cc5b
; Saved copy of OAM for the first frame of the animation to make it easy to
; flip back from the second frame.
; $60 bytes

wTrainerCardBlkPacket:: ; cc5b
; $40 bytes

wSlotMachineSevenAndBarModeChance:: ; cc5b
; If a random number greater than this value is generated, then the player is
; allowed to have three 7 symbols or bar symbols line up.
; So, this value is actually the chance of NOT entering that mode.
; If the slot is lucky, it equals 250, giving a 5/256 (~2%) chance.
; Otherwise, it equals 253, giving a 2/256 (~0.8%) chance.

wHallOfFame:: ; cc5b
wBoostExpByExpAll:: ; cc5b
wAnimationType:: ; cc5b
; values between 0-6. Shake screen horizontally, shake screen vertically, blink Pokemon...

wNPCMovementDirections:: ; cc5b

wDexRatingNumMonsSeen:: ; cc5b  make it 2 bytes to handle extended dex
	ds 2

wDexRatingNumMonsOwned:: ; cc5d  make it 2 bytes to handle extended dex
	ds 1

wSlotMachineSavedROMBank:: ; cc5e
; ROM bank to return to when the player is done with the slot machine
	ds 1

wDexRatingText:: ; cc5f
	ds 1
	
	ds 25					;  there is 1 byte less leftover after allocating more to wDexRatingNumMonsSeen and wDexRatingNumMonsOwned

wAnimPalette:: ; cc79
	ds 1

	ds 29

wNPCMovementDirections2:: ; cc97

wSwitchPartyMonTempBuffer:: ; cc97
; temporary buffer when swapping party mon data
	ds 10

wNumStepsToTake:: ; cca1
; used in Pallet Town scripted movement
	ds 49

wRLEByteCount:: ; ccd2
	ds 1

wAddedToParty:: ; ccd3
; 0 = not added
; 1 = added

wSimulatedJoypadStatesEnd:: ; ccd3
; this is the end of the joypad states
; the list starts above this address and extends downwards in memory until here
; overloaded with below labels

wParentMenuItem:: ; ccd3

wCanEvolveFlags:: ; ccd3
; 1 flag for each party member indicating whether it can evolve
; The purpose of these flags is to track which mons levelled up during the
; current battle at the end of the battle when evolution occurs.
; Other methods of evolution simply set it by calling TryEvolvingMon.
	ds 1

wForceEvolution:: ; ccd4
	ds 1

; if [ccd5] != 1, the second AI layer is not applied
wAILayer2Encouragement:: ; ccd5
	ds 1
	ds 1

; current HP of player and enemy substitutes
wPlayerSubstituteHP:: ; ccd7
	ds 1
wEnemySubstituteHP:: ; ccd8
	ds 1

;  used in AI layer 3 to save effectiveness of examined move while checking the other 3
wTypeEffectivenessCopy:: ; ccd9
; The player's selected move during a test battle.
; InitBattleVariables sets it to the move Pound.
	ds 1

	ds 1

wMoveMenuType:: ; ccdb
; 0=regular, 1=mimic, 2=above message box (relearn, heal pp..)
	ds 1

wPlayerSelectedMove:: ; ccdc
	ds 1
wEnemySelectedMove:: ; ccdd
	ds 1

wLinkBattleRandomNumberListIndex:: ; ccde
	ds 1

wAICount:: ; ccdf
; number of times remaining that AI action can occur
	ds 1

	ds 2

wEnemyMoveListIndex:: ; cce2
	ds 1

wLastSwitchInEnemyMonHP:: ; cce3
; The enemy mon's HP when it was switched in or when the current player mon
; was switched in, which was more recent.
; It's used to determine the message to print when switching out the player mon.
	ds 2

wTotalPayDayMoney:: ; cce5
; total amount of money made using Pay Day during the current battle
	ds 3

wSafariEscapeFactor:: ; cce8
	ds 1
wSafariBaitFactor:: ; cce9
	ds 1

wTransformedEnemyMonOriginalDVs:: ; cceb
	ds 3							; increased from 2 to 3 to hold the additionnal DV for special defense

wMonIsDisobedient:: ds 1 ; cced

wPlayerDisabledMoveNumber:: ds 1 ; ccee
wEnemyDisabledMoveNumber:: ds 1 ; ccef

wTransformedEnemyMonOriginalSpecies:: ; ccf0  stores the species ID of a transformed mon
	ds 2								; 2 bytes instead of one

wPlayerUsedMove:: ds 1 ; ccf1
wEnemyUsedMove:: ds 1 ; ccf2

wEnemyMonMinimized:: ds 1 ; ccf3

wMoveDidntMiss:: ds 1 ; ccf4

wPartyFoughtCurrentEnemyFlags:: ; ccf5
; flags that indicate which party members have fought the current enemy mon
	flag_array 6

wLowHealthAlarmDisabled:: ; ccf6
; Whether the low health alarm has been disabled due to the player winning the
; battle.
	ds 1

wPlayerMonMinimized:: ; ccf7
	ds 1

	ds 13

wLuckySlotHiddenObjectIndex:: ; cd05

wEnemyNumHits:: ; cd05
; number of hits by enemy in attacks like Double Slap, etc.

wEnemyBideAccumulatedDamage:: ; cd05
; the amount of damage accumulated by the enemy while biding (2 bytes)

	ds 10

; added this to mark the end of the block of memory overwritten with water tiles when SS Anne leaves the docks
wVermilionDockTileMapBufferEnd::

wInGameTradeGiveMonSpecies:: ; cd0f
	ds 2						; to handle 2 bytes species IDs

wPlayerMonUnmodifiedLevel:: ; cd0f
	ds 1

wInGameTradeTextPointerTablePointer:: ; cd10

wPlayerMonUnmodifiedMaxHP:: ; cd10
	ds 2

wInGameTradeTextPointerTableIndex:: ; cd12

wPlayerMonUnmodifiedAttack:: ; cd12
	ds 1
wInGameTradeGiveMonName:: ; cd13
	ds 1
wPlayerMonUnmodifiedDefense:: ; cd14
	ds 2
wPlayerMonUnmodifiedSpeed:: ; cd16
	ds 2
wPlayerMonUnmodifiedSpecialAttack:: ; cd18
	ds 2
wPlayerMonUnmodifiedSpecialDefense:: ; cd18
	ds 2

; stat modifiers for the player's current pokemon
; value can range from 1 - 13 ($1 to $D)
; 7 is normal

wPlayerMonStatMods::
wPlayerMonAttackMod:: ; cd1a
	ds 1
wPlayerMonDefenseMod:: ; cd1b
	ds 1
wPlayerMonSpeedMod:: ; cd1c
	ds 1
wPlayerMonSpecialAttackMod:: ; cd1d
	ds 1
wPlayerMonSpecialDefenseMod:: ; cd1d
	ds 1

wInGameTradeReceiveMonName:: ; cd1e

wPlayerMonAccuracyMod:: ; cd1e
	ds 1
wPlayerMonEvasionMod:: ; cd1f
	ds 1

	ds 3

wEnemyMonUnmodifiedLevel:: ; cd23
	ds 1
wEnemyMonUnmodifiedMaxHP:: ; cd24
	ds 2
wEnemyMonUnmodifiedAttack:: ; cd26
	ds 2
wEnemyMonUnmodifiedDefense:: ; cd28
	ds 1

wInGameTradeMonNick:: ; cd29		NAME_LENGTH bytes, can clobber wEngagedTrainerClass!
	ds 1

wEnemyMonUnmodifiedSpeed:: ; cd2a
	ds 2
wEnemyMonUnmodifiedSpecialAttack:: ; cd2c
	ds 2
wEnemyMonUnmodifiedSpecialDefense:: ; cd2c
	ds 2							; we must avoid clobbering wEngagedTrainerClass when initializing battle data
									; since now we use it to differentiate wild battles from trainer battles
wEngagedTrainerClass:: ; cd2d
	ds 1
wEngagedTrainerSet:: ; cd2e

; stat modifiers for the enemy's current pokemon
; value can range from 1 - 13 ($1 to $D)
; 7 is normal

wEnemyMonStatMods::
wEnemyMonAttackMod:: ; cd2e
	ds 1
wEnemyMonDefenseMod:: ; cd2f
	ds 1
wEnemyMonSpeedMod:: ; cd30
	ds 1
wEnemyMonSpecialAttackMod:: ; cd31
	ds 1
wEnemyMonSpecialDefenseMod:: ; cd31
	ds 1
wEnemyMonAccuracyMod:: ; cd32
	ds 1
wEnemyMonEvasionMod:: ; cd33
	ds 1

wInGameTradeReceiveMonSpecies::
	ds 2								; to handle 2 bytes species IDs

	ds 1

wNPCMovementDirections2Index:: ; cd37

wUnusedCD37:: ; cd37

wFilteredBagItemsCount:: ; cd37
; number of items in wFilteredBagItems list
	ds 1

wSimulatedJoypadStatesIndex:: ; cd38
; the next simulated joypad state is at wSimulatedJoypadStatesEnd plus this value minus 1
; 0 if the joypad state is not being simulated
	ds 1

; written to but nothing ever reads it
wWastedByteCD39::
	ds 1

; written to but nothing ever reads it
wWastedByteCD3A::
	ds 1

wOverrideSimulatedJoypadStatesMask:: ; cd3b
; mask indicating which real button presses can override simulated ones
; XXX is it ever not 0?
	ds 1

; add this to store the dex number of a pokemon
wMonDexNumber::
	ds 2

wTradedPlayerMonSpecies:: ; cd3d moved this back one byte so as not to clobber wTradingWhichEnemyMon now that this variable takes 2 bytes
; 2 bytes
	ds 1

wFallingObjectsMovementData:: ; cd3d
; up to 20 bytes (one byte for each falling object)

wSavedY:: ; cd3d

wTempSCX:: ; cd3d

wBattleTransitionCircleScreenQuadrantY:: ; cd3d
; 0 = upper half (Y < 9)
; 1 = lower half (Y >= 9)

wBattleTransitionCopyTilesOffset:: ; cd3d
; 2 bytes
; after 1 row/column has been copied, the offset to the next one to copy from

wInwardSpiralUpdateScreenCounter:: ; cd3d
; counts down from 7 so that every time 7 more tiles of the spiral have been
; placed, the tile map buffer is copied to VRAM so that progress is visible

wHoFTeamIndex:: ; cd3d

wSSAnneSmokeDriftAmount:: ; cd3d
; multiplied by 16 to get the number of times to go right by 2 pixels

wRivalStarterTemp:: ; cd3d

wBoxMonCounts:: ; cd3d
; 12 bytes
; array of the number of mons in each box

wDexMaxSeenMon:: ; cd3d there shouldn't be any need to allocate specifically more bytes, we can just overflow to the next byte

wPPRestoreItem:: ; cd3d

wWereAnyMonsAsleep:: ; cd3d

wCanPlaySlots:: ; cd3d

wNumShakes:: ; cd3d

wDayCareStartLevel:: ; cd3d
; the level of the mon at the time it entered day care

wWhichBadge:: ; cd3d

wPriceTemp:: ; cd3d
; 3-byte BCD number

wTitleMonSpecies:: ; cd3d

wPlayerCharacterOAMTile:: ; cd3d

wMoveDownSmallStarsOAMCount:: ; cd3d
; the number of small stars OAM entries to move down

wChargeMoveNum:: ; cd3d

wCoordIndex:: ; cd3d

wOptionsTextSpeedCursorX:: ; cd3d

wBoxNumString:: ; cd3d

wTrainerInfoTextBoxWidthPlus1:: ; cd3d

wSwappedMenuItem:: ; cd3d

wHoFMonSpecies:: ; cd3d

wFieldMoves:: ; cd3d
; 4 bytes
; the current mon's field moves

wBadgeNumberTile:: ; cd3d
; tile ID of the badge number being drawn

wRodResponse:: ; cd3d
; 0 = no bite
; 1 = bite
; 2 = no fish on map

wWhichTownMapLocation:: ; cd3d

wStoppingWhichSlotMachineWheel:: ; cd3d
; which wheel the player is trying to stop
; 0 = none, 1 = wheel 1, 2 = wheel 2, 3 or greater = wheel 3

wTradingWhichPlayerMon:: ; cd3d

wChangeBoxSavedMapTextPointer:: ; cd3d

wFlyAnimUsingCoordList:: ; cd3d

wPlayerSpinInPlaceAnimFrameDelay:: ; cd3d

wPlayerSpinWhileMovingUpOrDownAnimDeltaY:: ; cd3d

wHiddenObjectFunctionArgument:: ; cd3d

wWhichTrade:: ; cd3d
; which entry from TradeMons to select

wTrainerSpriteOffset:: ; cd3d

wUnusedCD3D:: ; cd3d
	ds 1

wHUDPokeballGfxOffsetX:: ; cd3e
; difference in X between the next ball and the current one

wBattleTransitionCircleScreenQuadrantX:: ; cd3e
; 0 = left half (X < 10)
; 1 = right half (X >= 10)

wSSAnneSmokeX:: ; cd3e

wDayCareNumLevelsGrown:: ; cd3e

wOptionsBattleAnimCursorX:: ; cd3e

wTrainerInfoTextBoxWidth:: ; cd3e

wNumCreditsMonsDisplayed:: ; cd3e
; the number of credits mons that have been displayed so far

wBadgeNameTile:: ; cd3e
; first tile ID of the name being drawn

wFlyLocationsList:: ; cd3e
; 11 bytes plus $ff sentinel values at each end

wSlotMachineWheel1Offset:: ; cd3e

wTradingWhichEnemyMon:: ; cd3e

wFlyAnimCounter:: ; cd3e

wPlayerSpinInPlaceAnimFrameDelayDelta:: ; cd3e

wPlayerSpinWhileMovingUpOrDownAnimMaxY:: ; cd3e

wHiddenObjectFunctionRomBank:: ; cd3e

wTrainerEngageDistance:: ; cd3e
	ds 1

wRivalStarterBallSpriteIndex:: ; cd3f moved this 1 byte forward to leave one more byte for wRivalStarterTemp
	
wHUDGraphicsTiles:: ; cd3f
; 3 bytes

wDayCareTotalCost:: ; cd3f
; 2-byte BCD number

wJigglypuffFacingDirections:: ; cd3f

wOptionsBattleStyleCursorX:: ; cd3f

wTrainerInfoTextBoxNextRowOffset:: ; cd3f

wHoFMonLevel:: ; cd3f

wBadgeOrFaceTiles:: ; cd3f
; 8 bytes
; a list of the first tile IDs of each badge or face (depending on whether the
; badge is owned) to be drawn on the trainer screen

wSlotMachineWheel2Offset:: ; cd3f

wNameOfPlayerMonToBeTraded:: ; cd3f

wFlyAnimBirdSpriteImageIndex:: ; cd3f

wPlayerSpinInPlaceAnimFrameDelayEndValue:: ; cd3f

wPlayerSpinWhileMovingUpOrDownAnimFrameDelay:: ; cd3f

wHiddenObjectIndex:: ; cd3f

wTradedEnemyMonSpecies:: ; cd3f
; 2 bytes
; moved this one byte forward to give one more byte to wTradedPlayerMonSpecies

wTrainerFacingDirection:: ; cd3f
	ds 1

wHoFMonOrPlayer:: ; cd40
; show mon or show player?
; 0 = mon
; 1 = player

wSlotMachineWheel3Offset:: ; cd40

wPlayerSpinInPlaceAnimSoundID:: ; cd40

wHiddenObjectY:: ; cd40

wTrainerScreenY:: ; cd40

wUnusedCD40:: ; cd40
	ds 1

wDayCarePerLevelCost:: ; cd41
; 2-byte BCD number (always set to $0100)

wHoFTeamIndex2:: ; cd41

wHiddenItemOrCoinsIndex:: ; cd41

wTradedPlayerMonOT:: ; cd41
; NAME_LENGTH bytes

wHiddenObjectX:: ; cd41

wSlotMachineWinningSymbol:: ; cd41
; the OAM tile number of the upper left corner of the winning symbol minus 2

wNumFieldMoves:: ; cd41

wSlotMachineWheel1BottomTile:: ; cd41

wTrainerScreenX:: ; cd41
	ds 1
; a lot of the uses for these values use more than the said address

wHoFPartyMonIndex:: ; cd42 moved this here to leave one more byte for wHoFMonSpecies

wSlotMachineWheel1MiddleTile:: ; cd42

wFieldMovesLeftmostXCoord:: ; cd42
	ds 1

wLastFieldMoveID:: ; cd43
; unused

wSlotMachineWheel1TopTile:: ; cd43
	ds 1

wSlotMachineWheel2BottomTile:: ; cd44
	ds 1

wSlotMachineWheel2MiddleTile:: ; cd45
	ds 1

wTempCoins1:: ; cd46
; 2 bytes
; temporary variable used to add payout amount to the player's coins

wSlotMachineWheel2TopTile:: ; cd46
	ds 1

wBattleTransitionSpiralDirection:: ; cd47
; 0 = outward, 1 = inward

wSlotMachineWheel3BottomTile:: ; cd47
	ds 1

wSlotMachineWheel3MiddleTile:: ; cd48

wFacingDirectionList:: ; cd48
; 4 bytes (also, the byte before the start of the list (cd47) is used a temp
;          variable when the list is rotated)
; used when spinning the player's sprite
	ds 1

; wBoxMonCounts ends at cd49
	
wHoFTeamNo:: ; cd49 moved this 6 bytes forward to leave room for HoF Species since species ID are now 2 bytes
	
wSlotMachineWheel3TopTile:: ; cd49

wTempObtainedBadgesBooleans::
; 8 bytes
; temporary list created when displaying the badges on the trainer screen
; one byte for each badge; 0 = not obtained, 1 = obtained
	ds 1

wTempCoins2:: ; cd4a
; 2 bytes
; temporary variable used to subtract the bet amount from the player's coins

wPayoutCoins:: ; cd4a
; 2 bytes
	ds 2

wTradedPlayerMonOTID:: ; cd4c
; 2 bytes

wSlotMachineFlags:: ; cd4c
; These flags are set randomly and control when the wheels stop.
; bit 6: allow the player to win in general
; bit 7: allow the player to win with 7 or bar (plus the effect of bit 6)
	ds 1

wSlotMachineWheel1SlipCounter:: ; cd4d
; wheel 1 can "slip" while this is non-zero

wCutTile:: ; cd4d
; $3d = tree tile
; $52 = grass tile
	ds 1

wSlotMachineWheel2SlipCounter:: ; cd4e
; wheel 2 can "slip" while this is non-zero

wTradedEnemyMonOT:: ; cd4e
; NAME_LENGTH bytes
	ds 1

wSavedPlayerScreenY:: ; cd4f

wSlotMachineRerollCounter:: ; cd4f
; The remaining number of times wheel 3 will roll down a symbol until a match is
; found, when winning is enabled. It's initialized to 4 each bet.

wEmotionBubbleSpriteIndex:: ; cd4f
; the index of the sprite the emotion bubble is to be displayed above
	ds 1

wWhichEmotionBubble:: ; cd50

wSlotMachineBet:: ; cd50
; how many coins the player bet on the slot machine (1 to 3)

wSavedPlayerFacingDirection:: ; cd50

wWhichAnimationOffsets:: ; cd50
; 0 = cut animation, 1 = boulder dust animation
	ds 9

; wFallingObjectsMovementData ends at cd51
	
wTradedEnemyMonOTID:: ; cd59
	ds 2

wStandingOnWarpPadOrHole:: ; cd5b
; 0 = neither
; 1 = warp pad
; 2 = hole

wOAMBaseTile:: ; cd5b

wGymTrashCanIndex:: ; cd5b
	ds 1

wSymmetricSpriteOAMAttributes:: ; cd5c
	ds 1

wMonPartySpriteSpecies:: ; cd5d
	ds 2		; to handle 2 bytes species IDs

wLeftGBMonSpecies:: ; cd5e
; in the trade animation, the mon that leaves the left gameboy
	ds 2		; to handle 2 bytes species IDs

wRightGBMonSpecies:: ; cd5f
; in the trade animation, the mon that leaves the right gameboy
	ds 2		; to handle 2 bytes species IDs

wFlags_0xcd60:: ; cd60
; bit 0: is player engaged by trainer (to avoid being engaged by multiple trainers simultaneously)
; bit 1: boulder dust animation (from using Strength) pending
; bit 3: using generic PC
; bit 5: don't play sound when A or B is pressed in menu
; bit 6: tried pushing against boulder once (you need to push twice before it will move)
	ds 1

wActionResultOrTookBattleTurn:: ; cd6a
; This has overlapping related uses.
; When the player tries to use an item or use certain field moves, 0 is stored
; when the attempt fails and 1 is stored when the attempt succeeds.
; In addition, some items store 2 for certain types of failures, but this
; cannot happen in battle.
; In battle, a non-zero value indicates the player has taken their turn using
; something other than a move (e.g. using an item or switching pokemon).
; So, when an item is successfully used in battle, this value becomes non-zero
; and the player is not allowed to make a move and the two uses are compatible.
	ds 1

wJoyIgnore:: ; cd6b
; Set buttons are ignored.
	ds 1

wDownscaledMonSize:: ; cd6c
; size of downscaled mon pic used in pokeball entering/exiting animation
; $00 = 5×5
; $01 = 3×3

wNumMovesMinusOne:: ; cd6c
; FormatMovesString stores the number of moves minus one here
	ds 1

UNION

wcd6d:: ds 4 ; buffer for various data

wStatusScreenCurrentPP:: ; cd71
; temp variable used to print a move's current PP on the status screen
	ds 1

	ds 6

wNormalMaxPPList:: ; cd78
; list of normal max PP (without PP up) values
	ds 9

NEXTU

; added MAX_EVO_MOVES to take into account the new format
wEvosMoves:: ds EVOLUTION_SIZE + MAX_EVO_MOVES + 1
.end::

ENDU

wSerialOtherGameboyRandomNumberListBlock:: ; cd81
; buffer for transferring the random number list generated by the other gameboy
; 17 bytes

wTileMapBackup2:: ; cd81
; second buffer for temporarily saving and restoring current screen's tiles (e.g. if menus are drawn on top)
	ds 20 * 18

wNamingScreenNameLength:: ; cee9

wEvoOldSpecies:: ; cee9
	ds 1			; added one byte so that wEvoNewSpecies is 2 bytes further

wBuffer:: ; cee9
; Temporary storage area of 30 bytes.

wTownMapCoords:: ; cee9
; lower nybble is x, upper nybble is y

wLearningMovesFromDayCare:: ; cee9
; whether WriteMonMoves is being used to make a mon learn moves from day care
; non-zero if so

wChangeMonPicEnemyTurnSpecies:: ; cee9
	ds 1			; add one byte so that wChangeMonPicPlayerTurnSpecies is 2 bytes away

wHPBarMaxHP:: ; cee9
	ds 1

wNamingScreenSubmitName:: ; ceea
; non-zero when the player has chosen to submit the name

wChangeMonPicPlayerTurnSpecies:: ; ceea

wEvoNewSpecies:: ; ceea
	ds 1

wAlphabetCase:: ; ceeb
; 0 = upper case
; 1 = lower case

wHPBarOldHP:: ; ceeb
	ds 1

wEvoMonTileOffset:: ; ceeb
	; moved this variable one byte away from wEvoNewSpecies so that it can store a 2 bytes species	ID
	; without clobbering this variable which is used conjointly with it during evolution
	ds 1

wEvoCancelled:: ; ceec
	; moved this variable one byte away from wEvoNewSpecies so that this variable doesn't get clobbered by
	; wEvoMonTileOffset which we also moved forward one byte, because the 3 variables are used at the same time
	
wNamingScreenLetter:: ; ceed

wHPBarNewHP:: ; ceed
	ds 2
wHPBarDelta:: ; ceef
	ds 1

wHPBarTempHP:: ; cef0
	ds 2

	ds 11

wHPBarHPDifference:: ; cefd
	ds 1
	ds 7

wAIItem:: ; cf05
; the item that the AI used
	ds 1

wUsedItemOnWhichPokemon:: ; cf05
	ds 1

; wBufferEnd

wAnimSoundID:: ; cf07
; sound ID during battle animations
	ds 1

wBankswitchHomeSavedROMBank:: ; cf08
; used as a storage value for the bank to return to after a BankswitchHome (bankswitch in homebank)
	ds 1

wBankswitchHomeTemp:: ; cf09
; used as a temp storage value for the bank to switch to
	ds 1

wBoughtOrSoldItemInMart:: ; cf0a
; 0 = nothing bought or sold in pokemart
; 1 = bought or sold something in pokemart
; this value is not used for anything
	ds 1

wBattleResult:: ; cf0b
; $00 - win
; $01 - lose
; $02 - draw
	ds 1

wAutoTextBoxDrawingControl:: ; cf0c
; bit 0: if set, DisplayTextID automatically draws a text box
	ds 1

wcf0d:: ds 1 ; used with some overworld scripts (not exactly sure what it's used for)

wTilePlayerStandingOn:: ; cf0e
; used in CheckForTilePairCollisions2 to store the tile the player is on
	ds 1

wNPCNumScriptedSteps:: ds 1 ; cf0f

wNPCMovementScriptFunctionNum:: ; cf10
; which script function within the pointer table indicated by
; wNPCMovementScriptPointerTableNum
	ds 1

wTextPredefFlag:: ; cf11
; bit 0: set when printing a text predef so that DisplayTextID doesn't switch
;        to the current map's bank
	ds 1

wPredefParentBank:: ; cf12
	ds 1

wSpriteIndex:: ds 1

wCurSpriteMovement2:: ; cf14
; movement byte 2 of current sprite
	ds 1

	ds 2

wNPCMovementScriptSpriteOffset:: ; cf17
; sprite offset of sprite being controlled by NPC movement script
	ds 1

wScriptedNPCWalkCounter:: ; cf18
	ds 1

	ds 1

wGBC:: ; cf1a
	ds 1

wOnSGB:: ; cf1b
; if running on SGB, it's 1, else it's 0
	ds 1

wDefaultPaletteCommand:: ; cf1c
	ds 1

wPlayerHPBarColor:: ; cf1d

wWholeScreenPaletteMonSpecies:: ; cf1d
; species of the mon whose palette is used for the whole screen
	ds 1					; no need to add 1 byte here because wEnemyHPBarColor is never used conjointly with this variable
							; so we can clobber it when we use wWholeScreenPaletteMonSpecies
wEnemyHPBarColor:: ; cf1e
	ds 1

; 0: green
; 1: yellow
; 2: red
; 1 byte per party member
wPartyMenuHPBarColors:: ; cf1f
	ds PARTY_LENGTH

wStatusScreenHPBarColor:: ; cf25
	ds 1

wCopyingSGBTileData:: ; cf2d

wWhichPartyMenuHPBar:: ; cf2d

wPalPacket:: ; cf2d
	ds 1

wPartyMenuBlkPacket:: ; cf2e
; $30 bytes
	ds 29

wExpAmountGained:: ; cf4b
; 2-byte big-endian number
; the total amount of exp a mon gained

wcf4b:: ds 2 ; storage buffer for various strings

wGainBoostedExp:: ; cf4d
	ds 1

	ds 17
	
; wPartyMenuBlkPacket ends here

wGymCityName:: ; cf5f
	ds 17

wGymLeaderName:: ; cf70
	ds NAME_LENGTH

wItemList:: ; cf7b
	ds 16

wListPointer:: ; cf8b
	ds 2

wTMShopEventFlags:: ; cf8d
; 2 bytes
; use it to store the address of the first byte containing the event flags for TMs in the shop
	ds 2

wItemPrices:: ; cf8f
	ds 2

wcf91:: ds 1 ; used with a lot of things (too much to list here)

wWhichPokemon:: ; cf92
; which pokemon you selected
	ds 1

wPrintItemPrices:: ; cf93
; if non-zero, then print item prices when displaying lists
	ds 1

wHPBarType:: ; cf94
; type of HP bar
; $00 = enemy HUD in battle
; $01 = player HUD in battle / status screen
; $02 = party menu

wListMenuID:: ; cf94
; ID used by DisplayListMenuID
	ds 1

wRemoveMonFromBox:: ; cf95
; if non-zero, RemovePokemon will remove the mon from the current box,
; else it will remove the mon from the party

wMoveMonType:: ; cf95
; 0 = move from box to party
; 1 = move from party to box
; 2 = move from daycare to party
; 3 = move from party to daycare
	ds 1

wItemQuantity:: ; cf96
	ds 1

wMaxItemQuantity:: ; cf97
	ds 1

; LoadMonData copies mon data here
wLoadedMon:: party_struct wLoadedMon ; cf98

wFontLoaded:: ; cfc4
; bit 0: The space in VRAM that is used to store walk animation tile patterns
;        for the player and NPCs is in use for font tile patterns.
;        This means that NPC movement must be disabled.
; The other bits are unused.
	ds 1

wWalkCounter:: ; cfc5
; walk animation counter
	ds 1

wTileInFrontOfPlayer:: ; cfc6
; background tile number in front of the player (either 1 or 2 steps ahead)
	ds 1

wAudioFadeOutControl:: ; cfc7
; The desired fade counter reload value is stored here prior to calling
; PlaySound in order to cause the current music to fade out before the new
; music begins playing. Storing 0 causes no fade out to occur and the new music
; to begin immediately.
; This variable has another use related to fade-out, as well. PlaySound stores
; the sound ID of the music that should be played after the fade-out is finished
; in this variable. FadeOutAudio checks if it's non-zero every V-Blank and
; fades out the current audio if it is. Once it has finished fading out the
; audio, it zeroes this variable and starts playing the sound ID stored in it.
	ds 1

wAudioFadeOutCounterReloadValue:: ; cfc8
	ds 1

wAudioFadeOutCounter:: ; cfc9
	ds 1

wLastMusicSoundID:: ; cfca
; This is used to determine whether the default music is already playing when
; attempting to play the default music (in order to avoid restarting the same
; music) and whether the music has already been stopped when attempting to
; fade out the current music (so that the new music can be begin immediately
; instead of waiting).
; It sometimes contains the sound ID of the last music played, but it may also
; contain $ff (if the music has been stopped) or 0 (because some routines zero
; it in order to prevent assumptions from being made about the current state of
; the music).
	ds 1

wUpdateSpritesEnabled:: ; cfcb
; $00 = causes sprites to be hidden and the value to change to $ff
; $01 = enabled
; $ff = disabled
; other values aren't used
	ds 1

wEnemyMoveNum:: ; cfcc
	ds 1
wEnemyMoveEffect:: ; cfcd
	ds 1
wEnemyMovePower:: ; cfce
	ds 1
wEnemyMoveType:: ; cfcf
	ds 1
wEnemyMoveAccuracy:: ; cfd0
	ds 1
wEnemyMoveMaxPP:: ; cfd1
	ds 1
wEnemyMoveExtra:: ; add this byte to hold the move category, priority and other flags cfd2
	ds 1
wPlayerMoveNum:: ; cfd2 +1
	ds 1
wPlayerMoveEffect:: ; cfd3 +1
	ds 1
wPlayerMovePower:: ; cfd4 +1
	ds 1
wPlayerMoveType:: ; cfd5 +1
	ds 1
wPlayerMoveAccuracy:: ; cfd6 +1
	ds 1
wPlayerMoveMaxPP:: ; cfd7 +1
	ds 1
wPlayerMoveExtra:: ; add this byte to hold the move category, priority and other flags cfd8 +1
	ds 1


wEnemyMonSpecies2:: ; cfd8 +2
	ds 2			; 2 bytes instead of one
wBattleMonSpecies2:: ; cfd9 +2
	ds 2			; 2 bytes instead of one

wEnemyMonNick:: ds NAME_LENGTH ; cfda +2

wEnemyMon:: battle_struct wEnemyMon ; cfe5 +2

wEnemyMonBaseStats:: ds NUM_STATS
wEnemyMonActualCatchRate:: ds 1
wEnemyMonBaseExp:: ds 1

wBattleMonNick:: ds NAME_LENGTH ; d009 +2
wBattleMon:: battle_struct wBattleMon ; d014 +2


wTrainerClass:: ; d031 +2
	ds 1

wTrainerPicPointer:: ; d033 +2
	ds 2

wTempMoveNameBuffer:: ; d036 +2

wLearnMoveMonName:: ; d036 +2
; The name of the mon that is learning a move.
	ds 16

wTrainerBaseMoney:: ; d046 +2
; 2-byte BCD number
; money received after battle = base money × level of highest-level enemy mon
	ds 2

wMissableObjectCounter:: ; d048 +2
	ds 1

	ds 1

wTrainerName:: ; d04a +2
; 13 bytes for the letters of the opposing trainer
; the name is terminated with $50 with possible
; unused trailing letters
	ds 13

wIsInBattle:: ; d057 +2
; lost battle, this is -1
; no battle, this is 0
; wild battle, this is 1
; trainer battle, this is 2
	ds 1

wPartyGainExpFlags:: ; d058 +2
; flags that indicate which party members should be be given exp when GainExperience is called
	flag_array 6

wCurOpponent:: ; d059 +2
; in a wild battle, this is the species of pokemon
; in a trainer battle, this is the trainer class
	ds 2		; to handle 2 bytes species IDs

wBattleType:: ; d05a +2
; in normal battle, this is 0
; in old man battle, this is 1
; in safari battle, this is 2
; in Battle Facility, this is 3
	ds 1

wDamageMultipliers:: ; d05b +2
; bits 0-6: Effectiveness
   ;  $0 = immune
   ;  $5 = not very effective
   ;  $a = neutral
   ; $14 = super-effective
; bit 7: STAB (this bit is set when a move has STAB, but never used otherwise, damage is multiplied before the bit is set)
	ds 1

wLoneAttackNo:: ; d05c +2
; which entry in LoneAttacks to use
wGymLeaderNo:: ; d05c
; it's actually the same thing as ^
	ds 1
wTrainerNo:: ; d05d +2
; which instance of [youngster, lass, etc] is this?
	ds 1

wCriticalHitOrOHKO:: ; d05e +2
; $00 = normal attack
; $01 = critical hit
; $02 = successful OHKO
; $ff = failed OHKO
	ds 1

wMoveMissed:: ; d05f +2
	ds 1

wPlayerMimicSlot:: ; d060 +2
; now used to store the slot number (1 to 4) of a signature move learned via Mimic
; remains 0 as long as Mimic wasn't used or was used on a non-signature move
	ds 1

wPlayerStatsToHalve:: ; d061 +2
; always 0
	ds 1

wPlayerBattleStatus1:: ; d062 +2
; bit 0 - bide
; bit 1 - thrash / petal dance
; bit 2 - attacking multiple times (e.g. double kick)
; bit 3 - flinch
; bit 4 - charging up for attack
; bit 5 - using multi-turn move (e.g. wrap)
; bit 6 - invulnerable to normal attack (using fly/dig)
; bit 7 - confusion
	ds 1

wPlayerBattleStatus2:: ; d063 +2
; bit 0 - X Accuracy effect
; bit 1 - protected by "mist"
; bit 2 - focus energy effect
; bit 4 - has a substitute
; bit 5 - need to recharge
; bit 6 - rage
; bit 7 - leech seeded
	ds 1

wPlayerBattleStatus3:: ; d064 +2
; bit 0 - toxic
; bit 1 - light screen
; bit 2 - reflect
; bit 3 - transformed
; bit 4 - trapped
; bit 5 - used an X item this turn
	ds 1

wEnemyMimicSlot:: ; d065 +2
; now used to store the slot number (1 to 4) of a signature move learned via Mimic
; remains 0 as long as Mimic wasn't used or was used on a non-signature move
	ds 1

wEnemyStatsToHalve:: ; d066 +2
; always 0
	ds 1

wEnemyBattleStatus1:: ; d067 +2
	ds 1
wEnemyBattleStatus2:: ; d068 +2
	ds 1
wEnemyBattleStatus3:: ; d069 +2
	ds 1

wPlayerNumAttacksLeft:: ; d06a +2
; when the player is attacking multiple times, the number of attacks left

wPlayerBidingTurnsLeft:: ; d06a +2
; when the player is using Bide, the number of turns left to spend Biding
	ds 1

wPlayerConfusedCounter:: ; d06b +2
	ds 1

wPlayerToxicCounter:: ; d06c +2
	ds 1

wPlayerDisabledMove:: ; d06d +2
; high nibble: which move is disabled (1-4)
; low nibble: disable turns left
	ds 1

; add this for Trick Room
wTrickRoomCounter::
	ds 1

wEnemyNumAttacksLeft:: ; d06f +2
; when the enemy is attacking multiple times, the number of attacks left

wEnemyBidingTurnsLeft:: ; d06f +2
; when the enemy is using Bide, the number of turns left to spend Biding
	ds 1

wEnemyConfusedCounter:: ; d070 +2
	ds 1

wEnemyToxicCounter:: ; d071 +2
	ds 1

wEnemyDisabledMove:: ; d072 +2
; high nibble: which move is disabled (1-4)
; low nibble: disable turns left
	ds 1

; added this to detect when a mon is learning a move through TM
wUsingTM::
	ds 1

wPlayerNumHits:: ; d074 +2
; number of hits by player in attacks like Double Slap, etc.

wPlayerBideAccumulatedDamage:: ; d074 +2
; the amount of damage accumulated by the player while biding (2 bytes)

wUnknownSerialCounter2:: ; d074 +2
; 2 bytes

	ds 4

wEscapedFromBattle:: ; d078 +2
; non-zero when an item or move that allows escape from battle was used
	ds 1

wAmountMoneyWon:: ; d079 +2
; 3-byte BCD number

wObjectToHide:: ; d079 +2
	ds 1

wObjectToShow:: ; d07a +2
	ds 1

	ds 1
	
wAmountMoneyWonEnd::

wDefaultMap:: ; d07c +2
; the map you will start at when the debug bit is set

wMenuItemOffset:: ; d07c +2

wAnimationID:: ; d07c +2
; ID number of the current battle animation
	ds 1

wNamingScreenType:: ; d07d +2

wPartyMenuTypeOrMessageID:: ; d07d

wTempTilesetNumTiles:: ; d07d +2
; temporary storage for the number of tiles in a tileset
	ds 1

wSavedListScrollOffset:: ; d07e +2
; used by the pokemart code to save the existing value of wListScrollOffset
; so that it can be restored when the player is done with the pokemart NPC
	ds 2	; increased it by 1 because ListScrollOffset is now 2 bytes to handle a pokedex with > 255 entries

	ds 1

; base coordinates of frame block
wBaseCoordX:: ; d081 +2
	ds 1
wBaseCoordY:: ; d082 +2
	ds 1

; low health alarm counter/enable
; high bit = enable, others = timer to cycle frequencies
wLowHealthAlarm:: ds 1 ; d083 +2

wFBTileCounter:: ; d084 +2
; counts how many tiles of the current frame block have been drawn
	ds 1

wMovingBGTilesCounter2:: ; d085 +2
	ds 1

wSubAnimFrameDelay:: ; d086 +2
; duration of each frame of the current subanimation in terms of screen refreshes
	ds 1
wSubAnimCounter:: ; d087 +2
; counts the number of subentries left in the current subanimation
	ds 1

wSaveFileStatus:: ; d088 +2
; 1 = no save file or save file is corrupted
; 2 = save file exists and no corruption has been detected
	ds 1

wNumFBTiles:: ; d089 +2
; number of tiles in current battle animation frame block
	ds 1

wFlashScreenLongCounter:: ; d08a +2

wSpiralBallsBaseY:: ; d08a +2

wFallingObjectMovementByte:: ; d08a +2
; bits 0-6: index into FallingObjects_DeltaXs array (0 - 8)
; bit 7: direction; 0 = right, 1 = left

wNumShootingBalls:: ; d08a +2

wTradedMonMovingRight:: ; d08a +2
; $01 if mon is moving from left gameboy to right gameboy; $00 if vice versa

wOptionsInitialized:: ; d08a +2

wNewSlotMachineBallTile:: ; d08a +2

wCoordAdjustmentAmount:: ; d08a +2
; how much to add to the X/Y coord

wUnusedD08A:: ; d08a +2
	ds 1

wSpiralBallsBaseX:: ; d08b +2

wNumFallingObjects:: ; d08b +2

wSlideMonDelay:: ; d08b +2

wAnimCounter:: ; d08b +2
; generic counter variable for various animations

wSubAnimTransform:: ; d08b +2
; controls what transformations are applied to the subanimation
; 01: flip horizontally and vertically
; 02: flip horizontally and translate downwards 40 pixels
; 03: translate base coordinates of frame blocks, but don't change their internal coordinates or flip their tiles
; 04: reverse the subanimation
	ds 1

wEndBattleWinTextPointer:: ; d08c +2
	ds 2

wEndBattleLoseTextPointer:: ; d08e +2
	ds 2

wEndBattleTextRomBank:: ; d092 +2
	ds 1

wSubAnimAddrPtr:: ; d094 +2
; the address _of the address_ of the current subanimation entry
	ds 2

wSlotMachineAllowMatchesCounter:: ; d096 +2
; If non-zero, the allow matches flag is always set.
; There is a 1/256 (~0.4%) chance that this value will be set to 60, which is
; the only way it can increase. Winning certain payout amounts will decrement it
; or zero it.

wSubAnimSubEntryAddr:: ; d096 +2
; the address of the current subentry of the current subanimation
	ds 2

wOutwardSpiralTileMapPointer:: ; d09a +2
	ds 1

wPartyMenuAnimMonEnabled:: ; d09b +2

wTownMapSpriteBlinkingEnabled:: ; d09b +2
; non-zero when enabled. causes nest locations to blink on and off.
; the town selection cursor will blink regardless of what this value is

wUnusedD09B:: ; d09b +2
	ds 1

wFBDestAddr:: ; d09c +2
; current destination address in OAM for frame blocks (big endian)
	ds 2

wFBMode:: ; d09e +2
; controls how the frame blocks are put together to form frames
; specifically, after finishing drawing the frame block, the frame block's mode determines what happens
; 00: clean OAM buffer and delay
; 02: move onto the next frame block with no delay and no cleaning OAM buffer
; 03: delay, but don't clean OAM buffer
; 04: delay, without cleaning OAM buffer, and do not advance [wFBDestAddr], so that the next frame block will overwrite this one
	ds 1

wLinkCableAnimBulgeToggle:: ; d09f +2
; 0 = small
; 1 = big

wIntroNidorinoBaseTile:: ; d09f +2

wOutwardSpiralCurrentDirection:: ; d09f +2

wDropletTile:: ; d09f +2

wNewTileBlockID:: ; d09f +2

wWhichBattleAnimTileset:: ; d09f +2

wSquishMonCurrentDirection:: ; d09f +2
; 0 = left
; 1 = right

wSlideMonUpBottomRowLeftTile:: ; d09f +2
; the tile ID of the leftmost tile in the bottom row in AnimationSlideMonUp_
	ds 1

wDisableVBlankWYUpdate:: ds 1 ; if non-zero, don't update WY during V-blank

wSpriteCurPosX:: ; d0a1 +2
	ds 1
wSpriteCurPosY:: ; d0a2 +2
	ds 1
wSpriteWidth:: ; d0a3 +2
	ds 1
wSpriteHeight:: ; d0a4 +2
	ds 1
wSpriteInputCurByte:: ; d0a5 +2
; current input byte
	ds 1
wSpriteInputBitCounter:: ; d0a6 +2
; bit offset of last read input bit
	ds 1

wSpriteOutputBitOffset:: ; d0a7 +2; determines where in the output byte the two bits are placed. Each byte contains four columns (2bpp data)
; 3 -> XX000000   1st column
; 2 -> 00XX0000   2nd column
; 1 -> 0000XX00   3rd column
; 0 -> 000000XX   4th column
	ds 1

wSpriteLoadFlags:: ; d0a8 +2
; bit 0 determines used buffer (0 -> $a188, 1 -> $a310)
; bit 1 loading last sprite chunk? (there are at most 2 chunks per load operation)
	ds 1
wSpriteUnpackMode:: ; d0a9 +2
	ds 1
wSpriteFlipped:: ; d0aa +2
	ds 1

wSpriteInputPtr:: ; d0ab +2
; pointer to next input byte
	ds 2
wSpriteOutputPtr:: ; d0ad +2
; pointer to current output byte
	ds 2
wSpriteOutputPtrCached:: ; d0af +2
; used to revert pointer for different bit offsets
	ds 2
wSpriteDecodeTable0Ptr:: ; d0b1 +2
; pointer to differential decoding table (assuming initial value 0)
	ds 2
wSpriteDecodeTable1Ptr:: ; d0b3 +2
; pointer to differential decoding table (assuming initial value 1)
	ds 2

wd0b5:: ds 1 ; d0b5 +2 used as a temp storage area for Pokemon Species, and other Pokemon/Battle related things

wNameListType:: ; d0b6 +2
	ds 1

wPredefBank:: ; d0b7 +2
	ds 1

wMonHeader:: ; d0b8 +2

wMonHIndex:: ; d0b8 +2
; In the ROM base stats data structure, this is the dex number, but it is
; overwritten with the internal index number after the header is copied to WRAM.
	ds 2			; to handle 2 bytes species IDs

wMonHBaseStats:: 	; d0b9 +2
	ds NUM_STATS	; replaced the six variables with one block of NUM_STATS bytes, since none were actually used by name

wMonHTypes:: ; d0be +2
wMonHType1:: ; d0be +2
	ds 1
wMonHType2:: ; d0bf +2
	ds 1

wMonHBaseEXP:: ; d0c1 +1
	ds 1
wMonHSpriteDim:: ; d0c2 +1
	ds 1
wMonHFrontSprite:: ; d0c3 +1
	ds 2
wMonHBackSprite:: ; d0c5 +1
	ds 2

wMonHMoves:: ; d0c7 +1
	ds NUM_MOVES

wMonHGrowthRate:: ; d0cb +1
	ds 1

wMonHLearnset:: ; d0cc +1
; bit field
	flag_array NUM_TMS + NUM_HMS + NUM_TUTOR_MOVES	; added tutor moves
	ds 1

wSavedTilesetType:: ; d0d4 +1
; saved at the start of a battle and then written back at the end of the battle
	ds 1


wDamage:: ; d0d7 +1
	ds 2

; new variable to hold 2-bytes species ID as inputs to several functions (in replacement of wd0b5 or wd11e etc)
wMonSpeciesTemp::	; dod8 +1
	ds 2

wRepelRemainingSteps:: ; d0db +1
	ds 1

wMoves:: ; d0dc +1
; list of moves for FormatMovesString
	ds 4

wMoveNum:: ; d0e0 +1
	ds 1

wTypeList::			; use these to store the list of types for ORIGIN_PLATE
wRelearnableMoves:: ; use these to store relearnable move list
wMoveTutorMoves::	; use these to store Move Tutor moves
wMovesString:: ; d0e1 +1
	ds 56

; marker to allow dynamic computing of the relearnable move list's max size
wRelearnableMovesEnd::

wSavedItemMenuCurrentPage:: ; d119 + 1
	ds 1

wWalkBikeSurfStateCopy:: ; d11a +1
; wWalkBikeSurfState is sometimes copied here, but it doesn't seem to be used for anything
	ds 1

wInitListType:: ; d11b +1
; the type of list for InitList to init
	ds 1

wSuccessfulCapture:: ; d11c +1
; renamed it from wCapturedMonSpecies, since it's actually just a binary flag
	ds 1

wFirstMonsNotOutYet:: ; d11d +1
; Non-zero when the first player mon and enemy mon haven't been sent out yet.
; It prevents the game from asking if the player wants to choose another mon
; when the enemy sends out their first mon and suppresses the "no will to fight"
; message when the game searches for the first non-fainted mon in the party,
; which will be the first mon sent out.
	ds 1

wPokeBallCaptureCalcTemp:: ; d11e +1

; lower nybble: number of shakes
; upper nybble: number of animations to play
wPokeBallAnimData:: ; d11e +1

wUsingPPUp:: ; d11e +1

wMaxPP:: ; d11e +1

	ds 1		; to avoid conflict between wUsingPPUp and wd11e which is used with signature moves

; 0 for player, non-zero for enemy
wCalculateWhoseStats:: ; d11e +1

wTypeEffectiveness:: ; d11e +1

wMoveType:: ; d11e +1

wNumSetBits:: ; d11e +1

wd11e:: ds 1 ; d11e +1 used as an Item storage value. Also used as an output value for CountSetBits

wForcePlayerToChooseMon:: ; d11f +1
; When this value is non-zero, the player isn't allowed to exit the party menu
; by pressing B and not choosing a mon.
	ds 1

wNumRunAttempts::
; number of times the player has tried to run from battle
	ds 1

wEvolutionOccurred:: ; d121 +1
	ds 1

wVBlankSavedROMBank:: ; d122 +1
	ds 1

	ds 1

wIsKeyItem:: ; d124 +1
	ds 1

wTextBoxID:: ; d125 +1
	ds 1

wCurrentMapScriptFlags:: ds 1 ; not exactly sure what this is used for, but it seems to be used as a multipurpose temp flag value

wCurEnemyLVL:: ; d127 +1
	ds 1

wItemListPointer:: ; d128 +1
; pointer to list of items terminated by $FF
	ds 2

; added this to make multiple pages in the items menu
wItemMenuCurrentPage::
	ds 1

wListCount::
; number of entries in a list
	ds 1

wLinkState:: ; d12b +1
	ds 1

wTwoOptionMenuID:: ; d12c +1
	ds 1

wChosenMenuItem:: ; d12d +1
; the id of the menu item the player ultimately chose
	ds 1

wMenuExitMethod:: ; d12e +1
; the way the user exited a menu
; for list menus and the buy/sell/quit menu:
; $01 = the user pressed A to choose a menu item
; $02 = the user pressed B to cancel
; for two-option menus:
; $01 = the user pressed A with the first menu item selected
; $02 = the user pressed B or pressed A with the second menu item selected
	ds 1

wDungeonWarpDataEntrySize:: ; d12f +1
; the size is always 6, so they didn't need a variable in RAM for this

wWhichPewterGuy:: ; d12f +1
; 0 = museum guy
; 1 = gym guy

wWhichPrizeWindow:: ; d12f +1
; there are 3 windows, from 0 to 2

wGymGateTileBlock:: ; d12f +1
; a horizontal or vertical gate block
	ds 1

wSavedSpriteScreenY:: ; d130 +1
	ds 1

wSavedSpriteScreenX:: ; d131 +1
	ds 1

wSavedSpriteMapY:: ; d132 +1
	ds 1

wSavedSpriteMapX:: ; d133 +1
	ds 1

wWhichPrize:: ; d139 +1
	ds 1

wIgnoreInputCounter:: ; d13a +1
; counts downward each frame
; when it hits 0, bit 5 (ignore input bit) of wd730 is reset
	ds 1

wStepCounter:: ; d13b +1
; counts down once every step
	ds 1

wNumberOfNoRandomBattleStepsLeft:: ; d13c +1
; after a battle, you have at least 3 steps before a random battle can occur
	ds 1

; add this label for pokemon prizes (to handle 2 bytes species IDs)
wPrizeMon1::
; 2 bytes
wPrize1:: ; d13d +1
	ds 1
wPrize2:: ; d13e +1
	ds 1

; add this label for pokemon prizes (to handle 2 bytes species IDs)	
wPrizeMon2::
; 2 bytes
wPrize3:: ; d13f +1
	ds 1

	ds 1

; add this label for pokemon prizes (to handle 2 bytes species IDs)
wPrizeMon3::
	ds 2

wSerialRandomNumberListBlock:: ; d141 +1
; the first 7 bytes are the preamble

wPrize1Price:: ; d141 +1
	ds 2

wPrize2Price:: ; d143 +1
	ds 2

wPrize3Price:: ; d145 +1
	ds 2

	ds 1

wLinkBattleRandomNumberList:: ; d148 +1
; shared list of 9 random numbers, indexed by wLinkBattleRandomNumberListIndex
	ds 10

wSerialPlayerDataBlock:: ; d152 +1
; 424 bytes
; the first 6 bytes are the preamble
; those bytes are sent to the other gameboy at the start of a link battle

wPseudoItemID:: ; d152 +1
; When a real item is being used, this is 0.
; When a move is acting as an item, this is the ID of the item it's acting as.
; For example, out-of-battle Dig is executed using a fake Escape Rope item. In
; that case, this would be ESCAPE_ROPE.
	ds 1

wNumSetBits_16bits::			; use this to store the result of CountSetBits_16bits (2 bytes)
	ds 2

	ds 1

wEvoStoneItemID:: ; d156 +1
	ds 1

wSavedNPCMovementDirections2Index:: ; d157 +1
	ds 1

wPlayerName:: ; d158 +1
	ds NAME_LENGTH


wPartyDataStart::

wPartyCount::   ds 1 ; d163 +1
wPartySpecies:: ds PARTY_LENGTH * 2	; d164 double the size since species ID are now 2 bytes long
wPartyEnd::     ds 2 ; d16a to handle 2 bytes species IDs

wPartyMons::
wPartyMon1:: party_struct wPartyMon1 ; d16b +1
wPartyMon2:: party_struct wPartyMon2 ; d197 +1
wPartyMon3:: party_struct wPartyMon3 ; d1c3 +1
wPartyMon4:: party_struct wPartyMon4 ; d1ef +1
wPartyMon5:: party_struct wPartyMon5 ; d21b +1
wPartyMon6:: party_struct wPartyMon6 ; d247 +1

wPartyMonOT::    ds NAME_LENGTH * PARTY_LENGTH ; d273 +1
wPartyMonNicks:: ds NAME_LENGTH * PARTY_LENGTH ; d2b5 +1

wPartyDataEnd::

; wSerialPlayerDataBlock ends 2 bytes after wPokedexOwned

wMainDataStart::

wPokedexOwned:: ; d2f7 +1
	flag_array NUM_POKEMON
wPokedexOwnedEnd::

wPokedexSeen:: ; d30a +1
	flag_array NUM_POKEMON
wPokedexSeenEnd::


wNumBagItems:: ; d31d +1
	ds 1
wBagItems:: ; d31e +1
; item, quantity
	ds BAG_ITEM_CAPACITY * 2
	ds 1 ; end

wPlayerMoney:: ; d347 +1
	ds 3 ; BCD

wRivalName:: ; d34a +1
	ds NAME_LENGTH

wOptions:: ; d355 +1
; bit 7 = battle animation
; 0: On
; 1: Off
; bit 6 = battle style
; 0: Shift
; 1: Set
; bit 5 = Exp. All activation
; 0: not activated
; 1: activated
; bits 0-3 = text speed (number of frames to delay after printing a letter)
; 1: Fast
; 3: Medium
; 5: Slow
	ds 1

wObtainedBadges:: ; d356 +1
	flag_array 8

	ds 1

wLetterPrintingDelayFlags:: ; d358 +1
; bit 0: If 0, limit the delay to 1 frame. Note that this has no effect if
;        the delay has been disabled entirely through bit 1 of this variable
;        or bit 6 of wd730.
; bit 1: If 0, no delay.
	ds 1

wPlayerID:: ; d359 +1
	ds 2

wMapMusicSoundID:: ; d35b +1
	ds 1

wMapMusicROMBank:: ; d35c +1
	ds 1

wMapPalOffset:: ; d35d +1
; offset subtracted from FadePal4 to get the background and object palettes for the current map
; normally, it is 0. it is 6 when Flash is needed, causing FadePal2 to be used instead of FadePal4
	ds 1

wCurMap:: ; d35e +1
	ds 1

wCurrentTileBlockMapViewPointer:: ; d35f +1
; pointer to the upper left corner of the current view in the tile block map
	ds 2

wYCoord:: ; d361 +1
; player’s position on the current map
	ds 1

wXCoord:: ; d362 +1
	ds 1

wYBlockCoord:: ; d363 +1
; player's y position (by block)
	ds 1

wXBlockCoord:: ; d364 +1
	ds 1

wLastMap:: ; d365 +1
	ds 1

; use this to store the amount of Battle Points the player has
wPlayerBattlePoints:: ; d366 +1
	ds 1

wCurMapTileset:: ; d367 +1
	ds 1

wCurMapHeight:: ; d368 +1
; blocks
	ds 1

wCurMapWidth:: ; d369 +1
; blocks
	ds 1

wMapDataPtr:: ; d36a +1
	ds 2

wMapTextPtr:: ; d36c +1
	ds 2

wMapScriptPtr:: ; d36e +1
	ds 2

wMapConnections:: ; d370 +1
; connection byte
	ds 1

wMapConn1Ptr:: ; d371 +1
	ds 1

wNorthConnectionStripSrc:: ; d372 +1
	ds 2

wNorthConnectionStripDest:: ; d374 +1
	ds 2

wNorthConnectionStripWidth:: ; d376 +1
	ds 1

wNorthConnectedMapWidth:: ; d377 +1
	ds 1

wNorthConnectedMapYAlignment:: ; d378 +1
	ds 1

wNorthConnectedMapXAlignment:: ; d379 +1
	ds 1

wNorthConnectedMapViewPointer:: ; d37a +1
	ds 2

wMapConn2Ptr:: ; d37c +1
	ds 1

wSouthConnectionStripSrc:: ; d37d +1
	ds 2

wSouthConnectionStripDest:: ; d37f: +2
	ds 2

wSouthConnectionStripWidth:: ; d381 +1
	ds 1

wSouthConnectedMapWidth:: ; d382 +1
	ds 1

wSouthConnectedMapYAlignment:: ; d383 +1
	ds 1

wSouthConnectedMapXAlignment:: ; d384 +1
	ds 1

wSouthConnectedMapViewPointer:: ; d385 +1
	ds 2

wMapConn3Ptr:: ; d387 +1
	ds 1

wWestConnectionStripSrc:: ; d388 +1
	ds 2

wWestConnectionStripDest:: ; d38a +1
	ds 2

wWestConnectionStripHeight:: ; d38c +1
	ds 1

wWestConnectedMapWidth:: ; d38d +1
	ds 1

wWestConnectedMapYAlignment:: ; d38e +1
	ds 1

wWestConnectedMapXAlignment:: ; d38f +1
	ds 1

wWestConnectedMapViewPointer:: ; d390 +1
	ds 2

wMapConn4Ptr:: ; d392 +1
	ds 1

wEastConnectionStripSrc:: ; d393 +1
	ds 2

wEastConnectionStripDest:: ; d395 +1
	ds 2

wEastConnectionStripHeight:: ; d397 +1
	ds 1

wEastConnectedMapWidth:: ; d398 +1
	ds 1

wEastConnectedMapYAlignment:: ; d399 +1
	ds 1

wEastConnectedMapXAlignment:: ; d39a +1
	ds 1

wEastConnectedMapViewPointer:: ; d39b +1
	ds 2

wSpriteSet:: ; d39d +1
; sprite set for the current map (11 sprite picture ID's)
	ds 11

wSpriteSetID:: ; d3a8 +1
; sprite set ID for the current map
	ds 1

wObjectDataPointerTemp:: ; d3a9 +1
	ds 2

; use these to store the current win streak at the Battle Facility
wBattleFacilityCurrentStreak::
	ds 2

wMapBackgroundTile:: ; d3ad +1
; the tile shown outside the boundaries of the map
	ds 1

wNumberOfWarps:: ; d3ae +1
; number of warps in current map
	ds 1

wWarpEntries:: ; d3af +1
; current map warp entries
	ds 128

wDestinationWarpID:: ; d42f +1
; if $ff, the player's coordinates are not updated when entering the map
	ds 1

wNumSigns:: ; d4b0 +1
; number of signs in the current map (up to 16)
	ds 1

wSignCoords:: ; d4b1 +1
; 2 bytes each
; Y, X
	ds 32

wSignTextIDs:: ; d4d1 +1
	ds 16

wNumSprites:: ; d4e1 +1
; number of sprites on the current map
	ds 1

; these two variables track the X and Y offset in blocks from the last special warp used
; they don't seem to be used for anything
wYOffsetSinceLastSpecialWarp:: ; d4e2 +1
	ds 1
wXOffsetSinceLastSpecialWarp:: ; d4e3 +1
	ds 1

wMapSpriteData:: ; d4e4 +1
; two bytes per sprite (movement byte 2, text ID)
	ds 32

wMapSpriteExtraData:: ; d504 +1
; two bytes per sprite (trainer class/item ID, trainer set ID)
	ds 32

wCurrentMapHeight2:: ; d524 +1
; map height in 2x2 meta-tiles
	ds 1

wCurrentMapWidth2:: ; d525 +1
; map width in 2x2 meta-tiles
	ds 1

wMapViewVRAMPointer:: ; d526 +1
; the address of the upper left corner of the visible portion of the BG tile map in VRAM
	ds 2

; In the comments for the player direction variables below, "moving" refers to
; both walking and changing facing direction without taking a step.

wPlayerMovingDirection:: ; d528 +1
; if the player is moving, the current direction
; if the player is not moving, zero
; map scripts write to this in order to change the player's facing direction
	ds 1

wPlayerLastStopDirection:: ; d529 +1
; the direction in which the player was moving before the player last stopped
	ds 1

wPlayerDirection:: ; d52a +1
; if the player is moving, the current direction
; if the player is not moving, the last the direction in which the player moved
	ds 1

wTilesetBank:: ; d52b +1
	ds 1

wTilesetBlocksPtr:: ; d52c +1
; maps blocks (4x4 tiles) to tiles
	ds 2

wTilesetGfxPtr:: ; d52e +1
	ds 2

wTilesetCollisionPtr:: ; d530 +1
; list of all walkable tiles
	ds 2

wTilesetTalkingOverTiles:: ; d532 +1
	ds 3

wGrassTile:: ; d535 +1
	ds 1

; add this to keep track of the player's longest winning streak
wBattleFacilityRecordStreak::
	ds 2

; add this to track streaks of 50 and trigger special battles every 10 battles
; allows special battles to occur even past the maximum streak of 65535
wBattleFacilitySubCounter::
	ds 1
	
	ds 1

wNumBoxItems:: ; d53a +1
	ds 1
wBoxItems:: ; d53b +1
; item, quantity
	ds PC_ITEM_CAPACITY * 2
	ds 1 ; end

wCurrentBoxNum:: ; d5a0 +1
; bits 0-6: box number
; bit 7: whether the player has changed boxes before
	ds 2

wNumHoFTeams:: ; d5a2 +1
; number of HOF teams
	ds 1

wPCBoxWasFilledUp:: ; d5a3 +1
; when the player catches a mon that is sent to PC, this variable can take 2 values:
; 0 = the box still has space
; 1 = the mon filled up the box
; added to keep track of whether a pokemon received in a trade is a new dex entry
wTradedMonIsNewDexEntry::
	ds 1

wPlayerCoins:: ; d5a4 +1
	ds 2 ; BCD

wMissableObjectFlags:: ; d5a6 +1
; bit array of missable objects. set = removed
	ds 32
wMissableObjectFlagsEnd::

; use these bytes to store more flags, allowing for more missable objects
wMissableObjectFlags2::
	ds 7
wMissableObjectFlags2End::

wd5cd:: ds 1 ; temp copy of c1x2 (sprite facing/anim)

wMissableObjectList:: ; d5ce +1
; each entry consists of 2 bytes
; * the sprite ID (depending on the current map)
; * the missable object index (global, used for wMissableObjectFlags)
; terminated with $FF
	ds 17 * 2

wGameProgressFlags:: ; d5f0 +1
; $c8 bytes
wOaksLabCurScript:: ; d5f0 +1
	ds 1
wPalletTownCurScript:: ; d5f1 +1
	ds 1
	ds 1
wBluesHouseCurScript:: ; d5f3 +1
	ds 1
wViridianCityCurScript:: ; d5f4 +1
	ds 1
	ds 2
wPewterCityCurScript:: ; d5f7 +1
	ds 1
wRoute3CurScript:: ; d5f8 +1
	ds 1
wRoute4CurScript:: ; d5f9 +1
	ds 1
	ds 1
wViridianGymCurScript:: ; d5fb +1
	ds 1
wPewterGymCurScript:: ; d5fc +1
	ds 1
wCeruleanGymCurScript:: ; d5fd +1
	ds 1
wVermilionGymCurScript:: ; d5fe +1
	ds 1
wCeladonGymCurScript:: ; d5ff +1
	ds 1
wRoute6CurScript:: ; d600 +1
	ds 1
wRoute8CurScript:: ; d601 +1
	ds 1
wRoute24CurScript:: ; d602 +1
	ds 1
wRoute25CurScript:: ; d603 +1
	ds 1
wRoute9CurScript:: ; d604 +1
	ds 1
wRoute10CurScript:: ; d605 +1
	ds 1
wMtMoon1FCurScript:: ; d606 +1
	ds 1
wMtMoonB2FCurScript:: ; d607 +1
	ds 1
wSSAnne1FRoomsCurScript:: ; d608 +1
	ds 1
wSSAnne2FRoomsCurScript:: ; d609 +1
	ds 1
wRoute22CurScript:: ; d60a +1
	ds 1
	ds 1
wRedsHouse2FCurScript:: ; d60c +1
	ds 1
wViridianMartCurScript:: ; d60d +1
	ds 1
wRoute22GateCurScript:: ; d60e +1
	ds 1
wCeruleanCityCurScript:: ; d60f +1
	ds 1
	ds 7
wSSAnneBowCurScript:: ; d617 +1
	ds 1
wViridianForestCurScript:: ; d618 +1
	ds 1
wMuseum1FCurScript:: ; d619 +1
	ds 1
wRoute13CurScript:: ; d61a +1
	ds 1
wRoute14CurScript:: ; d61b +1
	ds 1
wRoute17CurScript:: ; d61c +1
	ds 1
wRoute19CurScript:: ; d61d +1
	ds 1
wRoute21CurScript:: ; d61e +1
	ds 1
wSafariZoneGateCurScript:: ; d61f +1
	ds 1
wRockTunnelB1FCurScript:: ; d620 +1
	ds 1
wRockTunnel1FCurScript:: ; d621 +1
	ds 1
	ds 1
wRoute11CurScript:: ; d623 +1
	ds 1
wRoute12CurScript:: ; d624 +1
	ds 1
wRoute15CurScript:: ; d625 +1
	ds 1
wRoute16CurScript:: ; d626 +1
	ds 1
wRoute18CurScript:: ; d627 +1
	ds 1
wRoute20CurScript:: ; d628 +1
	ds 1
wSSAnneB1FRoomsCurScript:: ; d629 +1
	ds 1
wVermilionCityCurScript:: ; d62a +1
	ds 1
wPokemonTower2FCurScript:: ; d62b +1
	ds 1
wPokemonTower3FCurScript:: ; d62c +1
	ds 1
wPokemonTower4FCurScript:: ; d62d +1
	ds 1
wPokemonTower5FCurScript:: ; d62e +1
	ds 1
wPokemonTower6FCurScript:: ; d62f +1
	ds 1
wPokemonTower7FCurScript:: ; d630 +1
	ds 1
wRocketHideoutB1FCurScript:: ; d631 +1
	ds 1
wRocketHideoutB2FCurScript:: ; d632 +1
	ds 1
wRocketHideoutB3FCurScript:: ; d633 +1
	ds 1
wRocketHideoutB4FCurScript:: ; d634 +1
	ds 2
wRoute6GateCurScript:: ; d636 +1
	ds 1
wRoute8GateCurScript:: ; d637 +1
	ds 2
wCinnabarIslandCurScript:: ; d639 +1
	ds 1
wPokemonMansion1FCurScript:: ; d63a +1
	ds 2
wPokemonMansion2FCurScript:: ; d63c +1
	ds 1
wPokemonMansion3FCurScript:: ; d63d +1
	ds 1
wPokemonMansionB1FCurScript:: ; d63e +1
	ds 1
wVictoryRoad2FCurScript:: ; d63f +1
	ds 1
wVictoryRoad3FCurScript:: ; d640 +1
	ds 2
wFightingDojoCurScript:: ; d642 +1
	ds 1
wSilphCo2FCurScript:: ; d643 +1
	ds 1
wSilphCo3FCurScript:: ; d644 +1
	ds 1
wSilphCo4FCurScript:: ; d645 +1
	ds 1
wSilphCo5FCurScript:: ; d646 +1
	ds 1
wSilphCo6FCurScript:: ; d647 +1
	ds 1
wSilphCo7FCurScript:: ; d648 +1
	ds 1
wSilphCo8FCurScript:: ; d649 +1
	ds 1
wSilphCo9FCurScript:: ; d64a +1
	ds 1
wHallOfFameCurScript:: ; d64b +1
	ds 1
wChampionsRoomCurScript:: ; d64c +1
	ds 1
wLoreleisRoomCurScript:: ; d64d +1
	ds 1
wBrunosRoomCurScript:: ; d64e +1
	ds 1
wAgathasRoomCurScript:: ; d64f +1
	ds 1
wCeruleanCaveB1FCurScript:: ; d650 +1
	ds 1
wVictoryRoad1FCurScript:: ; d651 +1
	ds 1
	ds 1
wLancesRoomCurScript:: ; d653 +1
	ds 1
wBattleFacilityElevatorCurScript::
	ds 1
wBattleFacilityCurScript::
	ds 1
	
	ds 2
	
wSilphCo10FCurScript:: ; d658 +1
	ds 1
wSilphCo11FCurScript:: ; d659 +1
	ds 1
wSilphCo1FCurScript::	; add this for the Battle Facility
	ds 1
wFuchsiaGymCurScript:: ; d65b +1
	ds 1
wSaffronGymCurScript:: ; d65c +1
	ds 1
	ds 1
wCinnabarGymCurScript:: ; d65e +1
	ds 1
wGameCornerCurScript:: ; d65f +1
	ds 1
wRoute16Gate1FCurScript:: ; d660 +1
	ds 1
wBillsHouseCurScript:: ; d661 +1
	ds 1
wRoute5GateCurScript:: ; d662 +1
	ds 1
wPowerPlantCurScript:: ; d663 +1
wRoute7GateCurScript:: ; d663 +1
; overload
	ds 1
	ds 1
wSSAnne2FCurScript:: ; d665 +1
	ds 1
wSeafoamIslandsB3FCurScript:: ; d666 +1
	ds 1
wRoute23CurScript:: ; d667 +1
	ds 1
wSeafoamIslandsB4FCurScript:: ; d668 +1
	ds 1
wRoute18Gate1FCurScript:: ; d669 +1
	ds 1

	ds 77

; wGameProgressFlags ends at d6b8
	
wGameProgressFlagsEnd::

wTMsListCount::					; used to make a distinct page for TMs in the items menu
	ds 1

wTMsList::						; used to make a distinct page for TMs in the items menu
	ds NUM_TMS + NUM_HMS + 1	; had to add 1 to hold the list terminator at the end

wKeyItemsListCount::			; used to make a distinct page for key items in the items menu
	ds 1

wKeyItemsList::					; used to make a distinct page for key items in the items menu
	ds 20

wObtainedHiddenItemsFlags::
	ds 14

wObtainedHiddenCoinsFlags::
	ds 2

wWalkBikeSurfState:: ; d700 +1
; $00 = walking
; $01 = biking
; $02 = surfing
	ds 1

wTownVisitedFlag:: ; d70b +1
	flag_array 13

wSafariSteps:: ; d70d +1
; starts at 502
	ds 2

wFossilItem:: ; d70f +1
; item given to cinnabar lab
	ds 1

wFossilMon:: ; d710 +1
; mon that will result from the item
	ds 2							; to handle 2 bytes species IDs

	ds 1

wEnemyMonOrTrainerClass:: ; d713 +1
	ds 1

wPlayerJumpingYScreenCoordsIndex:: ; d714 +1
	ds 1

wRivalStarter:: ; d715 +1
	ds 2							; to handle 2 bytes species IDs

wPlayerStarter:: ; d717 +1
	ds 2							; to handle 2 bytes species IDs

wBoulderSpriteIndex:: ; d718 +1
; sprite index of the boulder the player is trying to push
	ds 1

wLastBlackoutMap:: ; d719 +1
	ds 1

wDestinationMap:: ; d71a +1
; destination map (for certain types of special warps, not ordinary walking)
	ds 1

wTileInFrontOfBoulderAndBoulderCollisionResult:: ; d71c +1
; used to store the tile in front of the boulder when trying to push a boulder
; also used to store the result of the collision check ($ff for a collision and $00 for no collision)
	ds 1

wDungeonWarpDestinationMap:: ; d71d +1
; destination map for dungeon warps
	ds 1

wWhichDungeonWarp:: ; d71e +1
; which dungeon warp within the source map was used
	ds 1

wUnusedD71F:: ; d71f +1
	ds 1

; removed 8 seemingly unused bytes

wd728:: ; d728 +1
; bit 0: using Strength outside of battle
; bit 1: set by IsSurfingAllowed when surfing's allowed, but the caller resets it after checking the result
; bit 3: received Old Rod
; bit 4: received Good Rod
; bit 5: received Super Rod
; bit 6: gave one of the Saffron guards a drink
; bit 7: set by ItemUseCardKey, which is leftover code from a previous implementation of the Card Key
	ds 1

	ds 1

wBeatGymFlags:: ; d72a +1
; redundant because it matches wObtainedBadges
; used to determine whether to show name on statue and in two NPC text scripts
	ds 1

; use this variable to store some new flags during battle
; see status_constants.asm for the meaning of each bit
wNewBattleFlags::
	ds 1

wd72c:: ; d72c +1
; bit 0: if not set, the 3 minimum steps between random battles have passed
; bit 1: prevent audio fade out
	ds 1

wd72d:: ; d72d +1
; This variable is used for temporary flags and as the destination map when
; warping to the Trade Center or Colosseum.
; bit 0: sprite facing directions have been initialised in the Trade Center
; bit 3: do scripted warp (used to warp back to Lavender Town from the top of the pokemon tower)
; bit 4: on a dungeon warp
; bit 5: don't make NPCs face the player when spoken to
; Bits 6 and 7 are set by scripts when starting major battles in the storyline,
; but they do not appear to affect anything. Bit 6 is reset after all battles
; and bit 7 is reset after trainer battles (but it's only set before trainer
; battles anyway).
	ds 1

wd72e:: ; d72e +1
; bit 0: the player has received Lapras in the Silph Co. building
; bit 1: set in various places, but doesn't appear to have an effect
; bit 2: the player has healed pokemon at a pokemon center at least once
; bit 3: the player has a received a pokemon from Prof. Oak
; bit 4: disable battles
; bit 5: set when a battle ends and when the player blacks out in the overworld due to poison
; bit 6: using the link feature
; bit 7: set if scripted NPC movement has been initialised
	ds 1

	ds 1

wd730:: ; d730 +1
; bit 0: NPC sprite being moved by script
; bit 1: reset in several places but apparently never checked or set anywhere
; bit 3: use this bit to indicate that FLASH is currently active inside a dark map
; bit 4: checked and reset at the end of trainer battles, but apparently never set anywhere
; bit 5: ignore joypad input
; bit 6: print text with no delay between each letter
; bit 7: set if joypad states are being simulated in the overworld or an NPC's movement is being scripted
	ds 1

	ds 1

wd732:: ; d732 +1
; bit 0: play time being counted
; bit 1: remnant of debug mode? not set by the game code.
; if it is set
; 1. skips most of Prof. Oak's speech, and uses NINTEN as the player's name and SONY as the rival's name
; 2. does not have the player start in floor two of the player's house (instead sending them to [wLastMap])
; 3. allows wild battles to be avoided by holding down B
; bit 2: the target warp is a fly warp (bit 3 set or blacked out) or a dungeon warp (bit 4 set)
; bit 3: used warp pad, escape rope, dig, teleport, or fly, so the target warp is a "fly warp"
; bit 4: jumped into hole (Pokemon Mansion, Seafoam Islands, Victory Road) or went down waterfall (Seafoam Islands), so the target warp is a "dungeon warp"
; bit 5: currently being forced to ride bike (cycling road)
; bit 6: map destination is [wLastBlackoutMap] (usually the last used pokemon center, but could be the player's house)
; bit 7: used secret passage
	ds 1

wFlags_D733:: ; d733 +1
; bit 0: running a test battle
; bit 1: prevent music from changing when entering new map
; bit 2: skip the joypad check in CheckWarpsNoCollision (used for the forced warp down the waterfall in the Seafoam Islands)
; bit 3: trainer wants to battle
; bit 4: use variable [wCurMapScript] instead of the provided index for next frame's map script (used to start battle when talking to trainers)
; bit 5: use this bit to indicate that the player is in the middle of a Battle Facility run
; bit 7: used fly out of battle
	ds 1

wBeatLorelei:: ; d734 +1
; bit 1: set when you beat Lorelei and reset in Indigo Plateau lobby
; the game uses this to tell when Elite 4 events need to be reset
	ds 2

wd736:: ; d736 +1
; bit 0: check if the player is standing on a door and make him walk down a step if so
; bit 1: the player is currently stepping down from a door
; bit 2: standing on a warp
; bit 3: use this bit for directional collisions
; bit 6: jumping down a ledge / fishing animation
; bit 7: player sprite spinning due to spin tiles (Rocket hideout / Viridian Gym)
	ds 1

wCompletedInGameTradeFlags:: ; d737 +1
	ds 2

	ds 2

wWarpedFromWhichWarp:: ; d73b +1
	ds 1

wWarpedFromWhichMap:: ; d73c +1
	ds 1

	ds 2

wCardKeyDoorY:: ; d73f +1
	ds 1

wCardKeyDoorX:: ; d740 +1
	ds 1

	ds 2

wFirstLockTrashCanIndex:: ; d743 +1
	ds 1

wSecondLockTrashCanIndex:: ; d743 +1
	ds 1

	ds 2
wEventFlags:: ; d747 +1
	ds 320

wLinkEnemyTrainerName:: ; d887 +1
; linked game's trainer name

wGrassRate:: ; d887 +1
	ds 1

wGrassMons:: ; d888 +1
	ds 21				; increase allocated space to handle 2 bytes species IDs
; Overload wGrassMons
wSerialEnemyDataBlock:: ; d893 +1
; 424 bytes
; this is where data received from the other gameboy is written at the start of a link battle
	ds 9

wGrassMonsEnd::			; added this to have a way to compute size of wGrassMons
	
wEnemyPartyCount:: ds 1     ; d89c +1
wEnemyPartyMons::  ds (PARTY_LENGTH + 1) * 2 ; d89d double the size since species IDs are now 2 bytes long

; Overload enemy party data
UNION

wWaterRate:: db ; d8a4 +1
wWaterMons:: db ; d8a5 +1

NEXTU

wEnemyMons:: ; d8a4 +1
wEnemyMon1:: party_struct wEnemyMon1
wEnemyMon2:: party_struct wEnemyMon2
wEnemyMon3:: party_struct wEnemyMon3
wEnemyMon4:: party_struct wEnemyMon4
wEnemyMon5:: party_struct wEnemyMon5
wEnemyMon6:: party_struct wEnemyMon6

wEnemyMonOT::    ds NAME_LENGTH * PARTY_LENGTH ; d9ac +1
wEnemyMonNicks:: ds NAME_LENGTH * PARTY_LENGTH ; d9ee +1

ENDU


wTrainerHeaderPtr:: ; da30 +1
	ds 2

wOpponentAfterWrongAnswer:: ; da38 +1
; the trainer the player must face after getting a wrong answer in the Cinnabar
; gym quiz

wUnusedDA38:: ; da38 +1
	ds 1

wCurMapScript:: ; da39 +1
; index of current map script, mostly used as index for function pointer array
; mostly copied from map-specific map script pointer and written back later
	ds 1

wPlayTimeHours:: ; da41 +1
	ds 2
wPlayTimeMaxed:: ; da42 +1
	ds 1
wPlayTimeMinutes:: ; da43 +1
	ds 1
wPlayTimeSeconds:: ; da44 +1
	ds 1
wPlayTimeFrames:: ; da45 +1
	ds 1

wSafariZoneGameOver:: ; da46 +1
	ds 1

wNumSafariBalls:: ; da47 +1
	ds 1


wDayCareInUse:: ; da48 +1
; 0 if no pokemon is in the daycare
; 1 if pokemon is in the daycare
	ds 1

wDayCareMonName:: ds NAME_LENGTH ; da49 +1
wDayCareMonOT::   ds NAME_LENGTH ; da54 +1

wDayCareMon:: box_struct wDayCareMon ; da5f +1

wMainDataEnd::


wBoxDataStart::

wNumInBox::  ds 1 ; da80 +1
wBoxSpecies:: ds (MONS_PER_BOX + 1) * 2		; to handle 2 bytes species IDs

wBoxMons::
wBoxMon1:: box_struct wBoxMon1 ; da96 +1
wBoxMon2:: ds box_struct_length * (MONS_PER_BOX + -1) ; dab7 +1

wBoxMonOT::    ds NAME_LENGTH * MONS_PER_BOX ; dd2a +1
wBoxMonNicks:: ds NAME_LENGTH * MONS_PER_BOX ; de06 +1
wBoxMonNicksEnd:: ; dee2 +1

wBoxDataEnd::	; dee2 +1

wEnemyTrappingMoveId::	; dee2 +1
	ds 1

wPlayerTrappingMoveId::	; dee3 +1
	ds 1

wPlayerLastMoveListIndex::	; dee4 +1  moveset index of the last move successfully used by the player
	ds 1
	
wEnemyLastMoveListIndex::	; dee5 +1  moveset index of the last move successfully used by the enemy
	ds 1

wPlayerReflectCounter::		; dee6 +1  Reflect counter for the player
	ds 1

wPlayerLightScreenCounter::	; dee7 +1  Light Screen counter for the player
	ds 1

wPlayerMistCounter::		; dee8 +1  Mist counter for the player
	ds 1

wEnemyReflectCounter::		; dee9 +1  Reflect counter for the enemy
	ds 1
	
wEnemyLightScreenCounter::	; deea +1  Light Screen counter for the enemy
	ds 1
	
wEnemyMistCounter::			; deeb +1  Mist counter for the enemy
	ds 1

wPlayerLastAttackReceived::	; deec +1  move ID of the last move to have hit the player (for Mirror Move)
	ds 1
	
wEnemyLastAttackReceived::	; deed +1  move ID of the last move to have hit the enemy (for Mirror Move)
	ds 1

wPlayerTrappingCounter::	; number of turns left of trapping move residual damage from the player to the enemy
	ds 1
	
wEnemyTrappingCounter::		; number of turns left of trapping move residual damage from the enemy to the player
	ds 1

	
; deed +1

SECTION "Stack", WRAM0
wStack::	; dfff
			; the stack is actually stored before this address, this is the bottom (end) of the stack, and as it fills up, it uses lower
			; and lower addresses, and it can overlap with variables if you don't let enough space between the last variable and the stack


INCLUDE "sram.asm"
