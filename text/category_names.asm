CategoryNames:
	dw .Physical
	dw .Special
	dw .Status
	dw .Unused		; category value 3 is unused

.Physical:
	db "<PHYSICAL>PHYSICAL@"
	
.Special:
	db "<SPECIAL>SPECIAL@"
	
.Status:
	db "<STATUS>STATUS@"
	
; category value 3 is unused
.Unused:
	db "@"
