//%attributes = {"invisible":true}
//Method: SRV_SaveziplogfileToLocal
//Description
// Call on server to zip a set of files in the logs folder matching a pattern,
// and return the zip file.  Then this file is saved in a local folder.
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Nov 25, 2022, 16:29:57
	Mods_2022_11
	// ----------------------------------------------------
	
	// Modified by: Costas Manousakis-(Designer)-(2022-12-16 13:40:09)
	Mods_2022_12_bug
	//  `allow to select the files to be zipped from the list available
End if 
//

C_BLOB:C604($resultBlob)

C_TEXT:C284($logfilespattern)
CONFIRM:C162("Retrieve files based on a pattern or select from list?"; "Pattern"; "SelectfromList")
C_BOOLEAN:C305($canceled_b)

If (OK=1)
	$logfilespattern:=Request:C163("Enter pattern of files to get"; "4DRequestsLog_@")
	$resultBlob:=SRV_RetrieveLogFromServer(New object:C1471("filepattern"; $logfilespattern))
	
Else 
	
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
	If ($pick>0)
		C_OBJECT:C1216($filestoget_o)
		$filestoget_o:=New object:C1471("files"; New collection:C1472)
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274($list_aL))
			$filestoget_o.files.push($filesOnserver.files[($list_aL{$loop_L}-1)])
		End for 
		$resultBlob:=SRV_RetrieveLogFromServer(New object:C1471("filestoget"; $filestoget_o))
	Else 
		$canceled_b:=True:C214
	End if 
	
End if 

Case of 
	: ($canceled_b)
		//canceled when selecting files or no files selected
		
	: (BLOB size:C605($resultBlob)=0)
		//No return - some unknown error
		ALERT:C41("No data returned from method SRV_RetrieveLogFromServer")
	Else 
		C_LONGINT:C283($offset)
		$offset:=0
		C_BOOLEAN:C305($success)
		C_TEXT:C284($message; $zipfilename)
		C_BLOB:C604($zipdata)
		BLOB TO VARIABLE:C533($resultBlob; $success; $offset)
		
		If ($success)
			BLOB TO VARIABLE:C533($resultBlob; $message; $offset)
			BLOB TO VARIABLE:C533($resultBlob; $zipfilename; $offset)
			BLOB TO VARIABLE:C533($resultBlob; $zipdata; $offset)
			ALERT:C41("Success message from server\n"+$message)
			C_TEXT:C284($targetfolder)
			$targetfolder:=Select folder:C670("Choose folder to save zip file")
			If (OK=1)
				BLOB TO DOCUMENT:C526($targetfolder+$zipfilename; $zipdata)
				SHOW ON DISK:C922($targetfolder+$zipfilename)
			End if 
		Else 
			BLOB TO VARIABLE:C533($resultBlob; $message; $offset)
			ALERT:C41("Error retrieving "+$logfilespattern+" files from logs folder of server\n"+$message)
		End if 
		
End case 

//End SRV_SaveziplogfileToLocal   