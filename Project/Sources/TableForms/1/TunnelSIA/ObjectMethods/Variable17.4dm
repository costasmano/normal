//[Bridge MHD NBIS];"SI & A Print"
//Description for Item 22

C_TEXT:C284(vItem22)  // Command Replaced was o_C_STRING length was 27

If (Before:C29)
	vItem22:=Get_Description(-><>aMaintOwner; -><>aMaintCod; ->[Bridge MHD NBIS:1]Item22:128)
End if 