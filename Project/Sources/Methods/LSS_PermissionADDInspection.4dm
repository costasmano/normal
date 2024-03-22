//%attributes = {"invisible":true}
//Method: LSS_PermissionADDInspection
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
	//----------------------------------------------------
	//User name (OS): administrator
	//Date and time: 03/25/15, 12:35:37
	//----------------------------------------------------
	
	Mods_2014_Lighting  // 
	//Modified by: administrator (3/25/15 12:35:39) 
	
	// Modified by: manousakisc (4/28/2023)
	Mods_2023_LSSNew
	// don't allow adding inspections for removed or proposed structures
End if 
LSS_AllowNewInspection_b:=True:C214
Case of 
	: (User in group:C338(Current user:C182; "Design Access Group"))
	: (LSS_ADDInspection_aB{7})  //allow ALL
	: ([LSS_Inventory:165]LSS_District_L:3<1)
		LSS_AllowNewInspection_b:=False:C215
	: ([LSS_Inventory:165]LSS_District_L:3>6)
		LSS_AllowNewInspection_b:=False:C215
	Else 
		LSS_AllowNewInspection_b:=LSS_ADDInspection_aB{[LSS_Inventory:165]LSS_District_L:3}
End case 

If (([LSS_Inventory:165]LSS_Status_s:35="Removed") | ([LSS_Inventory:165]LSS_Status_s:35="Proposed"))
	LSS_AllowNewInspection_b:=False:C215
End if 

//End LSS_PermissionADDInspection

