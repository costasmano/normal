If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/18/11, 10:54:37
	// ----------------------------------------------------
	// Method: Object Method: SCPOA_ShowNWS_L
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2011_05
	// Modified by: Costas Manousakis-(Designer)-(3/7/14 12:13:50)
	Mods_2014_03
	//  `use new method SCPOA_OpenURL
End if 
SCPOA_OpenURL(SCPOA_USGSStationURL2_txt; "Click to Open Web Page for  NOAA station "+SCPOA_USGSStationNo2_s)
