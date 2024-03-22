
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 07/02/15, 17:17:46
//----------------------------------------------------
//Method: Object Method: [LSS_refStructureCoating].Input.bValidate
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (7/2/15 17:17:53)
	
End if 
If (Modified record:C314([LSS_refStructureCoating:169]))
	If (Is new record:C668([LSS_refStructureCoating:169]))
		LogNewRecord(->[LSS_refStructureCoating:169]LSS_StructureCoatingId_s:1; ->[LSS_refStructureCoating:169]LSS_StructureCoatingId_s:1; ->[LSS_refStructureCoating:169]LSS_StructureCoatingId_s:1; 0; "LSS_StructureCoatingId_s")
	End if 
	ARRAY TEXT:C222($FieldsToSkip_atxt; 0)
	APPEND TO ARRAY:C911($FieldsToSkip_atxt; "LSS_StructureCoatingId_s")
	If (ACT_PushGroupChanges(Table:C252(->[LSS_refStructureCoating:169]); 1; ->$FieldsToSkip_atxt))
		FlushGrpChgs(1; ->[LSS_refStructureCoating:169]LSS_StructureCoatingId_s:1; ->[LSS_refStructureCoating:169]LSS_StructureCoatingId_s:1; ->[LSS_refStructureCoating:169]LSS_StructureCoatingId_s:1; 0)
		
		SAVE RECORD:C53([LSS_refStructureCoating:169])
	End if 
	VALIDATE TRANSACTION:C240
End if 
//End Object Method: [LSS_refStructureCoating].Input.bValidate

