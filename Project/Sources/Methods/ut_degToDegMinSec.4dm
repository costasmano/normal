//%attributes = {"invisible":true}
//Method: ut_degToDegMinSec
//Description
// convert a decimal degree to degrees min decimal seconds
// Parameters
// $1 : $deg_r
// $2 : $Deg_ptr
// $3: $Min_ptr
// $4: $Sec_ptr
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/14/13, 11:20:15
	// ----------------------------------------------------
	//Created : 
	Mods_2013_11
End if 
//
C_REAL:C285($1; $Deg_r)
C_POINTER:C301($2; $3; $4)
C_LONGINT:C283($Deg_L; $Min_L)
C_REAL:C285($Sec_R)
$Deg_r:=$1

$Deg_L:=Trunc:C95($Deg_r; 0)
$Deg_r:=$Deg_r-$Deg_L
$Deg_r:=$Deg_r*60
$Min_L:=Trunc:C95($Deg_r; 0)
$Sec_R:=$Deg_r-$Min_L
$Sec_R:=$Sec_R*60
$Sec_R:=Trunc:C95($Sec_R; 4)

$2->:=$Deg_L
$3->:=$Min_L
$4->:=$Sec_R
//End ut_degToDegMinSec