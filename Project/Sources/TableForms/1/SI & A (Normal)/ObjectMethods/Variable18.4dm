//[Bridge MHD NBIS];"SI & A Print"
//Description for Item 43a

C_TEXT:C284(item43a)  // Command Replaced was o_C_STRING length was 1//This must not be a local variable!
C_TEXT:C284(vItem43a)  // Command Replaced was o_C_STRING length was 30

If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Printing Detail:K2:18) | (Form event code:C388=On Display Detail:K2:22))
	item43a:=Substring:C12([Bridge MHD NBIS:1]Item43:75; 1; 1)
	vItem43a:=Get_Description(-><>aMaterial; -><>aMatCode; ->item43a)
End if 