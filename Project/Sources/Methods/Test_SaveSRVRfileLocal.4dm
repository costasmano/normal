//%attributes = {"invisible":true}
//Method: Test_SaveSRVRfileLocal
//Description
// retrieve a resouce file from server and save it locally
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/19/17, 09:54:45
	// ----------------------------------------------------
	//Created : 
	Mods_2017_01
End if 
//

C_TEXT:C284($Filepath_txt; $LocalDest_txt; $Path_txt; $FileName_txt)
C_BLOB:C604($File_x)

$Filepath_txt:=Test_SelectSRVFile

$Path_txt:=GetPath($Filepath_txt)
If ($Path_txt=$Filepath_txt)
	$Path_txt:=""
	$FileName_txt:=$Filepath_txt
Else 
	$FileName_txt:=Replace string:C233($Filepath_txt; $Path_txt; "")
End if 

ALERT:C41("picked file "+$Filepath_txt+" path: ["+$Path_txt+"]  name :"+$FileName_txt)

CONFIRM:C162("Save File locally?"; "Save"; "Cancel")
If (OK=1)
	$file_x:=Test_GetFileFromSRVR($Filepath_txt)
	C_LONGINT:C283($Compressed_L)
	BLOB PROPERTIES:C536($file_x; $Compressed_L)
	If ($Compressed_L#0)
		EXPAND BLOB:C535($file_x)
	End if 
	$Path_txt:=Select folder:C670("Choose where to save file "+$FileName_txt)
	C_TIME:C306($doc_t)
	$doc_t:=Create document:C266($Path_txt+$FileName_txt)
	CLOSE DOCUMENT:C267($doc_t)
	BLOB TO DOCUMENT:C526($Path_txt+$FileName_txt; $file_x)
	SHOW ON DISK:C922($Path_txt+$FileName_txt)
End if 

//End Test_SaveSRVRfileLocal