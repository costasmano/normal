//Thermometer for [TunnelInspection]Structural_Rtg_s
G_SetThermometer(->tItem62a; [TunnelInspection:152]Structural_Rtg_s:3)
If (Form event code:C388=On Data Change:K2:15)
	PushChange(5; Self:C308)
End if 