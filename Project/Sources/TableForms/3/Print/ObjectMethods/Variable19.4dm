//[Bridge MHD NBIS];"SI & A Print"
//Description for Item 43b

C_TEXT:C284(item43b)  // Command Replaced was o_C_STRING length was 2//This must not be a local variable!
C_TEXT:C284(vItem43b)  // Command Replaced was o_C_STRING length was 40

If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Printing Detail:K2:18) | (Form event code:C388=On Display Detail:K2:22))
	item43b:=Substring:C12([NBIS Secondary:3]Item43:24; 2; 2)
	vItem43b:=Get_Description(-><>aDesign; -><>aDesignCod; ->item43b)
End if 
