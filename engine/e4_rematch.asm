; unsets the carry flag if conditions are met, sets it otherwise
CheckE4RematchConditions:
; Uncomment following lines to put a threshold on the minimum number of times the original E4 must be defeated
;	ld a, [wNumHoFTeams]
;	cp 4
;	ret c
; Uncomment following lines to put a threshold on the record streak at the Battle Facility
;	ld hl, wBattleFacilityRecordStreak
;	ld a, [hli]
;	and a
;	jr nz, .rematch ; if high byte is non-null, record streak is > 50
;	ld a, [hl]
;	cp 50
;	ret
;.rematch
;	xor a
;	ret
; Remove following lines if any conditions are implemented above
	scf
	ret
