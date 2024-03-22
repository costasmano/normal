//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 04/02/15, 10:15:40
//----------------------------------------------------
//Method: FM_SaveUT
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (4/2/15 10:15:49)
	Mods_2015_12_bug  //Fix bug where accessibility records, ut records, dmeter recdords not updated all the time
	//Modified by: administrator (12/29/15 16:10:34)
	// Modified by: Costas Manousakis-(Designer)-(12/29/16 12:39:07)
	Mods_2016_12
	//  `Fixed wrong sequence name in the LognewRecord call. was "[LSS_UT]LSS_UTId_s" 
	Mods_2017_06_bug  ////Fix error where errors occur and tranaction not cancelled
	//Modified by: Chuck Miller (6/21/17 13:44:29)
End if 
If (Modified record:C314([LSS_UT:175]))
	C_TEXT:C284($ErrorMethodCalled_txt)
	$ErrorMethodCalled_txt:=Method called on error:C704
	
	ON ERR CALL:C155("LSS_ErrorMethod")
	LSS_UpdateMany_B:=True:C214
	
	ARRAY TEXT:C222($FieldsToSkip_atxt; 0)
	
	APPEND TO ARRAY:C911($FieldsToSkip_atxt; "LSS_UTId_s")
	If (Is new record:C668([LSS_UT:175]))
		LogNewRecord(->[LSS_UT:175]LSS_UTId_s:1; ->[LSS_UT:175]LSS_UTId_s:1; ->[LSS_UT:175]LSS_UTId_s:1; 0; "LSS_UTId_s")
	End if 
	If (ACT_PushGroupChanges(Table:C252(->[LSS_UT:175]); 9; ->$FieldsToSkip_atxt))
		[LSS_Inspection:164]LSS_InspectionId_s:1:=[LSS_Inspection:164]LSS_InspectionId_s:1  //reset to force modified record flag for this table
		FlushGrpChgs(9; ->[LSS_UT:175]LSS_UTId_s:1; ->[LSS_UT:175]LSS_UTId_s:1; ->[LSS_UT:175]LSS_UTId_s:1; 0)
		
		SAVE RECORD:C53([LSS_UT:175])
	End if 
	ON ERR CALL:C155($ErrorMethodCalled_txt)
End if 
UNLOAD RECORD:C212([LSS_UT:175])
//End FM_SaveUT