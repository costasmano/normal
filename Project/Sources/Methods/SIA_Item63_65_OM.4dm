//%attributes = {"invisible":true}
//Method: SIA_Item63_65_OM
//Description
// Object method for Item 63 and 65
// Parameters
// $1 : $CodeField_Ptr
// $2 : $RatingValueField_ptr
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 2022-03-30, 12:10:22
	// ----------------------------------------------------
	//Created : 
	Mods_2022_03
	
	C_POINTER:C301(SIA_Item63_65_OM; $1)
	C_POINTER:C301(SIA_Item63_65_OM; $2)
	C_POINTER:C301(SIA_Item63_65_OM; $3)
	C_POINTER:C301(SIA_Item63_65_OM; $4)
	C_POINTER:C301(SIA_Item63_65_OM; $5)
	
End if 
//
C_POINTER:C301($1; $2; $3; $4; $5)
C_POINTER:C301($CodeField_Ptr; $RatingValueField_ptr; $descrArr_ptr; $codeArr_ptr; $unittxt_ptr)
$descrArr_ptr:=$1
$codeArr_ptr:=$2
$CodeField_Ptr:=$3
$RatingValueField_ptr:=$4
$unittxt_ptr:=$5

POPUPMENUC($descrArr_ptr; $codeArr_ptr; $CodeField_Ptr)
If (Form event code:C388=On Clicked:K2:4)
	If (Old:C35($CodeField_Ptr->)#$CodeField_Ptr->)
		PushChange(1; $CodeField_Ptr)
	End if 
	If (Position:C15($CodeField_Ptr->; <>SIA_LoadRtg_63_RF_txt)>0)
		//selected rating factor- check if rating field is more than 3.
		If (($RatingValueField_ptr->)>3)
			ALERT:C41("Current value of "+Field name:C257($RatingValueField_ptr)+" is greater than 3.0! Value is changed to 3.0!")
			$RatingValueField_ptr->:=3
			PushChange(1; $RatingValueField_ptr)
		End if 
	End if 
End if 
G_FormatItm6466($CodeField_Ptr; $RatingValueField_ptr; $unittxt_ptr)

//End SIA_Item63_65_OM