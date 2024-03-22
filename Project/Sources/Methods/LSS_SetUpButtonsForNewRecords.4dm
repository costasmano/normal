//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 04/15/15, 14:55:07
//----------------------------------------------------
//Method: LSS_SetUpButtonsForNewRecords
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (4/15/15 14:55:08)
	Mods_2018_11  // Change code from
	//_ o_ENABLE BUTTON and _o_DISABLE to
	//OBJECT SET ENABLED
	//Modified by: Chuck Miller (11/19/18 12:28:01)
End if 
OBJECT SET VISIBLE:C603(*; "bFirst"; False:C215)
OBJECT SET VISIBLE:C603(*; "bPrevious"; False:C215)
OBJECT SET VISIBLE:C603(*; "bNext"; False:C215)
OBJECT SET VISIBLE:C603(*; "bLast"; False:C215)
OBJECT SET VISIBLE:C603(*; "bDelete"; False:C215)
OBJECT SET ENABLED:C1123(*; "bValidate@"; True:C214)
//End LSS_SetUpButtonsForNewRecords

