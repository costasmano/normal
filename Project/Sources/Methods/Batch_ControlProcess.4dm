//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/04/06, 14:08:03
	// ----------------------------------------------------
	// Method: Batch_ControlProcess
	// Description
	// Copied from ControlClientProcess
	// Execute Client processes in batch mode.
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM04
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v11
End if 

C_TEXT:C284($Year_txt; $Month_txt; $Day_txt; $QueryValue_txt)
C_REAL:C285($DelayTime_r)
C_TEXT:C284($MyName_txt)
$MyName_txt:=Current method name:C684
$DelayTime_r:=60*60*30  //test set to 30 minute
C_TIME:C306($CurrentTime)
C_LONGINT:C283($Minute; $Hour; $DelayMinutes)
C_BOOLEAN:C305($Complete_b)
$Complete_b:=False:C215
READ WRITE:C146([ServerProcesses:87])
QUERY:C277([ServerProcesses:87]; [ServerProcesses:87]ProcessName_s:1=$MyName_txt)
If (Records in selection:C76([ServerProcesses:87])=1)
	If ([ServerProcesses:87]ControlProcessDelay_l:6>0)
		$DelayMinutes:=[ServerProcesses:87]ControlProcessDelay_l:6
	Else 
		[ServerProcesses:87]ControlProcessDelay_l:6:=10
		$DelayMinutes:=[ServerProcesses:87]ControlProcessDelay_l:6
	End if 
	[ServerProcesses:87]ProcessRunning_b:5:=True:C214
	SAVE RECORD:C53([ServerProcesses:87])
	UNLOAD RECORD:C212([ServerProcesses:87])
Else 
	CREATE RECORD:C68([ServerProcesses:87])
	[ServerProcesses:87]ProcessName_s:1:=$MyName_txt
	[ServerProcesses:87]ControlProcessDelay_l:6:=10
	$DelayMinutes:=[ServerProcesses:87]ControlProcessDelay_l:6
	[ServerProcesses:87]NextRunTimeStamp_s:4:="999912319999"
	[ServerProcesses:87]ProcessRunning_b:5:=True:C214
	[ServerProcesses:87]ProcessRunSchedule_s:2:="one time"
	SAVE RECORD:C53([ServerProcesses:87])
	UNLOAD RECORD:C212([ServerProcesses:87])
End if 
REDUCE SELECTION:C351([ServerProcesses:87]; 0)
READ ONLY:C145([ServerProcesses:87])
$DelayTime_r:=60*60*$DelayMinutes
$CurrentTime:=Current time:C178(*)
$Minute:=($CurrentTime\60)%60
C_LONGINT:C283($Minute_left)
$Minute_left:=($Minute%$DelayMinutes)
Case of 
	: (($Minute>0) & ($Minute<$DelayMinutes))
		$Minute_left:=$DelayMinutes-$Minute
	: ($Minute_left>0)
		$Minute_left:=$DelayMinutes-$Minute_left
End case 
DELAY PROCESS:C323(Current process:C322; (60*60*$Minute_left))  //wait to run on the interval...
Repeat 
	$CurrentTime:=Current time:C178
	$Hour:=$CurrentTime\3600
	$Minute:=($CurrentTime\60)%60
	
	QUERY:C277([ServerProcesses:87]; [ServerProcesses:87]ProcessName_s:1=$MyName_txt)
	If (Records in selection:C76([ServerProcesses:87])=1)
		READ WRITE:C146([ServerProcesses:87])
		GOTO SELECTED RECORD:C245([ServerProcesses:87]; 1)
		[ServerProcesses:87]LastRunTimeStamp_s:3:=ut_ReturnTimeStampFromDate(Current date:C33(*); Current time:C178(*))
		SAVE RECORD:C53([ServerProcesses:87])
		UNLOAD RECORD:C212([ServerProcesses:87])
		READ ONLY:C145([ServerProcesses:87])
	End if 
	
	$QueryValue_txt:=ut_ReturnTimeStampFromDate(Current date:C33(*))
	$QueryValue_txt:=Substring:C12($QueryValue_txt; 1; 8)+String:C10($Hour; "00")+String:C10($Minute; "00")
	C_LONGINT:C283($Loop_l; $ProcessID)
	QUERY:C277([ServerProcesses:87]; [ServerProcesses:87]NextRunTimeStamp_s:4<=$QueryValue_txt)
	QUERY SELECTION:C341([ServerProcesses:87]; [ServerProcesses:87]ProcessName_s:1="Batch_@")
	For ($Loop_l; 1; Records in selection:C76([ServerProcesses:87]))
		READ WRITE:C146([ServerProcesses:87])
		GOTO SELECTED RECORD:C245([ServerProcesses:87]; $Loop_l)
		Case of 
			: ([ServerProcesses:87]ProcessRunning_b:5)
			Else 
				$ProcessID:=New process:C317([ServerProcesses:87]ProcessName_s:1; <>LStackSize; [ServerProcesses:87]ProcessName_s:1)
				If ($ProcessID>0)
					[ServerProcesses:87]ProcessRunning_b:5:=True:C214
					SAVE RECORD:C53([ServerProcesses:87])
					UNLOAD RECORD:C212([ServerProcesses:87])
				End if 
		End case 
		UNLOAD RECORD:C212([ServerProcesses:87])
		READ ONLY:C145([ServerProcesses:87])
	End for 
	
	REDUCE SELECTION:C351([ServerProcesses:87]; 0)
	//  $DelayStartTime:=Current time
	DELAY PROCESS:C323(Current process:C322; $DelayTime_r)
	//We get out of Delay when Resume Process is executed in Shutdown method.
	If (<>fQuit)  //Check if the Quit flag has been set...
		$Complete_b:=True:C214
	End if 
	// $DelayEndTime:=Current time
Until ($Complete_b)

//Clear Running flag when quiting.
READ WRITE:C146([ServerProcesses:87])
QUERY:C277([ServerProcesses:87]; [ServerProcesses:87]ProcessName_s:1=$MyName_txt)
If (Records in selection:C76([ServerProcesses:87])=1)
	[ServerProcesses:87]ProcessRunning_b:5:=False:C215
	SAVE RECORD:C53([ServerProcesses:87])
	UNLOAD RECORD:C212([ServerProcesses:87])
End if 
REDUCE SELECTION:C351([ServerProcesses:87]; 0)
READ ONLY:C145([ServerProcesses:87])