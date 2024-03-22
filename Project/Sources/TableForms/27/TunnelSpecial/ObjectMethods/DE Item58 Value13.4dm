//Thermometer for [TunnelInspection]UtilityRoom_Rtg_s
G_SetThermometer(->tItem62g; [TunnelInspection:152]UtilityRoom_Rtg_s:9)
If (Form event code:C388=On Data Change:K2:15)
	PushChange(5; Self:C308)
End if 