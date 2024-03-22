If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/02/07, 10:05:54
	// ----------------------------------------------------
	// Method: Object Method: bzSearch
	//Object Method: [Activity Log].Output.bzSearch 
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM12_5302
	Mods_2015_11
	//  `sort by RefID when reloading
End if 
M_SearchACTLOG_field
ORDER BY:C49([Activity Log:59]; [Activity Log:59]RefID:28; >)
WindowTitle