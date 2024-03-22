//%attributes = {"invisible":true,"executedOnServer":true}
//Method: ut_LoadUGOnServer
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 04/13/21, 15:18:59
	// ----------------------------------------------------
	//Created : 
	Mods_2021_04  //Added code to allow for selected of previously saved Users and Group File
	//Modified by: CJ (4/13/21 15:57:01)
End if 
//

C_TEXT:C284($1)
C_BLOB:C604($Users_blb)
SET BLOB SIZE:C606($Users_blb; 0)
$Users_blb:=UG_LoadUsersandGroupsFromFile($1)
If (BLOB size:C605($Users_blb)>0)
	BLOB TO USERS:C850($Users_blb)
End if 
//End ut_LoadUGOnServer