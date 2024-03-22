//%attributes = {"invisible":true}
//Method: LSS_GetPendingInsp
//  `Description
//  `Get the pending inspecions - not approved
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/16/16, 12:51:41
	// ----------------------------------------------------
	//Created : 
	Mods_2016_05
	// Modified by: Costas Manousakis-(Designer)-(3/23/20 14:32:17)
	Mods_2020_03_bug
	//  `added group LSS_MassDOTAdmin for overall review of inspections 
End if 
//
Case of 
	: (User in group:C338(Current user:C182; "Design Access Group"))
		ALL RECORDS:C47([LSS_Inspection:164])
		
	: (GRP_UserInGroup("LSS_MassDOTAdmin")=1)
		QUERY:C277([LSS_Inspection:164]; [LSS_Inspection:164]LSS_Approved_L:43#BMS Approved)
		
	: (GRP_UserInGroup("LSS_MassDOTRep")=1)
		//find my district
		QUERY:C277([LSS_Inspection:164]; [LSS_Inspection:164]LSS_Approved_L:43#BMS Approved; *)
		//get all non-approved for my district
		QUERY:C277([LSS_Inspection:164];  & ; [LSS_Inventory:165]LSS_District_L:3=Num:C11(Replace string:C233(<>PERS_MyDivision_txt; "044"; "")))
		
	: (GRP_UserInGroup("LSS_ProjectManager")=1) | (GRP_UserInGroup("LSS_TeamLeader")=1) | (GRP_UserInGroup("LSS_TeamMember")=1)
		//get all non-approved for my company
		QUERY:C277([LSS_Inspection:164]; [LSS_Inspection:164]LSS_Approved_L:43#BMS Approved; *)
		QUERY:C277([LSS_Inspection:164];  & ; [LSS_Inspection:164]LSS_ConsultantName_txt:10=<>PERS_MyCompany_txt)
		
End case 

//End LSS_GetPendingInsp