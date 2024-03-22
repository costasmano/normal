//%attributes = {"invisible":true}
// ControlClientProcess
//Same as ControlServerProcess but geared to execute on client.
//Will look for records in ServerProcess table that start with "BMSExternal"

If (False:C215)
	// ----------------------------------------------------
	// User name (OS): CostasManousakis
	// Date and time: 
	// ----------------------------------------------------
	
	Mods_2004_CM11
	Mods_2004_CM04
	Mods_2004_CM03
	Mods_2004_CM01
	Mods_2011_06  // CJ Miller`06/14/11, 10:42:35      ` Type all local variables for v11
	// Modified by: Costas Manousakis-(Designer)-(5/23/12 16:58:36)
	Mods_2012_05
	//  `Move  READ ONLY([ServerProcesses]) 
	// Modified by: Costas Manousakis-(Designer)-(6/8/12 12:38:44)
	Mods_2012_06
	//  `Use new method ut_MarkAsRunning executed on server to mark the record as running
	// Modified by: Costas Manousakis-(Designer)-(6/19/12 14:51:58)
	Mods_2012_06
	//  `Added code to record a log the actions during the execution of this method
	//  `Make sure we do not launch anything if the quit flag is on; and don't go in the Delay.
	// Modified by: Costas Manousakis-(Designer)-(7/21/20 16:50:44)
	Mods_2020_07_bug
	//  `changed stack size of new processes created to 0 (use default) Call Reference #732, #731
	// Modified by: Costas Manousakis-(Designer)-(7/27/20 17:01:25)
	Mods_2020_07_bug
	//  `changed the Delay process for $DelayTime_r to a For loop by dividing $DelayTime_r by 600 (10 sec)
	//  `one more try to address Call Reference #732, #731
	// Modified by: Costas Manousakis-(Designer)-(8/10/20 19:10:40)
	Mods_2020_08_bug
	//  `added checking for <>ABORTCONTROLCLIENTPROC from StopControlClientProc
	// Modified by: Costas Manousakis-(Designer)-(2023-04-07 14:51:55)
	Mods_2023_04
	//  `Removed IDLE
End if 

C_BOOLEAN:C305(<>ABORTCONTROLCLIENTPROC)
<>ABORTCONTROLCLIENTPROC:=False:C215  // initialize it as false at beginning
C_TEXT:C284($Year_txt; $Month_txt; $Day_txt; $QueryValue_txt)
C_REAL:C285($DelayTime_r)
//$DelayTime_r:=60 ticks to second*60 seconds*60 minutes `
//always delay for one hour as we might have something that needs to run hourly
$DelayTime_r:=60*60*30  //test set to 30 minute
C_TIME:C306($CurrentTime)
C_LONGINT:C283($Minute; $Hour; $DelayMinutes; $Loop_l; $ProcessID)
C_BOOLEAN:C305($Complete_b)
$Complete_b:=False:C215
C_TEXT:C284($CTRLCLIENTLOGS_txt; $CurrLOGFile_txt)
$CTRLCLIENTLOGS_txt:=<>MyDocumentsFolder_txt+"CTRLCLIENTLOGS"+<>PL_DirectorySep_s
If (Test path name:C476($CTRLCLIENTLOGS_txt)=Is a folder:K24:2)
Else 
	CREATE FOLDER:C475($CTRLCLIENTLOGS_txt)
End if 
$CurrLOGFile_txt:=$CTRLCLIENTLOGS_txt+"CTRLCLIENTLOG_"+ut_CreateTimeStamp+".log"
C_TIME:C306($CurrLOGFileRef_t)
$CurrLOGFileRef_t:=Create document:C266($CurrLOGFile_txt; "TEXT")
SEND PACKET:C103($CurrLOGFileRef_t; String:C10(Current date:C33(*))+"_"+String:C10(Current time:C178(*))+" Starting...."+Char:C90(13))

