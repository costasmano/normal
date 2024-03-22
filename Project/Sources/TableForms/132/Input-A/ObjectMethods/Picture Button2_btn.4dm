If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/18/11, 10:54:37
	// ----------------------------------------------------
	// Method: Object Method: SCPOA_OpenSta1URL_L
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2011_05
	// Modified by: Costas Manousakis-(Designer)-(3/7/14 12:12:57)
	Mods_2014_03
	//  `use new method SCPOA_OpenURL
End if 
SCPOA_OpenURL(SCPOA_USGSStationURL_txt; "Click to Open Web Page for USGS Station "+SCPOA_USGSStationNo_s)
