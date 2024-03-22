//Method: Object Method: [TunnelInfo].TunnelInput.bCancel
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/23/13, 14:01:02
	// ----------------------------------------------------
	//Created : 
	Mods_2013_04
End if 
//
If (Modified record:C314([TunnelInfo:151]) | Modified record:C314([Bridge MHD NBIS:1]))
	CONFIRM:C162("Changes have been made to the database! Are you sure you want to exit and Cancel the changes?"; "EXIT and CANCEL"; "Stay in Form")
	If (OK=1)
		CANCEL:C270
	End if 
Else 
	CANCEL:C270
End if 

//End Object Method: [TunnelInfo].TunnelInput.bCancel