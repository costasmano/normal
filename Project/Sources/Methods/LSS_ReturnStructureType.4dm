//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 04/09/15, 13:20:27
//----------------------------------------------------
//Method: LSS_ReturnStructureType
//Description
//
// Parameters
// ----------------------------------------------------
//$1 pointer to field key
//$2 pointer to array to look in
//$3 pointer to array to return description fgor sorting

If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (4/9/15 13:22:18)
	
End if 
C_POINTER:C301($1; $2; $3)

C_TEXT:C284($0)

C_LONGINT:C283($Pos_L)
$Pos_L:=Find in array:C230($2->; $1->)
If ($Pos_L>0)
	$0:=$3->{$Pos_L}
Else 
	$0:=""
	
End if 
//End LSS_ReturnStructureType

