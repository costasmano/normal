//%attributes = {"invisible":true}

// ----------------------------------------------------
// User name (OS): Lori Peterson
// Date and time: 04/21/15, 14:27:51
// ----------------------------------------------------
// Method: LSS_SelectInspectionsForInvItem
// Description
// 
//
// Parameters
// ----------------------------------------------------

SET QUERY DESTINATION:C396(Into current selection:K19:1)


QUERY:C277([LSS_Inspection:164]; [LSS_Inspection:164]LSS_InventoryId_s:2=[LSS_Inventory:165]LSS_InventoryId_s:1)
ORDER BY:C49([LSS_Inspection:164]; [LSS_Inspection:164]LSS_InspectionDate_d:4; <)
COPY NAMED SELECTION:C331([LSS_Inspection:164]; "InspectionSet")

// End Method: LSS_SelectInspectionsForInvItem