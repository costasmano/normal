
// ----------------------------------------------------
// User name (OS): administrator
// Date and time: 09/23/14, 16:15:20
// ----------------------------------------------------
// Method: Object Method: [LSS_Inventory];"Input".LSS_Print_L
// Description
// 
//
// Parameters
// ----------------------------------------------------
//Get row so we know which one selected

//SET VISIBLE(*;"LSS_Print_L";False)
If (False:C215)
	Mods_2018_05  //Aadd ability to print multiple inspections
	Mods_2018_07  //Add code to print damage inspections
	// Modified by: Costas Manousakis-(Designer)-(4/16/21 17:00:03)
	Mods_2021_WP
	//  `
End if 

If (Records in set:C195("ListboxSet0")<2)
	C_LONGINT:C283($LBCol_L; $LBRow_L)
	LISTBOX GET CELL POSITION:C971(*; "Inspection_LB"; $LBCol_L; $LBRow_L)
	GOTO SELECTED RECORD:C245([LSS_Inspection:164]; $LBRow_L)
	C_TEXT:C284($InspTypeDescription_txt; $AllowedElements_txt)
	LSS_RTRNInspectionData([LSS_Inspection:164]LSS_InspectionTypeId_s:3; ->v_167_002_txt; ->$AllowedElements_txt)
	
	If (Position:C15("Damage"; v_167_002_txt)>0)
		
		Compiler_FieldVariables(Table:C252(->[LSS_Inspection:164]))
		Compiler_FieldVariables(Table:C252(->[LSS_Inventory:165]))
		Compiler_FieldVariables(Table:C252(->[LSS_ElementInspection:163]))
		
		LSS_CreateElementInputArrays($AllowedElements_txt)
		LSS_PrintDamageInspection_WP
		FM_InventoryInput(On Load:K2:1)
	Else 
		LSS_PrintInspection_WP
	End if 
Else 
	COPY NAMED SELECTION:C331([LSS_Inspection:164]; "StartNamedSelection")
	USE SET:C118("ListboxSet0")
	C_LONGINT:C283($Loop_L)
	If (Records in selection:C76([LSS_Inspection:164])>0)
		CREATE SET:C116([LSS_Inspection:164]; "InspReviewSelect")
		LSS_PrintMultipleInspections
		CLEAR SET:C117("InspReviewSelect")
	End if 
	USE NAMED SELECTION:C332("StartNamedSelection")
	CLEAR NAMED SELECTION:C333("StartNamedSelection")
End if 

//SET VISIBLE(*;"LSS_Edit_L";False)
//SET VISIBLE(*;"LSS_Duplicate_L";False)
//SET VISIBLE(*;"LSS_Print_L";False)


