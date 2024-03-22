//Thermometer for [TunnelInspection]Ceiling_Rtg_s
G_SetThermometer(->tItem62c; [TunnelInspection:152]Ceiling_Rtg_s:5)
If (Form event code:C388=On Data Change:K2:15)
	PushChange(5; Self:C308)
End if 