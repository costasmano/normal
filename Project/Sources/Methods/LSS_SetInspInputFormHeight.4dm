//%attributes = {"invisible":true}
//Method: LSS_SetInspInputFormHeight
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 06/04/19, 13:48:39
	// ----------------------------------------------------
	//Created : 
	Mods_2019_06
End if 
//
C_TEXT:C284($1; $FormName_txt)
$FormName_txt:=$1
C_LONGINT:C283($l; $t; $r; $b; $Width_L; $Height_L; $ScreenHeight_L)
FORM GET PROPERTIES:C674([LSS_Inspection:164]; $FormName_txt; $Width_L; $Height_L)
GET WINDOW RECT:C443($l; $t; $r; $b)

$ScreenHeight_L:=Screen height:C188
If (($ScreenHeight_L-20)<($t+$Height_L+5))
	$Height_L:=$ScreenHeight_L-60
End if 
SET WINDOW RECT:C444($l; $t; $l+$Width_L+5; $t+$Height_L+5)
//End LSS_SetInspInputFormHeight