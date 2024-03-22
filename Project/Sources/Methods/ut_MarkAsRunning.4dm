//%attributes = {"invisible":true}
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 05/22/12, 14:46:56
//----------------------------------------------------
//Method: ut_MarkAsRunning
//Description
//  ` Mark a record in [ServerProcesses] as running
// Parameters
// $1 : $MethodName_txt
// ----------------------------------------------------
If (False:C215)
	//Created
	Mods_2012_06
End if 
C_TEXT:C284($1; $MethodName_txt)
$MethodName_txt:=$1
READ ONLY:C145([ServerProcesses:87])
QUERY:C277([ServerProcesses:87]; [ServerProcesses:87]ProcessName_s:1=$MethodName_txt)

If (ut_LoadRecordonServer(->[ServerProcesses:87]))
	[ServerProcesses:87]ProcessRunning_b:5:=True:C214
	SAVE RECORD:C53([ServerProcesses:87])
	UNLOAD RECORD:C212([ServerProcesses:87])
End if 
READ ONLY:C145([ServerProcesses:87])
//End Ut_MarkAsRunning