//%attributes = {"invisible":true}
If (False:C215)
	
	// ----------------------------------------------------
	// User name (OS): vunguyen
	// User name (4D): Designer
	// Date and time: 11/08/05, 14:06:04
	// ----------------------------------------------------
	// Method: M_LetterToTown
	// Description
	// 
	//
	// Parameters
	//
	//
	// ----------------------------------------------------
	
End if 

C_TEXT:C284($vsMenuItem)  // Command Replaced was o_C_STRING length was 80
$vsMenuItem:="Letter to Town"

G_LoadSpecialReports($vsMenuItem)