LoadWildData:
	ld hl, WildDataPointers
	ld a, [wCurMap]

	; get wild data for current map
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
.copy				; entrypoint used to update encounter table dynamically
	ld a, [hli]
	ld h, [hl]
	ld l, a       ; hl now points to wild data for current map
	ld a, [hli]
	ld [wGrassRate], a
	and a
	jr z, .NoGrassData ; if no grass data, skip to surfing data
	push hl
	ld de, wGrassMons ; otherwise, load grass data
	ld bc, wGrassMonsEnd - wGrassMons	; to handle 2 bytes species IDs
	call CopyData
	pop hl
	ld bc, wGrassMonsEnd - wGrassMons	; to handle 2 bytes species IDs
	add hl, bc
.NoGrassData
	ld a, [hli]
	ld [wWaterRate], a
	and a
	ret z        ; if no water data, we're done
	ld de, wWaterMons  ; otherwise, load surfing data
	ld bc, wGrassMonsEnd - wGrassMons	; to handle 2 bytes species IDs
	jp CopyData


; creates a list at wBuffer of maps where the mon in [wd11e] can be found.
; this is used by the pokedex to display locations the mon can be found on the map.
FindWildLocationsOfMon:
	ld hl, WildDataPointers
	ld de, wBuffer
	ld c, $0
.loop
	inc hl
	ld a, [hld]
	inc a
	jr z, .done
	push hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [hli]
	and a
	call nz, CheckMapForMon ; land
	ld a, [hli]
	and a
	call nz, CheckMapForMon ; water
	pop hl
	inc hl
	inc hl
	inc c
	jr .loop
.done
	call FindAlternateWildLocationsOfMon	; to take alternate encounter tables into account
	ld a, $ff ; list terminator
	ld [de], a
	ret

CheckMapForMon:
	inc hl
	ld b, $a
.loop
	ld a, [hli]
	ld [wMonSpeciesTemp+1], a
	ld a, [hli]
	ld [wMonSpeciesTemp], a
	call GetMonHeader					; we need the dex number
	ld a, [wMonDexNumber]				; to handle 2 bytes species IDs
	push hl
	ld hl, wMonHIndex
	cp [hl]
	pop hl
	jr nz, .nextEntry
	ld a, [wMonDexNumber+1]				; to handle 2 bytes species IDs
	push hl
	ld hl, wMonHIndex+1
	cp [hl]								; to handle 2 bytes species IDs
	pop hl
	jr nz, .nextEntry					; to handle 2 bytes species IDs
	ld a, c
	ld [de], a
	inc de
.nextEntry
	inc hl
	dec b
	jr nz, .loop
	dec hl
	ret

FindAlternateWildLocationsOfMon:
	ld hl, AlternateEncounterTablePointers
.loop
	ld a, [hli]
	cp $ff
	ret z
	ld c, a						; put map ID in c for CheckMapForMon
	push hl
	ld a, [hli]
	ld h, [hl]
	ld l, a						; hl now points to alternate encounter table
	ld a, [hli]
	and a
	call nz, CheckMapForMon		; land
	ld a, [hli]
	and a
	call nz, CheckMapForMon		; water
	pop hl
	inc hl
	inc hl
	jr .loop

MaybeUpdateEncounterTable:
	ld a, [wd730]
	bit BIT_FLASH_ACTIVE, a
	ret z
	; fallthrough

; add this to update the encounter table dynamically
; used when the player uses FLASH to light up Rock Tunnel
UpdateEncounterTable:
	ld a, [wCurMap]
	ld b, a
	ld hl, AlternateEncounterTablePointers
.loop
	ld a, [hli]
	cp $FF
	ret z
	cp b
	jr nz, .next
	jp LoadWildData.copy
.next
	inc hl
	inc hl
	jr .loop

; list of map ID/pointer to alternate encounter table
AlternateEncounterTablePointers:
	dbw ROCK_TUNNEL_1F, TunnelMonsB1_Flash
	dbw ROCK_TUNNEL_B1F, TunnelMonsB2_Flash
	db $FF

INCLUDE "data/wild_mons.asm"
