//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): vunguyen
	// User name (4D): Designer
	// Date and time: 11/07/05, 12:11:11
	// ----------------------------------------------------
	// Method: M_Request
	// Description
	//  
	//
	// Parameters
	// 
	// ----------------------------------------------------
	
End if 

C_TEXT:C284($vsMenuItem)  // Command Replaced was o_C_STRING length was 80
$vsMenuItem:="Request"

G_LoadSpecialReports($vsMenuItem)