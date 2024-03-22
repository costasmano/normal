//%attributes = {"invisible":true,"publishedSql":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 09/22/10, 15:51:23
//----------------------------------------------------
//Method: ut_SQLCheckExternalTransfer($UsertoCheck_txt;$ClientProcessNametoCheck_txt;$ServerProcessName_txt)

//Description
//
// Parametersƒ
// ----------------------------------------------------
//$0 blob returned data

If (False:C215)
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (9/22/10 15:51:27)
	// Modified by: Charles Miller-(Designer)-(7/6/12 16:55:33)
	Mods_2012_07
	//  `Added READ ONLY (*) at the  start
End if 
READ ONLY:C145(*)

C_TEXT:C284($UsertoCheck_txt; $ClientProcessNametoCheck_txt; $ServerProcessName_txt)
C_BLOB:C604($0; $Return_blb)
SET BLOB SIZE:C606($Return_blb; 0)

$UsertoCheck_txt:="BMSEXternal@"
$ClientProcessNametoCheck_txt:="@Transfer@"
$ServerProcessName_txt:="BMSExternal_Transfer"

C_DATE:C307($LastLogIn_d)

C_LONGINT:C283($Loop_l; $State_l; $ProcessTime_l; $ProcessOrigin_l)
C_LONGINT:C283($ProcesssUniqueID_i)  //Command Replaced was o_C_INTEGER
C_BOOLEAN:C305($ProcessVisible_b; $ClientProcessNameFound_b; $ProcessRunning_b; $SeverProcessRunning_b; $MailPriority_b)
C_TEXT:C284($LastRunTime_txt; $NextRunTime_txt)

$SeverProcessRunning_b:=False:C215

C_TEXT:C284($ProcessName_txt)

$ClientProcessNameFound_b:=False:C215
For ($Loop_l; 1; Count tasks:C335)
	PROCESS PROPERTIES:C336($Loop_l; $ProcessName_txt; $State_l; $ProcessTime_l; $ProcessVisible_b; $ProcesssUniqueID_i; $ProcessOrigin_l)
	If (Position:C15($ClientProcessNametoCheck_txt; $ProcessName_txt)>0)
		$ClientProcessNameFound_b:=True:C214
	End if 
	If (Position:C15($ServerProcessName_txt; $ProcessName_txt)>0)
		$SeverProcessRunning_b:=True:C214
	End if 
	
End for 

$ProcessRunning_b:=False:C215
$LastRunTime_txt:=""
$NextRunTime_txt:=""
SET QUERY DESTINATION:C396(Into current selection:K19:1)

QUERY:C277([ServerProcesses:87]; [ServerProcesses:87]ProcessName_s:1="BMSExternal_Transfer")

