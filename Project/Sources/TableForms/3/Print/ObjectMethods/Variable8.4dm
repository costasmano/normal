//[Bridge MHD NBIS];"SI & A Print"
//Description for Item 26

C_TEXT:C284(vItem26)  // Command Replaced was o_C_STRING length was 23

If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Printing Detail:K2:18) | (Form event code:C388=On Display Detail:K2:22))
	vItem26:=Get_Description(-><>aFC; -><>aFC_Cod; ->[NBIS Secondary:3]Item26:18)
End if 