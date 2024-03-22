//[Bridge MHD NBIS];"SI & A Print"
//Description for Item 31

C_TEXT:C284(vItem31)  // Command Replaced was o_C_STRING length was 19

If (Before:C29)
	vItem31:=Get_Description(-><>aDesignLoad; -><>aDesLoadCod; ->[Bridge MHD NBIS:1]Item31:135)
End if 