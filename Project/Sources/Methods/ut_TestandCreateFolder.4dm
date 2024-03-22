//%attributes = {"invisible":true}
//Method: ut_TestandCreateFolder
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 10/24/19, 11:19:52
	// ----------------------------------------------------
	//Created : 
	Mods_2019_10_bug
	Mods_2019_11_bug  //Moved Project retrieve code from development into bug fix 
	//and back as there were a few changes made in testing
	//Modified by: Chuck Miller (11/5/19 13:28:12)
	
End if 
//
C_TEXT:C284($0; $1; $FolderName_txt)
$FolderName_txt:=$1+Folder separator:K24:12

If (Test path name:C476($FolderName_txt)=Is a folder:K24:2)
Else 
	CREATE FOLDER:C475($FolderName_txt)
	
End if 
$0:=$FolderName_txt
//End ut_TestandCreateFolder