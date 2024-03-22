//Thermometer for [TunnelInspection]Egress_Rtg_s
G_SetThermometer(->tItem62f; [TunnelInspection:152]Egress_Rtg_s:8)
If (Form event code:C388=On Data Change:K2:15)
	PushChange(5; Self:C308)
End if 