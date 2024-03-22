//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/06/06, 09:37:05
	// ----------------------------------------------------
	// Method: ut_CheckServerProcess
	// Description
	// 
	// 
	// Parameters
	// 0 : AlertFlag : Boolean : Processes are out of schedule
	// 1 : MesgPtr : Pointer to a text var to append the result
	// ----------------------------------------------------
	Mods_2006_CMy4
End if 
C_BOOLEAN:C305($0; $AlertFlag_b)
C_POINTER:C301($1; $TxtMsg_ptr)
$TxtMsg_ptr:=$1
READ ONLY:C145([ServerProcesses:87])
QUERY:C277([ServerProcesses:87]; [ServerProcesses:87]ProcessName_s:1="Server_@")
C_LONGINT:C283($numTasks_L; $i)
$numTasks_L:=Records in selection:C76([ServerProcesses:87])
C_TEXT:C284($Results_txt)
$Results_txt:=""
FIRST RECORD:C50([ServerProcesses:87])
C_TEXT:C284($SRVLastRun_s; $SRVNextRun_s; $SRVSchedule_s; $SRVProcName_s)  // Command Replaced was o_C_STRING length was 80
C_BOOLEAN:C305($SRVProcRunning_b; $procFound_b; $AlertFlag_b)
$AlertFlag_b:=False:C215
While (Not:C34(End selection:C36([ServerProcesses:87])))
	$SRVLastRun_s:=[ServerProcesses:87]LastRunTimeStamp_s:3
	$SRVNextRun_s:=[ServerProcesses:87]NextRunTimeStamp_s:4
	$SRVProcRunning_b:=[ServerProcesses:87]ProcessRunning_b:5
	$SRVSchedule_s:=[ServerProcesses:87]ProcessRunSchedule_s:2
	$SRVProcName_s:=[ServerProcesses:87]ProcessName_s:1
	
	$Results_txt:=$Results_txt+"Data for Process "+$SRVProcName_s+" on a "+$SRVSchedule_s+" schedule"+Char:C90(13)
	$Results_txt:=$Results_txt+Char:C90(9)+"Last succesfull run finished at : "+String:C10(ut_ReturnDateFromTimeStamp($SRVLastRun_s))+"-"+String:C10(ut_ReturnTimeFromTimeStamp($SRVLastRun_s))+Char:C90(13)
	$Results_txt:=$Results_txt+Char:C90(9)+"Next Scheduled  execution at : "+String:C10(ut_ReturnDateFromTimeStamp($SRVNextRun_s))+"-"+String:C10(ut_ReturnTimeFromTimeStamp($SRVNextRun_s))+Char:C90(13)
	$Results_txt:=$Results_txt+Char:C90(9)+"Active Flag : "+f_Boolean2String($SRVProcRunning_b; "YN")+Char:C90(13)
	$procFound_b:=(Process number:C372($SRVProcName_s; *)#0)
	$Results_txt:=$Results_txt+"Actual "+$SRVProcName_s+" Process running : "+f_Boolean2String($procFound_b; "YN")+Char:C90(13)
	Case of 
		: ($SRVSchedule_s="Daily")
			Case of 
				: (Current date:C33(*)=ut_ReturnDateFromTimeStamp($SRVNextRun_s))
					If (Current time:C178(*)<ut_ReturnTimeFromTimeStamp($SRVNextRun_s))
						$Results_txt:=$Results_txt+Char:C90(13)+"Appears that "+$SRVProcName_s+" process is on schedule!"+Char:C90(13)
					Else 
						
					End if 
				: (Current date:C33(*)>ut_ReturnDateFromTimeStamp($SRVNextRun_s))
					$Results_txt:=$Results_txt+Char:C90(13)+"ERROR!!!!"+Char:C90(13)+""+$SRVProcName_s+" process is behind schedule!"
					$Results_txt:=$Results_txt+Char:C90(13)+"Check ServerControlProcess! If necessary execute "+$SRVProcName_s+" manually on the server!"
					$AlertFlag_b:=True:C214
				: (Current date:C33(*)=Add to date:C393(ut_ReturnDateFromTimeStamp($SRVNextRun_s); 0; 0; -1))
					If ((ut_ReturnTimeFromTimeStamp($SRVNextRun_s)+Time:C179("24:00:00")-ut_ReturnTimeFromTimeStamp($SRVLastRun_s))>Time:C179("18:00:00"))  //allow up to 6 hr execution time
						$Results_txt:=$Results_txt+Char:C90(13)+"Appears that "+$SRVProcName_s+" process is on schedule!"+Char:C90(13)
					Else 
						$Results_txt:=$Results_txt+Char:C90(13)+""+$SRVProcName_s+" process is scheduled to execute tomorrow!"+Char:C90(13)
						$Results_txt:=$Results_txt+"This should happen only if "+$SRVProcName_s+" was done earlier today!"+Char:C90(13)
					End if 
				Else 
					$Results_txt:=$Results_txt+Char:C90(13)+""+$SRVProcName_s+" process is scheduled to execute sometime in the future!"+Char:C90(13)
					$Results_txt:=$Results_txt+"Check if date and time settings are OK !"+Char:C90(13)
					$AlertFlag_b:=True:C214
			End case 
			
	End case 
	If ($SRVProcRunning_b)
		
		If ($procFound_b)
		Else 
			$Results_txt:=$Results_txt+Char:C90(13)+"!!! "+$SRVProcName_s+" Last finished succesfully on "+$SRVLastRun_s+". DB says process is in currently in process, but no such process was f"+"ound!"+Char:C90(13)
			$Results_txt:=$Results_txt+"!!! Will now attempt to re-set the Active Process flag"+Char:C90(13)
			If (Ok=1)
				
				//process not there.. Should set SRVProcRunning_b to false
				UNLOAD RECORD:C212([ServerProcesses:87])
				READ WRITE:C146([ServerProcesses:87])
				LOAD RECORD:C52([ServerProcesses:87])
				If (Locked:C147([ServerProcesses:87]))
					[ServerProcesses:87]ProcessRunning_b:5:=False:C215
					SAVE RECORD:C53([ServerProcesses:87])
					READ ONLY:C145([ServerProcesses:87])
					$Results_txt:=$Results_txt+"!!! Active Process flag Reset successfully."+Char:C90(13)
				Else 
					$Results_txt:=$Results_txt+("!!! "+$SRVProcName_s+" record is locked!!! Active Process flag Reset failed!!")+Char:C90(13)
					$AlertFlag_b:=True:C214
				End if 
				
			End if 
			
		End if 
		
	End if 
	$Results_txt:=$Results_txt+(20*".-. ")+Char:C90(13)
	NEXT RECORD:C51([ServerProcesses:87])
End while 
$0:=$AlertFlag_b
$Results_txt:=Char:C90(13)+Char:C90(13)+"Checking scheduled Server processes. Check run on "+String:C10(Current time:C178(*))+Char:C90(13)+$Results_txt
$TxtMsg_ptr->:=$TxtMsg_ptr->+$Results_txt
$Results_txt:=""