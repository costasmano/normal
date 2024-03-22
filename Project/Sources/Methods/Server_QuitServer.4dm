//%attributes = {"invisible":true}
// ----------------------------------------------------
//User name (OS): Costas Manousakis
//User (4D) : Designer
//Date and time: 02/22/12, 10:36:27
// ----------------------------------------------------
//Method: Server_QuitServer
//Description
//  ` Method to quit the server.  Meant to be run as part of batch job
// Parameters
// ----------------------------------------------------
If (False:C215)
	//Created : 
	Mods_2012_02
	// Modified by: Costas Manousakis-(Designer)-(4/17/12 )
	Mods_2012_04
	//  `add code so that we skip until after the next scheduled time
	// Modified by: Costas Manousakis-(Designer)-(2023-04-07 16:17:17)
	Mods_2023_04
	//  `Remove IDLE before Delay process
End if 
//
READ ONLY:C145([ServerProcesses:87])
QUERY:C277([ServerProcesses:87]; [ServerProcesses:87]ProcessName_s:1=Current method name:C684)

If (Records in selection:C76([ServerProcesses:87])=1)
	LOAD RECORD:C52([ServerProcesses:87])
	C_TIME:C306($RunTime_t)
	
	If ([ServerProcesses:87]NextRunTimeStamp_s:4#"")
		$RunTime_t:=ut_ReturnTimeFromTimeStamp([ServerProcesses:87]NextRunTimeStamp_s:4)
	End if 
	
	While (Current time:C178(*)<$RunTime_t)
		//find the difference and add 30 seconds for good measure
		C_LONGINT:C283($timeDiff)
		$timeDiff:=$RunTime_t-Current time:C178(*)+30
		//IDLE
		DELAY PROCESS:C323(Current process:C322; ($timeDiff*60))
		
	End while 
	
End if 

ut_SetNextRunTimeStamp(Current method name:C684)  // Run this before quiting.
QUIT 4D:C291(120)  //quit 4D server in 2 minutes
//End Server_QuitServer