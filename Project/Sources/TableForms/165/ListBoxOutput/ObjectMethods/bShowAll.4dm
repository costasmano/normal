//Method: [LSS_Inventory];"ListBoxOutput".bShowAll
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 04/11/19, 16:26:22
	// ----------------------------------------------------
	//Created : 
	Mods_2019_04_bug  // Fix defect with the LSS_Districts_as/LSS_Categories_as/ and LSS_StructType_atxt drop downs
	//Modified by: Chuck Miller (4/11/19 16:27:03)
	
	// Modified by: manousakisc (5/9/2023)
	Mods_2023_LSSNew
	// reset status filter dropdwon and proj no dropdown
End if 
//
ALL RECORDS:C47(Current form table:C627->)
OBJECT SET VISIBLE:C603(*; "bDelete@"; False:C215)

LSS_ResetListFilters


OBJECT SET VISIBLE:C603(*; "LSS_StructType_Lbl"; False:C215)
OBJECT SET VISIBLE:C603(*; "LSS_StructType_atxt"; False:C215)

LSS_SortInventory
COPY NAMED SELECTION:C331([LSS_Inventory:165]; "InventorySet")
WIN_SetWindowTitle(->[LSS_Inventory:165])

//End [LSS_Inventory].ListBoxOutput.bShowAll