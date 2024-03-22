//[Inspections];"FC Pr (Pg 1)"
//EDJMT Date.

C_TEXT:C284(vEDJMT)  // Command Replaced was o_C_STRING length was 80

If (Form event code:C388=On Printing Detail:K2:18)
	If ([Inspections:27]EDJMT Date:36#!00-00-00!)
		vEDJMT:=String:C10([Inspections:27]EDJMT Date:36)
	Else 
		vEDJMT:="----"
	End if 
End if 