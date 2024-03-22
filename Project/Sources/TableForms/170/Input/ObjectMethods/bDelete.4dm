
//----------------------------------------------------
//User name (OS): Bridge Section
//Date and time: 04/09/15, 16:26:17
//----------------------------------------------------
//Method: Object Method: [LSS_refStructureMaterial].Input.bDelete
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: Bridge Section (4/9/15 16:26:19)
	
End if 

LogDeletion(->[LSS_refStructureMaterial:170]LSS_StructureMaterialId_s:1; ->[LSS_refStructureMaterial:170]LSS_StructureMaterialId_s:1; ->[LSS_refStructureMaterial:170]LSS_StructureMaterialId_s:1; 0)
DELETE RECORD:C58([LSS_refStructureMaterial:170])
VALIDATE TRANSACTION:C240
CANCEL:C270

//End Object Method: [LSS_refStructureMaterial].Input.bDelete

