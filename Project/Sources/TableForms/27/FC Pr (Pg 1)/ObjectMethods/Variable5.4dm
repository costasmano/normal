//[Inspections];"FC Pr (Pg 1)"
//Rating date.

C_TEXT:C284(vRatingDate)  // Command Replaced was o_C_STRING length was 80

If (Form event code:C388=On Printing Detail:K2:18)
	If ([Inspections:27]Rating Date:74#!00-00-00!)
		vRatingDate:=String:C10([Inspections:27]Rating Date:74; Internal date short:K1:7)
	Else 
		vRatingDate:="----"
	End if 
End if 