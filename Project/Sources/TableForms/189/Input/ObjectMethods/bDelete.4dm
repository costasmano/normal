//Method: [NTI_TunnelRatings].Input.bDelete
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 05/02/18, 13:30:00
	// ----------------------------------------------------
	//Created : 
	Mods_2018_05
End if 
//
CONFIRM:C162("Are you sure you wish to delete this rating record"; "Yes - Delete"; "No - Do NOT Delete")
LogDeletion(->[NTI_TunnelInfo:181]NTI_i1_s:6; ->[NTI_TunnelRatings:189]NTI_i1_s:2; ->[NTI_TunnelRatings:189]RatingID_L:11; 1)
DELETE RECORD:C58([NTI_TunnelRatings:189])
ACCEPT:C269
//End [NTI_TunnelRatings].Input.bDelete