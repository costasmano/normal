//%attributes = {"invisible":true}
// Method: ut_SaveBlobDataToDoc
// Description
//  Save blob data to a file in Extras folder so it can be loaded in clients at startup
// Parameters
// $1 : $BlobData_x
// $2 : $FileName 
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/21/06, 17:23:56
	// ----------------------------------------------------
	Mods_2006_CM03
	Mods_2010_12  //r002 CJ Miller`12/30/10, 11:22:43      `Change placement of initialize files to Extras folder from either Win4DX or Mac4DX
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
	// Modified by: costasmanousakis-(Designer)-(10/5/11 11:59:24)
	Mods_2011_10
	//  `Change blob compression from fast to compact mode
	// Modified by: Costas Manousakis-(Designer)-(2022-01-11T00:00:00 18:42:52)
	Mods_2022_01
	//  `use Get 4D folder(Database folder) and Folder separator - create Extras folder if it does not exist on server
End if 
C_BLOB:C604($1; $Blob_blb)
C_TEXT:C284($2; $FileName)
$FileName:=$2
C_TEXT:C284($Path_txt)
C_LONGINT:C283($Mac4DX_L; $Win4DX_L)
SET BLOB SIZE:C606($Blob_blb; 0)
$Blob_blb:=$1
COMPRESS BLOB:C534($Blob_blb)
If (Application type:C494=4D Server:K5:6)
	$Path_txt:=Get 4D folder:C485(Database folder:K5:14)
	
	If (Test path name:C476($Path_txt+"Extras")=Is a folder:K24:2)
	Else 
		CREATE FOLDER:C475($Path_txt+"Extras")  //make sure folder exists
		//wait 10 ticks
		DELAY PROCESS:C323(Current process:C322; 10)
	End if 
	BLOB TO DOCUMENT:C526($Path_txt+"Extras"+Folder separator:K24:12+$Filename; $Blob_blb)
	
Else 
	
	$Path_txt:=Get 4D folder:C485(Database folder:K5:14)
	If (Test path name:C476($Path_txt+"Extras")=Is a folder:K24:2)
		BLOB TO DOCUMENT:C526($Path_txt+"Extras"+Folder separator:K24:12+$Filename; $Blob_blb)
	End if 
	C_TIME:C306($Doc)
	ALERT:C41("Save File as <"+$Filename+">")
	SET TEXT TO PASTEBOARD:C523($Filename)
	$Doc:=Create document:C266("")
	If (OK=1)
		$Path_txt:=Document
		CLOSE DOCUMENT:C267($Doc)
		BLOB TO DOCUMENT:C526($Path_txt; $Blob_blb)
	End if 
End if 
SET BLOB SIZE:C606($Blob_blb; 0)