READ WRITE:C146([ServerProcesses:87])
QUERY:C277([ServerProcesses:87]; [ServerProcesses:87]ProcessName_s:1="ControlClientProcess")
If (Records in selection:C76([ServerProcesses:87])=1)
	If ([ServerProcesses:87]ControlProcessDelay_l:6>0)
		$DelayMinutes:=[ServerProcesses:87]ControlProcessDelay_l:6
	Else 
		[ServerProcesses:87]ControlProcessDelay_l:6:=30  //default to one/half hour
		$DelayMinutes:=[ServerProcesses:87]ControlProcessDelay_l:6
	End if 
	[ServerProcesses:87]ProcessRunning_b:5:=True:C214
	SAVE RECORD:C53([ServerProcesses:87])
	UNLOAD RECORD:C212([ServerProcesses:87])
Else 
	CREATE RECORD:C68([ServerProcesses:87])
	[ServerProcesses:87]ProcessName_s:1:="ControlClientProcess"
	[ServerProcesses:87]ControlProcessDelay_l:6:=30  //default to one/half hour
	$DelayMinutes:=[ServerProcesses:87]ControlProcessDelay_l:6
	[ServerProcesses:87]NextRunTimeStamp_s:4:="999912319999"
	[ServerProcesses:87]ProcessRunning_b:5:=True:C214
	[ServerProcesses:87]ProcessRunSchedule_s:2:="one time"
	SAVE RECORD:C53([ServerProcesses:87])
	UNLOAD RECORD:C212([ServerProcesses:87])
End if 
REDUCE SELECTION:C351([ServerProcesses:87]; 0)
READ ONLY:C145([ServerProcesses:87])
SEND PACKET:C103($CurrLOGFileRef_t; String:C10(Current date:C33(*))+"_"+String:C10(Current time:C178(*))+" Delay minutes "+String:C10($DelayMinutes)+" minutes ...."+Char:C90(13))
$DelayTime_r:=60*60*$DelayMinutes
$CurrentTime:=Current time:C178(*)
$Minute:=($CurrentTime\60)%60
SEND PACKET:C103($CurrLOGFileRef_t; String:C10(Current date:C33(*))+"_"+String:C10(Current time:C178(*))+" Current minute "+String:C10($Minute)+" minutes ...."+Char:C90(13))
C_LONGINT:C283($Minute_left)
$Minute_left:=($Minute%$DelayMinutes)
Case of 
	: (($Minute>0) & ($Minute<$DelayMinutes))
		$Minute_left:=$DelayMinutes-$Minute
	: ($Minute_left>0)
		$Minute_left:=$DelayMinutes-$Minute_left
End case 
SEND PACKET:C103($CurrLOGFileRef_t; String:C10(Current date:C33(*))+"_"+String:C10(Current time:C178(*))+" Waiting for "+String:C10($Minute_left)+" minutes ...."+Char:C90(13))
DELAY PROCESS:C323(Current process:C322; (60*60*$Minute_left))  //wait to run on the interval...

If (<>ABORTCONTROLCLIENTPROC)
	SEND PACKET:C103($CurrLOGFileRef_t; String:C10(Current date:C33(*))+"_"+String:C10(Current time:C178(*))+" Canceled before starting ...."+Char:C90(13))
	
