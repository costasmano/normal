//[Bridge MHD NBIS];"SI & A Print"
//Description for Item 42a

C_TEXT:C284(item42a)  // Command Replaced was o_C_STRING length was 1//This must not be a local variable!
C_TEXT:C284(vItem42a)  // Command Replaced was o_C_STRING length was 24

If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Printing Detail:K2:18) | (Form event code:C388=On Display Detail:K2:22))
	item42a:=Substring:C12([Bridge MHD NBIS:1]Item42:85; 1; 1)
	vItem42a:=Get_Description(-><>aServiceOvr; -><>aSerOvrCode; ->item42a)
End if 