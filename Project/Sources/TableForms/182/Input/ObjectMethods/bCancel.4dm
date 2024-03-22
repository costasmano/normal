//Method: [NTI_ELEM_DEFS].Input.bCancel
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 12/19/17, 11:52:54
	// ----------------------------------------------------
	//Created : 
	Mods_2017_12
End if 
//
If (Is new record:C668([NTI_ELEM_DEFS:182])) | (Modified record:C314([NTI_ELEM_DEFS:182]))
	
	CONFIRM:C162("Exit without saving?"; "Exit without Saving"; "Stay in Form")
	If (OK=1)
		CANCEL:C270
	End if 
Else 
	CANCEL:C270
End if 
//End [NTI_ELEM_DEFS].Input.bCancel