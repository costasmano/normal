//%attributes = {"shared":true}
//Method: QR_ReturnPhotoType
//Description
// return result of hmFree_GET PICTURE TYPES 
// Parameters
// $0 : $TypesFound_atxt
// $1 : $Picture
// ----------------------------------------------------
If (False:C215)
	
	//----------------------------------------------------
	//User name (OS): administrator
	//Date and time: 10/13/16, 14:42:43
	//----------------------------------------------------
	Mods_2016_10  // 
	//Modified by: administrator (10/13/16 14:42:45)
	
	// Modified by: CM (4/2/20)
	Mods_2020_04
	// changed param 1 from pointer to picture
	// Modified by: Costas Manousakis-(Designer)-(9/15/20 12:07:40)
	Mods_2020_09
	//  `replaced calls to hmfree with call to GetPictureTypes
End if 
ARRAY TEXT:C222($TypesFound_atxt; 0)
C_TEXT:C284($0)
C_PICTURE:C286($1)
C_LONGINT:C283($RecordCount_L)

GetPictureTypes($1; ->$TypesFound_atxt)
If (Size of array:C274($TypesFound_atxt)>0)
	$0:=$TypesFound_atxt{1}
Else 
	$0:=""
End if 
//End QR_ReturnPhotoType