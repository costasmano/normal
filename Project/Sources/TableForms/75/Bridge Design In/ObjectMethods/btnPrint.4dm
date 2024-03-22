If (False:C215)
	// ----------------------------------------------------
	// Object Method: btnPrint
	// User name (OS): cjmiller
	// Date and time: 03/29/05, 16:00:11
	// ----------------------------------------------------
	// Description
	// 
	
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CJM02  //03/29/05, 16:00:32 
	// Modified by: costasmanousakis-(Designer)-(9/12/2007 10:34:03)
	Mods_2007_CM12_5301
End if 
G_PrintOptions
//PAGE SETUP([Bridge Design];"Design Print Form")
If (<>ShowPrint)
	PRINT SETTINGS:C106
End if 


If (Ok=1)  //check to see if canceled from Print Settings
	Print form:C5([Bridge Design:75]; "Design Print Form")
	PAGE BREAK:C6
End if 
//End Object Method: btnPrint

