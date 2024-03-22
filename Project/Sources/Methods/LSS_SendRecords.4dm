//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 03/08/16, 16:34:24
//----------------------------------------------------
//Method: LSS_SendRecords
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2016_03_bug  // 
	//Modified by: administrator (3/8/16 16:34:38)
	
End if 
C_POINTER:C301($1)
C_LONGINT:C283($Loop_L; $Number_L)
$Number_L:=Table:C252($1)
If (Records in selection:C76($1->)>0)
	SEND VARIABLE:C80($Number_L)
	$Number_L:=Records in selection:C76($1->)
	SEND VARIABLE:C80($Number_L)
	For ($Loop_L; 1; Records in selection:C76($1->))
		GOTO SELECTED RECORD:C245($1->; $Loop_L)
		SEND RECORD:C78($1->)
	End for 
End if 
//End LSS_SendRecords

