//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/07/06, 12:54:47
	// ----------------------------------------------------
	// Method: M_LoadAdmFunctions
	// Description
	// Launch a process to run G_LoadAdmFunctions
	// 
	// Parameters
	// ----------------------------------------------------
	
End if 
If (False:C215)
	G_LoadAdmFunctions
End if 

C_LONGINT:C283($Lpid)

$Lpid:=LSpawnProcess("G_LoadAdmFunctions"; <>LStackSize; "Admin Functions Bridges"; True:C214; False:C215)