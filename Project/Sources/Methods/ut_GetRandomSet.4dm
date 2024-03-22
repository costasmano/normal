//%attributes = {"invisible":true}
//Method: ut_GetRandomSet
//Description
// Create a random set of elements from an array
// Parameters
// $1 : $SourceArray_ptr
// $2 : $DestArray_ptr
// $3 : $NumElements_L
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/02/17, 17:03:52
	// ----------------------------------------------------
	//Created : 
	Mods_2017_05
	
	C_POINTER:C301(ut_GetRandomSet; $1)
	C_POINTER:C301(ut_GetRandomSet; $2)
	C_LONGINT:C283(ut_GetRandomSet; $3)
	
End if 
//
C_POINTER:C301($1; $SourceArray_ptr)
C_POINTER:C301($2; $DestArray_ptr)
C_LONGINT:C283($3; $NumElements_L)

$SourceArray_ptr:=$1
$DestArray_ptr:=$2
$NumElements_L:=$3

C_LONGINT:C283($SourceSize_L)

$SourceSize_L:=Size of array:C274($SourceArray_ptr->)
//clear out destination array

If (Size of array:C274($DestArray_ptr->)>0)
	CLEAR VARIABLE:C89($DestArray_ptr->)
	//DELETE FROM ARRAY($DestArray_ptr->;1;Size of array($DestArray_ptr->))
Else 
End if 


Case of 
	: ($NumElements_L=0) | ($SourceSize_L=0)
		//reduce dest array to 0
		//DELETE FROM ARRAY($DestArray_ptr->;1;Size of array($DestArray_ptr))
		$NumElements_L:=0
	: ($NumElements_L>=$SourceSize_L)
		$NumElements_L:=$SourceSize_L
	Else 
		
End case 

If ($NumElements_L>0)
	INSERT IN ARRAY:C227($DestArray_ptr->; 1; $NumElements_L)
	ARRAY LONGINT:C221($Indx_aL; $SourceSize_L)
	C_LONGINT:C283($loop_L)
	//load the index array
	For ($loop_L; 1; Size of array:C274($Indx_aL))
		$Indx_aL{$loop_L}:=$loop_L
	End for 
	C_LONGINT:C283($RandomIndx_L)
	//warm up Random
	For ($loop_L; 1; 5000)
		$RandomIndx_L:=Random:C100
	End for 
	For ($loop_L; 1; $NumElements_L)
		$RandomIndx_L:=(((Random:C100+Tickcount:C458)%(Size of array:C274($Indx_aL)))+1)
		$DestArray_ptr->{$loop_L}:=$SourceArray_ptr->{$Indx_aL{$RandomIndx_L}}
		DELETE FROM ARRAY:C228($Indx_aL; $RandomIndx_L; 1)
	End for 
	
End if 

//End ut_GetRandomSet