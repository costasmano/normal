//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/25/06, 12:57:40
	// ----------------------------------------------------
	// Method: ut_GetLibraryPicID
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM03
End if 
C_TEXT:C284($1; $PictureName)
C_LONGINT:C283($0; $PictureID; $k)  //Command Replaced was o_C_INTEGER
$PictureID:=0
$PictureName:=$1
ARRAY INTEGER:C220($arr_PicRefs_i; 0)
ARRAY TEXT:C222($arr_PicNames_txt; 0)
PICTURE LIBRARY LIST:C564($arr_PicRefs_i; $arr_PicNames_txt)
$k:=Find in array:C230($arr_PicNames_txt; $PictureName)
If ($k>0)
	$PictureID:=$arr_PicRefs_i{$k}
End if 

$0:=$PictureID