//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/09/09, 20:34:59
	// ----------------------------------------------------
	// Method: WKHR_ClearCosts
	// Description
	// Clear all rate fields
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2009_CM_5404  //("WKHRMODS")
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
C_LONGINT:C283($Loop_i)
For ($Loop_i; 1; WKHR_CategoryCount_i)
	RateFldPtr_a{$Loop_i}->:=0
	ConstrRateFldPtr_a{$Loop_i}->:=0
	PushChange(1; RateFldPtr_a{$Loop_i})
	PushChange(1; ConstrRateFldPtr_a{$Loop_i})
End for 
