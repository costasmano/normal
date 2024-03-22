//%attributes = {"invisible":true,"executedOnServer":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/15/05, 16:49:07
	// ----------------------------------------------------
	// Method: StartControlSrvProc
	// Description
	// Start the ControlServerProcesses method.
	//Called from On Server Startup method
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CM12
	Mods_2005_CM13
	//launches locally
	ControlServerProcesses
End if 
//debuggin:=True
//TRACE
C_LONGINT:C283($ControlServerProcessesID)
//Added a delay to prevent DB log problems
DELAY PROCESS:C323(Current process:C322; (5*60*60))  //delay 5 minutes
$ControlServerProcessesID:=New process:C317("ControlServerProcesses"; 0; "Control Server process")  //Mods_2002_02_18
