If (False:C215)
	//Object Method: [Bridge Design].Bridge Design In.vbDelete_BrgDes 
	// Modified by: costasmanousakis-(Designer)-(5/1/2007 08:30:53)
	Mods_2007_CM09
	// Modified by: Costas Manousakis-(Designer)-(6/21/13 09:39:07)
	Mods_2013_06
	//  `Removed the auto  Delete action of the button 
End if 

If (Form event code:C388=On Clicked:K2:4)
	CONFIRM:C162("Delete this Bridge Design Data Record?")
	If (OK=1)
		If (<>LogBridgeDesign_b)
			LogDeletion(->[Bridge MHD NBIS:1]BIN:3; ->[Bridge Design:75]BIN:1; ->[Bridge Design:75]BridgeDesignID:35; 1)
		End if 
		DELETE RECORD:C58([Bridge Design:75])
		CANCEL:C270
	End if 
End if 