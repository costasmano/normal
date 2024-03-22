//[Bridge MHD NBIS];"SI & A Print"
//Description for Item 43a

C_TEXT:C284(item43a)  // Command Replaced was o_C_STRING length was 1//This must not be a local variable!
C_TEXT:C284(vItem43ab)  // Command Replaced was o_C_STRING length was 120
C_TEXT:C284(item43b)  // Command Replaced was o_C_STRING length was 2//This must not be a local variable!
C_TEXT:C284(vItem43b)  // Command Replaced was o_C_STRING length was 40

If (Form event code:C388=On Load:K2:1)
	item43a:=Substring:C12([Bridge MHD NBIS:1]Item43:75; 1; 1)
	vItem43ab:=Get_Description(-><>aMaterial; -><>aMatCode; ->item43a)
	item43b:=Substring:C12([Bridge MHD NBIS:1]Item43:75; 2; 2)
	vItem43b:=Get_Description(-><>aDesign; -><>aDesignCod; ->item43b)
	If (vItem43ab#"")
		vItem43ab:=vItem43ab+" : "+vItem43b
	End if 
End if 