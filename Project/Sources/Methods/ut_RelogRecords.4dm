//%attributes = {"invisible":true}
//Method: ut_RelogRecords
//Description
//  ` Add activity log records to transfer creation and changes - uses form "ReLogRecords"
// Parameters
// $1 : $spawn : don't pass a parameter to spawn a process for the reloging
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/19/12, 08:35:38
	// ----------------------------------------------------
	//Created : 
	Mods_2012_06
	
	// Modified by: Costas Manousakis-(Designer)-(2021-10-20T00:00:00 16:27:31)
	Mods_2021_10
	//  `Spawn a new process to do the relog - added $1 param
	C_TEXT:C284(ut_RelogRecords; $1)
End if 
//
If (Count parameters:C259=0)
	C_LONGINT:C283($LPid_L)
	$LPid_L:=LSpawnProcess(Current method name:C684; 0; "RelogRecords"; True:C214; False:C215; "RUN")
Else 
	C_TEXT:C284($1)
	C_LONGINT:C283($FW_L; $FH_L)
	FORM GET PROPERTIES:C674("ReLogRecords"; $FW_L; $FH_L)
	CENTER_WINDOW($FW_L; $FH_L; Plain window:K34:13)
	DIALOG:C40("ReLogRecords")
	CLOSE WINDOW:C154
	
End if 


//End ut_RelogRecords