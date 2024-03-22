PushChange(1; Self:C308)
If (bIsNumeric([Inspections:27]Item 61 UW:72))
	If (bIsNumeric([Inspections:27]Item 61 Cur:159))
		Case of 
			: (Num:C11([Inspections:27]Item 61 UW:72)<Num:C11([Inspections:27]Item 61 Cur:159))
				[Inspections:27]Item 61:82:=[Inspections:27]Item 61 UW:72
				PushChange(1; ->[Inspections:27]Item 61:82)
			: (Num:C11([Inspections:27]Item 61 Cur:159)<Num:C11([Inspections:27]Item 61 UW:72))
				[Inspections:27]Item 61:82:=[Inspections:27]Item 61 Cur:159
				PushChange(1; ->[Inspections:27]Item 61:82)
		End case 
	Else 
		[Inspections:27]Item 61:82:=[Inspections:27]Item 61 UW:72
		PushChange(1; ->[Inspections:27]Item 61:82)
	End if 
	
	//Thermometer for Item 61
	G_SetThermometer(->tItem61; [Inspections:27]Item 61:82)
End if 