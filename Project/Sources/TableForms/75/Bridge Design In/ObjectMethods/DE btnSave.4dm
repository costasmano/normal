If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(5/1/2007 08:30:53)
	Mods_2007_CM09
End if 

If (Form event code:C388=On Clicked:K2:4)
	If (Is new record:C668([Bridge Design:75]))
		If (<>LogBridgeDesign_b)
			LogNewRecord(->[Bridge MHD NBIS:1]BIN:3; ->[Bridge Design:75]BIN:1; ->[Bridge Design:75]BridgeDesignID:35; 1; "BrDesign")
		End if 
	End if 
End if 