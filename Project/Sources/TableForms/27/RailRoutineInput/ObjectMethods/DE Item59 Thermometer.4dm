If (False:C215)
	//Thermometer for Item 59
	//This handles input if thermometer is used to enter information
	// Modified by: costasmanousakis-(Designer)-(4/9/09 20:08:57)
	Mods_2009_04
	//Use vars INSP_ThermoRed_L, INSP_ThermoBlack_L
End if 

[Inspections:27]Item 59:80:=String:C10(tItem59; "0")  //if the format is # and tItem59 is equal to 0 string returns a blank!
PushChange(1; ->[Inspections:27]Item 59:80)
If (Self:C308-><5)
	OBJECT SET RGB COLORS:C628(Self:C308->; Col_paletteToRGB(Abs:C99(INSP_ThermoRed_L)%256); Col_paletteToRGB(Abs:C99(INSP_ThermoRed_L)\256))  // **Replaced o OBJECT SET COLOR(Self->; INSP_ThermoRed_L)
Else 
	OBJECT SET RGB COLORS:C628(Self:C308->; Col_paletteToRGB(Abs:C99(INSP_ThermoBlack_L)%256); Col_paletteToRGB(Abs:C99(INSP_ThermoBlack_L)\256))  // **Replaced o OBJECT SET COLOR(Self->; INSP_ThermoBlack_L)
End if 