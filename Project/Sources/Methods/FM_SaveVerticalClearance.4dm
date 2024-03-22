//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 06/16/15, 12:10:58
//----------------------------------------------------
//Method: FM_SaveVerticalClearance
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (6/16/15 12:12:13)
	Mods_2015_12_bug  //Fix bug where accessibility records, ut records, dmeter recdords not updated all the time
	//Modified by: administrator (12/29/15 16:10:34)
	Mods_2017_06_bug  ////Fix error where errors occur and tranaction not cancelled
	//Modified by: Chuck Miller (6/21/17 13:44:29)
End if 
If (Modified record:C314([LSS_VerticalClearance:177]))
	C_TEXT:C284($ErrorMethodCalled_txt)
	$ErrorMethodCalled_txt:=Method called on error:C704
	ON ERR CALL:C155("LSS_ErrorMethod")
	LSS_UpdateMany_B:=True:C214
	If (Is new record:C668([LSS_VerticalClearance:177]))
		LogNewRecord(->[LSS_VerticalClearance:177]LSS_VerticalClearanceId_s:1; ->[LSS_VerticalClearance:177]LSS_VerticalClearanceId_s:1; ->[LSS_VerticalClearance:177]LSS_VerticalClearanceId_s:1; 0; "LSS_VerticalClearanceId_s")
	End if 
	ARRAY TEXT:C222($FieldsToSkip_atxt; 0)
	APPEND TO ARRAY:C911($FieldsToSkip_atxt; "LSS_VerticalClearanceId_s")
	If (ACT_PushGroupChanges(Table:C252(->[LSS_VerticalClearance:177]); 11; ->$FieldsToSkip_atxt))
		[LSS_Inspection:164]LSS_InspectionId_s:1:=[LSS_Inspection:164]LSS_InspectionId_s:1  //reset to force modified record flag for this table
		FlushGrpChgs(11; ->[LSS_VerticalClearance:177]LSS_VerticalClearanceId_s:1; ->[LSS_VerticalClearance:177]LSS_VerticalClearanceId_s:1; ->[LSS_VerticalClearance:177]LSS_VerticalClearanceId_s:1; 0)
		SAVE RECORD:C53([LSS_VerticalClearance:177])
	End if 
	
	ON ERR CALL:C155($ErrorMethodCalled_txt)
	If (LSS_DuplicateRecordError_B | LSS_Error_B)
		CANCEL:C270
	End if 
End if 
//End FM_SaveVerticalClearance
