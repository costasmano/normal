
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 06/16/15, 12:09:59
//----------------------------------------------------
//Method: Object Method: [LSS_UtResult].Input.bCancel
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (6/16/15 12:10:00)
	
End if 
If (LSS_AllowInspectionEdit_B)
	
	If (Modified record:C314([LSS_UtResult:176]))
		CONFIRM:C162("Exit UT Results without saving?"; "Exit without Saving"; "Stay in Form")
		If (OK=1)
			CANCEL:C270
		End if 
	Else 
		CANCEL:C270
	End if 
Else 
	CANCEL:C270
End if 

//End Object Method: [LSS_UtResult].Input.bCancel

