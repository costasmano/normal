//%attributes = {"invisible":true}
//Method: ut_FolderListToFile
//Description
// Get a list of files under a selected folder into a text file - does recursive parsing of subfolders
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/27/19, 16:38:50
	// ----------------------------------------------------
	//Created : 
	Mods_2019_06_bug
End if 
//

ARRAY TEXT:C222($allFiles_atxt; 0)

C_TEXT:C284($Folder_txt)
$Folder_txt:=Select folder:C670("Pick a folder to list files for")

DOCUMENT LIST:C474($Folder_txt; $allFiles_atxt; Recursive parsing:K24:13)

$Folder_txt:=ut_ArrayToText(->$allFiles_atxt; Char:C90(Carriage return:K15:38))

C_TEXT:C284($doc_txt)
$doc_txt:=Select document:C905(""; ".txt"; "Save file list to text file"; File name entry:K24:17; $allFiles_atxt)
TEXT TO DOCUMENT:C1237($allFiles_atxt{1}; $Folder_txt)

//End ut_FolderListToFile