If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/29/07, 08:57:22
	// ----------------------------------------------------
	// Method: Object Method: bValidate
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM12_5302
	Mods_2007_CJM_v54  //r001 `11/13/07, 15:38:48  ``Make typ_approved_d enetrable only if structure type has value
	Mods_2008_CJM_v56  //r001 `06/12/08, 16:15:59   `Add update of last action date    
End if 
If (Is new record:C668([PRJ_TypeStudy:121]))
	PRJ_2ndAddSubRecord_b:=True:C214
End if 
Case of 
	: (Old:C35([PRJ_TypeStudy:121]TYP_Approved_d:10)#[PRJ_TypeStudy:121]TYP_Approved_d:10) & ([PRJ_TypeStudy:121]TYP_Approved_d:10#!00-00-00!)
		
		Case of 
			: (([PRJ_ProjectDetails:115]PRJ_ApprovedType_s:30="") & ([PRJ_TypeStudy:121]TYP_StructureType_s:4#""))
				[PRJ_ProjectDetails:115]PRJ_ApprovedType_s:30:=[PRJ_TypeStudy:121]TYP_StructureType_s:4
			: ([PRJ_ProjectDetails:115]PRJ_ApprovedType_s:30=[PRJ_TypeStudy:121]TYP_StructureType_s:4)
			Else 
				CONFIRM:C162("Are you sure you wish to change Structure Type "+[PRJ_ProjectDetails:115]PRJ_ApprovedType_s:30+" to "+[PRJ_TypeStudy:121]TYP_StructureType_s:4; "Yes"; "No")
				If (OK=1)
					[PRJ_ProjectDetails:115]PRJ_ApprovedType_s:30:=[PRJ_TypeStudy:121]TYP_StructureType_s:4
				End if 
		End case 
		
	: ([PRJ_TypeStudy:121]TYP_Approved_d:10#!00-00-00!)
		Case of 
			: (([PRJ_ProjectDetails:115]PRJ_ApprovedType_s:30="") & ([PRJ_TypeStudy:121]TYP_StructureType_s:4#""))
				[PRJ_ProjectDetails:115]PRJ_ApprovedType_s:30:=[PRJ_TypeStudy:121]TYP_StructureType_s:4
			: ([PRJ_ProjectDetails:115]PRJ_ApprovedType_s:30=[PRJ_TypeStudy:121]TYP_StructureType_s:4)
			Else 
				CONFIRM:C162("Are you sure you wish to change Structure Type "+[PRJ_ProjectDetails:115]PRJ_ApprovedType_s:30+" to "+[PRJ_TypeStudy:121]TYP_StructureType_s:4; "Yes"; "No")
				If (OK=1)
					[PRJ_ProjectDetails:115]PRJ_ApprovedType_s:30:=[PRJ_TypeStudy:121]TYP_StructureType_s:4
				End if 
		End case 
		
End case 
PRJ_UpdateLastAction(Table name:C256(->[PRJ_TypeStudy:121]))