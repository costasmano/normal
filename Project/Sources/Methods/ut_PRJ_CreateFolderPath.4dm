//%attributes = {"invisible":true}
//Method: ut_PRJ_CreateFolderPath
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 10/24/19, 11:45:11
	// ----------------------------------------------------
	//Created : 
	Mods_2019_10_bug
	Compiler_PRJ
	Mods_2019_11_bug  //Moved Project retrieve code from development into bug fix 
	//and back as there were a few changes made in testing
	//Modified by: Chuck Miller (11/5/19 13:28:12)
End if 
//


C_TEXT:C284($0; $1; $2; $Path_txt; $FolderName_txt; $DBStructureName_txt)

$Path_txt:=ut_TestandCreateFolder(<>MyDocumentsFolder_txt+$1)

GET PROCESS VARIABLE:C371(-1; <>DatabaseStructureName_txt; $DBStructureName_txt)
$DBStructureName_txt:=Replace string:C233($DBStructureName_txt; "."; "_"; 99)
$DBStructureName_txt:=Replace string:C233($DBStructureName_txt; ":"; "_"; 99)
$DBStructureName_txt:=Replace string:C233($DBStructureName_txt; "/"; "_"; 99)
$Path_txt:=ut_TestandCreateFolder($Path_txt+$DBStructureName_txt)

If (Count parameters:C259=2)
	$Path_txt:=ut_TestandCreateFolder($Path_txt+$2)
End if 

$Path_txt:=ut_TestandCreateFolder($Path_txt+String:C10(Year of:C25(Current date:C33)))


$FolderName_txt:=String:C10(Current date:C33; Internal date long:K1:5)
$FolderName_txt:=Substring:C12($FolderName_txt; 1; Position:C15(" "; $FolderName_txt)-1)
$FolderName_txt:=String:C10(Month of:C24(Current date:C33); "00")+"-"+$FolderName_txt
$Path_txt:=ut_TestandCreateFolder($Path_txt+$FolderName_txt)

$0:=$Path_txt
//End ut_PRJ_CreateFolderPath