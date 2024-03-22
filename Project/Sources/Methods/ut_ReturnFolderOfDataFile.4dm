//%attributes = {"invisible":true,"executedOnServer":true}
// ----------------------------------------------------
// ut_ReturnFolderOfDataFile
// User name (OS): charlesmiller
// Date and time: 04/24/09, 15:23:33
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2009_04  //Add methods to store and retieve users and groups on server startup and shutdown
	Mods_2020_02  //Remove obsolete commands
End if 
C_TEXT:C284($0; $Folder_txt)
$Folder_txt:=Data file:C490

C_LONGINT:C283($Loop_l)
ARRAY TEXT:C222($FolderParts_atxt; 0)
ut_NewTextToArray($Folder_txt; ->$FolderParts_atxt; Folder separator:K24:12)
$Folder_txt:=""
For ($Loop_l; 1; Size of array:C274($FolderParts_atxt)-1)
	$Folder_txt:=$Folder_txt+$FolderParts_atxt{$Loop_l}+Folder separator:K24:12
	
	
End for 
ARRAY TEXT:C222($Segments_atxt; 0)

$0:=$Folder_txt
//End ut_ReturnFolderOfDataFile