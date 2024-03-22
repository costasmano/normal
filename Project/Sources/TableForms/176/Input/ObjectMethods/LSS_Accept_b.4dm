//Method: [LSS_UtResult].Input.LSS_Accept_b
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 10/09/18, 15:25:57
	// ----------------------------------------------------
	//Created : 
	Mods_2018_10_bug
End if 
//
If ([LSS_UtResult:176]LSS_Accept_b:6)
	[LSS_UtResult:176]LSS_Reject_b:7:=False:C215
End if 
//End [LSS_UtResult].Input.LSS_Accept_b