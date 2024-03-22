//[Inspections];"FC Pr (Pg 1)"
//Waived date.

C_TEXT:C284(vWaivedDate)  // Command Replaced was o_C_STRING length was 80

If (Form event code:C388=On Printing Detail:K2:18)
	If ([Inspections:27]WaivedDate:35#!00-00-00!)
		vWaivedDate:=String:C10([Inspections:27]WaivedDate:35; Internal date short:K1:7)
	Else 
		vWaivedDate:="----"
	End if 
End if 