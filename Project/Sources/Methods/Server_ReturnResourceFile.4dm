//%attributes = {"invisible":true,"executedOnServer":true}
//Method: Server_ReturnResourceFile
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 11/20/18, 16:03:52
	// ----------------------------------------------------
	//Created : 
	Mods_2018_11
End if 
//
C_TEXT:C284($1; $PathToFile_txt; $ResourceFolder_txt)
$PathToFile_txt:=$1
C_BLOB:C604($0; $Blob_blb)
SET BLOB SIZE:C606($Blob_blb; 0)
$ResourceFolder_txt:=Get 4D folder:C485(Current resources folder:K5:16)
If (Position:C15(Folder separator:K24:12; $PathToFile_txt)=1)
	$PathToFile_txt:=Substring:C12($PathToFile_txt; 2)
End if 
If (Test path name:C476($ResourceFolder_txt+$PathToFile_txt)=Is a document:K24:1)
	DOCUMENT TO BLOB:C525($ResourceFolder_txt+$PathToFile_txt; $Blob_blb)
End if 
$0:=$Blob_blb
//End Server_ReturnResourceFile