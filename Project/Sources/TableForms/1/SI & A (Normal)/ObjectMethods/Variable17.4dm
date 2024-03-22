//[Bridge MHD NBIS];"SI & A Print"
//Description for Item 13

C_TEXT:C284(vItem13)  // Command Replaced was o_C_STRING length was 12

If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Printing Detail:K2:18) | (Form event code:C388=On Display Detail:K2:22))
	vItem13:=[Bridge MHD NBIS:1]Item 13A:197+[Bridge MHD NBIS:1]Item 13B:198
End if 