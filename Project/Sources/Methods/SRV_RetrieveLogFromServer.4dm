//%attributes = {"invisible":true,"executedOnServer":true}
//Method: SRV_RetrieveLogFromServer
//Description
// retrieve a selected logfile zipped from server.
// execute on server attribute
// Parameters
// $0 : $Zippedfile_x : blob packed with the status, messages and zipped log file
// $1 : $paramobject : 
//   .filepattern : pattern of log file names - default "4DRequestsLog_@"
//   .filestoget : object with a files collection - see spec for ZIP Create archive
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Nov 25, 2022, 13:42:39
	Mods_2022_11
	// ----------------------------------------------------
	
	
	C_BLOB:C604(SRV_RetrieveLogFromServer; $0)
	C_OBJECT:C1216(SRV_RetrieveLogFromServer; $1)
	
	// Modified by: Costas Manousakis-(Designer)-(2022-12-16 13:41:13)
	Mods_2022_12_bug
	//  `modified to accept an object as the 1st parameter to indicate whether retrieving files based on a pattern
	//  `or from a collection of file objects
End if 
//
C_BLOB:C604($0)
C_TEXT:C284($filepattern_txt)
$filepattern_txt:="4DRequestsLog_@"
C_BOOLEAN:C305($pattern_b)
$pattern_b:=True:C214

C_BLOB:C604($docBlob; $resultBlob)

SET BLOB SIZE:C606($docBlob; 0)
C_OBJECT:C1216($zipStructure; $logsFolder; $file; $destination; $status)
C_BOOLEAN:C305($doZip; $success)
$doZip:=False:C215
$logsFolder:=Folder:C1567(fk logs folder:K87:17)

If (Count parameters:C259>0)
	
	C_OBJECT:C1216($1)
	Case of 
		: (OB Is defined:C1231($1; "filepattern"))
			If ($1.filepattern#"")
				$filepattern_txt:=$1.filepattern
			End if 
			//build the zip structure base on pattern
			$zipStructure:=New object:C1471("files"; New collection:C1472)
			$doZip:=False:C215
			
			C_TEXT:C284($result_txt; $zipfilename)
			For each ($file; $logsFolder.files())
				If ($file.name=$filepattern_txt)
					$zipStructure.files.push($file)
					$doZip:=True:C214
				End if 
			End for each 
			
			
		: (OB Is defined:C1231($1; "filestoget"))
			$zipStructure:=$1.filestoget
			$pattern_b:=False:C215
			$doZip:=True:C214
			
	End case 
	
End if 


If ($doZip)
	$status:=New object:C1471
	
	$zipfilename:="logs_"+Replace string:C233(String:C10(Current date:C33; ISO date GMT:K1:10; Current time:C178); ":"; "_")+".zip"
	$destination:=$logsFolder.file($zipfilename)
	$status:=ZIP Create archive:C1640($zipStructure; $destination)
	If ($status.success)
		$success:=True:C214
		//add the 
		$docBlob:=$destination.getContent()
		$result_txt:="zipped "+String:C10($zipStructure.files.length)+" "+$filepattern_txt+" files"
		VARIABLE TO BLOB:C532($success; $resultBlob)
		VARIABLE TO BLOB:C532($result_txt; $resultBlob; *)
		VARIABLE TO BLOB:C532($zipfilename; $resultBlob; *)
		VARIABLE TO BLOB:C532($docBlob; $resultBlob; *)
	Else 
		$success:=False:C215
		$result_txt:="Unable to create zip for "+String:C10($zipStructure.files.length)+" "+$filepattern_txt+" files"
		VARIABLE TO BLOB:C532($success; $resultBlob)
		VARIABLE TO BLOB:C532($result_txt; $resultBlob; *)
	End if 
	//delete the zip file
	
	If (Test path name:C476($destination.platformPath)=Is a document:K24:1)
		DELETE DOCUMENT:C159($destination.platformPath)
	End if 
	
Else 
	$success:=False:C215
	$result_txt:="No matching "+$filepattern_txt+" files"
	VARIABLE TO BLOB:C532($success; $resultBlob)
	VARIABLE TO BLOB:C532($result_txt; $resultBlob; *)
End if 

$0:=$resultBlob

//End SRV_RetrieveLogFromServer   