//%attributes = {"invisible":true}
If (False:C215)
	//BMSExternal_Transfer 
	Mods_2004_CM01
	Mods_OPNToSQLUpgrade  //Ugrade to v11
	//Modified by: Charles Miller (3/18/11 14:41:59)
	// Modified by: Costas Manousakis-(Designer)-(2/12/12 08:20:36)
	Mods_2012_02
	//  `Don't spawn a process for ut_ControlDBSycnh; need to  capture end time at the ut_SetNextRunTimeStamp
	// Modified by: Costas Manousakis-(Designer)-(5/8/12 09:54:06)
	Mods_2012_05
	//  `Added an email at the end. and a semaphore to make sure  two processes dont run on top of each other
	// Modified by: Costas Manousakis-(Designer)-(6/8/12 12:59:49)
	Mods_2012_06
	//  `Use EXECUTE ON SERVER to call ut_SetNextRunTimeStamp to avoid locking of record on client.
	// Modified by: Costas Manousakis-(Designer)-(6/19/12 14:51:58)
	Mods_2012_06
	//  `Added code to record a log the actions during the execution of this method
	// Modified by: Costas Manousakis-(Designer)-(12/4/13 10:23:42)
	Mods_2013_12
	//  `added more tracking of the transfer  to be sent in the email at the end
	// Modified by: Costas Manousakis-(Designer)-(8/17/20 17:51:42)
	Mods_2020_08_bug
	//  `When designer runs this method ask to send email - adjusted the composing of tMailNote
End if 
C_TEXT:C284($pwd)  // Command Replaced was o_C_STRING length was 80
C_LONGINT:C283($msgoutput)  //Command Replaced was o_C_INTEGER
$msgoutput:=3

If (Current user:C182="designer")
	C_TEXT:C284($1)
	$pwd:=$1
	//$pwd:=Request("Enter password for Designer")
Else 
	$pwd:="kaisaras"
End if 

//$Lpid:=LSpawnProcess ("ut_ControlDBSycnh";◊LStackSize;"Data Transfer";True;False;$msgoutput;$pwd)
//$Lpid:=New Process("ut_ControlDBSycnh";◊LStackSize;"Data Transfer";$msgoutput;$pwd)
//NewTellServer ($msgoutput;$pwd)  `messages to screen and file
C_TEXT:C284($CTRLCLIENTLOGS_txt; $CurrLOGFile_txt)
$CTRLCLIENTLOGS_txt:=<>MyDocumentsFolder_txt+"CTRLCLIENTLOGS"+<>PL_DirectorySep_s
If (Test path name:C476($CTRLCLIENTLOGS_txt)=Is a folder:K24:2)
Else 
	CREATE FOLDER:C475($CTRLCLIENTLOGS_txt)
End if 
$CurrLOGFile_txt:=$CTRLCLIENTLOGS_txt+"BMSEXTLOG_"+ut_CreateTimeStamp+".log"
C_TIME:C306($CurrLOGFileRef_t)
$CurrLOGFileRef_t:=Create document:C266($CurrLOGFile_txt; "TEXT")
SEND PACKET:C103($CurrLOGFileRef_t; String:C10(Current date:C33(*))+"_"+String:C10(Current time:C178(*))+" Checking Semaphore...."+Char:C90(13))

While (Semaphore:C143("BMSEXTERNALTRANSFER"))
	SEND PACKET:C103($CurrLOGFileRef_t; String:C10(Current date:C33(*))+"_"+String:C10(Current time:C178(*))+" Waiting 15 min for Semaphore...."+Char:C90(13))
	DELAY PROCESS:C323(Current process:C322; (15*60*60))  //wait 15 minutes
	IDLE:C311
End while 
SEND PACKET:C103($CurrLOGFileRef_t; String:C10(Current date:C33(*))+"_"+String:C10(Current time:C178(*))+" Reserved Semaphore...."+Char:C90(13))

C_TEXT:C284($CurrProcName_txt)
C_TEXT:C284($StartTimeStamp_txt; $ProcName_txt)
C_LONGINT:C283($ProcState_L; $ProdTime_L; $ProcUniqID_L; $ProcOrig_L; $ProcessID)
C_BOOLEAN:C305($procViz_b)
PROCESS PROPERTIES:C336(Current process:C322; $ProcName_txt; $ProcState_L; $ProdTime_L; $procViz_b; $ProcUniqID_L; $ProcOrig_L)

$StartTimeStamp_txt:=ut_CreateTimeStamp
SEND PACKET:C103($CurrLOGFileRef_t; String:C10(Current date:C33(*))+"_"+String:C10(Current time:C178(*))+" Starting ut_ControlDBSycnh ...."+Char:C90(13))

ut_ControlDBSycnh($msgoutput; $pwd)

SEND PACKET:C103($CurrLOGFileRef_t; String:C10(Current date:C33(*))+"_"+String:C10(Current time:C178(*))+" Setting next run time stamp...."+Char:C90(13))
$ProcessID:=Execute on server:C373("ut_SetNextRunTimeStamp"; 0; "Set Next stamp"; $ProcName_txt)
SEND PACKET:C103($CurrLOGFileRef_t; String:C10(Current date:C33(*))+"_"+String:C10(Current time:C178(*))+" Clearing Semaphore...."+Char:C90(13))
CLEAR SEMAPHORE:C144("BMSEXTERNALTRANSFER")

