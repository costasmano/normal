//Method: Object Method: [ScourPOA].Input-A.SCPOA_OthScCritElev_r
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 10/23/14, 12:41:36
	// ----------------------------------------------------
	//Created : 
	Mods_2014_10
End if 
//
If (Form event code:C388=On Data Change:K2:15)
	If ((SCPOA_CLCri_WLvl_r>0) & (SCPOA_OthScCritElev_r>0))
		SCPOA_LowChordDistFt_r:=SCPOA_CLCri_WLvl_r-SCPOA_OthScCritElev_r
	End if 
	
End if 
//End Object Method: [ScourPOA].Input-A.SCPOA_OthScCritElev_r