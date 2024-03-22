//%attributes = {"invisible":true}
//Method: GetPictureTypes
//Description
// Fill a text array with the picture types found in a picture
// Parameters
// $1 : $Picture
// $2 : $TypeArray_ptr
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/15/20, 10:55:27
	// ----------------------------------------------------
	//Created : 
	Mods_2020_09
	
	C_PICTURE:C286(GetPictureTypes; $1)
	C_POINTER:C301(GetPictureTypes; $2)
	
	// Modified by: Costas Manousakis-(Designer)-(2021-09-27T00:00:00 14:02:55)
	Mods_2021_09
	//  `use GET PICTURE FORMATS instead of hmfree coommands
End if 
//
C_PICTURE:C286($1)
C_POINTER:C301($2)
C_PICTURE:C286($pic_p)
$pic_p:=$1
C_POINTER:C301($typeArray_ptr)
$typeArray_ptr:=$2
ASSERT:C1129(Type:C295($typeArray_ptr->)=Text array:K8:16)
ARRAY TEXT:C222($typeArray_ptr->; 0)

//If (hmFree_IsLicensed >=0)
//Else 
//$loop_L:=hmFree_Register ("rLhAA-YcUAGWAAAAJCAMoBksABRAD+AGtAJbF-+")
//End if 
//hmFree_GET PICTURE TYPES ($1;$types_atxt)
ARRAY TEXT:C222($types_atxt; 0)
GET PICTURE FORMATS:C1406($1; $types_atxt)
COPY ARRAY:C226($types_atxt; $2->)
If (Size of array:C274($types_atxt)=Size of array:C274($2->))
Else 
	
	If (Size of array:C274($types_atxt)>0)
		ARRAY TEXT:C222($typeArray_ptr->; Size of array:C274($types_atxt))
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274($types_atxt))
			$typeArray_ptr->{$loop_L}:=$types_atxt{$loop_L}
		End for 
	End if 
End if 

//End GetPictureTypes