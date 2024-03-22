//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// prt_oofrep
	// User name (OS): cjmiller
	// Date and time: 03/29/05, 16:05:40
	// ----------------------------------------------------
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	//GP: prt_oofrep
	Mods_2005_CJM02  //03/29/05, 16:05:49 
	// Modified by: costasmanousakis-(Designer)-(9/12/2007 11:20:27)
	Mods_2007_CM12_5301
End if 
G_PrintOptions
//PAGE SETUP([Out of Freq];"P_OutofFreq")
PRINT SETTINGS:C106
Print form:C5([Out of Freq:70]; "P_OutofFreq")
PAGE BREAK:C6