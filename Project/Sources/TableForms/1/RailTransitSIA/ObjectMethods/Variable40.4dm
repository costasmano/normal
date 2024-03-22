//[Bridge MHD NBIS];"RailTransitSIA".Variable40  //Description for Item 38

C_TEXT:C284(vItem38)  // Command Replaced was o_C_STRING length was 40

If (Before:C29)
	vItem38:=Get_Description(-><>aItem38des; -><>aItem38; ->[Bridge MHD NBIS:1]Item38:113)
End if 