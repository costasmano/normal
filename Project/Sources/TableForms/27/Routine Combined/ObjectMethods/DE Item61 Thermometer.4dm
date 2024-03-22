If (False:C215)
	//Thermometer for Item 61
	//This handles input if thermometer is used to enter information
	// Modified by: costasmanousakis-(Designer)-(4/9/09 20:08:57)
	Mods_2009_04
	//Use vars INSP_ThermoRed_L, INSP_ThermoBlack_L
	// Fixes for move to v14 or 15 to make sure object method only runs using approriarte for event
	//Modified by: administrator (12/22/15 10:30:29)
End if 
If (Form event code:C388=On Clicked:K2:4)
	[Inspections:27]Item 61:82:=String:C10(tItem61; "0")  //if the format is # and tItem58 is equal to 0 string returns a blank!
	If (([Inspections:27]Item 61:82#[Inspections:27]Item 61 UW:72) & ([Inspections:27]Item 61:82#[Inspections:27]Item 61 Cur:159))
		C_TEXT:C284($msg)  // Command Replaced was o_C_STRING length was 255
		$msg:="Entered value of Item 61  <"+[Inspections:27]Item 61:82+"> does not match either of values in Item 61 This Report <"
		$msg:=$msg+[Inspections:27]Item 61 Cur:159+"> nor in Item 61 from UW inspection <"+[Inspections:27]Item 61 UW:72+">"
		ALERT:C41($msg)
	End if 
	PushChange(1; ->[Inspections:27]Item 61:82)
	If (Self:C308-><5)
		OBJECT SET RGB COLORS:C628(Self:C308->; Col_paletteToRGB(Abs:C99(INSP_ThermoRed_L)%256); Col_paletteToRGB(Abs:C99(INSP_ThermoRed_L)\256))  // **Replaced o OBJECT SET COLOR(Self->; INSP_ThermoRed_L)
	Else 
		OBJECT SET RGB COLORS:C628(Self:C308->; Col_paletteToRGB(Abs:C99(INSP_ThermoBlack_L)%256); Col_paletteToRGB(Abs:C99(INSP_ThermoBlack_L)\256))  // **Replaced o OBJECT SET COLOR(Self->; INSP_ThermoBlack_L)
	End if 
End if 
