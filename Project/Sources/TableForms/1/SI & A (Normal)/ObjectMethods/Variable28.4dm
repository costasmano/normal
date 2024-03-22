//[Bridge MHD NBIS];"SI & A Print"
//Description for Item 108a

C_TEXT:C284(vItem108a)  // Command Replaced was o_C_STRING length was 26

If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Printing Detail:K2:18) | (Form event code:C388=On Display Detail:K2:22))
	vItem108a:=Get_Description(-><>aWearing; -><>aWearCod; ->[Bridge MHD NBIS:1]Item108A:80)
End if 