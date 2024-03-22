//%attributes = {"invisible":true}
//GP: POPUPMENUC
//This procedure handles pop up menus relating to coded items
//Note: ptrPopUpCod must always contain the correctd code for ptrPopUp
//$ptrPopUps=$1 the description for the code contained in $ptrPopUpCod
//$ptrPopUpCod=$2 the code for the description in $ptrPopUps
//$ptrField=$3 the Field that initializes the arrays for $ptrPopUps->
// and $ptrPopUpCod
//$FormEvent=$4 (optional) 
If (False:C215)
	//Copyright © 1995-1996,  Albert S. Leung, All Rights Reserved.
	
	// Modified by: Costas Manousakis-(Designer)-(9/20/21 13:38:35)
	Mods_2021_09
	//  `added optional 4th param for form event
End if 

C_POINTER:C301($ptrPopUps; $1)
C_POINTER:C301($ptrPopUpCod; $2)
C_POINTER:C301($ptrField; $3)
C_LONGINT:C283($FormEvent)

C_LONGINT:C283($i)

$ptrPopUps:=$1
$ptrPopUpCod:=$2
$ptrField:=$3
If (Count parameters:C259>3)
	C_LONGINT:C283($4)
	$FormEvent:=$4
Else 
	$FormEvent:=Form event code:C388
End if 
Case of 
	: (($formEvent=On Load:K2:1) | ($ptrPopUps->=0))
		$ptrPopUps->:=Find in array:C230($ptrPopUpCod->; $ptrField->)
		// If ($ptrPopUps-><=0)  `Just in case nothing was found in array
		//  $ptrPopUps->:=1
		// End if 
	: ($formEvent=On Data Change:K2:15)
		$ptrPopUps->:=Find in array:C230($ptrPopUpCod->; $ptrField->)
		If ($ptrPopUps-><=0)  //Just in case nothing was found in array
			$ptrPopUps->:=1
		End if 
	: ($formEvent=On Clicked:K2:4)
		$i:=$ptrPopUps->  //Compiler cannot get the type of a pointer. Force it to longint
		If ($i>0)  //check for valid value
			$ptrField->:=$ptrPopUpCod->{$i}
		End if 
End case 