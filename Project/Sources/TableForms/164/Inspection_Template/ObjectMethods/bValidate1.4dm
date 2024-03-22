
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
	
	Mods_2015_08_bug  // 
	//Modified by: administrator (8/20/15 12:22:27)
	Mods_2015_12_bug  //Fix bug where accessibility records, ut records, dmeter recdords not updated all the time
	//Modified by: administrator (12/30/15 16:10:34)
	Mods_2017_06_bug  ////Fix error where errors occur and tranaction not cancelled
	//Modified by: Chuck Miller (6/21/17 13:44:29)
	// Modified by: Costas Manousakis-(Designer)-(10/11/17 13:36:05)
	Mods_2017_10
	//  `if user cancels at the Confirm, do not Cancel the entry.
	Mods_2018_11  //Add code so that if only editing damage chewck to mark as complete is not displayed if already approved
	//Modified by: Chuck Miller (11/20/18 14:35:30)
End if 

If (LSS_AllowInspectionEdit_B)
	If (LSS_DuplicateRecordError_B | LSS_Error_B)
		CANCEL TRANSACTION:C241
		
	Else 
		C_BOOLEAN:C305($Update_B)
		
		$Update_B:=False:C215
		CONFIRM:C162("Exit this Inspection and Save?"; "Exit and Save"; "Cancel")
		If (OK=1)
			
			If ((LSS_EditDamageOnly_B) & ([LSS_Inspection:164]LSS_Approved_L:43=BMS Approved))
			Else 
				LSS_CheckandUpdateComplete
			End if 
			LSS_EditDamageOnly_B:=False:C215
			If (Modified record:C314([LSS_Inspection:164]) | ($Update_B) | (LSS_PhotoUpdateSeq_b) | (LSS_UpdateMany_B) | (LSS_UpdateAccessibility_B))
				FM_SaveInspection
				VALIDATE TRANSACTION:C240
				ACCEPT:C269
			Else 
				CANCEL TRANSACTION:C241
				CANCEL:C270
			End if 
			
		End if 
		
		
		//CANCEL TRANSACTION
		//CANCEL
	End if 
	
End if 
//End Object Method: [LSS_Inspection].Inspection_Template.bValidate

