//[Bridge MHD NBIS];"SI & A Print"
//Description for Item 20

C_TEXT:C284(vItem20)  // Command Replaced was o_C_STRING length was 65

If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Printing Detail:K2:18) | (Form event code:C388=On Display Detail:K2:22))
	vItem20:=Get_Description(-><>aItem20des; -><>aItem20; ->[NBIS Secondary:3]Item20:17)
End if 