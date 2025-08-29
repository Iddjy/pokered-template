; de must point to wPlayerMoveNum or wEnemyMoveNum before calling this function
; input: move id in wd11e
ReadSignatureMoveDataInBattle:
	call ReadSignatureMoveDataInBattle_NoRestore
	jp RestoreMoveId

ReadSignatureMoveDataInBattle_NoRestore:
	ld hl, wBattleMonSpecies
	ld a, [H_WHOSETURN]
	and a
	jr z, .playersTurn
	ld hl, wEnemyMonSpecies
.playersTurn
	ld a, [hli]
	ld [wMonSpeciesTemp], a
	ld a, [hl]
	ld [wMonSpeciesTemp + 1], a
	call ReadSignatureMoveData
	call GetMoveName
	call CopyStringToCF4B
	ret
	
RestoreMoveId:
	ld hl, wPlayerSelectedMove
	ld bc, wPlayerMoveNum
	ld a, [H_WHOSETURN]
	and a
	jr z, .restoreOriginalMoveId
	ld hl, wEnemySelectedMove
	ld bc, wEnemyMoveNum
.restoreOriginalMoveId
	ld a, [hl]					; restore the original move id in wPlayerMoveNum or wEnemyMoveNum
	ld [bc], a					; so that the move remains identifiable as a signature move
	ret
	
; input: move id in wd11e
; input: pokemon species id in wMonSpeciesTemp/wMonSpeciesTemp+1
; de must point to the intended target RAM addresses for the move data
ReadSignatureMoveData:
	push de
	call MapSignatureMove
	ld a, d
	dec a
	ld hl, SignatureMoves
	ld bc, MoveEnd - Moves
	call AddNTimes
	pop de
	call CopyData
	ret

; wAnimationID must contain move id when calling this function
SignatureMoveAnimation:
	ld a, [wAnimationID]
	ld [wd11e], a
	ld hl, wBattleMonSpecies
	ld a, [H_WHOSETURN]
	and a
	jr z, .playersTurn
	ld hl, wEnemyMonSpecies
.playersTurn
	ld a, [hli]
	ld [wMonSpeciesTemp], a
	ld a, [hl]
	ld [wMonSpeciesTemp + 1], a
	call MapSignatureMove
	ld a, d
	ld [wAnimationID], a
	jpab MoveAnimation_3

MapAttackerSignatureMove:
	push hl
	ld hl, wBattleMonSpecies
	ld a, [H_WHOSETURN]
	and a
	jr z, .playersTurn
	ld hl, wEnemyMonSpecies
.playersTurn
	ld a, [hli]
	ld [wMonSpeciesTemp], a
	ld a, [hl]
	ld [wMonSpeciesTemp + 1], a
	call MapSignatureMove
	pop hl
	ret

MapDefenderSignatureMove:
	push hl
	ld hl, wEnemyMonSpecies
	ld a, [H_WHOSETURN]
	and a
	jr z, .playersTurn
	ld hl, wBattleMonSpecies
.playersTurn
	ld a, [hli]
	ld [wMonSpeciesTemp], a
	ld a, [hl]
	ld [wMonSpeciesTemp + 1], a
	call MapSignatureMove
	pop hl
	ret

; input: move id in wd11e
; input: pokemon species id in wMonSpeciesTemp/wMonSpeciesTemp+1
; output: mapped move id in d
MapSignatureMove:
	ld a, [wd11e]
	ld hl, wNewBattleFlags
	bit USING_SIGNATURE_MOVE, [hl]
	ld d, a						; put move id in d directly in case mapping was already done
	ret nz
	ld a, [wd11e]
	ld hl, wMonSpeciesTemp
	sub SIGNATURE_MOVE_1		; map SIGNATURE_MOVE_1 to zero
	and a
	jr z, .signatureMove1
	ld a, 1						; map SIGNATURE_MOVE_2 to one
.signatureMove1
	ld d, a						; store 0 or 1 in d according to which signature move it is
	ld a, [hli]					; read species id
	ld l, [hl]					; and put it in hl
	ld h, a
	dec hl						; species ids start at 1
	ld bc, SignatureMovesList
	add hl, hl					; each entry in the list is 2 bytes, so double the species ID
	add hl, bc					; make hl point to the entry corresponding to the species ID
	ld a, d
	and a
	jr z, .firstSignatureMove
	inc hl						; if it is the second signature move, increment hl
