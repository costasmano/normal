//%attributes = {"invisible":true,"executedOnServer":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 08/07/13, 15:18:58
//----------------------------------------------------
//Method: ut_ReturnSerialData
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2013_07  //r001 ` 
	//Modified by: Charles Miller (8/7/13 15:18:59)
	
End if 
C_LONGINT:C283($Key; $Connected; $MaxUsers)
C_TEXT:C284($User)  // Command Replaced was o_C_STRING length was 80
C_TEXT:C284($Company)  // Command Replaced was o_C_STRING length was 80

GET SERIAL INFORMATION:C696($Key; $User; $Company; $Connected; $MaxUsers)
C_BLOB:C604($Return_blb; $0)
SET BLOB SIZE:C606($Return_blb; 0)
VARIABLE TO BLOB:C532($Key; $Return_blb; *)
VARIABLE TO BLOB:C532($User; $Return_blb; *)
VARIABLE TO BLOB:C532($Company; $Return_blb; *)
VARIABLE TO BLOB:C532($Connected; $Return_blb; *)
VARIABLE TO BLOB:C532($MaxUsers; $Return_blb; *)
$0:=$Return_blb

//End ut_ReturnSerialData

