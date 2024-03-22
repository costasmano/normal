//%attributes = {"shared":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 07/20/15, 10:26:05
//----------------------------------------------------
//Method: QR_ReturnNUmberInspections
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (7/20/15 10:26:06)
	
End if 
C_LONGINT:C283($0; $Count_L)
SET QUERY DESTINATION:C396(Into variable:K19:4; $Count_L)
QUERY:C277([LSS_Inspection:164]; [LSS_Inspection:164]LSS_InventoryId_s:2=[LSS_Inventory:165]LSS_InventoryId_s:1)
$0:=$Count_L
SET QUERY DESTINATION:C396(Into current selection:K19:1)
//End QR_ReturnNUmberInspections