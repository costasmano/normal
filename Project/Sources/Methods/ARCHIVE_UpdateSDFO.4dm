//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/14/11, 18:43:18
	// ----------------------------------------------------
	// Method: ARCHIVE_UpdateSDFO
	// Description
	//  ` Run the RecalcAASHTO and update SD FO foe a selection of Arhcive records
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2011_09
End if 
QUERY:C277([BridgeMHDNBISArchive:139])
If (OK=1)
	
	ARCHIVE_RecalcAASHTO
	ARCHIVE_FOSDFields
End if 