Else 
	
	Repeat 
		$CurrentTime:=Current time:C178(*)
		$Hour:=$CurrentTime\3600
		$Minute:=($CurrentTime\60)%60
		SEND PACKET:C103($CurrLOGFileRef_t; String:C10(Current date:C33(*))+"_"+String:C10(Current time:C178(*))+" Starting Loop ...."+Char:C90(13))
		
		READ ONLY:C145([ServerProcesses:87])
		QUERY:C277([ServerProcesses:87]; [ServerProcesses:87]ProcessName_s:1="ControlClientProcess")
		If (Records in selection:C76([ServerProcesses:87])=1)
			READ WRITE:C146([ServerProcesses:87])
			GOTO SELECTED RECORD:C245([ServerProcesses:87]; 1)
			[ServerProcesses:87]LastRunTimeStamp_s:3:=ut_ReturnTimeStampFromDate(Current date:C33(*); Current time:C178(*))
			SAVE RECORD:C53([ServerProcesses:87])
			UNLOAD RECORD:C212([ServerProcesses:87])
			SEND PACKET:C103($CurrLOGFileRef_t; String:C10(Current date:C33(*))+"_"+String:C10(Current time:C178(*))+" Set Last run time ...."+Char:C90(13))
			READ ONLY:C145([ServerProcesses:87])
		End if 
		
		$QueryValue_txt:=ut_ReturnTimeStampFromDate(Current date:C33(*))
		$QueryValue_txt:=Substring:C12($QueryValue_txt; 1; 8)+String:C10($Hour; "00")+String:C10($Minute; "00")
		
		// $CURRENTTime:=Current time
		READ ONLY:C145([ServerProcesses:87])
		QUERY:C277([ServerProcesses:87]; [ServerProcesses:87]NextRunTimeStamp_s:4<=$QueryValue_txt)
		QUERY SELECTION:C341([ServerProcesses:87]; [ServerProcesses:87]ProcessName_s:1="BMSExternal@")
		SEND PACKET:C103($CurrLOGFileRef_t; String:C10(Current date:C33(*))+"_"+String:C10(Current time:C178(*))+" Found "+String:C10(Records in selection:C76([ServerProcesses:87]))+" records ...."+Char:C90(13))
		For ($Loop_l; 1; Records in selection:C76([ServerProcesses:87]))
			GOTO SELECTED RECORD:C245([ServerProcesses:87]; $Loop_l)
			SEND PACKET:C103($CurrLOGFileRef_t; String:C10(Current date:C33(*))+"_"+String:C10(Current time:C178(*))+" Checking recod "+[ServerProcesses:87]ProcessName_s:1+"...."+Char:C90(13))
			Case of 
				: (<>fQuit)
					SEND PACKET:C103($CurrLOGFileRef_t; String:C10(Current date:C33(*))+"_"+String:C10(Current time:C178(*))+"       <>fQuit Flag is on !!! ...."+Char:C90(13))
				: (<>ABORTCONTROLCLIENTPROC)
					SEND PACKET:C103($CurrLOGFileRef_t; String:C10(Current date:C33(*))+"_"+String:C10(Current time:C178(*))+"       <>ABORTCONTROLCLIENTPROC Flag is on !!! ...."+Char:C90(13))
				: ([ServerProcesses:87]ProcessRunning_b:5)
					SEND PACKET:C103($CurrLOGFileRef_t; String:C10(Current date:C33(*))+"_"+String:C10(Current time:C178(*))+"       Already Running ...."+Char:C90(13))
				Else 
					SEND PACKET:C103($CurrLOGFileRef_t; String:C10(Current date:C33(*))+"_"+String:C10(Current time:C178(*))+"       Launching ...."+Char:C90(13))
					
					$ProcessID:=New process:C317([ServerProcesses:87]ProcessName_s:1; 0; [ServerProcesses:87]ProcessName_s:1)
					If ($ProcessID>0)
						SEND PACKET:C103($CurrLOGFileRef_t; String:C10(Current date:C33(*))+"_"+String:C10(Current time:C178(*))+"       Launched process "+String:C10($ProcessID)+" ...."+Char:C90(13))
						$ProcessID:=Execute on server:C373("ut_MarkAsRunning"; 0; "Mark as Running"; [ServerProcesses:87]ProcessName_s:1)
						SEND PACKET:C103($CurrLOGFileRef_t; String:C10(Current date:C33(*))+"_"+String:C10(Current time:C178(*))+"       Launched process to mark running "+String:C10($ProcessID)+" ...."+Char:C90(13))
					Else 
						SEND PACKET:C103($CurrLOGFileRef_t; String:C10(Current date:C33(*))+"_"+String:C10(Current time:C178(*))+"       Could not Launch process "+String:C10(Error)+" ...."+Char:C90(13))
					End if 
			End case 
			UNLOAD RECORD:C212([ServerProcesses:87])
			READ ONLY:C145([ServerProcesses:87])
		End for 
		
		REDUCE SELECTION:C351([ServerProcesses:87]; 0)
		SEND PACKET:C103($CurrLOGFileRef_t; String:C10(Current date:C33(*))+"_"+String:C10(Current time:C178(*))+" End of Loop ...."+Char:C90(13))
		//  $DelayStartTime:=Current time
		If (Not:C34(<>fQuit))
			SEND PACKET:C103($CurrLOGFileRef_t; String:C10(Current date:C33(*))+"_"+String:C10(Current time:C178(*))+" Waiting for "+String:C10($DelayTime_r)+" ticks ...."+Char:C90(13))
			C_LONGINT:C283($loops_L; $loop_L)
			$Loops_l:=$DelayTime_r/600  // split the delay time into 10 second intervala
			If ($loops_L>0)
			Else 
				$loops_L:=1  // do at least one loop
			End if 
			SEND PACKET:C103($CurrLOGFileRef_t; String:C10(Current date:C33(*))+"_"+String:C10(Current time:C178(*))+" Will Loop for "+String:C10($loops_L)+" times at 600 ticks ...."+Char:C90(13))
			
			For ($Loop_l; 1; $loops_L)
				SEND PACKET:C103($CurrLOGFileRef_t; String:C10(Current date:C33(*))+"_"+String:C10(Current time:C178(*))+" Start of delay loop "+String:C10($loop_L)+" ...."+Char:C90(13))
				DELAY PROCESS:C323(Current process:C322; 600)
				
				SEND PACKET:C103($CurrLOGFileRef_t; String:C10(Current date:C33(*))+"_"+String:C10(Current time:C178(*))+" End of delay loop "+String:C10($loop_L)+" ...."+Char:C90(13))
				If (<>fQuit | <>ABORTCONTROLCLIENTPROC)
					$Loop_l:=$loops_L+1  //exit loop if we are quiting
				End if 
				
			End for 
			
		End if 
		//We get out of Delay when Resume Process is executed in Shutdown method.
		If (<>fQuit)  //Check if the Quit flag has been set...
			SEND PACKET:C103($CurrLOGFileRef_t; String:C10(Current date:C33(*))+"_"+String:C10(Current time:C178(*))+" Ready to quit ...."+Char:C90(13))
			$Complete_b:=True:C214
		End if 
		
		If (<>ABORTCONTROLCLIENTPROC)  //Check if the Abort flag has been set...
			SEND PACKET:C103($CurrLOGFileRef_t; String:C10(Current date:C33(*))+"_"+String:C10(Current time:C178(*))+" Abort Flag set ...."+Char:C90(13))
			$Complete_b:=True:C214
		End if 
		
		// $DelayEndTime:=Current time
	Until ($Complete_b)
	
End if 
//Clear Running flag when quiting.
READ WRITE:C146([ServerProcesses:87])
QUERY:C277([ServerProcesses:87]; [ServerProcesses:87]ProcessName_s:1="ControlClientProcess")
If (Records in selection:C76([ServerProcesses:87])=1)
	SEND PACKET:C103($CurrLOGFileRef_t; String:C10(Current date:C33(*))+"_"+String:C10(Current time:C178(*))+" Marking record as not running...."+Char:C90(13))
	[ServerProcesses:87]ProcessRunning_b:5:=False:C215
	SAVE RECORD:C53([ServerProcesses:87])
	UNLOAD RECORD:C212([ServerProcesses:87])
End if 
REDUCE SELECTION:C351([ServerProcesses:87]; 0)
READ ONLY:C145([ServerProcesses:87])
SEND PACKET:C103($CurrLOGFileRef_t; String:C10(Current date:C33(*))+"_"+String:C10(Current time:C178(*))+" Ending...."+Char:C90(13))
CLOSE DOCUMENT:C267($CurrLOGFileRef_t)