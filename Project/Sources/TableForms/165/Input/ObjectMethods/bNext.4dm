
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 12/02/14, 13:53:59
//----------------------------------------------------
//Method: Object Method: [LSS_Inventory].Input.bNext
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (12/2/14 13:54:00)
	
End if 
C_BOOLEAN:C305(LSS_MovingInvRecords_B)
LSS_MovingInvRecords_B:=True:C214

If (LSS_EditingInventory_B)
	FM_SaveInventoryInput
End if 
LSS_InventoryRow_L:=LSS_InventoryRow_L+1
USE NAMED SELECTION:C332("InventorySet")
GOTO SELECTED RECORD:C245([LSS_Inventory:165]; LSS_InventoryRow_L)
ACCEPT:C269
//FM_InventoryInput (On Load )
//End Object Method: [LSS_Inventory].Input.bNext

