//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 06/16/15, 11:58:37
//----------------------------------------------------
//Method: FM_SaveTowerDistance
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (6/16/15 11:58:55)
	Mods_2017_06_bug  ////Fix error where errors occur and tranaction not cancelled
	//Modified by: Chuck Miller (6/21/17 13:44:29)
End if 
If (Modified record:C314([LSS_TowerDistance:174]))
	C_TEXT:C284($ErrorMethodCalled_txt)
	$ErrorMethodCalled_txt:=Method called on error:C704
	ON ERR CALL:C155("LSS_ErrorMethod")
	If (Is new record:C668([LSS_TowerDistance:174]))
		LogNewRecord(->[LSS_TowerDistance:174]LSS_TowerDistanceId_s:1; ->[LSS_TowerDistance:174]LSS_TowerDistanceId_s:1; ->[LSS_TowerDistance:174]LSS_TowerDistanceId_s:1; 0; "LSS_TowerDistanceId_s")
	End if 
	ARRAY TEXT:C222($FieldsToSkip_atxt; 0)
	
	APPEND TO ARRAY:C911($FieldsToSkip_atxt; "LSS_TowerDistanceId_s")
	If (ACT_PushGroupChanges(Table:C252(->[LSS_TowerDistance:174]); 8; ->$FieldsToSkip_atxt))
		[LSS_Inspection:164]LSS_InspectionId_s:1:=[LSS_Inspection:164]LSS_InspectionId_s:1  //reset to force modified record flag for this table
		FlushGrpChgs(8; ->[LSS_TowerDistance:174]LSS_TowerDistanceId_s:1; ->[LSS_TowerDistance:174]LSS_TowerDistanceId_s:1; ->[LSS_TowerDistance:174]LSS_TowerDistanceId_s:1; 0)
		SAVE RECORD:C53([LSS_TowerDistance:174])
		
	End if 
	ON ERR CALL:C155($ErrorMethodCalled_txt)
End if 
UNLOAD RECORD:C212([LSS_TowerDistance:174])
//End FM_SaveTowerDistance

