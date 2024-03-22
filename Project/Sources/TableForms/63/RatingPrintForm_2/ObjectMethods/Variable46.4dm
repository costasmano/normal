//[Bridge MHD NBIS];"SI & A Print"
//Description for Item 65

C_TEXT:C284(vItem65)  // Command Replaced was o_C_STRING length was 50

If (Form event code:C388=On Printing Detail:K2:18)
	vItem65:=Get_Description(-><>aRatMethDes; -><>aRatingMeth; ->[Bridge MHD NBIS:1]Item 65:200)
	vItem65:=Replace string:C233(vItem65; " Loading"; "")
End if 
G_FormatItm6466(->[Bridge MHD NBIS:1]Item 65:200; ->[Bridge MHD NBIS:1]Item66:139)