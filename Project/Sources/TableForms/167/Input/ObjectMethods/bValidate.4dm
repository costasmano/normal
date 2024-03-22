
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 07/02/15, 17:13:15
//----------------------------------------------------
//Method: Object Method: [LSS_refInspectionType].Input.bValidate
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (7/2/15 17:13:17)
	
End if 
If (Modified record:C314([LSS_refInspectionType:167]))
	
	ARRAY TEXT:C222($FieldsToSkip_atxt; 0)
	APPEND TO ARRAY:C911($FieldsToSkip_atxt; "LSS_InspectionTypeId_s")
	If (Is new record:C668([LSS_refInspectionType:167]))
		LogNewRecord(->[LSS_refInspectionType:167]LSS_InspectionTypeId_s:1; ->[LSS_refInspectionType:167]LSS_InspectionTypeId_s:1; ->[LSS_refInspectionType:167]LSS_InspectionTypeId_s:1; 0; "LSS_InspectionTypeId_s")
	End if 
	If (ACT_PushGroupChanges(Table:C252(->[LSS_refInspectionType:167]); 1; ->$FieldsToSkip_atxt))
		FlushGrpChgs(1; ->[LSS_refInspectionType:167]LSS_InspectionTypeId_s:1; ->[LSS_refInspectionType:167]LSS_InspectionTypeId_s:1; ->[LSS_refInspectionType:167]LSS_InspectionTypeId_s:1; 0)
		
		SAVE RECORD:C53([LSS_refInspectionType:167])
	End if 
	VALIDATE TRANSACTION:C240
End if 
//End Object Method: [LSS_refInspectionType].Input.bValidate

