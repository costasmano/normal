//%attributes = {"invisible":true}
If (False:C215)
	// ut_SetNextRunTimeStamp 
	//----------------------------------------------------
	// User name (OS): cjmiller
	// Date and time: 09/16/03, 15:48:27
	// ----------------------------------------------------
	// Description
	// This method will set next run time stamp for serverprocess record,
	//whose unique name is passed in
	//This must be called at the end of each method that is to be run as a server 
	//process
	//
	// Parameters
	//$1 (Method name)
	// ----------------------------------------------------
	Mods_2004_CJM02
	Mods_2004_CM01
	// Modified by: costasmanousakis-(Designer)-(5/1/2006 16:45:32)
	Mods_2006_CM04
	Mods_2011_06  // CJ Miller`06/14/11, 10:36:56      ` Type all local variables for v11
End if 

C_TEXT:C284($1; $MethodName_txt)
$MethodName_txt:=$1

C_BOOLEAN:C305($Complete_b)
$Complete_b:=False:C215
READ WRITE:C146([ServerProcesses:87])
QUERY:C277([ServerProcesses:87]; [ServerProcesses:87]ProcessName_s:1=$MethodName_txt)
If (Records in selection:C76([ServerProcesses:87])=1)
	LOAD RECORD:C52([ServerProcesses:87])
	If (Locked:C147([ServerProcesses:87])=True:C214)
		Repeat 
			IDLE:C311
			DELAY PROCESS:C323(Current process:C322; 120)
			LOAD RECORD:C52([ServerProcesses:87])
			
			If (Locked:C147([ServerProcesses:87])=False:C215)
				$Complete_b:=True:C214
			End if 
		Until ($Complete_b=True:C214)
	End if 
	C_DATE:C307($CurrentDate_d)
	$CurrentDate_d:=Current date:C33(*)
	[ServerProcesses:87]LastRunTimeStamp_s:3:=ut_ReturnTimeStampFromDate(Current date:C33(*); Current time:C178(*))
	C_TIME:C306($CurrentTime; $RunTime_t)
	C_DATE:C307($Newdate_d; $CheckDate_d)
	C_LONGINT:C283($Hour; $Minute)
	C_TEXT:C284($Hour_txt; $Minute_txt)
	If ([ServerProcesses:87]NextRunTimeStamp_s:4="")  //never set change to today at 1 am
		[ServerProcesses:87]NextRunTimeStamp_s:4:=ut_ReturnTimeStampFromDate(Current date:C33(*))
	End if 
	$RunTime_t:=ut_ReturnTimeFromTimeStamp([ServerProcesses:87]NextRunTimeStamp_s:4)
	$CheckDate_d:=ut_ReturnDateFromTimeStamp([ServerProcesses:87]NextRunTimeStamp_s:4)
	$Newdate_d:=Current date:C33(*)
	Case of 
		: ([ServerProcesses:87]ProcessRunSchedule_s:2="Daily")
			$CheckDate_d:=$CheckDate_d+1
			Case of 
				: ($Newdate_d=$CheckDate_d)
					If ((($RunTime_t\3600)-(Current time:C178(*)\3600))>2)
						$Newdate_d:=$CheckDate_d
					Else 
						$Newdate_d:=$CheckDate_d+1  //don't run within 2 hours.
					End if 
				: ($Newdate_d>$CheckDate_d)
					If ((($RunTime_t\3600)-(Current time:C178(*)\3600))>2)
						$Newdate_d:=$Newdate_d
					Else 
						$Newdate_d:=$Newdate_d+1  //don't run within 2 hours.
					End if 
				Else 
					$Newdate_d:=$CheckDate_d
			End case 
			[ServerProcesses:87]NextRunTimeStamp_s:4:=ut_ReturnTimeStampFromDate($Newdate_d; $RunTime_t)
		: ([ServerProcesses:87]ProcessRunSchedule_s:2="Weekly")
			$CheckDate_d:=$CheckDate_d+7
			Case of 
				: ($Newdate_d=$CheckDate_d)
					$Newdate_d:=$CheckDate_d+7
				: ($Newdate_d>$CheckDate_d)
					C_LONGINT:C283($numWeeksPassed)
					$numWeeksPassed:=1+(($Newdate_d-$CheckDate_d)\7)
					$Newdate_d:=$CheckDate_d+($numWeeksPassed*7)
				Else 
					$Newdate_d:=$CheckDate_d
			End case 
			[ServerProcesses:87]NextRunTimeStamp_s:4:=ut_ReturnTimeStampFromDate($Newdate_d; $RunTime_t)
		: ([ServerProcesses:87]ProcessRunSchedule_s:2="Monthly")
			$CheckDate_d:=Add to date:C393($CheckDate_d; 0; 1; 0)  //Add one month
			Case of 
				: ($Newdate_d=$CheckDate_d)
					$Newdate_d:=Add to date:C393($CheckDate_d; 0; 1; 0)
				: ($Newdate_d>$CheckDate_d)
					C_LONGINT:C283($numMonthsPassed; $dueMonth; $DoneMonth)
					$dueMonth:=(Year of:C25($CheckDate_d)*12)+Month of:C24($CheckDate_d)
					$DoneMonth:=(Year of:C25($Newdate_d)*12)+Month of:C24($Newdate_d)
					$numMonthsPassed:=($DoneMonth-$dueMonth+1)
					If (Day of:C23($Newdate_d)<Day of:C23($CheckDate_d))
						$numMonthsPassed:=$numMonthsPassed-1
					End if 
					$Newdate_d:=Add to date:C393($CheckDate_d; 0; $numMonthsPassed; 0)
				Else 
					$Newdate_d:=$CheckDate_d
			End case 
			[ServerProcesses:87]NextRunTimeStamp_s:4:=ut_ReturnTimeStampFromDate($Newdate_d; $RunTime_t)
		: ([ServerProcesses:87]ProcessRunSchedule_s:2="Yearly")
			$CheckDate_d:=Add to date:C393($CheckDate_d; 1; 0; 0)  //Add one year
			$Newdate_d:=$CheckDate_d
			[ServerProcesses:87]NextRunTimeStamp_s:4:=ut_ReturnTimeStampFromDate($Newdate_d; $RunTime_t)
		: ([ServerProcesses:87]ProcessRunSchedule_s:2="Hourly")
			$CurrentTime:=Current time:C178
			C_TEXT:C284($TimeStamp_s)  //<--- Added// Command Replaced was o_C_STRING length was 12
			If ($Hour>22)
				$TimeStamp_s:=ut_ReturnTimeStampFromDate(Current date:C33(*)+1)
				[ServerProcesses:87]NextRunTimeStamp_s:4:=Substring:C12($TimeStamp_s; 1; 8)+"0001"  //make it one minute past midnight
			Else 
				$TimeStamp_s:=ut_ReturnTimeStampFromDate(Current date:C33(*))
				$Hour:=$CurrentTime\3600
				$Hour:=$Hour+1
				$Minute:=($CurrentTime\60)%60
				[ServerProcesses:87]NextRunTimeStamp_s:4:=Substring:C12($TimeStamp_s; 1; 8)+String:C10($Hour; "00")+String:C10($Minute; "00")  //make it one minute past midnight"
			End if 
			
		: ([ServerProcesses:87]ProcessRunSchedule_s:2="One Time")
			[ServerProcesses:87]NextRunTimeStamp_s:4:="999912310100"  //make sure it will not run till year 9999
	End case 
	
	[ServerProcesses:87]ProcessRunning_b:5:=False:C215
	SAVE RECORD:C53([ServerProcesses:87])
	UNLOAD RECORD:C212([ServerProcesses:87])
End if 
READ ONLY:C145([ServerProcesses:87])