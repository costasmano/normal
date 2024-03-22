//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Chuck Miller
//Date and time: 07/14/16, 12:20:31
//----------------------------------------------------
//Method: ut_ReturnPathToEngineLink
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2016_06  // 
	//Modified by: Chuck Miller (7/14/16 12:20:32)
	
End if 
C_TEXT:C284($Text_txt)
$Text_txt:=Application file:C491
ALERT:C41($Text_txt)

//End ut_ReturnPathToEngineLink

