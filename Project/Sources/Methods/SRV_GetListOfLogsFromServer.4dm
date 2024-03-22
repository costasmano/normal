//%attributes = {"invisible":true,"executedOnServer":true}
//Method: SRV_GetListOfLogsFromServer
//Description
// get the list of files in the logs folder on the server
// Parameters
// $0 : $List_object
//     .files : collection of files
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Nov 25, 2022, 13:48:00
	Mods_2022_11
	// ----------------------------------------------------
	
	C_OBJECT:C1216(SRV_GetListOfLogsFromServer; $0)
End if 
//
C_OBJECT:C1216($0)
C_OBJECT:C1216($FileStructure; $Folder; $file)
$FileStructure:=New object:C1471("files"; New collection:C1472)
$Folder:=Folder:C1567(fk logs folder:K87:17)
For each ($file; $Folder.files())
	$FileStructure.files.push($file)
End for each 

$0:=$FileStructure
//End SRV_GetListOfLogsFromServer   