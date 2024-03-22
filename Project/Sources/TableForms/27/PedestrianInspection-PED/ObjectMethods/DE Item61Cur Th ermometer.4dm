If (False:C215)
	//Thermometer for Item 61 Cur
	//This handles input if thermometer is used to enter information
	// Modified by: costasmanousakis-(Designer)-(4/9/09 20:08:57)
	Mods_2009_04
	//Use vars INSP_ThermoRed_L, INSP_ThermoBlack_L
End if 

[Inspections:27]Item 61 Cur:159:=String:C10(tItem61Cur; "0")  //if the format is # and tItemX is equal to 0 string returns a blank!
PushChange(1; ->[Inspections:27]Item 61 Cur:159)
If (Self:C308-><5)
	OBJECT SET RGB COLORS:C628(Self:C308->; Col_paletteToRGB(Abs:C99(INSP_ThermoRed_L)%256); Col_paletteToRGB(Abs:C99(INSP_ThermoRed_L)\256))  // **Replaced o OBJECT SET COLOR(Self->; INSP_ThermoRed_L)
Else 
	OBJECT SET RGB COLORS:C628(Self:C308->; Col_paletteToRGB(Abs:C99(INSP_ThermoBlack_L)%256); Col_paletteToRGB(Abs:C99(INSP_ThermoBlack_L)\256))  // **Replaced o OBJECT SET COLOR(Self->; INSP_ThermoBlack_L)
End if 

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