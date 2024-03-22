//[Bridge MHD NBIS];"SI & A Print"
//Description for Item 102

C_TEXT:C284(vItem102)  // Command Replaced was o_C_STRING length was 28

If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Printing Detail:K2:18) | (Form event code:C388=On Display Detail:K2:22))
	vItem102:=Get_Description(-><>aDirection; -><>aDirCode; ->[NBIS Secondary:3]Item102:30)
End if 