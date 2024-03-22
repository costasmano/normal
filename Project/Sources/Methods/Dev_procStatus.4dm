//%attributes = {"invisible":true}
//Method: Dev_procStatus
//Description
// text of process status from process properties
// Parameters
// $0: $proc status desc
// $1 : $procStatus
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/11/20, 15:29:17
	// ----------------------------------------------------
	//Created : 
	Mods_2020_08_bug
	C_TEXT:C284(Dev_procStatus; $0)
	C_LONGINT:C283(Dev_procStatus; $1)
	
End if 
//
$0:=""
Case of 
	: ($1=-1)
		$0:="Aborted"
	: ($1=1)
		$0:="Delayed"
	: ($1=-100)
		$0:="Does not exist"
	: ($1=0)
		$0:="Executing"
	: ($1=6)
		$0:="Hidden modal dialog"
	: ($1=5)
		$0:="Paused"
	: ($1=3)
		$0:="Waiting for input output"
	: ($1=4)
		$0:="Waiting for internal flag"
	: ($1=2)
		$0:="Waiting for user event"
		
End case 

//End Dev_procStatus