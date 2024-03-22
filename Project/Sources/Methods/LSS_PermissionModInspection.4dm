//%attributes = {"invisible":true}
//Method: LSS_PermissionModInspection
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
	//----------------------------------------------------
	//User name (OS): administrator
	//Date and time: 03/25/15, 16:28:52
	//----------------------------------------------------
	
	Mods_2014_Lighting  // 
	//Modified by: administrator (3/25/15 16:28:54)
	
	// Modified by: manousakisc (4/28/2023)
	Mods_2023_LSSNew
	// do not allow edit of inspections for removed or proposed structures
End if 
LSS_AllowInspectionEdit_B:=False:C215
C_BOOLEAN:C305($IsDesigner_B)
$IsDesigner_B:=False:C215
Case of 
	: (User in group:C338(Current user:C182; "Design Access Group"))
		$IsDesigner_B:=True:C214
		LSS_AllowInspectionEdit_B:=False:C215
		
	: (LSS_MODInspection_aB{7})  //allow ALL
		LSS_AllowInspectionEdit_B:=True:C214
		
		
	Else 
		//ALERT("Not DEsigner")
		LSS_AllowInspectionEdit_B:=LSS_MODInspection_aB{[LSS_Inventory:165]LSS_District_L:3}
		
End case 
If (Not:C34(LSS_AllowInspectionEdit_B))
	LSS_CheckTeamMembership(->LSS_AllowInspectionEdit_B)
End if 

If (Not:C34($IsDesigner_B))
	If (LSS_AllowInspectionEdit_B)
		LSS_AllowInspectionEdit_B:=(Not:C34([LSS_Inspection:164]LSS_Approved_L:43=BMS Approved))
	End if 
End if 

If (Not:C34($IsDesigner_B))
	
	If (([LSS_Inventory:165]LSS_Status_s:35="Removed") | ([LSS_Inventory:165]LSS_Status_s:35="Proposed"))
		LSS_AllowInspectionEdit_B:=False:C215
	End if 
	
End if 

//End LSS_PermissionModInspection