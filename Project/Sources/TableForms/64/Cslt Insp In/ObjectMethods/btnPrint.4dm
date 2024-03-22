If (False:C215)
	// ----------------------------------------------------
	// Object Method: btnPrint
	// User name (OS): cjmiller
	// Date and time: 03/29/05, 15:59:46
	// ----------------------------------------------------
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CJM02  //03/29/05, 16:00:03 
	// Modified by: costasmanousakis-(Designer)-(9/12/2007 10:33:39)
	Mods_2007_CM12_5301
End if 

G_PrintOptions
//PAGE SETUP([Cons Inspection];"Inspection Print Form")
If (<>ShowPrint)
	PRINT SETTINGS:C106
End if 


If (Ok=1)  //check to see if canceled from Print Settings
	Print form:C5([Cons Inspection:64]; "Inspection Print Form")
	//end of change
	PAGE BREAK:C6
End if 
//End Object Method: btnPrint
