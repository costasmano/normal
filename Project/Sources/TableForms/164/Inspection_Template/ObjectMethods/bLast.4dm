
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 12/02/14, 15:49:08
//----------------------------------------------------
//Method: Object Method: [LSS_Inspection].Inspection_Template.bLast
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (12/2/14 15:49:09)
	
End if 
If (LSS_EditingInspection_B)
	FM_InspectionInput(On Validate:K2:3)
End if 
LSS_InspectionRow_L:=Records in selection:C76([LSS_Inspection:164])
USE NAMED SELECTION:C332("InspectionSet")
GOTO SELECTED RECORD:C245([LSS_Inspection:164]; LSS_InspectionRow_L)
FM_InspectionInput(On Load:K2:1)
//End Object Method: [LSS_Inspection].Inspection_Template.bLast

