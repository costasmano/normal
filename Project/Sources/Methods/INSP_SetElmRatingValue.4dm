//%attributes = {"invisible":true}
//Method: INSP_SetElmRatingValue
//Description
//  ` Set the value of element load ratings
// Parameters
// $1 : $RatingFiledArray_ptr
// $2 : $Value_r

// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/25/14, 09:45:37
	// ----------------------------------------------------
	//Created : 
	Mods_2014_04
End if 
//
C_POINTER:C301($1)
C_REAL:C285($2)

C_POINTER:C301($RatingFiledArray_ptr)
C_REAL:C285($Value_r)

$RatingFiledArray_ptr:=$1
$Value_r:=$2
C_LONGINT:C283($numRatings_L; $ratingLoop_L)
$numRatings_L:=Size of array:C274($RatingFiledArray_ptr->)
For ($ratingLoop_L; 1; $numRatings_L)
	If (Is record loaded:C669(Table:C252(Table:C252($RatingFiledArray_ptr->{$ratingLoop_L}))->))
		$RatingFiledArray_ptr->{$ratingLoop_L}->:=$Value_r
	End if 
End for 

//End INSP_SetValueRatings