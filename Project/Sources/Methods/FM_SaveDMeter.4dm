//%attributes = {"invisible":true}
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 03/31/15, 16:46:42
//----------------------------------------------------
//Method: FM_SaveDMeter
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (3/31/15 16:47:09)
	Mods_2017_06_bug  ////Fix error where errors occur and tranaction not cancelled
	//Modified by: Chuck Miller (6/21/17 13:44:29)
End if 

If (Modified record:C314([LSS_DMeter:161]))
	C_TEXT:C284($ErrorMethodCalled_txt)
	$ErrorMethodCalled_txt:=Method called on error:C704
	ON ERR CALL:C155("LSS_ErrorMethod")
	If (Is new record:C668([LSS_DMeter:161]))
		LogNewRecord(->[LSS_DMeter:161]LSS_DMeterId_s:1; ->[LSS_DMeter:161]LSS_DMeterId_s:1; ->[LSS_DMeter:161]LSS_DMeterId_s:1; 0; "LSS_DMeterId_s")
	End if 
	ARRAY TEXT:C222($FieldsToSkip_atxt; 0)
	APPEND TO ARRAY:C911($FieldsToSkip_atxt; "LSS_DMeterId_s")
	If (ACT_PushGroupChanges(Table:C252(->[LSS_DMeter:161]); 4; ->$FieldsToSkip_atxt))
		[LSS_Inspection:164]LSS_InspectionId_s:1:=[LSS_Inspection:164]LSS_InspectionId_s:1  //reset to force modified record flag for this table
		FlushGrpChgs(4; ->[LSS_DMeter:161]LSS_DMeterId_s:1; ->[LSS_DMeter:161]LSS_DMeterId_s:1; ->[LSS_DMeter:161]LSS_DMeterId_s:1; 0)
		SAVE RECORD:C53([LSS_DMeter:161])
	End if 
	ON ERR CALL:C155($ErrorMethodCalled_txt)
	If (LSS_DuplicateRecordError_B | LSS_Error_B)
		
		CANCEL:C270
	End if 
End if 

//End FM_SaveDMeter

