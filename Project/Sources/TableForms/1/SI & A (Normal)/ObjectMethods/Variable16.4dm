//[Bridge MHD NBIS];"SI & A Print"
//Description for Item 37

C_TEXT:C284(vItem37)  // Command Replaced was o_C_STRING length was 60

If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Printing Detail:K2:18) | (Form event code:C388=On Display Detail:K2:22))
	vItem37:=Get_Description(-><>aItem37des; -><>aItem37; ->[Bridge MHD NBIS:1]Item37:129)
End if 