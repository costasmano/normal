//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/04/06, 16:59:04
	// ----------------------------------------------------
	// Method: Launch_BatchControl
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Batch_ControlProcess
	Mods_2006_CM04
End if 

If (Not:C34(<>fQuit))
	C_LONGINT:C283($pid)
	$pid:=New process:C317("Batch_ControlProcess"; 0; "Control Batch Process")
End if 