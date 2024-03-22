//%attributes = {"invisible":true}
//Method: dev_mergeCodeAndDesc
//Description
// combine the code with the description Code:Description
// Parameters
// $1 : $PointertoDescription array
// $2 : PointerToCode Array
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/27/17, 16:38:36
	// ----------------------------------------------------
	//Created : 
	Mods_2017_03
	
	C_POINTER:C301(dev_mergeCodeAndDesc; $1)
	C_POINTER:C301(dev_mergeCodeAndDesc; $2)
End if 
//
C_POINTER:C301($1; $2)

C_LONGINT:C283($loop_L)
For ($loop_L; 1; Size of array:C274($1->))
	$1->{$loop_L}:=$2->{$loop_L}+":"+$1->{$loop_L}
End for 

//End dev_mergeCodeAndDesc