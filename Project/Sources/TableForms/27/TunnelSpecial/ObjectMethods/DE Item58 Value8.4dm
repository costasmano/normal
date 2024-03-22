//Thermometer for [TunnelInspection]Roadway_Rtg_s
G_SetThermometer(->tItem62b; [TunnelInspection:152]Roadway_Rtg_s:4)
If (Form event code:C388=On Data Change:K2:15)
	PushChange(5; Self:C308)
End if 