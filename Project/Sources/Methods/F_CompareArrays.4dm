//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/02/06, 15:56:47
	// ----------------------------------------------------
	// Method: F_CompareArrays
	// Description
	// 
	// 
	// Parameters
	// $0 : Boolean = Arrays equal
	// Ptr 1 - Pointer to array 1
	// Ptr 2 - Pointer to array 2
	// ----------------------------------------------------
	
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(2/9/2006 09:16:12)
	Mods_2006_CM03
End if 
C_BOOLEAN:C305($0; $ArraysEq_b)
C_POINTER:C301($1; $2; $arr_ptr1; $arr_ptr2)
$arr_ptr1:=$1
$arr_ptr2:=$2
C_LONGINT:C283($arrType1_L; $arrType2_L; $ArrSize1_L; $ArrSize2_L; $i; $position_l)
$arrType1_L:=Type:C295($arr_ptr1->)
$arrType2_L:=Type:C295($arr_ptr2->)
$ArraysEq_b:=True:C214
If ($arrType1_L=$arrType2_L)
	C_TEXT:C284($text_txt; $SearchType_txt)
	$text_txt:=",14,15,16,17,18,21,22,"  //array types
	$SearchType_txt:=","+String:C10($arrType1_L)+","
	$position_l:=Position:C15($SearchType_txt; $text_txt)
	If ($position_l>0)
		$ArrSize1_L:=Size of array:C274($arr_ptr1->)
		$ArrSize2_L:=Size of array:C274($arr_ptr2->)
		If ($ArrSize1_L=$ArrSize2_L)
			For ($i; 1; $ArrSize1_L)
				If ($arr_ptr2->{$i}#$arr_ptr1->{$i})
					$ArraysEq_b:=False:C215
					$i:=$ArrSize1_L+1
				End if 
			End for 
		Else 
			$ArraysEq_b:=False:C215
		End if 
	Else 
		$ArraysEq_b:=False:C215
	End if 
Else 
	$ArraysEq_b:=False:C215
End if 

$0:=$ArraysEq_b