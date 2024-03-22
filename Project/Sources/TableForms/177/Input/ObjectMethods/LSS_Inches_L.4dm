
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 05/26/15, 16:56:20
//----------------------------------------------------
//Method: Object Method: [LSS_VerticalClearance].Input.LSS_Inches_L
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (5/26/15 16:56:22)
	
End if 
C_LONGINT:C283($Inches_L)
$Inches_L:=([LSS_VerticalClearance:177]LSS_Feet_L:4*12)+[LSS_VerticalClearance:177]LSS_Inches_L:5
[LSS_VerticalClearance:177]LSS_Meters_r:6:=Round:C94(($Inches_L/39.37); 2)
//End Object Method: [LSS_VerticalClearance].Input.LSS_Inches_L

