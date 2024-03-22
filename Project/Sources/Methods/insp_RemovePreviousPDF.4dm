//%attributes = {"invisible":true}
//Method: insp_RemovePreviousPDF
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 06/07/22, 17:05:02
	// ----------------------------------------------------
	//Created : 
	Mods_2022_06
End if 
//
C_TEXT:C284($1)
ARRAY TEXT:C222($files_atxt; 0)
DOCUMENT LIST:C474($1; $files_atxt; Ignore invisible:K24:16)
C_LONGINT:C283($Loop_l)
For ($Loop_l; 1; Size of array:C274($files_atxt))
	DELETE DOCUMENT:C159($1+$files_atxt{$loop_L})
End for 
//End insp_RemovePreviousPDF