//%attributes = {"invisible":true}
//GP POPUP(»array;»field;default;new_array;»IDarray)
//Copyright © 1995-1996, Thomas D. Nee, All Rights Reserved.
//This is a generic popup procedure for one or two arrays:
//One array is the display text.
//If the second array is passed, it contains the ID's that are tied to the field.
//$1: pointer to the array displayed in the popup.
//$2: pointer to the associated field.
//$3: position of default value.
//$4: indicates whether the array has been newly loaded.
//$5: Optional; pointer to the associated array of ID's.

C_POINTER:C301($ptr_pop_arr; $ptr_field; $ptr_id_arr)
C_LONGINT:C283($DefPos; $ItemNum)
C_BOOLEAN:C305($NewLoad)

//TRACE

$ptr_pop_arr:=$1
$ptr_field:=$2
$DefPos:=$3
$NewLoad:=$4

If (Count parameters:C259=5)
	$ptr_id_arr:=$5  //Set the associated pointer to the optional ID array pointer.
Else   //Should be 4 parameters.
	$ptr_id_arr:=$ptr_pop_arr  //There is only one array; use it.
End if 

Case of 
	: (((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Printing Detail:K2:18) | (Form event code:C388=On Display Detail:K2:22)) | ($NewLoad))
		//TRACE
		$ItemNum:=Find in array:C230($ptr_id_arr->; $ptr_field->)
		If ($ItemNum<=0)
			//Existing field value not found in array.
			If (Num:C11($ptr_pop_arr->{0})>0)
				$ItemNum:=Num:C11($ptr_pop_arr->{0})  //Use the last one chosen.
			Else 
				$ItemNum:=$DefPos  //Use the default value in array.
			End if 
			//Set the field equal to the array choice.
			$ptr_field->:=$ptr_id_arr->{$ItemNum}
		End if 
		$ptr_pop_arr->:=$ItemNum
		$ptr_pop_arr->{0}:=String:C10($ItemNum)
		
	: (Form event code:C388=On Clicked:K2:4)
		//TRACE
		If ($ptr_pop_arr->=0)  //The user didn't choose a value from the popup menu.
			$ptr_pop_arr->:=Num:C11($ptr_pop_arr->{0})  //Use the last one chosen.
			$ItemNum:=$ptr_pop_arr->
		Else   //The user chose a value from the popup menu.
			$ItemNum:=$ptr_pop_arr->
			$ptr_pop_arr->{0}:=String:C10($ItemNum)  //Save this choice as the new default.
		End if 
		$ptr_field->:=$ptr_id_arr->{$ItemNum}  //Set the field equal to the array choice.
End case 