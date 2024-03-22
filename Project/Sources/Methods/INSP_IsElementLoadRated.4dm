//%attributes = {"invisible":true}
//Method: INSP_IsElementLoadRated
//Description
// check if current ElementsSafety record is load rated. 
// the related [ElmtRatingLoads] record must already be loaded 
// fix CallReference #598 
// Parameters
// $0 : $ElementRated_b
// $1 : $RtgFields_ptr : pointer array of rating field pointers from INSP_LoadElmRtgDefs
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/22/19, 13:35:39
	// ----------------------------------------------------
	//Created : 
	Mods_2019_01_bug
	
	C_BOOLEAN:C305(INSP_IsElementLoadRated; $0)
	C_POINTER:C301(INSP_IsElementLoadRated; $1)
End if 
//

C_BOOLEAN:C305($0; $ElementRated_b)
C_POINTER:C301($1; $RtgFields_ptr)

$ElementRated_b:=False:C215
$RtgFields_ptr:=$1
C_LONGINT:C283($numRatingFields_L; $field_L)
$numRatingFields_L:=Size of array:C274($RtgFields_ptr->)

For ($field_L; 1; $numRatingFields_L)
	If (Is record loaded:C669(Table:C252(Table:C252($RtgFields_ptr->{$field_L}))->))
		$ElementRated_b:=$ElementRated_b | ((($RtgFields_ptr->{$field_L})->)>=0)
	End if 
End for 

$0:=$ElementRated_b
//End INSP_IsElementLoadRated