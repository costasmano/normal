
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 04/02/15, 16:43:29
//----------------------------------------------------
//Method: Object Method: [LSS_AccessibilityElement].Input.bNext
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (4/2/15 16:43:30)
	
End if 

FM_Accessibility(On Validate:K2:3)
LSS_SelectedRow_L:=LSS_SelectedRow_L+1
FM_Accessibility(On Load:K2:1)
//End Object Method: [LSS_AccessibilityElement].Input.bNext

