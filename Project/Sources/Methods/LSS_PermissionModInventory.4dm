//%attributes = {"invisible":true}
//Method: LSS_PermissionModInventory
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
	//----------------------------------------------------
	//User name (OS): administrator
	//Date and time: 03/25/15, 12:33:56
	//----------------------------------------------------
	Mods_2014_Lighting  // 
	//Modified by: administrator (3/25/15 12:33:58)
	
	//Modified by: administrator (11/3/15 )
	Mods_2015_11_bug
	//  `fix wrong field in check for current user
	
	// Modified by: manousakisc (4/28/2023)
	Mods_2023_LSSNew
	// do not allow changes when structure has been removed
	// Modified by: Costas Manousakis-(Designer)-(2023-11-21 13:24:57)
	Mods_2023_11
	//  `added proc variable LSS_AllowStatusChange_B - to control access to the Status pulldown
End if 
LSS_AllowInventoryEdit_B:=True:C214
Case of 
	: (User in group:C338(Current user:C182; "Design Access Group"))
	: (LSS_MODInventory_aB{7})  //allow ALL
	: ([LSS_Inventory:165]LSS_CreatedBy_s:27=Current user:C182)
	: ([LSS_Inventory:165]LSS_District_L:3<1)
		LSS_AllowInventoryEdit_B:=False:C215
	: ([LSS_Inventory:165]LSS_District_L:3>6)
		LSS_AllowInventoryEdit_B:=False:C215
	Else 
		LSS_AllowInventoryEdit_B:=LSS_MODInventory_aB{[LSS_Inventory:165]LSS_District_L:3}
End case 

//start of Mods_2023_11
LSS_AllowStatusChange_B:=LSS_AllowInventoryEdit_B
//end of Mods_2023_11
If ([LSS_Inventory:165]LSS_Status_s:35="Removed")  //if structure removed - no mods allowed
	LSS_AllowInventoryEdit_B:=False:C215
End if 

//End LSS_PermissionModInventory