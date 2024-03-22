//Method: [NTI_TunnelRatings].Input.bCancel
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 05/02/18, 13:29:33
	// ----------------------------------------------------
	//Created : 
	Mods_2018_05
End if 
C_BOOLEAN:C305($Cancel_B)

Case of 
	: (Is new record:C668([NTI_TunnelRatings:189]))
		CONFIRM:C162("Do you want to save this new tunnel rating record"; "Yes"; "No")
		$Cancel_B:=(OK=0)
	: (Modified record:C314([NTI_TunnelRatings:189]))
		CONFIRM:C162("Do you want to save this modified tunnel rating record"; "Yes"; "No")
		$Cancel_B:=(OK=0)
	Else 
		$Cancel_B:=True:C214
		
End case 
If ($Cancel_B)
	CANCEL:C270
End if 
//End [NTI_TunnelRatings].Input.bCancel