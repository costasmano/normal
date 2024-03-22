If (False:C215)
	// Fixes for move to v14 or 15 to make sure object method only runs using approriarte for event
	//Modified by: administrator (12/22/15 10:30:29)
End if 
If (Form event code:C388=On Data Change:K2:15)
	PushChange(1; Self:C308)
	G_SetThermometer(->tItem62cur; [Inspections:27]Item 62 Cur:172)
	If (bIsNumeric([Inspections:27]Item 62 UW:165))
		If (Position:C15([Inspections:27]Item 62 Cur:172; "0123456789N ")<Position:C15([Inspections:27]Item 62 UW:165; "0123456789N "))
			[Inspections:27]Item 62:113:=[Inspections:27]Item 62 Cur:172
			PushChange(1; ->[Inspections:27]Item 62:113)
		Else 
			[Inspections:27]Item 62:113:=[Inspections:27]Item 62 UW:165
			PushChange(1; ->[Inspections:27]Item 62:113)
		End if 
	Else 
		[Inspections:27]Item 62:113:=[Inspections:27]Item 62 Cur:172
		PushChange(1; ->[Inspections:27]Item 62:113)
	End if 
	
	//Thermometer for Item 62
	G_SetThermometer(->tItem62; [Inspections:27]Item 62:113)
	
End if 