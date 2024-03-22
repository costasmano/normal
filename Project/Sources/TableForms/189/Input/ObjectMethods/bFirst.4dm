//Method: [NTI_TunnelRatings].Input.bFirst
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 05/02/18, 13:22:08
	// ----------------------------------------------------
	//Created : 
	Mods_2018_05
End if 
//
FM_SaveTunnelRating
LSS_SelectedRow_L:=1
LSS_SetPrevNextButtons(LSS_SelectedRow_L; Records in selection:C76([NTI_TunnelRatings:189]))
GOTO SELECTED RECORD:C245([NTI_TunnelRatings:189]; LSS_SelectedRow_L)
FM_TunnelRatingInput(On Load:K2:1)
//End [NTI_TunnelRatings].Input.bFirst