//%attributes = {"invisible":true}
//Method: LSS_PermissionADDInventory
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
	//----------------------------------------------------
	//User name (OS): administrator
	//Date and time: 03/25/15, 16:28:30
	//----------------------------------------------------
	Mods_2014_Lighting  // 
	//Modified by: administrator (3/25/15 16:28:31)
	// Modified by: Costas Manousakis-(Designer)-(2023-10-17 09:58:18)
	Mods_2023_10
	//  `Enable the Add inventory button if user is allowed to add in any district.
	//  `The town drop down in the Add form is controlled by the districts user is allowed to add into. 
	//  `Pers groups LSS_AddInventory_Dx
	
End if 
LSS_AllowNewInventoryItem_b:=True:C214
Case of 
	: (User in group:C338(Current user:C182; "Design Access Group"))
	: (LSS_ADDInventory_aB{7})  //allow ALL
	: ([LSS_Inventory:165]LSS_District_L:3<1)
		LSS_AllowNewInventoryItem_b:=False:C215
	: ([LSS_Inventory:165]LSS_District_L:3>6)
		LSS_AllowNewInventoryItem_b:=False:C215
	Else 
		// Start of Mods_2023_10
		//LSS_AllowNewInventoryItem_b:=LSS_ADDInventory_aB{[LSS_Inventory]LSS_District_L}
		LSS_AllowNewInventoryItem_b:=(Find in array:C230(LSS_ADDInventory_aB; True:C214)>0)
		// End of Mods_2023_10
		
End case 

//End LSS_PermissionADDInventory