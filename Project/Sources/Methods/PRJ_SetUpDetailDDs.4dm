//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_SetUpDetailDDs
// User name (OS): cjmiller
// Date and time: 04/12/07, 10:50:59
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJMv2
End if 
C_POINTER:C301($1; $2; $ArrayPtr; $FieldPtr)
$ArrayPtr:=$1
$FieldPtr:=$2
C_LONGINT:C283($0; $Position_l)

$Position_l:=Find in array:C230($ArrayPtr->; $FieldPtr->)
If ($Position_l<1)
	$Position_l:=1
End if 

$0:=$Position_l

//End PRJ_SetUpDetailDDs