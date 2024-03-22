If (False:C215)
	//Thermometer for Item 61
	//This handles input if thermometer is used to enter information
	// Modified by: costasmanousakis-(Designer)-(4/9/09 20:08:57)
	Mods_2009_04
	//Use vars INSP_ThermoRed_L, INSP_ThermoBlack_L
End if 

[Inspections:27]Item 62:113:=String:C10(tItem62; "0")  //if the format is # and tItem58 is equal to 0 string returns a blank!
If (([Inspections:27]Item 62:113#[Inspections:27]Item 62 UW:165) & ([Inspections:27]Item 62:113#[Inspections:27]Item 62 Cur:172))
	C_TEXT:C284($msg)  // Command Replaced was o_C_STRING length was 255
	$msg:="Entered value of Item 62  <"+[Inspections:27]Item 62:113+"> does not match either of values in Item 62 This Report <"
	$msg:=$msg+[Inspections:27]Item 62 Cur:172+"> nor in Item 62 from UW inspection <"+[Inspections:27]Item 62 UW:165+">"
	ALERT:C41($msg)
End if 
PushChange(1; ->[Inspections:27]Item 62:113)
If (Self:C308-><5)
	OBJECT SET RGB COLORS:C628(Self:C308->; Col_paletteToRGB(Abs:C99(INSP_ThermoRed_L)%256); Col_paletteToRGB(Abs:C99(INSP_ThermoRed_L)\256))  // **Replaced o OBJECT SET COLOR(Self->; INSP_ThermoRed_L)
Else 
	OBJECT SET RGB COLORS:C628(Self:C308->; Col_paletteToRGB(Abs:C99(INSP_ThermoBlack_L)%256); Col_paletteToRGB(Abs:C99(INSP_ThermoBlack_L)\256))  // **Replaced o OBJECT SET COLOR(Self->; INSP_ThermoBlack_L)
End if 
