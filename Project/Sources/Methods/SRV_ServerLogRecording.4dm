//%attributes = {"invisible":true}
//Method: SRV_ServerLogRecording
//Description
// Execute tasks to handle server log reocrding tasks
// Meant to be executed on server using "Execute on server"
// Can use system parameter "SRV_LOGLimitation" as a parameter to Circular log limitation
// Parameters
// `$1 : $Task
//  // "START" | "STOP" | "CLEARLOG"
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Nov 21, 2022, 13:07:54
	Mods_2022_11
	// ----------------------------------------------------
	
	C_TEXT:C284(SRV_ServerLogRecording; $1)
	
End if 
//
C_TEXT:C284($task)
If (Count parameters:C259=0)
	$task:=Request:C163("Enter task (START , STOP, CLEARLOG"; "START")
	C_BOOLEAN:C305($runonserver)
	$runonserver:=True:C214
	Case of 
		: ($task="START")
		: ($task="STOP")
		: ($task="CLEARLOG")
		Else 
			$runonserver:=False:C215
	End case 
	If ($runonserver)
		C_LONGINT:C283($pid)
		$pid:=Execute on server:C373(Current method name:C684; 0; Current method name:C684; $task)
		ALERT:C41("Launched process on server")
	Else 
		ALERT:C41("Task "+$task+" not valid!  Must be one of START , STOP, CLEARLOG")
	End if 
	
Else 
	C_TEXT:C284($1)
	$Task:=$1
	
	Case of 
		: ($Task="START")
			SET DATABASE PARAMETER:C642(4D Server log recording:K37:28; 1)
			C_TEXT:C284($limit)
			$limit:=ut_GetSysParameter("SRV_LOGLimitation"; ""; "VALUE")
			If (Num:C11($limit)>0)
				SET DATABASE PARAMETER:C642(Circular log limitation:K37:76; Num:C11($limit))
			End if 
			
		: ($Task="STOP")
			SET DATABASE PARAMETER:C642(4D Server log recording:K37:28; 0)
			
		: ($Task="CLEARLOG")
			ARRAY TEXT:C222($_files; 0)
			C_LONGINT:C283($i)
			DOCUMENT LIST:C474(Get 4D folder:C485(Logs folder:K5:19); $_files; Absolute path:K24:14)
			For ($i; 1; Size of array:C274($_files); 1)
				If ($_files{$i}="@4DRequestsLog_@")
					DELETE DOCUMENT:C159($_files{$i})
				End if 
			End for 
			
	End case 
	
End if 

//End SRV_ServerLogRecording   