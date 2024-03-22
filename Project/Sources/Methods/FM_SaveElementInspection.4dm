//%attributes = {"invisible":true}

// ----------------------------------------------------
// User name (OS): administrator
// Date and time: 10/14/14, 14:10:25
// ----------------------------------------------------
// Method: FM_SaveElementInspection
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2017_06_bug  ////Fix error where errors occur and tranaction not cancelled
	//Modified by: Chuck Miller (6/21/17 13:44:29)
End if 

If ([LSS_ElementInspection:163]LSS_Description_txt:7#"")
	C_LONGINT:C283($Pos_L)
	$Pos_L:=Position:C15(" "; v_163_007_atxt{LSS_SelectedRow_L})
	C_TEXT:C284($Number_txt)
	$Number_txt:=Substring:C12(v_163_007_atxt{LSS_SelectedRow_L}; 1; $Pos_L)
	v_163_007_atxt{LSS_SelectedRow_L}:=$Number_txt+[LSS_ElementInspection:163]LSS_Description_txt:7
End if 
v_163_004_atxt{LSS_SelectedRow_L}:=[LSS_ElementInspection:163]LSS_Rating_s:4
v_163_006_atxt{LSS_SelectedRow_L}:=[LSS_ElementInspection:163]LSS_Urgency_s:6
v_163_005_atxt{LSS_SelectedRow_L}:=[LSS_ElementInspection:163]LSS_Deficiency_s:5
v_163_008_atxt{LSS_SelectedRow_L}:=[LSS_ElementInspection:163]LSS_Remarks_txt:8
C_TEXT:C284($ErrorMethodCalled_txt)
$ErrorMethodCalled_txt:=Method called on error:C704
ON ERR CALL:C155("LSS_ErrorMethod")
If (LSS_IsNewESRecord_B)
	LogNewRecord(->[LSS_ElementInspection:163]LSS_ElementInspectionId_s:1; ->[LSS_ElementInspection:163]LSS_ElementInspectionId_s:1; ->[LSS_ElementInspection:163]LSS_ElementInspectionId_s:1; 0; "LSS_ElementInspection")
End if 
ARRAY TEXT:C222($FieldsToSkip_atxt; 0)
APPEND TO ARRAY:C911($FieldsToSkip_atxt; "LSS_ElementInspectionId_s")
If (ACT_PushGroupChanges(Table:C252(->[LSS_ElementInspection:163]); 3; ->$FieldsToSkip_atxt))
	[LSS_Inspection:164]LSS_InspectionId_s:1:=[LSS_Inspection:164]LSS_InspectionId_s:1  //reset to force modified record flag for this table
	FlushGrpChgs(3; ->[LSS_ElementInspection:163]LSS_ElementInspectionId_s:1; ->[LSS_ElementInspection:163]LSS_ElementInspectionId_s:1; ->[LSS_ElementInspection:163]LSS_ElementInspectionId_s:1; 0)
	SAVE RECORD:C53([LSS_ElementInspection:163])
End if 
ON ERR CALL:C155($ErrorMethodCalled_txt)

//End method FM_SaveElementInspection