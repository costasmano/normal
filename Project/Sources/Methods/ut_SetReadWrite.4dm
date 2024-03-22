//%attributes = {"invisible":true}

// ----------------------------------------------------
// User name (OS): administrator
// Date and time: 08/21/14, 11:18:58
// ----------------------------------------------------
// Method: ut_SetReadWrite
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $What_txt)
C_POINTER:C301(${2})
$What_txt:=$1
C_POINTER:C301($Table_ptr)
C_LONGINT:C283($Loop_L)
For ($Loop_L; 2; Count parameters:C259)
	UNLOAD RECORD:C212(${$Loop_L}->)
	If ($What_txt="write")
		READ WRITE:C146(${$Loop_L}->)
	Else 
		READ ONLY:C145(${$Loop_L}->)
	End if 
End for 