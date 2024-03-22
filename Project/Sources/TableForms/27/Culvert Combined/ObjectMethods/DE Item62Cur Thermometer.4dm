If (False:C215)
	//Thermometer for Item 61
	//This handles input if thermometer is used to enter information
	// Modified by: costasmanousakis-(Designer)-(4/9/09 20:08:57)
	Mods_2009_04
	//Use vars INSP_ThermoRed_L, INSP_ThermoBlack_L
End if 

[Inspections:27]Item 62 Cur:172:=String:C10(tItem62Cur; "0")  //if the format is # and tItem58 is equal to 0 string returns a blank!
PushChange(1; ->[Inspections:27]Item 62 Cur:172)
If (Self:C308-><5)
	OBJECT SET RGB COLORS:C628(Self:C308->; Col_paletteToRGB(Abs:C99(INSP_ThermoRed_L)%256); Col_paletteToRGB(Abs:C99(INSP_ThermoRed_L)\256))  // **Replaced o OBJECT SET COLOR(Self->; INSP_ThermoRed_L)
	
Else 
	OBJECT SET RGB COLORS:C628(Self:C308->; Col_paletteToRGB(Abs:C99(INSP_ThermoBlack_L)%256); Col_paletteToRGB(Abs:C99(INSP_ThermoBlack_L)\256))  // **Replaced o OBJECT SET COLOR(Self->; INSP_ThermoBlack_L)
End if 

If (Position:C15([Inspections:27]Item 62 UW:165; "0123456789")>0)
	If (Position:C15([Inspections:27]Item 62 Cur:172; "0123456789N ")<Position:C15([Inspections:27]Item 62 UW:165; "0123456789N "))
		[Inspections:27]Item 62:113:=[Inspections:27]Item 62 Cur:172
	Else 
		[Inspections:27]Item 62:113:=[Inspections:27]Item 62 UW:165
	End if 
Else 
	[Inspections:27]Item 62:113:=[Inspections:27]Item 62 Cur:172
End if 

//Thermometer for Item 62
G_SetThermometer(->tItem62; [Inspections:27]Item 62:113)
PushChange(1; ->[Inspections:27]Item 62:113)