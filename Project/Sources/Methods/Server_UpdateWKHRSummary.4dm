//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/04/07, 16:35:37
	// ----------------------------------------------------
	// Method: Server_UpdateWKHRSummary
	// Description
	//
	// 
	// Parameters
	WKHR_ComputeAvgs
	// ----------------------------------------------------
	
	Mods_2007_CM10a
End if 

C_LONGINT:C283($Lpid)
$Lpid:=New process:C317("WKHR_ComputeAvgs"; 0; "Compute WKHR Avg")