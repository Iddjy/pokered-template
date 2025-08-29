MarkTownVisitedAndLoadMissableObjects:
	ld a, [wCurMap]
	cp ROUTE_1
	jr nc, .notInTown
	ld c, a
	ld b, FLAG_SET
	ld hl, wTownVisitedFlag   ; mark town as visited (for flying)
	predef FlagActionPredef
.notInTown
	ld hl, MapHS00
	ld a, [wCurMap]
	ld c, a
.seekToMapMissableObjects
	ld a, [hli]
	cp $ff
	jr nz, .checkMap
	ld de, wMissableObjectList
	jr LoadMissableObjects.putSentinel
.checkMap
	cp c
	jr z, LoadMissableObjects
	ld a, [hli]							; read number of entries for this map
	ld e, a
	ld d, 0
	add hl, de							; skip this map's entries which are 3 bytes each
	add hl, de
	add hl, de
	jr .seekToMapMissableObjects
	; fall through

LoadMissableObjects:
	ld de, wMissableObjectList
	ld a, [hli]
	ld b, a
.writeMissableObjectsListLoop
	ld a, [hli]
	ld [de], a								; write (map-local) sprite ID
	inc de
	ld a, [hli]
	ld [de], a								; write (global) missable object index
	inc de
	inc hl
	dec b
	jr nz, .writeMissableObjectsListLoop
.putSentinel
	ld a, $ff
	ld [de], a								; write sentinel
	ret

InitializeMissableObjectsFlags:
	ld hl, wMissableObjectFlags
	ld bc, wMissableObjectFlagsEnd - wMissableObjectFlags
	xor a
	call FillMemory ; clear missable objects flags
	ld hl, wMissableObjectFlags2
	ld bc, wMissableObjectFlags2End - wMissableObjectFlags2
	xor a
	call FillMemory												; clear second set of missable objects flags
	ld hl, MapHS00
.missableObjectsLoop
	ld a, [hli]
	cp $ff          ; end of list
	ret z
	ld a, [hli]						; read number of entries for this map
	ld b, a
.loopEntry
	ld a, [hli]						; read object id, which is the list number concatenated with the sprite index
	and $f0							; keep only 4 most significant bits (which contain the list number)
	swap a							; this will extract the list number
	ld d, a							; put list number in d
	ld a, [hli]						; read global index
	ld c, a							; put it in c for call to MissableObjectFlagAction later
	ld a, [hli]
	push hl
	cp Hide
	jr nz, .skip
	push bc
	ld hl, wMissableObjectFlags
	ld a, d
	and a
	jr z, .next
	ld hl, wMissableObjectFlags2
.next
	ld b, FLAG_SET
	call MissableObjectFlagAction ; set flag if Item is hidden
	pop bc
.skip
	pop hl
	dec b
	jr nz, .loopEntry
	jr .missableObjectsLoop

; tests if current sprite is a missable object that is hidden/has been removed
IsObjectHidden:
	ld a, [H_CURRENTSPRITEOFFSET]
	swap a
	ld b, a
	ld hl, wMissableObjectList
.loop
	ld a, [hl]
	cp $ff
	jr z, .notHidden ; not missable -> not hidden
	and $f0
	swap a
	ld c, a
	ld a, [hli]
	and $0f
	cp b
	ld a, [hli]
	jr nz, .loop
	ld b, a
	ld a, c
	and a
	ld a, b
	ld hl, wMissableObjectFlags
	jr z, .test
	ld hl, wMissableObjectFlags2
.test
	ld c, a
	ld b, FLAG_TEST
	call MissableObjectFlagAction
	ld a, c
	and a
	jr nz, .hidden
.notHidden
	xor a
.hidden
	ld [$ffe5], a
	ret

; adds missable object (items, leg. pokemon, etc.) to the map
; [wMissableObjectIndex]: index of the missable object to be added (global index)
ShowObject:
	ld hl, wMissableObjectFlags
	jr ShowObject2.do
ShowObject2:
	ld hl, wMissableObjectFlags2
.do
	ld a, [wMissableObjectIndex]
	ld c, a
	ld b, FLAG_RESET
	call MissableObjectFlagAction   ; reset "removed" flag
	jp UpdateSprites

; removes missable object (items, leg. pokemon, etc.) from the map
; [wMissableObjectIndex]: index of the missable object to be removed (global index)
HideObject:
	ld hl, wMissableObjectFlags
	jr HideObject2.do
HideObject2:
	ld hl, wMissableObjectFlags2
.do
	ld a, [wMissableObjectIndex]
	ld c, a
	ld b, FLAG_SET
	call MissableObjectFlagAction   ; set "removed" flag
	jp UpdateSprites

; moved out of home bank
HideStaticMon:
	ld hl, wMissableObjectList
	ld a, [wSpriteIndex]
	ld b, a
.loop
	ld a, [hl]
	cp $ff
	ret z
	and $0f
	cp b
	jr z, .matchFound
	inc hl
	inc hl
	jr .loop
.matchFound
	ld a, [hli]
	and $f0
	and a
	ld a, [hl]
	ld [wMissableObjectIndex], a               ; load corresponding missable object index and remove it
	jr nz, .secondList
	predef HideObject
	ret
.secondList
	predef HideObject2
	ret

MissableObjectFlagAction:
; identical to FlagAction

	push hl
	push de
	push bc

	; bit
	ld a, c
	ld d, a
	and 7
	ld e, a

	; byte
	ld a, d
	srl a
	srl a
	srl a
	add l
	ld l, a
	jr nc, .ok
	inc h
.ok

	; d = 1 << e (bitmask)
	inc e
	ld d, 1
.shift
	dec e
	jr z, .shifted
	sla d
	jr .shift
.shifted

	ld a, b
	and a
	jr z, .reset
	cp 2
	jr z, .read

.set
	ld a, [hl]
	ld b, a
	ld a, d
	or b
	ld [hl], a
	jr .done

.reset
	ld a, [hl]
	ld b, a
	ld a, d
	xor $ff
	and b
	ld [hl], a
	jr .done

.read
	ld a, [hl]
	ld b, a
	ld a, d
	and b

.done
	pop bc
	pop de
	pop hl
	ld c, a
	ret
