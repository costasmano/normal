//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 03/25/15, 15:42:22
//----------------------------------------------------
//Method: LSS_PermissionDELInventory
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (3/25/15 15:42:23)
	// Modified by: Costas Manousakis-(Designer)-(11/4/15 09:31:32)
	Mods_2015_11_bug
	//  remove check for current user-to delete inventory must be in a delete access group
End if 

LSS_AllowInventoryDelete_B:=True:C214
C_LONGINT:C283($Count_L)

SET QUERY DESTINATION:C396(Into variable:K19:4; $Count_L)
QUERY:C277([LSS_Inspection:164]; [LSS_Inspection:164]LSS_InventoryId_s:2=[LSS_Inventory:165]LSS_InventoryId_s:1)
SET QUERY DESTINATION:C396(Into current selection:K19:1)

Case of 
	: ($Count_L>0)
		LSS_AllowInventoryDelete_B:=False:C215
	: (User in group:C338(Current user:C182; "Design Access Group"))
		
	: (LSS_DELInventory_aB{7})  //allow ALL 
		
	: ([LSS_Inventory:165]LSS_District_L:3<1)
		LSS_AllowInventoryDelete_B:=False:C215
	: ([LSS_Inventory:165]LSS_District_L:3>6)
		LSS_AllowInventoryDelete_B:=False:C215
	Else 
		LSS_AllowInventoryDelete_B:=LSS_DELInventory_aB{[LSS_Inventory:165]LSS_District_L:3}
End case 
//End LSS_PermissionDELInventory