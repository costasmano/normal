//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/04/11, 09:02:02
	// ----------------------------------------------------
	// Method: ut_LaunchKeepOpen
	// Description
	// Launch the keepopen method as a local process. only for external server
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2011_10
	//Calls
	ut_KeepConnOpen
End if 
C_TEXT:C284($StructFile)
$StructFile:=Structure file:C489

If ($StructFile="@MHD BMS External@")
	C_LONGINT:C283($pid_L)
	$pid_L:=LSpawnProcess("ut_KeepConnOpen"; 0; "$KeepConnOpen"; True:C214; False:C215)
End if 