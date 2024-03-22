//[Conslt Rating];"RatingPrintForm_2".Variable45
//Description for Item 63

C_TEXT:C284(vItem63)  // Command Replaced was o_C_STRING length was 50

If (Form event code:C388=On Printing Detail:K2:18)
	vItem63:=Get_Description(-><>aRatMethDes; -><>aRatingMeth; ->[Bridge MHD NBIS:1]Item 63:199)
	vItem63:=Replace string:C233(vItem63; " Loading"; "")
End if 
G_FormatItm6466(->[Bridge MHD NBIS:1]Item 63:199; ->[Bridge MHD NBIS:1]Item64:137)