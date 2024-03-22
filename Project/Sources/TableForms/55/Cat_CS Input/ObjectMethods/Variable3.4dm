//SC vCat on layout [Cat CS Notes];"Cat_CS Input".
//Copyright © 1996, Thomas D. Nee, All Rights Reserved.

C_TEXT:C284(vCat)  // Command Replaced was o_C_STRING length was 62

If (Form event code:C388=On Load:K2:1)
	vCat:=[BMS Categories:49]General Cat:2
	If ([BMS Categories:49]Subcategory:3#"")
		If (vCat#"")
			vCat:=vCat+", "+[BMS Categories:49]Subcategory:3
		Else 
			vCat:=[BMS Categories:49]Subcategory:3
		End if 
	End if 
End if 