//%attributes = {"invisible":true}
//Method: ut_ClearSavedPassword
//Description
//  `Clear the saved password created when "Remember Password" is checked in login dialog
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/12/15, 16:46:18
	// ----------------------------------------------------
	//Created : 
	Mods_2015_11
	
	// Modified by: Costas Manousakis-(Designer)-(8/31/17 16:01:41)
	Mods_2017_08_bug
	//  `comment out line $PathToEngineLink_txt:=$1 - not needed
	// Modified by: Costas Manousakis-(Designer)-(3/27/19 17:41:30)
	Mods_2019_03
	//  `to get Engine link file, need the folder of the application file to get to the .4Dlink file
	
	C_TEXT:C284(ut_ClearSavedPassword; $1)
End if 

C_TEXT:C284($1; $PathToEngineLink_txt; $Attribute_txt; $xml_txt; $elemref_txt)
//$PathToEngineLink_txt:=$1
$PathToEngineLink_txt:=GetPath(Application file:C491)
$PathToEngineLink_txt:=$PathToEngineLink_txt+"DataBase"+Folder separator:K24:12+"EnginedServer.4Dlink"
If (Test path name:C476($PathToEngineLink_txt)=Is a document:K24:1)
	//ALERT("Removing password from  "+$PathToEngineLink_txt)
	
	$xml_txt:=DOM Parse XML source:C719($PathToEngineLink_txt)
	$elemref_txt:=DOM Find XML element:C864($xml_txt; "database_shortcut")
	DOM SET XML ATTRIBUTE:C866($elemref_txt; "md5_password"; "")
	DOM SET XML ATTRIBUTE:C866($elemref_txt; "user_name"; "")
	DOM REMOVE XML ATTRIBUTE:C1084($elemref_txt; "md5_password")
	DOM REMOVE XML ATTRIBUTE:C1084($elemref_txt; "user_name")
	DOM EXPORT TO FILE:C862($xml_txt; $PathToEngineLink_txt)
End if 


C_TEXT:C284($mdpFile_txt)
ARRAY TEXT:C222($Files_atxt; 0)
$mdpFile_txt:=Get 4D folder:C485(Active 4D Folder:K5:10)+"Favorites v"+Substring:C12(Application version:C493; 1; 2)+<>PL_DirectorySep_s+"Remote"+<>PL_DirectorySep_s

DOCUMENT LIST:C474($mdpFile_txt; $Files_atxt)

C_LONGINT:C283($fileIndex_L)
$fileIndex_L:=Find in array:C230($Files_atxt; "@.mdp")
If ($fileIndex_L>0)
	$mdpFile_txt:=$mdpFile_txt+$Files_atxt{$fileIndex_L}
	If (Test path name:C476($mdpFile_txt)=Is a document:K24:1)
		DELETE DOCUMENT:C159($mdpFile_txt)
		If (OK=1)
			ALERT:C41("Stored Password in file "+$mdpFile_txt+" cleared!")
		Else 
			ALERT:C41("Error Deleting Stored Password file "+$mdpFile_txt+"!  You will have to do this manually.")
			SHOW ON DISK:C922($mdpFile_txt)
		End if 
		
	End if 
Else 
	//ALERT("There is no Stored Password file!")
End if 
//End ut_ClearSavedPassword