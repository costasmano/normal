
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 06/16/15, 11:42:24
//----------------------------------------------------
//Method: Object Method: [LSS_DMeter].Input.bCancel
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (6/16/15 11:42:25)
	
End if 
If (LSS_AllowInspectionEdit_B)
	
	If (Modified record:C314([LSS_DMeter:161]))
		CONFIRM:C162("Exit D Meter without saving?"; "Exit without Saving"; "Stay in Form")
		If (OK=1)
			CANCEL:C270
		End if 
	Else 
		CANCEL:C270
	End if 
Else 
	CANCEL:C270
End if 
//End Object Method: [LSS_DMeter].Input.bCancel

