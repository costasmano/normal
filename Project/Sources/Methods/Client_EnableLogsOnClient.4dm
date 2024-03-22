//%attributes = {"invisible":true}
//Method: Client_EnableLogsOnClient
//Description
// Enable Logs on client  - meant to be used by execute on client
// or on startup of client
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Mar 6, 2023, 11:28:23
	Mods_2023_03
	// ----------------------------------------------------
	C_TEXT:C284(Client_EnableLogsOnClient; $1)
	
End if 
//
//SHOW ON DISK(Get 4D folder(Logs folder))
If (Count parameters:C259>0)
	
	C_TEXT:C284($1)
	
	// first stop all log recording
	SET DATABASE PARAMETER:C642(Debug log recording:K37:34; 0)
	SET DATABASE PARAMETER:C642(Client log recording:K37:44; 0)
	SET DATABASE PARAMETER:C642(Diagnostic log recording:K37:69; 0)
	
	// then delete all files in the logs folder of client
	C_OBJECT:C1216($logsFolder; $file)
	$logsFolder:=Folder:C1567(fk logs folder:K87:17)
	ON ERR CALL:C155("4D_Errors")
	C_BOOLEAN:C305(4DError_b)
	
	For each ($file; $logsFolder.files())
		//attempt to delete each file
		4DError_b:=False:C215
		$file.delete()
		
	End for each 
	ON ERR CALL:C155("")
	
End if 

SET DATABASE PARAMETER:C642(Debug log recording:K37:34; 2+4)
SET DATABASE PARAMETER:C642(Client log recording:K37:44; 1)
SET DATABASE PARAMETER:C642(Diagnostic log recording:K37:69; 1)

//End Client_EnableLogsOnClient   