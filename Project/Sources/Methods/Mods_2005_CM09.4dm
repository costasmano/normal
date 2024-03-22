//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/30/05, 08:35:19
	// ----------------------------------------------------
	// Method: Mods_2005_CM09
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	
End if 
//Modified Method
//ADD_COMBINED_INSPECT 
//  `Moved LogNewRec([Combined]) statement right before the FlushGrp([Combined]). 
//  `It was not recording properly the BIN for the [Combined] record.