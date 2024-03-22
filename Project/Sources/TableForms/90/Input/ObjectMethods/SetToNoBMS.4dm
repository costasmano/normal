CONFIRM:C162("Set BMS ID To -1 (No Related BMS Record)?")
If (OK=1)
	[Combined Inspections:90]BMSInspID:3:=-1
	LogLink(->[Combined Inspections:90]BMSInspID:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Combined Inspections:90]BIN:1; ->[Combined Inspections:90]ID:6; 1)
End if 