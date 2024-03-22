//[Inspections];"FC Pr (Pg 1)"
//Damage date.

C_TEXT:C284(vDamageDate)  // Command Replaced was o_C_STRING length was 80

If (Form event code:C388=On Printing Detail:K2:18)
	If ([Inspections:27]D_Damage:147#!00-00-00!)
		vDamageDate:=String:C10([Inspections:27]D_Damage:147; Internal date short:K1:7)
	Else 
		vDamageDate:="UNKNOWN"
	End if 
End if 