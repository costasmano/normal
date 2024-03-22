//%attributes = {"invisible":true,"executedOnServer":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/04/07, 16:11:27
	// ----------------------------------------------------
	// Method: StopControlSrvProcess
	// Description
	// Stop the Control Server process running on the current machine.
	// (probably a 4D server)
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2007_CM07
End if 
C_LONGINT:C283($ControlProcNum)
$ControlProcNum:=Process number:C372("Control Server Process")
If ($ControlProcNum#0)
	C_BOOLEAN:C305(<>AbortControlSrvProc)
	<>AbortControlSrvProc:=True:C214
	RESUME PROCESS:C320($ControlProcNum)
End if 
$ControlProcNum:=Process number:C372("ControlServerProcess@")
If ($ControlProcNum#0)
	C_BOOLEAN:C305(<>AbortControlSrvProc)
	<>AbortControlSrvProc:=True:C214
	RESUME PROCESS:C320($ControlProcNum)
End if 
