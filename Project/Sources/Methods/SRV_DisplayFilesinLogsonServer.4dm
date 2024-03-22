//%attributes = {"invisible":true}
//Method: SRV_DisplayFilesinLogsonServer
//Description
// display the list of files in the logs folder on the server
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Nov 25, 2022, 18:09:41
	Mods_2022_11
	// ----------------------------------------------------
	
	// Modified by: Costas Manousakis-(Designer)-(2022-12-16 13:38:12)
	Mods_2022_12_bug
	//  `allow retrieving the list of files selected
End if 
//
C_OBJECT:C1216($filesOnserver)
$filesOnserver:=SRV_GetListOfLogsFromServer
C_OBJECT:C1216($file)
ARRAY TEXT:C222($filenames_atxt; 0)
For each ($file; $filesOnserver.files)
	APPEND TO ARRAY:C911($filenames_atxt; ($file.path+" "+String:C10($file.modificationDate)+" "+String:C10(($file.size)/1024; "###,###,###,###Kb")))
End for each 
C_LONGINT:C283($pick)
ARRAY LONGINT:C221($list_aL; 0)
$pick:=G_PickFromList(->$filenames_atxt; "List of files in logs folder of server"; ->$list_aL)

C_OBJECT:C1216($filestoget_o)
$filestoget_o:=New object:C1471("files"; New collection:C1472)
C_LONGINT:C283($loop_L)
For ($loop_L; 1; Size of array:C274($list_aL))
	$filestoget_o.files.push($filesOnserver.files[($list_aL{$loop_L}-1)])
End for 

//End SRV_DisplayFilesinLogsonServer   