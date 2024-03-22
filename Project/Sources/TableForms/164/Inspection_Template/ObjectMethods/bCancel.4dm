
// ----------------------------------------------------
// User name (OS): administrator
// Date and time: 10/14/14, 17:25:20
// ----------------------------------------------------
// Method: Object Method: [LSS_Inspection].Input_ITS.bCancel
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_12_bug  // 
	Mods_2017_06_bug  ////Fix error where errors occur and tranaction not cancelled
	//Modified by: Chuck Miller (6/21/17 13:44:29)
End if 
//Modified by: administrator (12/29/15 10:56:48)

If (LSS_AllowInspectionEdit_B)
	If (LSS_DuplicateRecordError_B | LSS_Error_B)
		CANCEL TRANSACTION:C241
		CANCEL:C270
	Else 
		If (Modified record:C314([LSS_Inspection:164]) | (LSS_PhotoUpdateSeq_b) | (LSS_UpdateMany_B) | (LSS_UpdateAccessibility_B))
			CONFIRM:C162("Exit Inspection without saving?"; "Exit without Saving"; "Stay in Form")
			If (OK=1)
				CANCEL TRANSACTION:C241
				CANCEL:C270
			End if 
		Else 
			CANCEL TRANSACTION:C241
			CANCEL:C270
			
		End if 
	End if 
Else 
	CANCEL:C270
End if 
