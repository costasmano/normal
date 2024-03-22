//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 06/09/15, 11:54:08
//----------------------------------------------------
//Method: LSS_DeletePhoto
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (6/9/15 11:54:20)
	Mods_2015_12_bug  // Fix bug where deletion of picture records not recorded correctly
	//Modified by: administrator (12/24/15 11:13:41)
	Mods_2017_06_bug  ////Fix error where errors occur and tranaction not cancelled
	//Modified by: Chuck Miller (6/21/17 13:44:29)
End if 
C_BOOLEAN:C305($DoDelete_b)
$DoDelete_b:=True:C214
If (Not:C34(Is record loaded:C669([LSS_Photos:166])))
	If (ut_LoadRecordInteractive(->[LSS_Photos:166]))
	Else 
		$DoDelete_b:=False:C215
	End if 
End if 
If ($DoDelete_b)
	LSS_UpdateMany_B:=True:C214
	
	LogDeletion(->[LSS_Photos:166]LSS_PhotoId_s:1; ->[LSS_Photos:166]LSS_PhotoId_s:1; ->[LSS_Photos:166]LSS_PhotoId_s:1; 0)
	If ([LSS_Photos:166]LSS_PhotoType_s:3="Sketch D Meter")
		CLEAR VARIABLE:C89(LSS_DMeterPicture_pct)
	Else 
		CLEAR VARIABLE:C89(LSS_UTPicture_pct)
	End if 
	
	DELETE RECORD:C58([LSS_Photos:166])
	REDUCE SELECTION:C351([LSS_Photos:166]; 0)
	
	OBJECT SET VISIBLE:C603(*; "DMeterButton@"; False:C215)
	OBJECT SET VISIBLE:C603(*; "DMeterInput_@"; False:C215)
	OBJECT SET VISIBLE:C603(*; "DMeterButton_L"; True:C214)
	
	OBJECT SET VISIBLE:C603(*; "UTButton1_L"; False:C215)
	OBJECT SET VISIBLE:C603(*; "UTInput_1@"; False:C215)
	OBJECT SET VISIBLE:C603(*; "UTButton_L"; True:C214)
	
End if 
LSS_SetSaveandDelete
//End LSS_DeletePhoto

