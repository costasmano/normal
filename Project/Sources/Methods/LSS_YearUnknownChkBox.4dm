//%attributes = {"invisible":true}
//Method: LSS_YearUnknownChkBox
//Description
// handle the Year unknown checkboxes in the inventory form
// Parameters
// $1 : $Checkbox_L
// $2 : $YearField_ptr
// $3 : $YearFieldObjName_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/25/15, 11:52:06
	// ----------------------------------------------------
	//Created : 
	Mods_2015_06
	C_LONGINT:C283(LSS_YearUnknownChkBox; $1)
	C_POINTER:C301(LSS_YearUnknownChkBox; $2)
	C_TEXT:C284(LSS_YearUnknownChkBox; $3)
End if 
//
C_LONGINT:C283($Checkbox_L; $1)
C_POINTER:C301($YearField_ptr; $2)
C_TEXT:C284($YearFieldObjName_txt; $3)
$Checkbox_L:=$1
$YearField_ptr:=$2
$YearFieldObjName_txt:=$3

If ($Checkbox_L=1)
	$YearField_ptr->:="Unknown"
	OBJECT SET ENTERABLE:C238(*; $YearFieldObjName_txt; False:C215)
	OBJECT SET RGB COLORS:C628(*; $YearFieldObjName_txt; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; $YearFieldObjName_txt; <>Color_Not_Editable)
Else 
	$YearField_ptr->:=""
	OBJECT SET ENTERABLE:C238(*; $YearFieldObjName_txt; True:C214)
	OBJECT SET RGB COLORS:C628(*; $YearFieldObjName_txt; Col_paletteToRGB(Abs:C99(<>Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; $YearFieldObjName_txt; <>Color_Editable)
End if 

//End LSS_YearUnknownChkBox