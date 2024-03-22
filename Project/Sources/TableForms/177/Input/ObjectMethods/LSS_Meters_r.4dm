
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 05/26/15, 16:42:15
//----------------------------------------------------
//Method: Object Method: [LSS_VerticalClearance].Input.LSS_Meters_r
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (5/26/15 16:42:17)
	
End if 
C_REAL:C285($Inches_r)

$Inches_r:=Round:C94(([LSS_VerticalClearance:177]LSS_Meters_r:6*39.37); 0)

[LSS_VerticalClearance:177]LSS_Feet_L:4:=$Inches_r\12
[LSS_VerticalClearance:177]LSS_Inches_L:5:=$Inches_r-([LSS_VerticalClearance:177]LSS_Feet_L:4*12)

//End Object Method: [LSS_VerticalClearance].Input.LSS_Meters_r

