//Method: Object Method: [ScourPOA].Input-A.SCPOA_USGSStationURL_txt
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/07/14, 15:02:33
	// ----------------------------------------------------
	//Created : 
	Mods_2014_03
End if 
//
SCPOA_OpenURL(Self:C308->; "Ctrl-Click to open Web Page for USGS station "+SCPOA_USGSStationNo_s; Not:C34(<>WindowsPL_b))

//End Object Method: [ScourPOA].Input-A.SCPOA_USGSStationURL_txt