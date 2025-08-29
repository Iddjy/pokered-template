; This function decrement all the counters for move effects that last several turns
; It requires that those counters be next to each other in RAM and in a precise order for it to work
; It also brings susbtitutes onscreen if needed and reinitializes damage
BetweenTurnsEvents:
	callab CallReshowSubstituteAnim_			; bring substitute back onscreen if needed
	ld a, [H_WHOSETURN]
	xor $01
	ld [H_WHOSETURN], a
	callab CallReshowSubstituteAnim_			; bring other substitute back onscreen if needed
	ld hl, wDamage
	xor a
	ld [hli], a									; zero the damage
	ld [hl], a									; zero the damage
	ld a, [wTrickRoomCounter]
	and a
	jr z, .afterTrickRoom
	dec a
	ld [wTrickRoomCounter], a
	jr nz, .afterTrickRoom
	ld hl, TrickRoomOverText
	call PrintText
.afterTrickRoom
	ld hl, wPlayerReflectCounter - 1			; address holding the Reflect counter for the player (minus one)
	ld c, $7
.loop
	inc hl				; point hl to the next counter
	dec c				; decrement loop counter
	ret z				; if loop counter is zero, return
	ld a, [hl]			; load current counter value in a and point hl to next counter
	and a
	jr z, .loop			; if current counter is already zero, nothing to do
	dec [hl]			; decrement current counter
	jr nz, .loop		; if current counter is still not zero, nothing more to do
						; else it means corresponding effect is over, so print it
	push hl				; save hl in the stack
	push bc				; save the loop counter in c to the stack
	call PrintEffectOverText
	pop bc				; restore the loop counter from the stack into c
	pop hl				; restore hl from the stack for next iteration
	jr .loop

; this function prints the text signalling the end of a multiturn effect like Reflect etc.
; It requires that the counters for those effects be next to each other in RAM and in a precise order.
PrintEffectOverText:
	ld a, c
	sub $4
	jr nc, .player
	inc a
	jr z, .enemyReflect
	inc a
	jr z, .enemyLightScreen
	ld hl, EnemyMistWoreOff
	jr .printText
.enemyLightScreen
	ld hl, EnemyLightScreenFell
	jr .printText
.enemyReflect
	ld hl, EnemyReflectFaded
	jr .printText
.player
	and a
	jr z, .playerMist
	dec a
	jr z, .playerLightScreen
	ld hl, PlayerReflectFaded
	jr .printText
.playerMist
	ld hl, PlayerMistWoreOff
	jr .printText
.playerLightScreen
	ld hl, PlayerLightScreenFell
.printText
	call PrintText
	ret

PlayerReflectFaded:
	TX_FAR _PlayerReflectFaded
	db "@"

EnemyReflectFaded:
	TX_FAR _EnemyReflectFaded
	db "@"

PlayerLightScreenFell:
	TX_FAR _PlayerLightScreenFell
	db "@"

EnemyLightScreenFell:
	TX_FAR _EnemyLightScreenFell
	db "@"

PlayerMistWoreOff:
	TX_FAR _PlayerMistWoreOff
	db "@"

EnemyMistWoreOff:
	TX_FAR _EnemyMistWoreOff
	db "@"

TrickRoomOverText:
	TX_FAR _TrickRoomOver
	db "@"
