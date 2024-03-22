If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/18/11, 08:33:31
	// ----------------------------------------------------
	// Method: Object Method: SCPOA_NWSStationURL_txt
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2011_05
	// Modified by: Costas Manousakis-(Designer)-(3/7/14 15:12:53)
	Mods_2014_03
	//  `use new method SCPOA_OpenURL
End if 
SCPOA_OpenURL(SCPOA_NWSStationURL_txt; "Click to Open Web Page for "+SCPOA_NWSStation_txt)
