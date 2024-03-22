//%attributes = {"invisible":true}
//Method: StopControlClientProc
//Description
// stop the control client process running on current machine - Client
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/11/20, 19:07:02
	// ----------------------------------------------------
	//Created : 
	Mods_2020_08_bug
End if 
//
C_LONGINT:C283($ControlProcNum)
$ControlProcNum:=Process number:C372("Control Client Process")
If ($ControlProcNum#0)
	C_BOOLEAN:C305(<>ABORTCONTROLCLIENTPROC)
	<>ABORTCONTROLCLIENTPROC:=True:C214
	RESUME PROCESS:C320($ControlProcNum)
	ALERT:C41("Resumed process "+String:C10($ControlProcNum))
Else 
	ALERT:C41("No Process found called \"Control Client Process\"")
End if 

//End StopControlClientProc