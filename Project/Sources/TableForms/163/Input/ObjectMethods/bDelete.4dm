
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 03/31/15, 15:49:06
//----------------------------------------------------
//Method: Object Method: [LSS_ElementInspection].Input.bDelete
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (3/31/15 15:49:07)
	
End if 

LSS_UpdateMany_B:=True:C214
LogDeletion(->[LSS_ElementInspection:163]LSS_ElementInspectionId_s:1; ->[LSS_ElementInspection:163]LSS_ElementInspectionId_s:1; ->[LSS_ElementInspection:163]LSS_ElementInspectionId_s:1; 0)
If (False:C215)
	If ([LSS_refInspectionType:167]LSS_InspectionTypeId_s:1#[LSS_Inspection:164]LSS_InspectionTypeId_s:3)
		QUERY:C277([LSS_refInspectionType:167]; [LSS_refInspectionType:167]LSS_InspectionTypeId_s:1=[LSS_Inspection:164]LSS_InspectionTypeId_s:3)
	End if 
	LSS_CreateElementInputArrays([LSS_refInspectionType:167]LSS_AllowedElements_txt:3)
	
End if 
v_163_004_atxt{LSS_SelectedRow_L}:=""
v_163_006_atxt{LSS_SelectedRow_L}:=""
v_163_005_atxt{LSS_SelectedRow_L}:=""
v_163_008_atxt{LSS_SelectedRow_L}:=""
//get the default description
C_LONGINT:C283($ElementID_L)
$ElementID_L:=[LSS_ElementInspection:163]LSS_ElementId_L:2
C_TEXT:C284($Defaultdesc_txt)
$Defaultdesc_txt:=""
Begin SQL
	select [LSS_Element].[LSS_ElementDescription_s] from [LSS_Element]
	where [LSS_Element].[LSS_ElementId_L] = :$ElementID_L
	into :$Defaultdesc_txt ;
End SQL
C_LONGINT:C283($Pos_L)
$Pos_L:=Position:C15(" "; v_163_007_atxt{LSS_SelectedRow_L})
C_TEXT:C284($Number_txt)
$Number_txt:=Substring:C12(v_163_007_atxt{LSS_SelectedRow_L}; 1; $Pos_L)
If (Position:C15("blank element"; $Defaultdesc_txt)>0)
	v_163_007_atxt{LSS_SelectedRow_L}:=$Number_txt+"blank element"
Else 
	v_163_007_atxt{LSS_SelectedRow_L}:=$Number_txt+$Defaultdesc_txt
End if 

//End Object Method: [LSS_ElementInspection].Input.bDelete

