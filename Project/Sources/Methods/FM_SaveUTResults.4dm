//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 04/02/15, 11:19:50
//----------------------------------------------------
//Method: FM_SaveUTResults
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (4/2/15 14:35:27)
	Mods_2015_12_bug  //Fix bug where accessibility records, ut records, dmeter recdords not updated all the time
	//Modified by: administrator (12/29/15 16:10:34)
	Mods_2017_06_bug  ////Fix error where errors occur and tranaction not cancelled
	//Modified by: Chuck Miller (6/21/17 13:44:29)
End if 
If (Modified record:C314([LSS_UtResult:176]))
	C_TEXT:C284($ErrorMethodCalled_txt)
	$ErrorMethodCalled_txt:=Method called on error:C704
	ON ERR CALL:C155("LSS_ErrorMethod")
	LSS_UpdateMany_B:=True:C214
	
	If (Is new record:C668([LSS_UtResult:176]))
		LogNewRecord(->[LSS_UtResult:176]LSS_UTResultId_s:1; ->[LSS_UtResult:176]LSS_UTResultId_s:1; ->[LSS_UtResult:176]LSS_UTResultId_s:1; 0; "LSS_UTResultId_s")
	End if 
	ARRAY TEXT:C222($FieldsToSkip_atxt; 0)
	
	APPEND TO ARRAY:C911($FieldsToSkip_atxt; "LSS_UTResultId_s")
	
	If (ACT_PushGroupChanges(Table:C252(->[LSS_UtResult:176]); 10; ->$FieldsToSkip_atxt))
		[LSS_Inspection:164]LSS_InspectionId_s:1:=[LSS_Inspection:164]LSS_InspectionId_s:1  //reset to force modified record flag for this table
		FlushGrpChgs(10; ->[LSS_UtResult:176]LSS_UTResultId_s:1; ->[LSS_UtResult:176]LSS_UTResultId_s:1; ->[LSS_UtResult:176]LSS_UTResultId_s:1; 0)
		
		SAVE RECORD:C53([LSS_UtResult:176])
	End if 
	ON ERR CALL:C155($ErrorMethodCalled_txt)
End if 
UNLOAD RECORD:C212([LSS_UtResult:176])

//End FM_SaveUTResults

