//[Bridge MHD NBIS];"SI & A Print"
//Description for Item 108c

C_TEXT:C284(vItem108c)  // Command Replaced was o_C_STRING length was 26

If (Before:C29)
	vItem108c:=Get_Description(-><>aDeckProt; -><>aDeckPCod; ->[Bridge MHD NBIS:1]Item108C:82)
End if 