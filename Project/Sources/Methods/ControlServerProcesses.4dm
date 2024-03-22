//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// ControlServerProcesses
	// User name (OS): cjmiller
	// Date and time: 
	// ----------------------------------------------------
	// Description
	// This method will control starting and running predesignated methods as 
	//Server processes
	//	Create a new server process named ControlServerProcesses
	//In this process
	//Query ServerProcesses table for records whose next run date 
	//and time is less than current run date and time
	//If current date time is greater than Next process run date and time, 
	//start that process
	//If process launch successful set ProcessRunning to true and unload record
	//Else
	//Calculate when next check should occur and delay master process by no more than 
	//Monthly processes should always run on the same day of month as set
	//  `For example a process which is set to monthly and runs on 2/1/04 will next 
	//  `run on 3/1/04 and not 30 or 31 days after
	//  `This is true for weekly and yearly processes as well
	// Parameters
	// None
	// ----------------------------------------------------
	Mods_2004_CM11
	Mods_2004_CM03
	Mods_2004_CM02
	Mods_2004_CJM02
	Mods_2004_CM01
	Mods_2005_CM07
	// Modified by: costasmanousakis-(Designer)-(4/4/2007 16:03:01) 
	Mods_2007_CM07
End if 
//debugging:=True
//TRACE
C_TEXT:C284($Year_txt; $Month_txt; $Day_txt; $QueryValue_txt)
C_REAL:C285($DelayTime_r)

//$DelayTime_r:=60 ticks to second*60 seconds*60 minutes `
//always delay for one hour as we might have something that needs to run hourly
$DelayTime_r:=2*60*60  //test set to 2 minute
C_TIME:C306($CurrentTime)
C_LONGINT:C283($Minute; $Hour)
C_BOOLEAN:C305($Complete_b)
C_BOOLEAN:C305(<>AbortControlSrvProc)
<>AbortControlSrvProc:=False:C215
$Complete_b:=False:C215
READ ONLY:C145([ServerProcesses:87])
QUERY:C277([ServerProcesses:87]; [ServerProcesses:87]ProcessName_s:1="ControlProcessDelay")
If (Records in selection:C76([ServerProcesses:87])=1)
	If ([ServerProcesses:87]ControlProcessDelay_l:6>0)
		$DelayTime_r:=60*60*[ServerProcesses:87]ControlProcessDelay_l:6
	End if 
Else 
	CREATE RECORD:C68([ServerProcesses:87])
	[ServerProcesses:87]ProcessName_s:1:="ControlProcessDelay"
	[ServerProcesses:87]ControlProcessDelay_l:6:=60  //default to one minute
	[ServerProcesses:87]NextRunTimeStamp_s:4:="999912319999"
	$DelayTime_r:=60*60*[ServerProcesses:87]ControlProcessDelay_l:6
	[ServerProcesses:87]ProcessRunning_b:5:=True:C214
	[ServerProcesses:87]ProcessRunSchedule_s:2:="one time"
	SAVE RECORD:C53([ServerProcesses:87])
	UNLOAD RECORD:C212([ServerProcesses:87])
End if 
DELAY PROCESS:C323(Current process:C322; (60*60*1))  //wait one  minute before starting
If (Not:C34(<>AbortControlSrvProc))  //check just in case we were canceled really quick
	Repeat 
		$CurrentTime:=Current time:C178(*)
		$Hour:=$CurrentTime\3600
		$Minute:=($CurrentTime\60)%60
		
		QUERY:C277([ServerProcesses:87]; [ServerProcesses:87]ProcessName_s:1="ControlProcessDelay")
		If (Records in selection:C76([ServerProcesses:87])=1)
			READ WRITE:C146([ServerProcesses:87])
			GOTO SELECTED RECORD:C245([ServerProcesses:87]; 1)
			[ServerProcesses:87]LastRunTimeStamp_s:3:=ut_ReturnTimeStampFromDate(Current date:C33(*); Current time:C178(*))
			SAVE RECORD:C53([ServerProcesses:87])
			UNLOAD RECORD:C212([ServerProcesses:87])
			READ ONLY:C145([ServerProcesses:87])
		End if 
		
		If ($Hour>22)
			$QueryValue_txt:=ut_ReturnTimeStampFromDate(Current date:C33(*)+1)
			$QueryValue_txt:=Substring:C12($QueryValue_txt; 1; 8)+"00"+String:C10($Minute; "00")
		Else 
			$QueryValue_txt:=ut_ReturnTimeStampFromDate(Current date:C33(*))
			$QueryValue_txt:=Substring:C12($QueryValue_txt; 1; 8)+String:C10($Hour; "00")+String:C10($Minute; "00")
		End if 
		C_LONGINT:C283($Loop_l; $ProcessID)
		// $CURRENTTime:=Current time
		QUERY:C277([ServerProcesses:87]; [ServerProcesses:87]NextRunTimeStamp_s:4<=$QueryValue_txt)
		QUERY SELECTION:C341([ServerProcesses:87]; [ServerProcesses:87]ProcessName_s:1="Server@")
		For ($Loop_l; 1; Records in selection:C76([ServerProcesses:87]))
			READ WRITE:C146([ServerProcesses:87])
			GOTO SELECTED RECORD:C245([ServerProcesses:87]; $Loop_l)
			Case of 
				: ([ServerProcesses:87]ProcessRunning_b:5)
					
				Else 
					
					$ProcessID:=New process:C317([ServerProcesses:87]ProcessName_s:1; 0; [ServerProcesses:87]ProcessName_s:1)
					If ($ProcessID>0)
						[ServerProcesses:87]ProcessRunning_b:5:=True:C214
						SAVE RECORD:C53([ServerProcesses:87])
						UNLOAD RECORD:C212([ServerProcesses:87])
						READ ONLY:C145([ServerProcesses:87])
					End if 
			End case 
			UNLOAD RECORD:C212([ServerProcesses:87])
			READ ONLY:C145([ServerProcesses:87])
		End for 
		//  $DelayStartTime:=Current time
		DELAY PROCESS:C323(Current process:C322; $DelayTime_r)
		If (<>AbortControlSrvProc)
			$Complete_b:=True:C214
		End if 
		// $DelayEndTime:=Current time
	Until ($Complete_b)
End if 