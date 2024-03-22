//%attributes = {"invisible":true,"executedOnServer":true}
//Method: Server_ProcessStatus
//Description
//This method will run on a schedule on server and send email about server processes. I will exclde itself
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 06/21/22, 13:35:44
	// ----------------------------------------------------
	//Created : 
	Mods_2022_06
	// Modified by: Costas Manousakis-(Designer)-(2022-11-28 16:12:31)
	Mods_2022_11
	//  `use parameters MAIL_BRGSTATFROM and MAIL_TRANSFCHKLIST for email from: and to:
	//  `added machine name in the text.
	
End if 
//
Compiler_MailUtils
Compiler_SQL
ut_ControlSendMail("INIT")

C_DATE:C307($Date_d)
Begin SQL
	select 
	[SQL_Connections].[SQL_LastUpdate_d] 
	from
	[SQL_Connections]
	where [SQL_Connections].[SQL_DatabaseName_s] = 'Tish'
	into
	:$Date_d;
	
End SQL
//QUERY([Parameters];[Parameters]ParamCode="MAIL_BRGSTATFROM")
//tFromEmailAddress:="Manousakis Costas (DOT) <costas.manousakis@dot.state.ma.us>"
//tToBuilt_txt:="costas.manousakis@dot.state.ma.us,Charles Miller <cjmiller@informed-solutions.com"+">"
tFromEmailAddress:=ut_GetSysParameter("MAIL_BRGSTATFROM")
tToBuilt_txt:=ut_GetSysParameter("MAIL_TRANSFCHKLIST")

C_TEXT:C284($Results_txt)
$Results_txt:="TISH UPDATE Last run date was "+String:C10($Date_d; Internal date long:K1:5)+Char:C90(Carriage return:K15:38)
bMailPriority_b:=False:C215
If ((Current date:C33-$Date_d)>1)
	bMailPriority_b:=True:C214
	$Results_txt:=$Results_txt+"ERROR !!!!!! TISH update is behind schedule!!!!!! "+Char:C90(Carriage return:K15:38)
Else 
	$Results_txt:=$Results_txt+"TISH update is on schedule"+Char:C90(Carriage return:K15:38)
End if 
ARRAY TEXT:C222($SQL_LastRunTime_atxt; 0)
ARRAY TEXT:C222($SQL_NextRunTime_atxt; 0)
ARRAY BOOLEAN:C223($SQL_ProcessRunning_ab; 0)
ARRAY TEXT:C222($SQL_RunSchedule_atxt; 0)
ARRAY TEXT:C222($SQL_ProcessName_atxt; 0)
ARRAY TEXT:C222($SQL_ServerProcesses_atxt; 0)
C_TEXT:C284($CurrentMethodName_s)
$CurrentMethodName_s:=Current method name:C684
Begin SQL
	select
	[ServerProcesses].[LastRunTimeStamp_s],
	[ServerProcesses].[NextRunTimeStamp_s],
	[ServerProcesses].[ProcessRunning_b],
	[ServerProcesses].[ProcessRunSchedule_s],
	[ServerProcesses].[ProcessName_s]
	FROM [ServerProcesses]
	where
	[ServerProcesses].[ProcessName_s] <> :$CurrentMethodName_s
	into 
	:$SQL_LastRunTime_atxt,
	:$SQL_NextRunTime_atxt,
	:$SQL_ProcessRunning_ab,
	:$SQL_RunSchedule_atxt,
	:$SQL_ProcessName_atxt;
End SQL
C_BLOB:C604($Process_Blb)
C_LONGINT:C283($Offset_l)


$Process_Blb:=ut_SQLReturnServerProcesses

$Offset_l:=0
BLOB TO VARIABLE:C533($Process_Blb; $SQL_ServerProcesses_atxt; $Offset_l)

