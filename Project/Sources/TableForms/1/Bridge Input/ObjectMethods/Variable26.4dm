//[Bridge MHD NBIS];"Inspections"
//Description for Item 22

C_TEXT:C284(vItem22)  // Command Replaced was o_C_STRING length was 27

If (Form event code:C388=On Load:K2:1)
	vItem22:=Get_Description(-><>aMaintOwner; -><>aMaintCod; ->[Bridge MHD NBIS:1]Item22:128)
End if 