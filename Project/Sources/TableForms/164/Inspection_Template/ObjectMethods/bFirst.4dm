
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 12/02/14, 13:30:43
//----------------------------------------------------
//Method: Object Method: [LSS_Inspection].Inspection_Template.bFirst
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (12/2/14 13:30:44)
	
End if 
If (LSS_EditingInspection_B)
	FM_InspectionInput(On Validate:K2:3)
End if 
LSS_InspectionRow_L:=1
USE NAMED SELECTION:C332("InspectionSet")
GOTO SELECTED RECORD:C245([LSS_Inspection:164]; LSS_InspectionRow_L)
FM_InspectionInput(On Load:K2:1)
//End Object Method: [LSS_Inspection].Inspection_Template.bFirst

