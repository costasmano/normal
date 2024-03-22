PushChange(1; Self:C308)
If (bIsNumeric([Inspections:27]Item 62 UW:165))
	If (bIsNumeric([Inspections:27]Item 62 Cur:172))
		Case of 
			: (Num:C11([Inspections:27]Item 62 UW:165)<Num:C11([Inspections:27]Item 62 Cur:172))
				[Inspections:27]Item 62:113:=[Inspections:27]Item 62 UW:165
				PushChange(1; ->[Inspections:27]Item 62:113)
			: (Num:C11([Inspections:27]Item 62 Cur:172)<Num:C11([Inspections:27]Item 62 UW:165))
				[Inspections:27]Item 62:113:=[Inspections:27]Item 62 Cur:172
				PushChange(1; ->[Inspections:27]Item 62:113)
		End case 
	Else 
		[Inspections:27]Item 62:113:=[Inspections:27]Item 62 UW:165
		PushChange(1; ->[Inspections:27]Item 62:113)
	End if 
	
	//Thermometer for Item 62
	G_SetThermometer(->tItem62; [Inspections:27]Item 62:113)
End if 