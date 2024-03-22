//[Bridge MHD NBIS];"Inspections"
//Description for Item 21

C_TEXT:C284(vItem21)  // Command Replaced was o_C_STRING length was 27

If (Form event code:C388=On Load:K2:1)
	vItem21:=Get_Description(-><>aMaintOwner; -><>aMaintCod; ->[Bridge MHD NBIS:1]Item21:127)
End if 