$Results_txt:=$Results_txt+Char:C90(Carriage return:K15:38)+Char:C90(Carriage return:K15:38)
C_BOOLEAN:C305($ServerProcessRunning_b)
C_TEXT:C284($onTimeResults_txt; $LateResults_txt)
C_POINTER:C301($PointertoResults_Ptr)
C_LONGINT:C283($Loop_l)
//$LateResults_txt:=+char(Carriage return)
For ($Loop_l; 1; Size of array:C274($SQL_ProcessName_atxt))
	If ($SQL_ProcessName_atxt{$Loop_l}=$CurrentMethodName_s)
	Else 
		If (Position:C15("Server_"; $SQL_ProcessName_atxt{$Loop_l})>0)
			$date_d:=ut_ReturnDateFromTimeStamp($SQL_NextRunTime_atxt{$Loop_l})
			$ServerProcessRunning_b:=(Find in array:C230($SQL_ServerProcesses_atxt; $SQL_ProcessName_atxt{$Loop_l})>0)
			
			If ($date_d<Current date:C33)
				$PointertoResults_Ptr:=->$LateResults_txt
				$PointertoResults_Ptr->:=$PointertoResults_Ptr->+"Server process "+$SQL_ProcessName_atxt{$Loop_l}+" is behind schedule"+Char:C90(Carriage return:K15:38)
			Else 
				$PointertoResults_Ptr:=->$onTimeResults_txt
				$PointertoResults_Ptr->:=$PointertoResults_Ptr->+"Server process "+$SQL_ProcessName_atxt{$Loop_l}+Char:C90(Carriage return:K15:38)
			End if 
			$PointertoResults_Ptr->:=$PointertoResults_Ptr->+Char:C90(Tab:K15:37)+"Actual "+$SQL_ProcessName_atxt{$Loop_l}+" Process running : "+f_Boolean2String($ServerProcessRunning_b; "YN")+Char:C90(Carriage return:K15:38)
			$PointertoResults_Ptr->:=$PointertoResults_Ptr->+Char:C90(Tab:K15:37)+"Last succesfull run finished at : "+String:C10(ut_ReturnDateFromTimeStamp($SQL_LastRunTime_atxt{$Loop_l}))+"-"+String:C10(ut_ReturnTimeFromTimeStamp($SQL_LastRunTime_atxt{$Loop_l}))+Char:C90(Carriage return:K15:38)
			$PointertoResults_Ptr->:=$PointertoResults_Ptr->+Char:C90(Tab:K15:37)+"Next Scheduled  execution at : "+String:C10(ut_ReturnDateFromTimeStamp($SQL_NextRunTime_atxt{$Loop_l}))+"-"+String:C10(ut_ReturnTimeFromTimeStamp($SQL_NextRunTime_atxt{$Loop_l}))+Char:C90(Carriage return:K15:38)
			
			$PointertoResults_Ptr->:=$PointertoResults_Ptr->+Char:C90(Tab:K15:37)+"Data for Process "+$SQL_ProcessName_atxt{$Loop_l}+" on a "+$SQL_RunSchedule_atxt{$Loop_l}+" schedule"+Char:C90(Carriage return:K15:38)
			$PointertoResults_Ptr->:=$PointertoResults_Ptr->+Char:C90(Tab:K15:37)+"Active Flag : "+f_Boolean2String($SQL_ProcessRunning_ab{$Loop_l}; "YN")+Char:C90(Carriage return:K15:38)
			
			Case of 
					
				: (Not:C34($ServerProcessRunning_b) & $SQL_ProcessRunning_ab{$Loop_l})
					$PointertoResults_Ptr->:=$PointertoResults_Ptr->+"!!!  DB says process is currently in process, but no such process was found!"+Char:C90(Carriage return:K15:38)
					bMailPriority_b:=True:C214
				: ($ServerProcessRunning_b & Not:C34($SQL_ProcessRunning_ab{$Loop_l}))
					$PointertoResults_Ptr->:=$PointertoResults_Ptr->+"!!!  Server process is currently runnning, but DB says not running!"+Char:C90(Carriage return:K15:38)
					bMailPriority_b:=True:C214
				Else 
					
			End case 
			$PointertoResults_Ptr->:=$PointertoResults_Ptr->+Char:C90(Carriage return:K15:38)
		End if 
	End if 
End for 
<>SHOWERRORS:=False:C215
If ($LateResults_txt#"")
	$Results_txt:=$Results_txt+"!!!! ERROR The following Server Processes are behind schedule "+Char:C90(Carriage return:K15:38)+$LateResults_txt+Char:C90(Carriage return:K15:38)
End if 
If ($onTimeResults_txt#"")
	$Results_txt:=$Results_txt+"The following Server Processes are on schedule "+Char:C90(Carriage return:K15:38)+$onTimeResults_txt
	
End if 
tMailNote:="Server and Client Process results for:\n"+"Structure : "+Structure file:C489+"\nRunning on IP: "+ut_ReturnServerIP+"\nMachine : "+Current machine:C483+"\n\n"+$Results_txt+Char:C90(Carriage return:K15:38)
tSubject:="Process results for Server"

If (ut_ControlSendMail)
	
End if 
tMailNote:=""

ut_SetNextRunTimeStamp(Current method name:C684)

//End Server_ProcessStatus