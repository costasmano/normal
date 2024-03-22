//%attributes = {"invisible":true}
//Method: LSS_SortInspReview
//Description
// Sort the insp review screen
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/12/16, 14:15:41
	// ----------------------------------------------------
	//Created : 
	Mods_2016_05
End if 
//
ORDER BY:C49([LSS_Inspection:164]; [LSS_Inventory:165]LSS_Category_s:2; >; [LSS_Inventory:165]LSS_StructureNumber_s:6; >; [LSS_Inspection:164]LSS_InspectionDate_d:4; >)

//End LSS_SortInspReview