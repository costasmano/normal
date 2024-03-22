//%attributes = {"invisible":true}
//Method: ut_ReturnServerExportFolder
//Description
// folder path next to the datafile
// Parameters
// $1  : Folder name
// ----------------------------------------------------
If (False:C215)
	
	//----------------------------------------------------
	//User name (OS): administrator
	//Date and time: 01/05/17, 12:17:36
	//----------------------------------------------------
	Mods_2017_01  //Add code to enable saving of [Preferences] record for server
	//Modified by: administrator (1/5/17 15:16:48)
	// Modified by: (Designer)-(1/12/17 10:51:06)
	Mods_2017_01
	//  `added parameter for the folder name
End if 


C_TEXT:C284($0; $1)
$FolderName_txt:=$1
C_TEXT:C284($PathToDataFile_txt; $PathToPrefFolder_txt; $FolderName_txt)
$PathToDataFile_txt:=Data file:C490
ARRAY TEXT:C222($Parts_atxt; 0)

ut_NewTextToArray($PathToDataFile_txt; ->$Parts_atxt; Folder separator:K24:12)
C_LONGINT:C283($Loop_L)

For ($Loop_l; 1; Size of array:C274($Parts_atxt)-1)
	$PathToPrefFolder_txt:=$PathToPrefFolder_txt+$Parts_atxt{$Loop_L}+Folder separator:K24:12
	
End for 
$PathToPrefFolder_txt:=$PathToPrefFolder_txt+$FolderName_txt
If (Test path name:C476($PathToPrefFolder_txt)=Is a folder:K24:2)
Else 
	CREATE FOLDER:C475($PathToPrefFolder_txt)
End if 
$0:=$PathToPrefFolder_txt
//End ut_ReturnServerExportFolder
