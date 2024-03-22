//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/09/07, 21:14:01
	// ----------------------------------------------------
	// Method: M_SearchBrgInInspections
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(10/24/2007 09:15:19)
	Mods_2007_CM12_5302
End if 
C_BOOLEAN:C305($SearchAll_b)
$SearchAll_b:=(((Current user:C182="Designer") | (vApproveLvl=2)) & (Macintosh option down:C545))
SRC_SearchByBridge(->[Inspections:27]; ->[Inspections:27]BIN:1; ->[Bridge MHD NBIS:1]BDEPT:1; ->[Bridge MHD NBIS:1]Bridge Key:2; $SearchAll_b)
