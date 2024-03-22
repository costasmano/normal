If (Form event code:C388=On Data Change:K2:15)
	PushChange(1; Self:C308)
	If (bIsNumeric([Inspections:27]Item 61 UW:72))
		If (Position:C15([Inspections:27]Item 61 Cur:159; "0123456789N ")<Position:C15([Inspections:27]Item 61 UW:72; "0123456789N "))
			[Inspections:27]Item 61:82:=[Inspections:27]Item 61 Cur:159
			PushChange(1; ->[Inspections:27]Item 61:82)
		Else 
			[Inspections:27]Item 61:82:=[Inspections:27]Item 61 UW:72
			PushChange(1; ->[Inspections:27]Item 61:82)
		End if 
	Else 
		[Inspections:27]Item 61:82:=[Inspections:27]Item 61 Cur:159
		PushChange(1; ->[Inspections:27]Item 61:82)
	End if 
	
	//Thermometer for Item 61
	G_SetThermometer(->tItem61; [Inspections:27]Item 61:82)
	
End if 
//Thermometer for Item 61 cur
G_SetThermometer(->tItem61Cur; [Inspections:27]Item 61 Cur:159)