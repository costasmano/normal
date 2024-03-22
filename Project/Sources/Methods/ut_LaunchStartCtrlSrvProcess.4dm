//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/05/07, 11:03:50
	// ----------------------------------------------------
	// Method: ut_LaunchStartCtrlSrvProcess
	// Description
	// Launch on server a process to run the StartControlSrvProc method
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2007_CM07
	StartControlSrvProc
End if 
C_LONGINT:C283($pid)
C_TEXT:C284($methodname)
$methodname:="StartControlSrvProc"
$pid:=Execute on server:C373($methodname; <>LStackSize; $methodname)
If ($pid=0)
	ALERT:C41("Error Executing method "+$methodname+" on Server!")
End if 
