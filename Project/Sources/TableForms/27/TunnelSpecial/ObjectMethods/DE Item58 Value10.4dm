//Thermometer for [TunnelInspection]SupplyAirDuct_Rtg_s
G_SetThermometer(->tItem62d; [TunnelInspection:152]SupplyAirDuct_Rtg_s:6)
If (Form event code:C388=On Data Change:K2:15)
	PushChange(5; Self:C308)
End if 