Case of 
	: (Records in selection:C76([ServerProcesses:87])=1)
		
		$ProcessRunning_b:=[ServerProcesses:87]ProcessRunning_b:5
		$LastRunTime_txt:=[ServerProcesses:87]LastRunTimeStamp_s:3
		$NextRunTime_txt:=[ServerProcesses:87]NextRunTimeStamp_s:4
		C_DATE:C307($LastRun_d; $NextRun_d)
		C_TIME:C306($LastRun_tm; $NextRun_tm)
		$LastRun_d:=ut_ReturnDateFromTimeStamp($LastRunTime_txt)
		$NextRun_d:=ut_ReturnDateFromTimeStamp($NextRunTime_txt)
		$LastRun_tm:=ut_ReturnTimeFromTimeStamp($LastRunTime_txt)
		$NextRun_tm:=ut_ReturnTimeFromTimeStamp($NextRunTime_txt)
		C_TEXT:C284($Transfer_txt)
		$Transfer_txt:="Check on External Server"+Char:C90(Carriage return:K15:38)+"Data found on External Server for Transfer Process:"+Char:C90(Carriage return:K15:38)
		$Transfer_txt:=$Transfer_txt+Char:C90(Tab:K15:37)+"Last succesfull run finished at : "+String:C10($LastRun_d)+"-"+String:C10($LastRun_tm)+Char:C90(Carriage return:K15:38)
		$Transfer_txt:=$Transfer_txt+Char:C90(Tab:K15:37)+"Next Scheduled  execution at : "+String:C10($NextRun_d)+"-"+String:C10($NextRun_tm)+Char:C90(Carriage return:K15:38)
		$Transfer_txt:=$Transfer_txt+Char:C90(Tab:K15:37)+"Active Flag : "+f_Boolean2String($ProcessRunning_b; "YN")+Char:C90(Carriage return:K15:38)
		$Transfer_txt:=$Transfer_txt+"Current Process status on Server:"+Char:C90(Carriage return:K15:38)
		$Transfer_txt:=$Transfer_txt+Char:C90(Tab:K15:37)+"Actual Transfer Process running : "+f_Boolean2String($SeverProcessRunning_b; "YN")+Char:C90(Carriage return:K15:38)
		GET USER LIST:C609($CurrentUsers_atxt; $UserIds_ar)
		C_LONGINT:C283($Loc_l)
		$Loc_l:=Find in array:C230($CurrentUsers_atxt; "BMSEXternal@")
		
		C_TEXT:C284($UserName_txt; $StartUpMethod_txt; $Password_txt)
		C_LONGINT:C283($NumberofLogins_l)
		C_DATE:C307($LastLogin_d)
		GET USER PROPERTIES:C611($UserIds_ar{$Loc_l}; $UserName_txt; $StartUpMethod_txt; $Password_txt; $NumberofLogins_l; $LastLogin_d)
		$Transfer_txt:=$Transfer_txt+Char:C90(Tab:K15:37)+"Last time user <BMSExternal Server> logged-in  : "+String:C10($LastLogin_d; 7)
		C_DATE:C307($Current_d)
		$Current_d:=Current date:C33(*)
		
		Case of 
			: ($Current_d=$NextRun_d)
				If (Current time:C178(*)<$NextRun_tm)
					$Transfer_txt:="Appears that transfer process is on schedule!"
				Else 
					$Transfer_txt:="ERROR!!!!"+Char:C90(Carriage return:K15:38)+"Transfer process is behind schedule!"+Char:C90(Carriage return:K15:38)
					$MailPriority_b:=True:C214
				End if 
			: ($Current_d>$NextRun_d)
				$Transfer_txt:="ERROR!!!!"+Char:C90(Carriage return:K15:38)+"Transfer process is behind schedule!"
				$Transfer_txt:=$Transfer_txt+Char:C90(Carriage return:K15:38)+"Check Batch PC!! If necessary execute transfer on a Mac!"
				$MailPriority_b:=True:C214
				
			: ($Current_d=Add to date:C393($NextRun_d; 0; 0; -1))
				$Transfer_txt:="Transfer process is scheduled to execute tomorrow!"+Char:C90(Carriage return:K15:38)
				$Transfer_txt:=$Transfer_txt+"This should happen only if transfer was done earlier today!"+Char:C90(Carriage return:K15:38)
				$MailPriority_b:=True:C214
				
			Else 
				$Transfer_txt:="Transfer process is scheduled to execute sometime in the future!"+Char:C90(Carriage return:K15:38)
				$Transfer_txt:=$Transfer_txt+"Check if date and time settings are OK!"+Char:C90(Carriage return:K15:38)
				$MailPriority_b:=True:C214
				
		End case 
		
		ARRAY REAL:C219($UserIds_ar; 0)
		
		If ($ProcessRunning_b)
			If ($SeverProcessRunning_b)
				$Transfer_txt:=$Transfer_txt+"Transfer process is currently in progress!"+Char:C90(Carriage return:K15:38)
				$MailPriority_b:=False:C215
			Else 
				$Transfer_txt:=$Transfer_txt+"!!! External Server Transfer Last finished succesfully on "+$LastRunTime_txt+". External DB says Transfer is in currently in process, but no such process was f"+"ound!"+Char:C90(Carriage return:K15:38)
				$Transfer_txt:=$Transfer_txt+"!!! Will now attempt to re-set the Active Process flag"+Char:C90(Carriage return:K15:38)
				
				If (ut_LoadRecord(->[ServerProcesses:87]; 5))
					
					//process not there.. Should set SRVProcRunning_b to false
					[ServerProcesses:87]ProcessRunning_b:5:=False:C215
					SAVE RECORD:C53([ServerProcesses:87])
					UNLOAD RECORD:C212([ServerProcesses:87])
					$Transfer_txt:=$Transfer_txt+"!!! Active Process flag Reset successfully."+Char:C90(Carriage return:K15:38)
					
				Else 
					$Transfer_txt:=$Transfer_txt+("!!! BMSExternal Transfer record is locked!!! Active Process flag Reset failed!!")+Char:C90(Carriage return:K15:38)
					$MailPriority_b:=True:C214
				End if 
			End if 
		End if 
		
	: (Records in selection:C76([ServerProcesses:87])=0)
		$Transfer_txt:="ERROR !!! Data transfer process record not Found!!!!!"
		$MailPriority_b:=True:C214
		//ut_MessageDia ($errMessage;"Check from External Server";1;1)
	: (Records in selection:C76([ServerProcesses:87])>1)
		$Transfer_txt:=("ERROR !!! More than one Data transfer process records found!!!!!")
		$MailPriority_b:=True:C214
		//ut_MessageDia ($errMessage;"Check from External Server";1;1)
End case 

VARIABLE TO BLOB:C532($Transfer_txt; $Return_blb)

$0:=$Return_blb

//End ut_SQLCheckExternalTransfer

