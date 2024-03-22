//[Bridge MHD NBIS];"SI & A Print"
//Description for Item 44a

C_TEXT:C284(item44a)  // Command Replaced was o_C_STRING length was 1//This must not be a local variable!
C_TEXT:C284(vItem44a)  // Command Replaced was o_C_STRING length was 40

If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Printing Detail:K2:18) | (Form event code:C388=On Display Detail:K2:22))
	item44a:=Substring:C12([Bridge MHD NBIS:1]Item44:76; 1; 1)
	vItem44a:=Get_Description(-><>aDesign; -><>aDesignCod; ->item44a)
End if 