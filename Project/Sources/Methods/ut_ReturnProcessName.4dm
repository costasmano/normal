//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 01/05/16, 15:06:40
//----------------------------------------------------
//Method: ut_ReturnProcessName
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2016_01_bug  //   `FIX BUG WHERE [Activity Log] records were being created where they should not have been
	//Modified by: administrator (1/5/16 14:16:58)
End if 
C_LONGINT:C283($1; $Process_ID)
C_TEXT:C284($ProcessName)
C_LONGINT:C283($State)
C_LONGINT:C283($Time)
C_TEXT:C284($0)
$Process_ID:=$1

PROCESS PROPERTIES:C336($Process_ID; $ProcessName; $State; $Time)

$0:=$ProcessName

//End ut_ReturnProcessName