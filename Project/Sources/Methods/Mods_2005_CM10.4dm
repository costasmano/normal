//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/01/05, 17:08:05
	// ----------------------------------------------------
	// Method: Method: Mods_2005_CM10
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	
End if 

//Modified Table attributes
//[ServerProcesses]
//  `Allowed ALL USERS all access to the table.

//Modified Form Method
//[Bridge MHD NBIS];"Bridge Input"
//  `Allowed access to all to button bID-Security is handled inside the form
//[Bridge MHD NBIS];"ID Input"
//  `Lock fields vars and buttons for users not part of the "KeyAccess" group.

//Modified Method
//M_QuickReport
//  `Changed call to QR Report(;;True;False;False)

//XGetServerGrp
//TellServerGrp_2 
//  `Added code to check whether the Field we are trying to update matches what exists
//  `in the structure
