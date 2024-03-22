//%attributes = {"invisible":true}
//Method: SetSortButton
//Description
// set the value of a sort button
// Parameters
// $1 : $Btn_ptr : pointer to the button variable
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 02/20/20, 15:36:03
	// ----------------------------------------------------
	//Created : 
	Mods_2020_02
	
	C_POINTER:C301(SetSortButton; $1)
End if 
//
C_POINTER:C301($1; $Btn_ptr)
$Btn_ptr:=$1
If (($Btn_ptr->=0) | ($Btn_ptr->=2))
	$Btn_ptr->:=1
Else 
	$Btn_ptr->:=2
End if 
//End SetSortButton