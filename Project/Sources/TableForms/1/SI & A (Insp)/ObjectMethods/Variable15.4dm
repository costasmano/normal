//[Bridge MHD NBIS];"SI & A Print"
//Description for Item 20

C_TEXT:C284(vItem20)  // Command Replaced was o_C_STRING length was 65

If (Before:C29)
	vItem20:=Get_Description(-><>aItem20des; -><>aItem20; ->[Bridge MHD NBIS:1]Item20:126)
End if 