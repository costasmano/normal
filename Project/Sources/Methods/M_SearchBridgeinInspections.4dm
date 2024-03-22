//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/27/06, 10:09:26
	// ----------------------------------------------------
	// Method: M_SearchBridgeinInspections
	// Description
	// Search for an Inspection by BIN, BDEPT, BRKEY..
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2006_CM07
End if 
SRC_SearchByBridge(->[Inspections:27]; ->[Inspections:27]BIN:1; ->[Bridge MHD NBIS:1]BDEPT:1; ->[Bridge MHD NBIS:1]Bridge Key:2)