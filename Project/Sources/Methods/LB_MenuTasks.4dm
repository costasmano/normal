//%attributes = {"invisible":true}
//Method: LB_MenuTasks
//Description
//  ` Execute method LB_Tasks from a menu item with a parameter
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/26/14, 11:24:44
	// ----------------------------------------------------
	//Created : 
	Mods_2014_02
End if 
//
C_TEXT:C284($taskParam_txt)
$taskParam_txt:=Get selected menu item parameter:C1005
LB_Tasks($taskParam_txt; [LB_QueryTable:147]QueryName_s:1)

//End LB_MenuTasks