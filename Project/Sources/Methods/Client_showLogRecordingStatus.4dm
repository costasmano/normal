//%attributes = {"invisible":true}
//Method: Client_showLogRecordingStatus
//Description
//Show the status of log recording on a client and open the logs folder
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Mar 6, 2023, 12:15:14
	Mods_2023_03
	// ----------------------------------------------------
	
End if 
//

C_TEXT:C284($welcome)
C_LONGINT:C283($dbglogrecording; $clientlogrecording; $diagLogRecording)
$dbglogrecording:=Get database parameter:C643(Debug log recording:K37:34; $welcome)
$clientlogrecording:=Get database parameter:C643(Client log recording:K37:44; $welcome)
$diagLogRecording:=Get database parameter:C643(Diagnostic log recording:K37:69; $welcome)
$welcome:="Debug log setting Value "+String:C10($dbglogrecording)+"\n"+\
"Client log setting Value "+String:C10($clientlogrecording)+"\n"+\
"Diagnostic log setting Value "+String:C10($diagLogRecording)
ALERT:C41($welcome)
C_OBJECT:C1216($logsFolder; $file; $zipstructure; $status; $desktopFolder)
$logsFolder:=Folder:C1567(fk logs folder:K87:17)
$desktopFolder:=Folder:C1567(fk desktop folder:K87:19)
$zipstructure:=New object:C1471("files"; New collection:C1472)
For each ($file; $logsFolder.files())
	If ($file.extension=".txt")
		$zipstructure.files.push($file)
	End if 
End for each 

C_TEXT:C284($zipfilename)
C_OBJECT:C1216($destination)
If ($zipstructure.files.length>0)
	$status:=New object:C1471
	$zipfilename:="Clientlogs_"+Replace string:C233(String:C10(Current date:C33; ISO date GMT:K1:10; Current time:C178); ":"; "_")+".zip"
	$destination:=$desktopFolder.file($zipfilename)
	$status:=ZIP Create archive:C1640($zipStructure; $destination)
	
	If ($status.success)
		SHOW ON DISK:C922($destination.platformPath)
	Else 
		ALERT:C41("There was an error creating a zip file from the files in the Logs folder! Please do it manually")
		SHOW ON DISK:C922(Get 4D folder:C485(Logs folder:K5:19))
	End if 
Else 
	ALERT:C41("There are no log files")
End if 
//End Client_showLogRecordingStatus   