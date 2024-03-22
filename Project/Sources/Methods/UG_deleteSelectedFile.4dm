//%attributes = {"invisible":true,"executedOnServer":true}
//Method: UG_deleteSelectedFile
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 04/29/21, 16:01:08
	// ----------------------------------------------------
	//Created : 
	Mods_2021_04
	Compiler_Utilities
End if 
//
C_TEXT:C284($1)
DELETE DOCUMENT:C159($1)

