//Method: Object Method: [ScourPOA].Input-A.SCPOA_CLCri_WLvl_r
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 10/23/14, 12:34:41
	// ----------------------------------------------------
	//Created : 
	Mods_2014_10
End if 
//

If ((SCPOA_CLCri_WLvl_r>0) & (SCPOA_OthScCritElev_r>0))
	SCPOA_LowChordDistFt_r:=SCPOA_CLCri_WLvl_r-SCPOA_OthScCritElev_r
End if 

//End Object Method: [ScourPOA].Input-A.SCPOA_CLCri_WLvl_r