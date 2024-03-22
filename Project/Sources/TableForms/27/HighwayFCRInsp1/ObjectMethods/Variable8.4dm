//[Inspections];"Routine Form"
//Description for Item 26

C_TEXT:C284(vItem26)  // Command Replaced was o_C_STRING length was 23

If (Form event code:C388=On Printing Detail:K2:18)
	vItem26:=Get_Description(-><>aFC; -><>aFC_Cod; ->[Inspections:27]Item26:200)
End if 