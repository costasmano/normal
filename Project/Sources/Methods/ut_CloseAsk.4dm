//%attributes = {"invisible":true}
//Method: ut_CloseAsk
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 12/12/19, 14:30:37
	// ----------------------------------------------------
	//Created : 
	Mods_2019_12  //add code to modify how bin groups are created and maintained for a project
	//by Chuck Miller 
End if 
//
CONFIRM:C162("Save Changes?"; "Yes"; "No")
If (OK=1)
	ACCEPT:C269
Else 
	CANCEL:C270
End if 
//End ut_CloseAsk