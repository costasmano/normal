If (False:C215)
	//Thermometer for [TunnelInspection]CrossPassage_Rtg_s
	
End if 
[TunnelInspection:152]CrossPassage_Rtg_s:7:=String:C10(tItem62e; "0")
PushChange(5; ->[TunnelInspection:152]CrossPassage_Rtg_s:7)
If (Self:C308-><5)
	OBJECT SET RGB COLORS:C628(Self:C308->; Col_paletteToRGB(Abs:C99(INSP_ThermoRed_L)%256); Col_paletteToRGB(Abs:C99(INSP_ThermoRed_L)\256))  // **Replaced o OBJECT SET COLOR(Self->; INSP_ThermoRed_L)
Else 
	OBJECT SET RGB COLORS:C628(Self:C308->; Col_paletteToRGB(Abs:C99(INSP_ThermoBlack_L)%256); Col_paletteToRGB(Abs:C99(INSP_ThermoBlack_L)\256))  // **Replaced o OBJECT SET COLOR(Self->; INSP_ThermoBlack_L)
End if 
