//[Bridge MHD NBIS];"SI & A Print"
//Description for Item 33

C_TEXT:C284(vItem33)  // Command Replaced was o_C_STRING length was 42

If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Printing Detail:K2:18) | (Form event code:C388=On Display Detail:K2:22))
	vItem33:=Get_Description(-><>aItem33des; -><>aItem33; ->[Bridge MHD NBIS:1]Item33:99)
End if 