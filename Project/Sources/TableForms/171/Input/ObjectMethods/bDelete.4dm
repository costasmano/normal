
//----------------------------------------------------
//User name (OS): Bridge Section
//Date and time: 04/09/15, 16:27:14
//----------------------------------------------------
//Method: Object Method: [LSS_refStructureTypes].Input.bDelete
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: Bridge Section (4/9/15 16:27:15)
	
End if 

LogDeletion(->[LSS_refStructureTypes:171]LSS_StructureTypeId_s:1; ->[LSS_refStructureTypes:171]LSS_StructureTypeId_s:1; ->[LSS_refStructureTypes:171]LSS_StructureTypeId_s:1; 0)
DELETE RECORD:C58([LSS_refStructureTypes:171])
VALIDATE TRANSACTION:C240
CANCEL:C270
//End Object Method: [LSS_refStructureTypes].Input.bDelete

