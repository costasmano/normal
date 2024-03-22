
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 06/16/15, 11:48:45
//----------------------------------------------------
//Method: Object Method: [LSS_Photos].Input.bCancel
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (6/16/15 11:48:47)
	Mods_2015_08_bug  //change save message to not say photos
	//Modified by: administrator (8/26/15 11:02:47)
	
End if 
If (LSS_AllowInspectionEdit_B)
	
	If (Modified record:C314([LSS_Photos:166]))
		CONFIRM:C162("Exit without saving?"; "Exit without Saving"; "Stay in Form")
		If (OK=1)
			CANCEL:C270
		End if 
	Else 
		CANCEL:C270
	End if 
Else 
	CANCEL:C270
End if 
//End Object Method: [LSS_Photos].Input.bCancel

