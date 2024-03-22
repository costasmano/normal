If (False:C215)
	//Thermometer for Item 60
	//This handles input if thermometer is used to enter information
	
	// Modified by: costasmanousakis-(Designer)-(4/9/09 20:08:57)
	Mods_2009_04
	//Use vars INSP_ThermoRed_L, INSP_ThermoBlack_L
	
End if 

[Inspections:27]Item 60:81:=String:C10(tItem60; "0")  //if the format is # and tItem60 is equal to 0 string returns a blank!
If (([Inspections:27]Item 60:81#[Inspections:27]Item 60 UW:66) & ([Inspections:27]Item 60:81#[Inspections:27]Item 60 Cur:155))
	C_TEXT:C284($msg)  // Command Replaced was o_C_STRING length was 255
	$msg:="Entered value of Item 60  <"+[Inspections:27]Item 60:81+"> does not match either of values in Item 60 This Report <"
	$msg:=$msg+[Inspections:27]Item 60 Cur:155+"> nor in Item 60 from UW inspection <"+[Inspections:27]Item 60 UW:66+">"
	ALERT:C41($msg)
End if 
PushChange(1; ->[Inspections:27]Item 60:81)
If (Self:C308-><5)
	OBJECT SET RGB COLORS:C628(Self:C308->; Col_paletteToRGB(Abs:C99(INSP_ThermoRed_L)%256); Col_paletteToRGB(Abs:C99(INSP_ThermoRed_L)\256))  // **Replaced o OBJECT SET COLOR(Self->; INSP_ThermoRed_L)
Else 
	OBJECT SET RGB COLORS:C628(Self:C308->; Col_paletteToRGB(Abs:C99(INSP_ThermoBlack_L)%256); Col_paletteToRGB(Abs:C99(INSP_ThermoBlack_L)\256))  // **Replaced o OBJECT SET COLOR(Self->; INSP_ThermoBlack_L)
End if 