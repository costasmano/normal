//%attributes = {"invisible":true}
// ----------------------------------------------------
// PM_ControlLogDocument
// User name (OS): charlesmiller
// Date and time: 06/02/09, 10:37:19
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2009_06  //r002 `06/02/09, 10:37:21   `Modify Pontis retrieve
	//Add code to allow for deletion of a run
	//Add code to log what occurred during run
End if 
C_TEXT:C284($1; $Action_s)  // Command Replaced was o_C_STRING length was 1
C_POINTER:C301($2; $Action_ptr; $DocumentPath_ptr; $DataToWrite_ptr)
$Action_s:=$1
$DocumentPath_ptr:=$2
C_TIME:C306($Document_tm)
If (Count parameters:C259=3)
	C_POINTER:C301($3)
	$DataToWrite_ptr:=$3
End if 
Case of 
	: ($Action_s="A")
		$Document_tm:=Append document:C265($DocumentPath_ptr->)
		SEND PACKET:C103($Document_tm; $DataToWrite_ptr->)
		
	: ($Action_s="C")
		$Document_tm:=Create document:C266($DocumentPath_ptr->)
		
End case 

CLOSE DOCUMENT:C267($Document_tm)
//End PM_ControlLogDocument