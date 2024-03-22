//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/04/06, 11:52:11
	// ----------------------------------------------------
	// Method: M_ListServerProcesses
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	P_ListServerProcesses
	Mods_2006_CM04
End if 
C_LONGINT:C283($Lpid)
$Lpid:=LSpawnProcess("P_ListServerProcesses"; <>LStackSize; "ServerProc"; True:C214; False:C215)