//%attributes = {"invisible":true}
// Method: P_ListServerProcesses
// Description
// launch a dialog displaying server processes
// 
// Parameters
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/04/06, 11:50:46
	// ----------------------------------------------------
	// ----------------------------------------------------
	
	Mods_2006_CM04
	// Modified by: Costas Manousakis-(Designer)-(11/7/18 09:14:44)
	Mods_2018_11
	//  `added a window title and the output form name
	Mods_2022_05  //Add List box and selection if designer
	//Modified by: Chuck Miller (5/10/22 12:30:30)
End if 
C_TEXT:C284($FormName_txt)
If (ut_UseListBox(Current method name:C684))
	$FormName_txt:="Output_LB"
Else 
	$FormName_txt:="Output"
End if 
G_DisplayTable_generic(->[ServerProcesses:87]; "Server Processes"; "Input"; $FormName_txt)