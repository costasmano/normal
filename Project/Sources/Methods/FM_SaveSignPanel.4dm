//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 06/16/15, 11:40:34
//----------------------------------------------------
//Method: FM_SaveSignPanel
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (6/16/15 11:41:17)
	Mods_2015_12_bug  //Fix bug where accessibility records, ut records, dmeter recdords not updated all the time
	//Modified by: administrator (12/29/15 16:10:34)
	Mods_2018_09_bug  //Fix bug to make sure $ErrorMethodCalled_txt is defined
	//Modified by: Chuck Miller (9/27/18 16:33:21)
End if 
C_TEXT:C284($ErrorMethodCalled_txt)
$ErrorMethodCalled_txt:=Method called on error:C704
If (Modified record:C314([LSS_SignPanel:172]))
	LSS_UpdateMany_B:=True:C214
	ARRAY TEXT:C222($FieldsToSkip_atxt; 0)
	APPEND TO ARRAY:C911($FieldsToSkip_atxt; "LSS_SignPanelId_s")
	ON ERR CALL:C155("LSS_ErrorMethod")
	//APPEND TO ARRAY($FieldsToSkip_atxt;"LSS_InspectionId_s")
	If (Is new record:C668([LSS_SignPanel:172]))
		LogNewRecord(->[LSS_SignPanel:172]LSS_SignPanelId_s:1; ->[LSS_SignPanel:172]LSS_SignPanelId_s:1; ->[LSS_SignPanel:172]LSS_SignPanelId_s:1; 0; "LSS_SignPanelId_s")
	End if 
	If (ACT_PushGroupChanges(Table:C252(->[LSS_SignPanel:172]); 6; ->$FieldsToSkip_atxt))
		[LSS_Inspection:164]LSS_InspectionId_s:1:=[LSS_Inspection:164]LSS_InspectionId_s:1  //reset to force modified record flag for this table
		FlushGrpChgs(6; ->[LSS_SignPanel:172]LSS_SignPanelId_s:1; ->[LSS_SignPanel:172]LSS_SignPanelId_s:1; ->[LSS_SignPanel:172]LSS_SignPanelId_s:1; 0)
		SAVE RECORD:C53([LSS_SignPanel:172])
	End if 
End if 
UNLOAD RECORD:C212([LSS_SignPanel:172])
ON ERR CALL:C155($ErrorMethodCalled_txt)
//End FM_SaveSignPanel

