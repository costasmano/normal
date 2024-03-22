
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 07/02/15, 17:19:14
//----------------------------------------------------
//Method: Object Method: [LSS_refStructureMaterial].Input.bValidate
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (7/2/15 17:19:15)
	
End if 
If (Modified record:C314([LSS_refStructureMaterial:170]))
	If (Is new record:C668([LSS_refStructureMaterial:170]))
		LogNewRecord(->[LSS_refStructureMaterial:170]LSS_StructureMaterialId_s:1; ->[LSS_refStructureMaterial:170]LSS_StructureMaterialId_s:1; ->[LSS_refStructureMaterial:170]LSS_StructureMaterialId_s:1; 0; "LSS_StructureMaterialId_s")
	End if 
	ARRAY TEXT:C222($FieldsToSkip_atxt; 0)
	APPEND TO ARRAY:C911($FieldsToSkip_atxt; "LSS_StructureMaterialId_s")
	If (ACT_PushGroupChanges(Table:C252(->[LSS_refStructureMaterial:170]); 1; ->$FieldsToSkip_atxt))
		FlushGrpChgs(1; ->[LSS_refStructureMaterial:170]LSS_StructureMaterialId_s:1; ->[LSS_refStructureMaterial:170]LSS_StructureMaterialId_s:1; ->[LSS_refStructureMaterial:170]LSS_StructureMaterialId_s:1; 0)
		
		SAVE RECORD:C53([LSS_refStructureMaterial:170])
	End if 
	VALIDATE TRANSACTION:C240
End if 
//End Object Method: [LSS_refStructureMaterial].Input.bValidate

