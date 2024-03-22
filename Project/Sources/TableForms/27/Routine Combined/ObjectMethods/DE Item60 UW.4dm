If (False:C215)
	// Fixes for move to v14 or 15 to make sure object method only runs using approriarte for event
	//Modified by: administrator (12/22/15 10:30:29)
End if 
If (Form event code:C388=On Data Change:K2:15)
	PushChange(1; Self:C308)
	If (bIsNumeric([Inspections:27]Item 60 UW:66))
		If (bIsNumeric([Inspections:27]Item 60 Cur:155))
			Case of 
				: (Num:C11([Inspections:27]Item 60 UW:66)<Num:C11([Inspections:27]Item 60 Cur:155))
					[Inspections:27]Item 60:81:=[Inspections:27]Item 60 UW:66
					PushChange(1; ->[Inspections:27]Item 60:81)
				: (Num:C11([Inspections:27]Item 60 Cur:155)<Num:C11([Inspections:27]Item 60 UW:66))
					[Inspections:27]Item 60:81:=[Inspections:27]Item 60 Cur:155
					PushChange(1; ->[Inspections:27]Item 60:81)
			End case 
		Else 
			[Inspections:27]Item 60:81:=[Inspections:27]Item 60 UW:66
			PushChange(1; ->[Inspections:27]Item 60:81)
		End if 
		
		//Thermometer for Item 60
		G_SetThermometer(->tItem60; [Inspections:27]Item 60:81)
	End if 
	
End if 