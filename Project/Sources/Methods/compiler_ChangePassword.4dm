//%attributes = {"invisible":true}
//Method: compiler_ChangePassword
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 07/13/22, 13:05:00
	// ----------------------------------------------------
	//Created : 
	// Modified by: Chuck Miller-(Designer)-(7/19/22 12:51:55)
	Mods_2022_07  //Modified how passwords are changed in single user so that server password can be changed at the same time
	
End if 
//
If (False:C215)
	C_BLOB:C604(FN_SetPassword; $0)
	C_BLOB:C604(FN_SetPassword; $1)
	
	C_TEXT:C284(ut_CheckPasswordRules; $1)
	C_TEXT:C284(ut_CheckPasswordRules; $2)
	C_BOOLEAN:C305(ut_CheckPasswordRules; $0)
	
	
End if 
//End compiler_ChangePassword