If (Form event code:C388=On Data Change:K2:15)
	PushChange(1; Self:C308)
	If (bIsNumeric([Inspections:27]Item 60 UW:66))
		If (Position:C15([Inspections:27]Item 60 Cur:155; "0123456789N ")<Position:C15([Inspections:27]Item 60 UW:66; "0123456789N "))
			[Inspections:27]Item 60:81:=[Inspections:27]Item 60 Cur:155
			PushChange(1; ->[Inspections:27]Item 60:81)
		Else 
			[Inspections:27]Item 60:81:=[Inspections:27]Item 60 UW:66
			PushChange(1; ->[Inspections:27]Item 60:81)
		End if 
	Else 
		[Inspections:27]Item 60:81:=[Inspections:27]Item 60 Cur:155
		PushChange(1; ->[Inspections:27]Item 60:81)
	End if 
	
	//Thermometer for Item 60
	G_SetThermometer(->tItem60; [Inspections:27]Item 60:81)
	
End if 
//Thermometer for Item 60 cur
G_SetThermometer(->tItem60Cur; [Inspections:27]Item 60 Cur:155)