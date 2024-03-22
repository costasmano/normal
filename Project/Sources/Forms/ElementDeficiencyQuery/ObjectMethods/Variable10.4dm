//Method: ElementDeficiencyQuery.Variable10
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 02/26/19, 12:10:18
	// ----------------------------------------------------
	//Created : 
	Mods_2019_02
End if 
//
USE SET:C118("InventoryStartSet")
LSS_SortInventory
COPY NAMED SELECTION:C331([LSS_Inventory:165]; "InventorySet")
//End ElementDeficiencyQuery.Variable10