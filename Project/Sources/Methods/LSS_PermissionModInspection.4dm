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
	// Modified by: Costas Manousakis-(Designer)-(2024-03-06 18:19:15)
	Mods_2024_LSS_1
	//  `re-arranged last checks for all non design users
	//  `Allow editing of blank inspections (date=!00/00/00!) with a contract number if user is member of one associated companies 
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

//start of Mods_2024_LSS_1

If (Not:C34($IsDesigner_B))
	
	If (LSS_AllowInspectionEdit_B)
		LSS_AllowInspectionEdit_B:=(Not:C34([LSS_Inspection:164]LSS_Approved_L:43=BMS Approved))
	End if 
	
	If (([LSS_Inventory:165]LSS_Status_s:35="Removed") | ([LSS_Inventory:165]LSS_Status_s:35="Proposed"))
		LSS_AllowInspectionEdit_B:=False:C215
	End if 
	
	If ([LSS_Inspection:164]LSS_InspectionDate_d:4=!00-00-00!) & \
		([LSS_Inspection:164]LSS_ContractNo_L:60>0) & \
		([LSS_Inspection:164]LSS_TeamLeaderId_L:8=0) & \
		(ds:C1482.LSS_TeamMembers.query("LSS_InspectionId_s = :1"; [LSS_Inspection:164]LSS_InspectionId_s:1).length=0)
		//for blank inspection date with a contract - they are inspection assignements
		// and a team leader or TMs have not been assigned yet
		
		// allow only users who are members of the companies and are allowed to add/modify all inspections 
		// and the structure has not been removed - structure must be made active before
		LSS_AllowInspectionEdit_B:=LSS_MemberofContract([LSS_Inspection:164]LSS_ContractNo_L:60) & \
			(LSS_MODInspection_aB{7} | LSS_ADDInspection_aB{7}) & \
			([LSS_Inventory:165]LSS_Status_s:35="Active")
		//
	End if 
	
End if 
//end of Mods_2024_LSS_1

//End LSS_PermissionModInspection