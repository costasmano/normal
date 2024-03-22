//%attributes = {"invisible":true}
//Method: INSP_FitPictToFormObj
//Description
// Fit a picture variable to a Form object. CallReference #600
// Parameters
// $1 : $ObjectName_txt
// $2 : $PicturePointer_ptr
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/23/19, 09:47:46
	// ----------------------------------------------------
	//Created : 
	Mods_2019_01_bug
	
	C_TEXT:C284(INSP_FitPictToFormObj; $1)
	C_POINTER:C301(INSP_FitPictToFormObj; $2)
End if 
//

C_TEXT:C284($ObjectName_txt; $1)
C_POINTER:C301($PicturePointer_ptr; $2)

$ObjectName_txt:=$1
$PicturePointer_ptr:=$2

C_LONGINT:C283($ObjL_L; $ObjT_L; $ObjR_L; $ObjB_L)
OBJECT GET COORDINATES:C663(*; $ObjectName_txt; $ObjL_L; $ObjT_L; $ObjR_L; $ObjB_L)
C_LONGINT:C283($ObjW_L; $ObjH_L)
$ObjW_L:=$ObjR_L-$ObjL_L
C_LONGINT:C283($PicW_L; $PicH_L)
PICTURE PROPERTIES:C457($PicturePointer_ptr->; $PicW_L; $PicH_L)
//scale picture to fit width wise
$PicturePointer_ptr->:=($PicturePointer_ptr->)*($ObjW_L/$PicW_L)

//End INSP_FitPictToFormObj