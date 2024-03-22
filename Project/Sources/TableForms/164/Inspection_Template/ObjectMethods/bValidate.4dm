
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 04/09/15, 15:46:11
//----------------------------------------------------
//Method: Object Method: [LSS_Inspection].Inspection_Template.bValidate
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (4/9/15 15:46:13)
	Mods_2015_08_bug
	//Modified by: administrator (8/20/15 14:34:43)
	// Modified by: Costas Manousakis-(Designer)-(9/14/15 13:40:15)
	Mods_2015_09_bug
	//  `Reload images after saving when on images tab
	Mods_2015_12_bug  // Fix bug where deletion of picture records not recorded correctly
	//Modified by: administrator (12/24/15 11:13:41)
	Mods_2016_01_bug  // Fix where UT and DMeter pictures not being saved properly
	//Modified by: administrator (1/21/16 12:42:23)
	
End if 

If (LSS_AllowInspectionEdit_B)
	
	If (LSS_DuplicateRecordError_B | LSS_Error_B)
		CANCEL TRANSACTION:C241
		START TRANSACTION:C239
	Else 
		CONFIRM:C162("Save Inspection Data?"; "Save"; "Cancel")
		If (OK=1)
			C_BOOLEAN:C305($Update_B)
			$Update_B:=False:C215
			
			
			If (Modified record:C314([LSS_Inspection:164]) | ($Update_B) | (LSS_PhotoUpdateSeq_b) | (LSS_UpdateMany_B) | (LSS_UpdateAccessibility_B))
				
				FM_SaveInspection
				If (LSS_InpectionTabs_as{FORM Get current page:C276}="Images") | (LSS_InpectionTabs_as{FORM Get current page:C276}="@Photos@")
					LSS_GetImages  //Reload images when on Images tab
				End if 
				VALIDATE TRANSACTION:C240
				START TRANSACTION:C239
				LSS_UpdateMany_B:=False:C215
				LSS_PhotoUpdateSeq_b:=False:C215
				LSS_UpdateAccessibility_B:=False:C215
				
			End if 
		End if 
	End if 
End if 
//End Object Method: [LSS_Inspection].Inspection_Template.bValidate