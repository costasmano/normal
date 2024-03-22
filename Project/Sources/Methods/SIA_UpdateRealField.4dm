//%attributes = {"invisible":true}
//Method: SIA_UpdateRealField
//Description
// Update a real Field in [Bridge mhd nbis] from data off NBI tape
// Parameters
// $1 : $fld_ptr
// $2 : $TextData
// $3 : $Decimals
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Mar 15, 2023, 17:51:50
	Mods_2023_03
	// ----------------------------------------------------
	
	C_POINTER:C301(SIA_UpdateRealField; $1)
	C_TEXT:C284(SIA_UpdateRealField; $2)
	C_LONGINT:C283(SIA_UpdateRealField; $3)
	
End if 
//
C_POINTER:C301($1)
C_TEXT:C284($2)
C_LONGINT:C283($3)

C_LONGINT:C283($oldv_L; $newV_L)

$newV_L:=Num:C11($2)
$oldv_L:=Trunc:C95($1->; $3)*(10^$3)

If (Abs:C99($newV_L-$oldv_L)>1)  // account for any rounding done during export items49 and 51
	$1->:=$newV_L/(2^$3)
End if 

//End SIA_UpdateRealField   