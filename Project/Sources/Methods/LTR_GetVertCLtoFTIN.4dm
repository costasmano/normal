//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/20/07, 16:34:27
	// ----------------------------------------------------
	// Method: LTR_GetVertCLtoFTIN
	// Description
	// get a length to Feet Inches used in the verification dialog
	// 
	// Parameters
	// $1 : $VertCL_r : Vertical clearance in meters (real)
	// ----------------------------------------------------
	Mods_2007_CM07
End if 
C_REAL:C285($1; $VertCL_r)
$VertCL_r:=$1
C_TEXT:C284(VERTCL_Feet_txt; VERTCL_Inches_txt)
VERTCL_Feet_txt:=F_Meters_to_FTIN($VertCL_r)
VERTCL_Inches_txt:=String:C10(Num:C11(Substring:C12(VERTCL_Feet_txt; (Position:C15("-"; VERTCL_Feet_txt)+1))))
VERTCL_Feet_txt:=Substring:C12(VERTCL_Feet_txt; 1; (Position:C15("'"; VERTCL_Feet_txt)-1))