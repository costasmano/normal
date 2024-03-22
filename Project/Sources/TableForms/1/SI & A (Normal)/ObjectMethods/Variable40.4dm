//[Bridge MHD NBIS];"SI & A Print"
//Description for Item 38

C_TEXT:C284(vItem38)  // Command Replaced was o_C_STRING length was 40

If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Printing Detail:K2:18) | (Form event code:C388=On Display Detail:K2:22))
	vItem38:=Get_Description(-><>aItem38des; -><>aItem38; ->[Bridge MHD NBIS:1]Item38:113)
End if 