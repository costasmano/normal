If (False:C215)
	//Thermometer for Item 60 Cur
	//This handles input if thermometer is used to enter information
	// Modified by: costasmanousakis-(Designer)-(4/9/09 20:08:57)
	Mods_2009_04
	//Use vars INSP_ThermoRed_L, INSP_ThermoBlack_L
	
	// Fixes for move to v14 or 15 to make sure object method only runs using approriarte for event
	//Modified by: administrator (12/22/15 10:30:29)
End if 
If (Form event code:C388=On Clicked:K2:4)
	[Inspections:27]Item 60 Cur:155:=String:C10(tItem60Cur; "0")  //if the format is # and tItemX is equal to 0 string returns a blank!
	PushChange(1; ->[Inspections:27]Item 60 Cur:155)
	If (Self:C308-><5)
		OBJECT SET RGB COLORS:C628(Self:C308->; Col_paletteToRGB(Abs:C99(INSP_ThermoRed_L)%256); Col_paletteToRGB(Abs:C99(INSP_ThermoRed_L)\256))  // **Replaced o OBJECT SET COLOR(Self->; INSP_ThermoRed_L)
	Else 
		OBJECT SET RGB COLORS:C628(Self:C308->; Col_paletteToRGB(Abs:C99(INSP_ThermoBlack_L)%256); Col_paletteToRGB(Abs:C99(INSP_ThermoBlack_L)\256))  // **Replaced o OBJECT SET COLOR(Self->; INSP_ThermoBlack_L)
	End if 
	
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
End if 
//Thermometer for Item 60
G_SetThermometer(->tItem60; [Inspections:27]Item 60:81)