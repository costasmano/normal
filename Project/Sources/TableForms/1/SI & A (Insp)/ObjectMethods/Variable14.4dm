//[Bridge MHD NBIS];"SI & A Print"
//Description for Item 102

C_TEXT:C284(vItem102)  // Command Replaced was o_C_STRING length was 28

If (Before:C29)
	vItem102:=Get_Description(-><>aDirection; -><>aDirCode; ->[Bridge MHD NBIS:1]Item102:123)
End if 