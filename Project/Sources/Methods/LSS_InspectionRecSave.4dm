//%attributes = {"invisible":true}
//Method: LSS_InspectionRecSave
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/15/15, 16:26:10
	// ----------------------------------------------------
	//Created : 
	Mods_2015_06
	Mods_2017_06_bug  ////Fix error where errors occur and tranaction not cancelled
	//Modified by: Chuck Miller (6/21/17 13:44:29)
End if 
//

ARRAY TEXT:C222($FieldsToSkip_atxt; 0)
APPEND TO ARRAY:C911($FieldsToSkip_atxt; "LSS_InspectionId_s")
APPEND TO ARRAY:C911($FieldsToSkip_atxt; "LSS_TeamLeaderId_L")
APPEND TO ARRAY:C911($FieldsToSkip_atxt; "LSS_DistHWYEngineerId_L")
APPEND TO ARRAY:C911($FieldsToSkip_atxt; "LSS_ProjectManagerId_L")
C_TEXT:C284($ErrorMethodCalled_txt)
$ErrorMethodCalled_txt:=Method called on error:C704
ON ERR CALL:C155("LSS_ErrorMethod")
If (Is new record:C668([LSS_Inspection:164]))
	LogNewRecord(->[LSS_Inspection:164]LSS_InspectionId_s:1; ->[LSS_Inspection:164]LSS_InspectionId_s:1; ->[LSS_Inspection:164]LSS_InspectionId_s:1; 0; "LSS_Inspection")
End if 
If (ACT_PushGroupChanges(Table:C252(->[LSS_Inspection:164]); 1; ->$FieldsToSkip_atxt))
	FlushGrpChgs(1; ->[LSS_Inspection:164]LSS_InspectionId_s:1; ->[LSS_Inspection:164]LSS_InspectionId_s:1; ->[LSS_Inspection:164]LSS_InspectionId_s:1; 0)
End if 
If ([LSS_Inspection:164]LSS_TeamLeaderId_L:8>0) & (Old:C35([LSS_Inspection:164]LSS_TeamLeaderId_L:8)#[LSS_Inspection:164]LSS_TeamLeaderId_L:8)
	LogLink(->[LSS_Inspection:164]LSS_TeamLeaderId_L:8; ->[LSS_Inspection:164]LSS_InspectionId_s:1; ->[LSS_Inspection:164]LSS_InspectionId_s:1; ->[LSS_Inspection:164]LSS_InspectionId_s:1; 0; ->[Personnel:42]Person ID:1)
End if 
If ([LSS_Inspection:164]LSS_DistHWYEngineerId_L:5>0) & (Old:C35([LSS_Inspection:164]LSS_DistHWYEngineerId_L:5)#[LSS_Inspection:164]LSS_DistHWYEngineerId_L:5)
	LogLink(->[LSS_Inspection:164]LSS_DistHWYEngineerId_L:5; ->[LSS_Inspection:164]LSS_InspectionId_s:1; ->[LSS_Inspection:164]LSS_InspectionId_s:1; ->[LSS_Inspection:164]LSS_InspectionId_s:1; 0; ->[Personnel:42]Person ID:1)
End if 
If ([LSS_Inspection:164]LSS_ProjectManagerId_L:9>0) & (Old:C35([LSS_Inspection:164]LSS_ProjectManagerId_L:9)#[LSS_Inspection:164]LSS_ProjectManagerId_L:9)
	LogLink(->[LSS_Inspection:164]LSS_ProjectManagerId_L:9; ->[LSS_Inspection:164]LSS_InspectionId_s:1; ->[LSS_Inspection:164]LSS_InspectionId_s:1; ->[LSS_Inspection:164]LSS_InspectionId_s:1; 0; ->[Personnel:42]Person ID:1)
End if 
SAVE RECORD:C53([LSS_Inspection:164])
ON ERR CALL:C155($ErrorMethodCalled_txt)

//End LSS_InspectionRecSave