
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 04/07/15, 13:32:44
//----------------------------------------------------
//Method: Object Method: [LSS_refStructureCoating].Input.bDelete
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (4/7/15 13:32:45)
	
End if 
LogDeletion(->[LSS_refStructureCoating:169]LSS_StructureCoatingId_s:1; ->[LSS_refStructureCoating:169]LSS_StructureCoatingId_s:1; ->[LSS_refStructureCoating:169]LSS_StructureCoatingId_s:1; 0)
DELETE RECORD:C58([LSS_refStructureCoating:169])
VALIDATE TRANSACTION:C240
CANCEL:C270

//End Object Method: [LSS_refStructureCoating].Input.bDelete

