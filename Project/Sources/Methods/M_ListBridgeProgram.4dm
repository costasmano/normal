//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/05/07, 10:53:47
	// ----------------------------------------------------
	// Method: M_ListBridgeProgram
	// Description
	// 
	// 
	// Parameters
	PRJ_DisplayBridgePgm
	// ----------------------------------------------------
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
C_LONGINT:C283($ProcessID_l)
$ProcessID_l:=LSpawnProcess("PRJ_DisplayBridgePgm"; <>LStackSize; "Bridge Program"; True:C214; False:C215)
