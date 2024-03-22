//%attributes = {"invisible":true}
//GP: Get_Description
//Copyright © 1995-1996,  Albert S. Leung, All Rights Reserved.
//This function accesses the description field given the code

C_TEXT:C284($0)  // Command Replaced was o_C_STRING length was 255
C_POINTER:C301($ptrPopUps)
C_POINTER:C301($ptrPopUpCod)
C_POINTER:C301($ptrField)
C_LONGINT:C283($i)

$ptrPopUps:=$1
$ptrPopUpCod:=$2
$ptrField:=$3
$ptrPopUps->:=Find in array:C230($ptrPopUpCod->; $ptrField->)
If ($ptrPopUps-><0)  //Just in case nothing was found in array
	$ptrPopUps->:=0
End if 
$i:=$ptrPopUps->  //Compiler cannot get the type of a pointer. Force it to longint
$0:=$ptrPopUps->{$i}  //Return string with description