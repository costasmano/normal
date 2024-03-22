//%attributes = {"invisible":true}
//Method: LSS_SortInventory
//Description
// sort the Inventory list
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/29/15, 15:59:53
	// ----------------------------------------------------
	//Created : 
	Mods_2015_05
End if 
//
ORDER BY:C49([LSS_Inventory:165]; [LSS_Inventory:165]LSS_Category_s:2; >; [LSS_Inventory:165]LSS_StructureNumber_s:6; >)

//End LSS_SortInventory