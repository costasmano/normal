//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/28/05, 21:35:22
	// ----------------------------------------------------
	// Method: WKHR_Input_LockRevBtns
	// Description
	// 
	// 
	// Parameters
	// $1 : Option
	//  ` "Review" : lock review btn /field
	//  ` "Approve" : lock approve btn /field
	//  ` "Both" : lock both
	// ----------------------------------------------------
	
	Mods_2005_CM21
End if 
C_TEXT:C284($1)  // Command Replaced was o_C_STRING length was 8
OBJECT SET ENABLED:C1123(*; "Approve_@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
OBJECT SET ENTERABLE:C238(*; "Approve_@"; True:C214)
OBJECT SET ENABLED:C1123(*; "Review_@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
OBJECT SET ENTERABLE:C238(*; "Review_@"; True:C214)
Case of 
	: ($1="Review")
		OBJECT SET ENABLED:C1123(*; "Review_@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENTERABLE:C238(*; "Review_@"; False:C215)
	: ($1="Approve")
		OBJECT SET ENABLED:C1123(*; "Approve_@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENTERABLE:C238(*; "Approve_@"; False:C215)
	: ($1="Both")
		OBJECT SET ENABLED:C1123(*; "Review_@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENTERABLE:C238(*; "Review_@"; False:C215)
		OBJECT SET ENABLED:C1123(*; "Approve_@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENTERABLE:C238(*; "Approve_@"; False:C215)
		
End case 