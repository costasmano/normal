//[Bridge MHD NBIS];"SI & A Print"
//Description for Item 37

C_TEXT:C284(vItem37)  // Command Replaced was o_C_STRING length was 60

If (Before:C29)
	vItem37:=Get_Description(-><>aItem37des; -><>aItem37; ->[Bridge MHD NBIS:1]Item37:129)
End if 