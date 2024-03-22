//[Bridge MHD NBIS];"SI & A Print"
//Description for Item 26

C_TEXT:C284(vItem26)  // Command Replaced was o_C_STRING length was 23

If (Before:C29)
	vItem26:=Get_Description(-><>aFC; -><>aFC_Cod; ->[Bridge MHD NBIS:1]Item26:120)
End if 