.firstSignatureMove
	ld d, [hl]
	ret

; List of signature moves in species ID order (2 moves per species)
; first byte per species is SIGNATURE_MOVE_1
; second byte per species is SIGNATURE_MOVE_2
SignatureMovesList:
	db VINE_WHIP, PETAL_BLIZZARD		; Bulbasaur
	db VINE_WHIP, PETAL_BLIZZARD		; Ivysaur
	db VINE_WHIP, PETAL_BLIZZARD		; Venusaur
	db HEAT_WAVE, HEAT_WAVE				; Charmander
	db HEAT_WAVE, HEAT_WAVE
	db HEAT_WAVE, HEAT_WAVE
	db WAVE_CRASH, WAVE_CRASH			; Squirtle
	db WAVE_CRASH, WAVE_CRASH
	db WAVE_CRASH, WAVE_CRASH
	db STRING_SHOT, QUIVER_DANCE		; Caterpie
	db STRING_SHOT, QUIVER_DANCE
	db STRING_SHOT, QUIVER_DANCE
	db STRING_SHOT, TWINEEDLE			; Weedle
	db STRING_SHOT, TWINEEDLE
	db STRING_SHOT, TWINEEDLE
	db FEATHER_DANCE, FEATHER_DANCE		; Pidgey
	db FEATHER_DANCE, FEATHER_DANCE
	db FEATHER_DANCE, FEATHER_DANCE
	db HYPER_FANG, SUPER_FANG			; Rattata
	db HYPER_FANG, SUPER_FANG
	db FEATHER_DANCE, FEATHER_DANCE		; Spearow*
	db FEATHER_DANCE, FEATHER_DANCE
	db GLARE, HAZE						; Ekans
	db GLARE, HAZE
	db SLAM, SWEET_KISS					; Pikachu
	db SLAM, SWEET_KISS
	db MUD_SLAP, MUD_SLAP				; Sandshrew*
	db MUD_SLAP, MUD_SLAP
	db SUPER_FANG, SUPER_FANG			; NidoranF
	db SUPER_FANG, SUPER_FANG
	db SUPER_FANG, SUPER_FANG
	db HORN_DRILL, HORN_DRILL			; NidoranM
	db HORN_DRILL, HORN_DRILL
	db HORN_DRILL, HORN_DRILL
	db MOONLIGHT, COSMIC_POWER			; Clefairy
	db MOONLIGHT, COSMIC_POWER
	db FLAME_BURST, FLAME_BURST			; Vulpix
	db FLAME_BURST, FLAME_BURST
	db FAKE_TEARS, FAKE_TEARS			; Jigglypuff*
	db FAKE_TEARS, FAKE_TEARS
	db ACROBATICS, HAZE					; Zubat
	db ACROBATICS, HAZE
	db ACROBATICS, HAZE					; Crobat
	db MOONLIGHT, PETAL_BLIZZARD		; Oddish
	db MOONLIGHT, PETAL_BLIZZARD
	db MOONLIGHT, PETAL_BLIZZARD
	db SPORE, SPORE						; Paras
	db SPORE, SPORE
	db QUIVER_DANCE, QUIVER_DANCE		; Venonat
	db QUIVER_DANCE, QUIVER_DANCE
	db ASTONISH, MUD_SLAP				; Diglett
	db ASTONISH, MUD_SLAP
	db PAY_DAY, PAY_DAY					; Meowth
	db PAY_DAY, PAY_DAY
	db LIQUIDATION, LIQUIDATION			; Psyduck*
	db LIQUIDATION, LIQUIDATION
	db MUD_SLAP, MUD_SLAP				; Mankey
	db MUD_SLAP, MUD_SLAP
	db MUD_SLAP, MUD_SLAP				; Annihilape
	db HOWL, HOWL						; Growlithe
	db HOWL, HOWL
	db SUBMISSION, BUBBLEBEAM			; Poliwag
	db SUBMISSION, BUBBLEBEAM
	db SUBMISSION, BUBBLEBEAM
	db KINESIS, BARRIER					; Abra
	db KINESIS, BARRIER
	db KINESIS, BARRIER
	db LOW_SWEEP, DUAL_CHOP				; Machop
	db LOW_SWEEP, DUAL_CHOP
	db LOW_SWEEP, DUAL_CHOP
	db VINE_WHIP, SWEET_SCENT			; Bellsprout
	db VINE_WHIP, SWEET_SCENT
	db VINE_WHIP, SWEET_SCENT
	db ACID_ARMOR, SLUDGE_WAVE			; Tentacool
	db ACID_ARMOR, SLUDGE_WAVE
	db ROCK_POLISH, STEAMROLLER			; Geodude
	db ROCK_POLISH, STEAMROLLER
	db ROCK_POLISH, STEAMROLLER
	db SMART_STRIKE, HORN_DRILL			; Ponyta
	db SMART_STRIKE, HORN_DRILL
	db SLACK_OFF, SLACK_OFF				; Slowpoke
	db SLACK_OFF, SLACK_OFF 
	db SONICBOOM, MIRROR_SHOT			; Magnemite
	db SONICBOOM, MIRROR_SHOT 
	db SONICBOOM, MIRROR_SHOT			; Magnezone
	db ACROBATICS, ACROBATICS			; Farfetch'd
	db DOUBLE_HIT, LUNGE				; Doduo
	db DOUBLE_HIT, LUNGE
	db SHEER_COLD, SHEER_COLD			; Seel
	db SHEER_COLD, SHEER_COLD 
	db SLUDGE_WAVE, ACID_ARMOR			; Grimer
	db SLUDGE_WAVE, ACID_ARMOR 
	db ICICLE_SPEAR, SPIKE_CANNON		; Shellder
	db ICICLE_SPEAR, SPIKE_CANNON 
	db LICK, LICK						; Gastly
	db LICK, LICK 
	db LICK, LICK
	db ROCK_POLISH, SLAM				; Onix
	db ROCK_POLISH, SLAM				; Steelix
	db MEDITATE, MEDITATE				; Drowzee
	db MEDITATE, MEDITATE 
	db VICEGRIP, CRABHAMMER				; Krabby
	db VICEGRIP, CRABHAMMER 
	db SONICBOOM, SONICBOOM				; Voltorb
	db SONICBOOM, SONICBOOM 
	db BULLET_SEED, EGG_BOMB			; Exeggcute
	db BULLET_SEED, EGG_BOMB 
	db SHOCK_WAVE, SHOCK_WAVE			; Spiritomb*
	db BONE_CLUB, BONEMERANG			; Cubone
	db BONE_CLUB, BONEMERANG
	db BONE_CLUB, BONEMERANG			; for GHOST MAROWAK
	db ROLLING_KICK, MEDITATE 			; Hitmonlee
	db COMET_PUNCH, POWER_UP_PUNCH		; Hitmonchan
	db LICK, SLAM 						; Lickitung
	db DOUBLE_HIT, HAZE 				; Koffing
	db DOUBLE_HIT, HAZE 
	db HORN_DRILL, ROCK_WRECKER			; Rhyhorn
	db HORN_DRILL, ROCK_WRECKER
	db HORN_DRILL, ROCK_WRECKER			; Rhyperior
	db SOFTBOILED, EGG_BOMB				; Chansey
	db SOFTBOILED, EGG_BOMB				; Blissey
	db VINE_WHIP, SLAM					; Tangela
	db VINE_WHIP, SLAM					; Tangrowth
	db COMET_PUNCH, DIZZY_PUNCH			; Kangaskhan
	db WAVE_CRASH, WAVE_CRASH			; Horsea
	db WAVE_CRASH, WAVE_CRASH
	db WAVE_CRASH, WAVE_CRASH			; Kingdra
	db HORN_DRILL, HORN_DRILL			; Goldeen
	db HORN_DRILL, HORN_DRILL				
	db PSYWAVE, COSMIC_POWER			; Staryu
	db PSYWAVE, COSMIC_POWER
	db BARRIER, MEDITATE				; Mr.Mime
	db VACUUM_WAVE, DOUBLE_HIT			; Scyther
	db VACUUM_WAVE, DOUBLE_HIT			; Scizor
	db FAKE_TEARS, LOVELY_KISS			; Jynx
	db SHOCK_WAVE, SHOCK_WAVE			; Electabuzz
	db SHOCK_WAVE, SHOCK_WAVE			; Electivire
	db FLAME_BURST, LAVA_PLUME			; Magmar
	db FLAME_BURST, LAVA_PLUME			; Magmortar
	db VICEGRIP, VITAL_THROW			; Pinsir
	db RAGING_BULL, RAGING_BULL			; Tauros
	db SPLASH, DRAGON_RAGE				; Magikarp
	db SPLASH, DRAGON_RAGE
	db SHEER_COLD, SHEER_COLD			; Lapras
	db TRANSFORM, TRANSFORM				; Ditto
	db FAKE_TEARS, FAKE_TEARS			; Eevee*
	db HAZE, ACID_ARMOR					; Vaporeon
	db SHOCK_WAVE, SHOCK_WAVE			; Jolteon*
	db LAVA_PLUME, LAVA_PLUME			; Flareon
	db MORNING_SUN, MORNING_SUN			; Espeon
	db MOONLIGHT, MOONLIGHT				; Umbreon
	db GRASSWHISTLE, GRASSWHISTLE		; Leafeon
	db BARRIER, BARRIER					; Glaceon
	db FAKE_TEARS, FAKE_TEARS			; Sylveon*
	db CONVERSION, SHARPEN				; Porygon
	db CONVERSION, SHARPEN				; Porygon2
	db CONVERSION, SHARPEN				; Porygon-Z
	db MUD_SLAP, MUD_SLAP				; Totodile
	db MUD_SLAP, MUD_SLAP
	db MUD_SLAP, MUD_SLAP
	db FEATHER_DANCE, FEATHER_DANCE		; Hoothoot*
	db FEATHER_DANCE, FEATHER_DANCE
	db BUBBLEBEAM, BUBBLEBEAM			; Chinchou
	db BUBBLEBEAM, BUBBLEBEAM
	db MORNING_SUN, SWEET_KISS			; Togepi
	db MORNING_SUN, SWEET_KISS
	db MORNING_SUN, SWEET_KISS
	db HAZE, HAZE						; Natu*
	db HAZE, HAZE
	db COTTON_SPORE, COTTON_SPORE		; Mareep
	db COTTON_SPORE, COTTON_SPORE
	db COTTON_SPORE, COTTON_SPORE
	db BUBBLEBEAM, SLAM					; Maril
	db BUBBLEBEAM, SLAM
	db STRING_SHOT, SONICBOOM			; Yanma
	db STRING_SHOT, SONICBOOM
	db ASTONISH, HAZE					; Murkrow
	db ASTONISH, HAZE
	db MYSTICAL_FIRE, PSYWAVE			; Misdreavus
	db MYSTICAL_FIRE, PSYWAVE
	db DOUBLE_HIT, TWIN_BEAM			; Girafarig
	db DOUBLE_HIT, TWIN_BEAM
	db ACROBATICS, CRABHAMMER			; Gligar
	db ACROBATICS, CRABHAMMER
	db LICK, LICK						; Snubbull
	db LICK, LICK
	db BULLET_SEED, BULLET_SEED			; Heracross
	db DOUBLE_HIT, DOUBLE_HIT			; Sneasel*
	db DOUBLE_HIT, DOUBLE_HIT
	db LICK, HEADLONG_RUSH				; Teddiursa
	db LICK, HEADLONG_RUSH
	db LICK, HEADLONG_RUSH
	db MUD_SLAP, DOUBLE_HIT				; Swinub
	db MUD_SLAP, DOUBLE_HIT
	db MUD_SLAP, DOUBLE_HIT
	db METAL_SOUND, METAL_SOUND			; Skarmory
	db HOWL, HOWL						; Houndour
	db HOWL, HOWL
	db MUD_SLAP, MUDDY_WATER			; Mudkip
	db MUD_SLAP, MUDDY_WATER
	db MUD_SLAP, MUDDY_WATER
	db ASTONISH, BUBBLEBEAM				; Lotad
	db ASTONISH, BUBBLEBEAM
	db ASTONISH, BUBBLEBEAM
	db LIQUIDATION, LIQUIDATION			; Wingull*
	db LIQUIDATION, LIQUIDATION
	db MYSTICAL_FIRE, MYSTICAL_FIRE		; Ralts
	db MYSTICAL_FIRE, MYSTICAL_FIRE
	db MYSTICAL_FIRE, MYSTICAL_FIRE
	db MYSTICAL_FIRE, MYSTICAL_FIRE		; Gallade
	db SPORE, SPORE						; Shroomish
	db SPORE, SPORE
	db HOWL, BOOMBURST					; Whismur
	db HOWL, BOOMBURST
	db HOWL, BOOMBURST
	db ARM_THRUST, VITAL_THROW			; Makuhita
	db ARM_THRUST, VITAL_THROW
	db MUD_SLAP, METAL_SOUND			; Aron
	db MUD_SLAP, METAL_SOUND
	db MUD_SLAP, METAL_SOUND
	db MEDITATE, MEDITATE				; Meditite
	db MEDITATE, MEDITATE
	db LIQUIDATION, WAVE_CRASH			; Carvanha
	db LIQUIDATION, WAVE_CRASH
	db FLAME_BURST, LAVA_PLUME			; Numel
	db FLAME_BURST, LAVA_PLUME
	db ASTONISH, ASTONISH				; Shuppet
	db ASTONISH, ASTONISH
	db ASTONISH, ASTONISH				; Duskull
	db ASTONISH, ASTONISH
	db ASTONISH, ASTONISH
	db MUD_SLAP, MUD_SLAP				; Absol*
	db ASTONISH, SHEER_COLD				; Snorunt
	db ASTONISH, SHEER_COLD
	db ASTONISH, SHEER_COLD				; Froslass
	db LIQUIDATION, SHEER_COLD			; Spheal
	db LIQUIDATION, SHEER_COLD
	db LIQUIDATION, SHEER_COLD
	db LEAFAGE, HEADLONG_RUSH			; Turtwig
	db LEAFAGE, HEADLONG_RUSH
	db LEAFAGE, HEADLONG_RUSH
	db POWER_UP_PUNCH, ACROBATICS		; Chimchar
	db POWER_UP_PUNCH, ACROBATICS
	db POWER_UP_PUNCH, ACROBATICS
	db FEATHER_DANCE, FEATHER_DANCE		; Starly*
	db FEATHER_DANCE, FEATHER_DANCE
	db FEATHER_DANCE, FEATHER_DANCE
	db SHOCK_WAVE, SHOCK_WAVE			; Shinx*
	db SHOCK_WAVE, SHOCK_WAVE
	db SHOCK_WAVE, SHOCK_WAVE
	db GRASSWHISTLE, SWEET_SCENT		; Budew
	db GRASSWHISTLE, SWEET_SCENT		; Roselia
	db GRASSWHISTLE, SWEET_SCENT		; Roserade
	db LIQUIDATION, WAVE_CRASH			; Buizel
	db LIQUIDATION, WAVE_CRASH
	db ASTONISH, MYSTICAL_FIRE			; Drifloon
	db ASTONISH, MYSTICAL_FIRE
	db PSYWAVE, METAL_SOUND				; Bronzor
	db PSYWAVE, METAL_SOUND
	db POWER_UP_PUNCH, METEOR_MASH		; Riolu
	db POWER_UP_PUNCH, METEOR_MASH
	db POISON_TAIL, POISON_TAIL			; Skorupi*
	db POISON_TAIL, POISON_TAIL
	db MUD_SLAP, ASTONISH				; Croagunk
	db MUD_SLAP, ASTONISH
	db GRASSWHISTLE, SHEER_COLD			; Snover
	db GRASSWHISTLE, SHEER_COLD
	db MOONLIGHT, PSYWAVE				; Munna
	db MOONLIGHT, PSYWAVE
	db SHOCK_WAVE, SHOCK_WAVE			; Blitzle
	db SHOCK_WAVE, SHOCK_WAVE
	db MUD_SLAP, MUD_SLAP				; Roggenrola
	db MUD_SLAP, MUD_SLAP
	db MUD_SLAP, MUD_SLAP
	db MUD_SLAP, HORN_DRILL				; Drilbur
	db MUD_SLAP, HORN_DRILL
	db BUBBLEBEAM, MUDDY_WATER			; Tympole
	db BUBBLEBEAM, MUDDY_WATER
	db BUBBLEBEAM, MUDDY_WATER
	db STRING_SHOT, STRING_SHOT			; Sewaddle
	db STRING_SHOT, STRING_SHOT
	db STRING_SHOT, STRING_SHOT
	db POISON_TAIL, STEAMROLLER			; Venipede
	db POISON_TAIL, STEAMROLLER
	db POISON_TAIL, STEAMROLLER
	db COTTON_SPORE, COTTON_SPORE		; Cottonee
	db COTTON_SPORE, COTTON_SPORE
	db QUIVER_DANCE, QUIVER_DANCE		; Petilil
	db QUIVER_DANCE, QUIVER_DANCE
	db MUD_SLAP, MUD_SLAP				; Sandile
	db MUD_SLAP, MUD_SLAP
	db MUD_SLAP, MUD_SLAP
	db HEAD_SMASH, HEAD_SMASH			; Scraggy
	db HEAD_SMASH, HEAD_SMASH
	db PSYWAVE, DIZZY_PUNCH				; Solosis
	db PSYWAVE, DIZZY_PUNCH
	db PSYWAVE, DIZZY_PUNCH
	db STRING_SHOT, ELECTROWEB			; Joltik
	db STRING_SHOT, ELECTROWEB
	db MIRROR_SHOT, MIRROR_SHOT			; Ferroseed
	db MIRROR_SHOT, MIRROR_SHOT
	db ASTONISH, FLAME_BURST			; Litwick
	db ASTONISH, FLAME_BURST
	db ASTONISH, FLAME_BURST
	db DUAL_CHOP, BREAKING_SWIPE		; Axew
	db DUAL_CHOP, BREAKING_SWIPE
	db DUAL_CHOP, BREAKING_SWIPE
	db SHEER_COLD, SHEER_COLD			; Cubchoo
	db SHEER_COLD, SHEER_COLD
	db DRAGON_RAGE, DRAGON_TAIL			; Druddigon
	db ASTONISH, MUD_SLAP				; Golett
	db ASTONISH, MUD_SLAP
	db METAL_SOUND, METAL_SOUND			; Pawniard
	db METAL_SOUND, METAL_SOUND
	db VICEGRIP, METAL_SOUND			; Durant
	db HEAT_WAVE, QUIVER_DANCE			; Larvesta
	db HEAT_WAVE, QUIVER_DANCE
	db HOWL, MYSTICAL_FIRE				; Fennekin
	db HOWL, MYSTICAL_FIRE
	db HOWL, MYSTICAL_FIRE
	db ACROBATICS, ACROBATICS			; Fletchling
	db ACROBATICS, ACROBATICS
	db ACROBATICS, ACROBATICS
	db VINE_WHIP, PETAL_BLIZZARD		; Flabébé
	db VINE_WHIP, PETAL_BLIZZARD
	db VINE_WHIP, PETAL_BLIZZARD
	db VINE_WHIP, LOW_SWEEP				; Skiddo
	db VINE_WHIP, LOW_SWEEP
	db ARM_THRUST, VITAL_THROW			; Pancham
	db ARM_THRUST, VITAL_THROW
	db SWEET_SCENT, SWEET_KISS			; Spritzee
	db SWEET_SCENT, SWEET_KISS
	db FAKE_TEARS, COTTON_SPORE			; Swirlix
	db FAKE_TEARS, COTTON_SPORE
	db CONSTRICT, PSYWAVE				; Inkay
	db CONSTRICT, PSYWAVE
	db POISON_TAIL, DRAGON_TAIL			; Skrelp
	db POISON_TAIL, DRAGON_TAIL
	db SHARPEN, ROCK_POLISH				; Carbink
	db ASTONISH, HORN_LEECH				; Phantump
	db ASTONISH, HORN_LEECH
	db SUPER_FANG, BOOMBURST			; Noibat
	db SUPER_FANG, BOOMBURST
	db LEAFAGE, FEATHER_DANCE			; Rowlet
	db LEAFAGE, FEATHER_DANCE
	db LEAFAGE, FEATHER_DANCE
	db POLLEN_PUFF, QUIVER_DANCE		; Cutiefly
	db POLLEN_PUFF, QUIVER_DANCE
	db MUD_SLAP, MUD_SLAP				; Mudbray
	db MUD_SLAP, MUD_SLAP
	db LUNGE, LIQUIDATION				; Dewpider
	db LUNGE, LIQUIDATION
	db FLAME_BURST, FIRE_LASH			; Salandit
	db FLAME_BURST, FIRE_LASH
	db GLARE, DRAGON_RAGE				; Drampa
	db HOWL, HOWL						; Yamper*
	db HOWL, HOWL
	db ROCK_POLISH, HEAT_CRASH			; Rolycoly
	db ROCK_POLISH, HEAT_CRASH
	db ROCK_POLISH, HEAT_CRASH
	db FALSE_SURRENDER, SPIRIT_BREAK	; Impidimp
	db FALSE_SURRENDER, SPIRIT_BREAK
	db FALSE_SURRENDER, SPIRIT_BREAK
	db FEATHER_DANCE, QUIVER_DANCE		; Snom
	db FEATHER_DANCE, QUIVER_DANCE
	db ICE_SPINNER, ICE_SPINNER			; Cetoddle
	db ICE_SPINNER, ICE_SPINNER
	db LICK, LICK						; Snorlax
	db CONSTRICT, SPIKE_CANNON			; Omanyte
	db CONSTRICT, SPIKE_CANNON
	db METAL_SOUND, LIQUIDATION			; Kabuto
	db METAL_SOUND, LIQUIDATION
	db ROCK_POLISH, HEAD_SMASH			; Cranidos
	db ROCK_POLISH, HEAD_SMASH
	db METAL_SOUND, METAL_SOUND			; Shieldon
	db METAL_SOUND, METAL_SOUND
	db DRAGON_TAIL, HEAD_SMASH			; Tyrunt
	db DRAGON_TAIL, HEAD_SMASH
	db HAZE, HAZE						; Amaura*
	db HAZE, HAZE
	db DRAGON_RAGE, DRAGON_RAGE			; Aerodactyl*
	db HAZE, SHEER_COLD					; Articuno
	db SHOCK_WAVE, SHOCK_WAVE			; Zapdos*
	db HEAT_WAVE, HEAT_WAVE				; Moltres
	db SLAM, DRAGON_TAIL				; Dratini
	db SLAM, DRAGON_TAIL
	db SLAM, DRAGON_TAIL
	db MUD_SLAP, MUD_SLAP				; Larvitar*
	db MUD_SLAP, MUD_SLAP
	db MUD_SLAP, MUD_SLAP
	db METEOR_MASH, METEOR_MASH			; Beldum
	db METEOR_MASH, METEOR_MASH
	db METEOR_MASH, METEOR_MASH
	db DRAGON_RAGE, DUAL_CHOP			; Gible
	db DRAGON_RAGE, DUAL_CHOP
	db DRAGON_RAGE, DUAL_CHOP
	db DRAGON_RAGE, DOUBLE_HIT			; Deino
	db DRAGON_RAGE, DOUBLE_HIT
	db DRAGON_RAGE, DOUBLE_HIT
	db ASTONISH, ASTONISH				; Giratina Altered*
	db ASTONISH, ASTONISH				; Giratina Origin*
	db BARRIER, PSYSTRIKE				; Mewtwo
	db TRANSFORM, BARRIER				; Mew
	db COSMIC_POWER, JUDGMENT			; Arceus
	db COSMIC_POWER, JUDGMENT			; Arceus
	db COSMIC_POWER, JUDGMENT			; Arceus
	db COSMIC_POWER, JUDGMENT			; Arceus
	db COSMIC_POWER, JUDGMENT			; Arceus
	db COSMIC_POWER, JUDGMENT			; Arceus
	db COSMIC_POWER, JUDGMENT			; Arceus
	db COSMIC_POWER, JUDGMENT			; Arceus
	db COSMIC_POWER, JUDGMENT			; Arceus
	db COSMIC_POWER, JUDGMENT			; Arceus
	db COSMIC_POWER, JUDGMENT			; Arceus
	db COSMIC_POWER, JUDGMENT			; Arceus
	db COSMIC_POWER, JUDGMENT			; Arceus
	db COSMIC_POWER, JUDGMENT			; Arceus
	db COSMIC_POWER, JUDGMENT			; Arceus
	db COSMIC_POWER, JUDGMENT			; Arceus
	db COSMIC_POWER, JUDGMENT			; Arceus
	db COSMIC_POWER, JUDGMENT			; Arceus