C_BOOLEAN:C305($SendEmail_b)
$SendEmail_b:=True:C214
If (Current user:C182="Designer")
	If (Count parameters:C259=2)
		C_BOOLEAN:C305($2)
		$SendEmail_b:=$2
	Else 
		CONFIRM:C162("Send email notification?"; "Send"; "Newp")
		$SendEmail_b:=(OK=1)
	End if 
End if 

If ($SendEmail_b)
	SEND PACKET:C103($CurrLOGFileRef_t; String:C10(Current date:C33(*))+"_"+String:C10(Current time:C178(*))+" Starting Email...."+Char:C90(13))
	ut_ControlSendMail("INIT")
	SEND PACKET:C103($CurrLOGFileRef_t; String:C10(Current date:C33(*))+"_"+String:C10(Current time:C178(*))+"      Send SMTP "+<>pref_SMTP+"...."+Char:C90(13))
	tFromEmailAddress:=ut_GetSysParameter("EXT_Transf_Rpt_From"; "costas.manousakis@dot.state.ma.us")
	SEND PACKET:C103($CurrLOGFileRef_t; String:C10(Current date:C33(*))+"_"+String:C10(Current time:C178(*))+"      Send from "+tFromEmailAddress+"...."+Char:C90(13))
	tToBuilt_txt:=ut_GetSysParameter("EXT_Transf_Rpt_TO"; "costas.manousakis@dot.state.ma.us")
	SEND PACKET:C103($CurrLOGFileRef_t; String:C10(Current date:C33(*))+"_"+String:C10(Current time:C178(*))+"      Send to "+tToBuilt_txt+"...."+Char:C90(13))
	tSubject:="BMS External Transfer report"
	tMailNote:="BMS External Transfer process name "+$ProcName_txt+", method "+Current method name:C684+Char:C90(13)
	tMailNote:=tMailNote+"Executed on machine "+Current machine:C483+" from account "+Current system user:C484+Char:C90(13)
	tMailNote:=tMailNote+", started at "+ut_formatTimeStamp($StartTimeStamp_txt)+", completed at "+ut_formatTimeStamp(ut_CreateTimeStamp)+Char:C90(13)
	
	tMailNote:=tMailNote+"Start of upload :"+ut_formatTimeStamp(X_StartSend_txt)+Char:C90(13)
	tMailNote:=tMailNote+"Number of records to be sent :"+String:C10(X_NumActLogToBeSent_L)+Char:C90(13)
	tMailNote:=tMailNote+"First RefID :"+String:C10(X_ActLogToBeSentStart_L)+" - Last RefID :"+String:C10(X_ActLogToBeSentEnd_L)+Char:C90(13)
	tMailNote:=tMailNote+"Last RefID Sent :"+String:C10(X_ActLogLastSent_L)+Char:C90(13)
	tMailNote:=tMailNote+"End of upload :"+ut_formatTimeStamp(ut_ReturnTimeStampFromDate(vDUplFinishDate; vTUplFinishTime))+Char:C90(13)
	tMailNote:=tMailNote+"Send Message :"+X_SendError_txt+Char:C90(13)
	
	tMailNote:=tMailNote+"Start of download :"+ut_formatTimeStamp(X_StartRec_txt)+Char:C90(13)
	tMailNote:=tMailNote+"Number of records to be received :"+String:C10(X_NumActLogToBeRecd_L)+Char:C90(13)
	tMailNote:=tMailNote+"First RefID :"+String:C10(X_ActLogToBeRecdStart_L)+" - Last RefID :"+String:C10(X_ActLogToBeRecdEnd_L)+Char:C90(13)
	tMailNote:=tMailNote+"Last RefID received :"+String:C10(X_ActLogLastRecd_L)+Char:C90(13)
	tMailNote:=tMailNote+"End of download :"+ut_formatTimeStamp(X_EndRec_txt)+Char:C90(13)
	tMailNote:=tMailNote+"Receive Message :"+X_RecdError_txt+Char:C90(13)
	
	SEND PACKET:C103($CurrLOGFileRef_t; String:C10(Current date:C33(*))+"_"+String:C10(Current time:C178(*))+"      Sending email ...."+Char:C90(13))
	If (ut_ControlSendMail)
		SEND PACKET:C103($CurrLOGFileRef_t; String:C10(Current date:C33(*))+"_"+String:C10(Current time:C178(*))+"      Email Sent  ...."+Char:C90(13))
	Else 
		SEND PACKET:C103($CurrLOGFileRef_t; String:C10(Current date:C33(*))+"_"+String:C10(Current time:C178(*))+"      Error Sending Email  ...."+Char:C90(13))
	End if 
	
End if 
//
SEND PACKET:C103($CurrLOGFileRef_t; String:C10(Current date:C33(*))+"_"+String:C10(Current time:C178(*))+" Ending...."+Char:C90(13))
CLOSE DOCUMENT:C267($CurrLOGFileRef_t)
//
