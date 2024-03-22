//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Chuck Miller
//Date and time: 06/21/17, 13:18:13
//----------------------------------------------------
//Method: LSS_SetSaveandDelete
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2017_06_bug  ////Fix error where errors occur and tranaction not cancelled
	//Modified by: Chuck Miller (6/21/17 13:18:27)
	
End if 
If (LSS_DuplicateRecordError_B | LSS_Error_B)
	OBJECT SET ENABLED:C1123(*; "bValidate"; False:C215)
	OBJECT SET ENABLED:C1123(*; "bValidate1"; False:C215)
	OBJECT SET ENABLED:C1123(*; "bDelete"; False:C215)
End if 
//End LSS_SetSaveandDelete

