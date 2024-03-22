//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/04/07, 16:23:14
	// ----------------------------------------------------
	// Method: Method: ut_LaunchStopCtrlSrvProcess
	// Description
	// Launch on server a process to run the StopControlSrvProcess method
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2007_CM07
	StopControlSrvProcess
End if 
C_LONGINT:C283($pid)
C_TEXT:C284($methodname)
$methodname:="StopControlSrvProcess"
$pid:=Execute on server:C373($methodname; <>LStackSize; $methodname)
If ($pid=0)
	ALERT:C41("Error Executing method "+$methodname+" on Server!")
End if 
