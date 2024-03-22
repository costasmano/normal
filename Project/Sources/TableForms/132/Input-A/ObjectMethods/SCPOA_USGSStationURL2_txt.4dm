//Method: Object Method: [ScourPOA].Input-A.SCPOA_USGSStationURL2_txt
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/07/14, 16:17:03
	// ----------------------------------------------------
	//Created : 
	Mods_2014_03
End if 
//
SCPOA_OpenURL(Self:C308->; "Click to Open Web Page for  NOAA station "+SCPOA_USGSStationNo2_s; Not:C34(<>WindowsPL_b))
//End Object Method: [ScourPOA].Input-A.SCPOA_USGSStationURL2_txt