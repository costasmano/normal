//[Bridge MHD NBIS];"SI & A Print"
//Description for Item 42b

C_TEXT:C284(item42b)  // Command Replaced was o_C_STRING length was 1//This must not be a local variable!
C_TEXT:C284(vItem42b)  // Command Replaced was o_C_STRING length was 24

If (Before:C29)
	item42b:=Substring:C12([Bridge MHD NBIS:1]Item42:85; 2; 1)
	vItem42b:=Get_Description(-><>aServUndr; -><>aSerUndrCod; ->item42b)
End if 