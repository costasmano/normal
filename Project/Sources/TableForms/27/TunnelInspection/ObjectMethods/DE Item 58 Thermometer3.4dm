If (False:C215)
	//Thermometer for [TunnelInspection]SupplyAirDuct_Rtg_s
	
End if 
[TunnelInspection:152]SupplyAirDuct_Rtg_s:6:=String:C10(tItem62d; "0")  //if the format is # and tItem58 is equal to 0 string returns a blank!
PushChange(5; ->[TunnelInspection:152]SupplyAirDuct_Rtg_s:6)
If (Self:C308-><5)
	OBJECT SET RGB COLORS:C628(Self:C308->; Col_paletteToRGB(Abs:C99(INSP_ThermoRed_L)%256); Col_paletteToRGB(Abs:C99(INSP_ThermoRed_L)\256))  // **Replaced o OBJECT SET COLOR(Self->; INSP_ThermoRed_L)
Else 
	OBJECT SET RGB COLORS:C628(Self:C308->; Col_paletteToRGB(Abs:C99(INSP_ThermoBlack_L)%256); Col_paletteToRGB(Abs:C99(INSP_ThermoBlack_L)\256))  // **Replaced o OBJECT SET COLOR(Self->; INSP_ThermoBlack_L)
End if 