//[Bridge MHD NBIS];"SI & A Print"
//Description for Item 31

C_TEXT:C284(vItem31)  // Command Replaced was o_C_STRING length was 19

If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Printing Detail:K2:18) | (Form event code:C388=On Display Detail:K2:22))
	vItem31:=Get_Description(-><>aDesignLoad; -><>aDesLoadCod; ->[Bridge MHD NBIS:1]Item31:135)
End if 