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
If (False:C215)
	//Mods_2005_CJM02   `03/29/05, 16:00:32 
End if 
SET PRINT OPTION:C733(Orientation option:K47:2; 1)  //set to portrait
SET PRINT OPTION:C733(Paper option:K47:1; "Letter")
//PAGE SETUP([Bridge Design];"Design Print Form")
If (<>ShowPrint)
	PRINT SETTINGS:C106
End if 


If (Ok=1)  //check to see if canceled from Print Settings
	Print form:C5([Scour Report:129]; "Scour Report - State")
	Print form:C5([Scour Report:129]; "Scour Report - Agencies")
	Print form:C5([Scour Report:129]; "Scour Report - Mass")
	Print form:C5([Scour Report:129]; "Scour Report - Summary")
	PAGE BREAK:C6
End if 
//End Object Method: btnPrint

