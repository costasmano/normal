If (False:C215)
	// ----------------------------------------------------
	// Object Method: bCancel
	
	// Modified by: costasmanousakis-(Designer)-(6/8/11 11:11:34)
	Mods_2011_06
	//  `Changed the prompt to replace the default "OK" button
End if 
C_BOOLEAN:C305(SCPOA_EditRecord_b)
If (SCPOA_EditRecord_b)
	If (Modified record:C314([ScourPOA:132]))
		CONFIRM:C162("Changes have been made! Do you want to Exit without saving?"; "Exit w/out Saving"; "Cancel")
		If (OK=1)
			CANCEL:C270
		End if 
	Else 
		CANCEL:C270
	End if 
Else 
	CANCEL:C270
End if 

//End Object Method: bCancel