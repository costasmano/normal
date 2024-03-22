//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 04/09/15, 13:41:25
//----------------------------------------------------
//Method: WIN_SetWindowTitle
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (4/9/15 13:41:27)
	Mods_2017_12  //Change name from LSS_ to WIN as it is used ion more than LSS
	//Modified by: Chuck Miller (12/14/17 16:00:20)
	
End if 
C_POINTER:C301($1)
C_TEXT:C284($Title_txt)
$Title_txt:=Table name:C256($1)+" Displaying ["+String:C10(Records in selection:C76($1->))+" out of "+String:C10(Records in table:C83($1->))+"] records"

SET WINDOW TITLE:C213($Title_txt)

//End WIN_SetWindowTitle

