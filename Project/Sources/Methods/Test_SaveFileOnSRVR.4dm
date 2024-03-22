//%attributes = {"invisible":true,"executedOnServer":true}
//Method: Test_SaveFileOnSRVR
//Description
// EXECUTE ON SERVER
// Save a file on server in the resources folder
// $0 : 
// $1 : Text : filespec
// $2 : BLOB  : filecontents
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/18/17, 16:44:35
	// ----------------------------------------------------
	//Created : 
	Mods_2017_01
	C_BOOLEAN:C305(Test_SaveFileOnSRVR; $0)
	C_TEXT:C284(Test_SaveFileOnSRVR; $1)
	C_BLOB:C604(Test_SaveFileOnSRVR; $2)
End if 
//
TRACE:C157
C_BOOLEAN:C305($0)
C_TEXT:C284($1)
C_BLOB:C604($2)

C_TEXT:C284($path_txt; $Folder_txt; $Filename_txt)
C_BLOB:C604($file_x)

$path_txt:=$1
$file_x:=$2

C_LONGINT:C283($Compr_L)
BLOB PROPERTIES:C536($file_x; $Compr_L)
If ($Compr_L#Is not compressed:K22:11)
	EXPAND BLOB:C535($file_x)
End if 
$Folder_txt:=GetPath($path_txt)
$Filename_txt:=Replace string:C233($path_txt; $Folder_txt; "")
$Folder_txt:=Get 4D folder:C485(Current resources folder:K5:16)+$Folder_txt

If (Test path name:C476($Folder_txt+$Filename_txt)=Is a document:K24:1)
	BLOB TO DOCUMENT:C526($Folder_txt+$Filename_txt; $file_x)
Else 
	C_TIME:C306($doc_t)
	$doc_t:=Create document:C266($Folder_txt+$Filename_txt)
	CLOSE DOCUMENT:C267($doc_t)
	BLOB TO DOCUMENT:C526($Folder_txt+$Filename_txt; $file_x)
End if 

//End Test_SaveFileOnSRVR