//%attributes = {"invisible":true}
//Method: ut_LoadPicFromResources
//Description
//  `Load a picture from the Resources folder. Pass the name of the picture file
//  ` including any subfolders

// Parameters
// $0 : PictureLoaded_pic
// $1 : PicFileName_txt 
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/06/12, 10:04:57
	// ----------------------------------------------------
	//Created : 
	Mods_2012_04
End if 
//
C_TEXT:C284($1; $PicFileName_txt)
C_PICTURE:C286($0; $PictureLoaded_pic)
$PictureLoaded_pic:=$PictureLoaded_pic*0
$PicFileName_txt:=$1
C_TEXT:C284($ResourcesFolder_txt)
$ResourcesFolder_txt:=Get 4D folder:C485(Current resources folder:K5:16)
If (Test path name:C476($ResourcesFolder_txt+$PicFileName_txt)=Is a document:K24:1)
	C_BLOB:C604($Fileblob_blb)
	DOCUMENT TO BLOB:C525($ResourcesFolder_txt+$PicFileName_txt; $Fileblob_blb)
	BLOB TO PICTURE:C682($Fileblob_blb; $PictureLoaded_pic)
	SET BLOB SIZE:C606($Fileblob_blb; 0)
End if 

$0:=$PictureLoaded_pic
$PictureLoaded_pic:=$PictureLoaded_pic*0
//End ut_LoadPicFromResources