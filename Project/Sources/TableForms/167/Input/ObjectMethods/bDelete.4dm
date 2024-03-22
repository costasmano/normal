
//----------------------------------------------------
//User name (OS): Bridge Section
//Date and time: 04/09/15, 16:24:25
//----------------------------------------------------
//Method: Object Method: [LSS_refInspectionType].Input.bDelete
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: Bridge Section (4/9/15 16:24:27)
	
End if 
LogDeletion(->[LSS_refInspectionType:167]LSS_InspectionTypeId_s:1; ->[LSS_refInspectionType:167]LSS_InspectionTypeId_s:1; ->[LSS_refInspectionType:167]LSS_InspectionTypeId_s:1; 0)
DELETE RECORD:C58([LSS_refInspectionType:167])
VALIDATE TRANSACTION:C240
CANCEL:C270
//End Object Method: [LSS_refInspectionType].Input.bDelete

