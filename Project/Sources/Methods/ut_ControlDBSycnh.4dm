//%attributes = {"invisible":true}
// Method: ut_ControlDBSycnh
// Description
// This method is the SQL replacement for NewTell server method whcih used 4D opeen
//This method controls upload of data from calling db to appropriate server and then download from that server to local db
// Parameters
// ----------------------------------------------------
//$1 integer passed in as a 1, 2 or 3
//when = 1 or 3 display on screen
//when 2 or 3 write log file
//$2 when passed in is the password (This occurs only during automated  processing)
If (False:C215)
	
	// ----------------------------------------------------
	// User name (OS): Charles Miller
	// Date and time: 02/18/10, 12:13:14
	// ----------------------------------------------------
	
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (8/11/10 11:44:04)
	//Ugrade to v11
	//Modified by: Charles Miller (5/10/11 15:18:58)
	//Modify how (Not(4DError_b)) and (Not(SQLError_b)) handled replace with (ut_fTestForSQLor4DError)
	//Modified by: Charles Miller (11/4/11 11:13:35)
	// Modified by: Costas Manousakis-(Designer)-(10/28/13 14:24:19)
	Mods_2013_10
	//  `Don't call SQL_RetrieveNextID for NRC records if the Sequence name is blank - Happens with Railinforecords, Tunnelinfo or other bridge related records
	// Modified by: Costas Manousakis-(Designer)-(12/4/13 10:23:34)
	Mods_2013_12
	//  `Added tracking variables for  the email sent by BMSExternal_transfer
	Mods_2013_12  // Add ability to skip add record errors for certain tables
	//Modified by: Charles Miller (12/19/13 14:07:52)
	
	Mods_2016_01_bug  //   `FIX BUG WHERE [Activity Log] records were being created where they should not have been
	//Modified by: administrator (1/5/16 14:16:58)
	// Modified by: Costas Manousakis-(Designer)-(5/2/16 11:07:19)
	Mods_2016_05_bug
	//  `Add var to keep track of the current Refid of local act log. the RefID at VALIDATE TRANSACTION was not the correct current one.
	// Modified by: Costas Manousakis-(Designer)-(6/8/16 16:32:26)
	Mods_2016_06
	//  `Added current 4D  user and machine name  to the subject of the sent mail
	// Modified by: Charles Miller-(Designer)-(10/13/16 )
	Mods_2016_10
	//  `Added check to verify that we there are no existing FileIDRes entries when sending a NRC activity
	Mods_2019_01  // Move ut_SQLLogout to directly after for loop so it does not wait for user to press enter on fisplayed form
	//Modified by: Chuck Miller (1/29/19 14:47:12)
	// Modified by: Costas Manousakis-(Designer)-(9/17/20 15:33:01)
	Mods_2020_09_bug
	//  `re-arrange SQL_Logout to make sure there is no case where we don't log out.
	// Modified by: Costas Manousakis-(Designer)-(2022-06-27 12:23:51)
	Mods_2022_06
	//  `add call to ACTFIX202206 - needs to run the check before an upload
End if 

//Fix owners of data on remote server when ignoring the LastRefID downloaded
ACTFIX202206

Compiler_forSQL
Compiler_FieldVariables
ut_InitFieldArray
Compiler_TransfLog
Compiler_MailUtils
tMailNote:=""
C_LONGINT:C283($viOnScreen)  //Command Replaced was o_C_INTEGER
$viOnScreen:=3
C_BOOLEAN:C305($AbortDueToDuplicateNRC_B)
$AbortDueToDuplicateNRC_B:=False:C215
AbortDueToLockedRecord_b:=False:C215
If (Count parameters:C259>0)
	C_LONGINT:C283($1)  //Command Replaced was o_C_INTEGER
	$viOnScreen:=$1
	If (Count parameters:C259>1)
		C_TEXT:C284($2)  // Command Replaced was o_C_STRING length was 80
	End if 
End if 

C_BOOLEAN:C305($TransferOk; $vbServConnOK)

C_TEXT:C284($UserName; $Password)  // Command Replaced was o_C_STRING length was 80
C_LONGINT:C283($i; $NumberRecords_l; $Interval; $Lpid; $Error_l; $CurrActLogRefID_L)

//Added to get transfer rate...    
C_DATE:C307($Start_d; $End_d)
C_TIME:C306($Start_tm; $Finish_tm; $Elapsed_tm)
C_LONGINT:C283($vStartMsgCycleNo_L; $InternalNumber_l)
$vStartMsgCycleNo_L:=<>MessageFileCycle_L
SQLError_b:=False:C215
4DError_b:=False:C215
InWHKRUpdate_b:=False:C215
If (Count parameters:C259>=1)
	$viOnScreen:=$1
Else 
	$viOnScreen:=3  //3= on screen msgs only
	<>MessageFileCycle_L:=3  //set msg cycle to 3 for user interactive execution.
End if 
C_DATE:C307(vDUplStartDate; vDUplFinishDate)
C_TIME:C306(vTUplStartTime; vTUplFinishTime; $eTime)

vbOnScreenMessage:=(($viOnScreen=1) | ($viOnScreen=3))
vbToFileMessage:=(($viOnScreen=2) | ($viOnScreen=3))

//Verify Tx Lock
If ((<>LockUserTx) & (<>TxUserName#Current user:C182))
	If (vbOnScreenMessage)
		ALERT:C41("Sorry! You are not authorized to send or receive any data!")
	End if 
	ABORT:C156
End if 
C_LONGINT:C283($viNumWindows)
$viNumWindows:=Size of array:C274(<>asWindows)
If (($viNumWindows>1) & (Current user:C182#"BMSEXternal@"))
	C_TEXT:C284($msg)
	$msg:=""
	For ($i; 1; $viNumWindows)
		If (<>asWindows{$i}#"Splash@")
			$msg:=$msg+<>asWindows{$i}+", "
		End if 
	End for 
	$msg:=Substring:C12($msg; 1; (Length:C16($msg)-2))
	$msg:="You are about to execute a transfer and have "+String:C10($viNumWindows-1)+" windows ("+$msg+") open!"+<>sCR
	$msg:=$msg+"Please make sure all open windows are either closed or at least returned to their"+" original list form! "
	$msg:=$msg+"Then you can click the 'Continue' button on this dialog. "+<>sCR
	$msg:=$msg+"This is to avoid not receiving all information coming from the server."
	G_MyConfirm($msg; "Continue"; "Cancel")
	If (OK#1)
		ABORT:C156
	End if 
	$msg:=""
End if 
$Password:=""
vsPassword:=""
If (Count parameters:C259=2)
	$Password:=$2
End if 
ut_SetMessageDir("DataTransfers")
ut_StartMessage($viOnScreen; "Upload Log"; 600; 300; Regular window:K27:1)
ut_FillIgnoreDupTableNames

$Error_l:=ut_SQLMakeConnnection(Current user:C182; $Password; <>DestIP; Current user:C182+", you are about to transfer data to the remote database.")

$TransferOk:=False:C215
If ($Error_l=1)
	ut_Message("Testing Destination...")
	$Error_l:=ut_TestServerStructureName
End if 
If ($Error_l=1)  //connection made
	
	$Password:=vsPassword
	$Lpid:=LProcessID("$Logoff")  //Is there a logoff checker
	If ($Lpid>0)
		ON EVENT CALL:C190("")  //Turn off the event handler if on
		PAUSE PROCESS:C319($Lpid)
	End if 
	C_LONGINT:C283($RecordCount_l)
	$RecordCount_l:=0
	SET QUERY DESTINATION:C396(Into variable:K19:4; $RecordCount_l)
	QUERY:C277([Activity Log:59]; [Activity Log:59]Status:9=0; *)
	QUERY:C277([Activity Log:59];  & ; [Activity Log:59]Destination:1=<>Destination)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	
	<>vCancel:=False:C215
	vDUplStartDate:=Current date:C33(*)
	vTUplStartTime:=Current time:C178(*)
	$msg:="Upload started at "+String:C10(vDUplStartDate; Internal date short special:K1:4)+" - "+String:C10(vTUplStartTime; HH MM SS:K7:1)+<>sCR
	
	If (vbToFileMessage)
		ut_Message($msg)
	End if 
	
	If ($RecordCount_l>0)
		
		If (Not:C34(SQLError_b))  //connection made
			PLAY:C290("ConEstablished")
			SQLError_b:=False:C215
			4DError_b:=False:C215
			$vbServConnOK:=True:C214
			//Get the number of fields in the activity log file
			
			ActFileID_l:=Table:C252(->[Activity Log:59])
			OwnerFileID_l:=Table:C252(->[Owners of Data:62])
			
			//Get the profile of the Owers of Data file
			OwnerRef_l:=Field:C253(->[Owners of Data:62]RefID:1)
			OwnerName_l:=Field:C253(->[Owners of Data:62]Owner Name:2)
			//...Perform data syncronization
			//* * * Look for untransferred data for set destination  * * *
			QUERY:C277([Activity Log:59]; [Activity Log:59]Status:9=0; *)
			QUERY:C277([Activity Log:59];  & ; [Activity Log:59]Destination:1=<>Destination)
			ORDER BY:C49([Activity Log:59]; [Activity Log:59]RefID:28; >)
			$NumberRecords_l:=Records in selection:C76([Activity Log:59])
			
			X_StartSend_txt:=ut_CreateTimeStamp
			X_NumActLogToBeSent_L:=$NumberRecords_l
			
			X_ActLogToBeSentStart_L:=0
			X_ActLogToBeSentEnd_L:=0
			X_ActLogLastSent_L:=0
			X_SendError_txt:=""
			
			If ($NumberRecords_l>0)
				
				FIRST RECORD:C50([Activity Log:59])
				X_ActLogToBeSentStart_L:=[Activity Log:59]RefID:28
				LAST RECORD:C200([Activity Log:59])
				X_ActLogToBeSentEnd_L:=[Activity Log:59]RefID:28
				
				<>vCancel:=False:C215
				//ON EVENT CALL("CancelJob")
				
				PLAY:C290("SynchMachines")
				If (vbOnScreenMessage)
					<>ProgressPID:=StartProgress("Upload"; "Button"; "Sending Data to Server")
					$Interval:=MaxNum(MinNum(Int:C8($NumberRecords_l/40); 20); 2)  // get an update interval between 2 and 20
					UpdateProgress(0; $NumberRecords_l)  //start it
				End if 
				FIRST RECORD:C50([Activity Log:59])
				
				
				C_BOOLEAN:C305($BackupRunning_b)
				$InternalNumber_l:=0
				For ($i; 1; $NumberRecords_l)
					DeletionOK_b:=True:C214
					$BackupRunning_b:=False:C215
					$CurrActLogRefID_L:=[Activity Log:59]RefID:28
					
					If (Not:C34(<>vCancel))
						
						
						$BackupRunning_b:=ut_CheckForBackup
						
						
						
					End if 
					
					If (<>vCancel) | ($BackupRunning_b) | (SQLError_b) | (4DError_b) | (AbortDueToLockedRecord_b)
						<>vCancel:=True:C214  //set to make sure next step does not run if cancelled here
						ut_Message(<>sCR+"Data transfer is being cancelled!"+<>sCR)
						$i:=$NumberRecords_l+1
						$InternalNumber_l:=-999
						Case of 
							: (SQLError_b)
								$InternalNumber_l:=-888
							: ($BackupRunning_b)
								$InternalNumber_l:=-777
							: (AbortDueToLockedRecord_b)
								$InternalNumber_l:=-555
							: ($AbortDueToDuplicateNRC_B)
								$InternalNumber_l:=-333
								
							: (4DError_b)
								$InternalNumber_l:=-666
						End case 
					Else 
						C_LONGINT:C283(RemoteActivityID_l; RemoteUniquekey_l)
						RemoteActivityID_l:=SQL_RetrieveNextID("Activity Log")
						$AbortDueToDuplicateNRC_B:=False:C215
						If ([Activity Log:59]Activity Type:3="NRC")
							SET QUERY DESTINATION:C396(Into variable:K19:4; $InternalNumber_l)
							QUERY:C277([FileIDRes Table:60]; [FileIDRes Table:60]File Number:1=[Activity Log:59]FileID Local:24; *)
							QUERY:C277([FileIDRes Table:60];  & ; [FileIDRes Table:60]Destination ID:3=[Activity Log:59]Local ID:15; *)
							QUERY:C277([FileIDRes Table:60];  & ; [FileIDRes Table:60]Destination:4="here")
							SET QUERY DESTINATION:C396(Into current selection:K19:1)
							If ($InternalNumber_l=0)
								If ([Activity Log:59]RefIDType:26#3) & (Not:C34(4DError_b))
									C_TEXT:C284($SeqName_txt)
									BLOB TO VARIABLE:C533([Activity Log:59]Data:10; $SeqName_txt)
									If ($SeqName_txt#"")
										RemoteUniquekey_l:=SQL_RetrieveNextID($SeqName_txt)
									End if 
								Else 
									RemoteUniquekey_l:=Num:C11(aLookUpDest([Activity Log:59]File Number:7; [Activity Log:59]Local ID:15; <>Destination))
									If (RemoteUniquekey_l=0)
										RemoteUniquekey_l:=Num:C11([Activity Log:59]Local ID:15)
									End if 
								End if 
							Else 
								4DError_b:=True:C214
								$AbortDueToDuplicateNRC_B:=True:C214
								$InternalNumber_l:=-333
							End if 
							
						End if 
						ut_SQLExecuteNoReturn("START")
						START TRANSACTION:C239
						clone_ClearFieldVariables([Activity Log:59]FileID Local:24)
						InGroupDelete_b:=False:C215
						If ($InternalNumber_l=0)
							ut_Message("Act Log entry "+String:C10($i)+" of "+String:C10($NumberRecords_l)+" - ID:"+String:C10([Activity Log:59]RefID:28)+<>sCR)
							
							Case of 
								: ([Activity Log:59]Activity Type:3="FLD")  //Update a field
									ut_Message("Searching record to update…"+<>sCR)
									ut_SQLTellServerField
									//TellServerFld ($ConnID;$numflds;$ActFileID;$OwnerFileID;$OwnerRef;$OwnerName)
								: ([Activity Log:59]Activity Type:3="NRC")  //Create a new record
									ut_Message("Creating new record…"+<>sCR)
									ut_SQLTellServerNRC
									//TellServerNRC ($ConnID;$numflds;$ActFileID;$OwnerFileID;$OwnerRef;$OwnerName)
								: ([Activity Log:59]Activity Type:3="DRC")  //Delete a record
									ut_Message("Deleting record…"+<>sCR)
									ut_SQLTellServerDRC
									//TellServerDRC ($ConnID;$numflds;$ActFileID;$OwnerFileID;$OwnerRef;$OwnerName)
								: ([Activity Log:59]Activity Type:3="GRP")  //Update a group of field in a  record
									ut_Message("Searching record to group update…"+<>sCR)
									ut_SQLTellServerGrp_2
									
									//TellServerGrp_2 ($ConnID;$numflds;$ActFileID;$OwnerFileID;$OwnerRef;$OwnerName)
								: ([Activity Log:59]Activity Type:3="GRD")  //Delete a group of records
									ut_Message("Searching records to group Delete…"+<>sCR)
									InGroupDelete_b:=True:C214
									ut_SQLTellServerGRD
									//TellServerGRD ($ConnID;$numflds;$ActFileID;$OwnerFileID;$OwnerRef;$OwnerName)
									//2004-08-11 ASL added to handle links
								: ([Activity Log:59]Activity Type:3="LNK")  //Update a link
									ut_Message("Updating a link…"+<>sCR)
									ut_SQLTellServerField
									//TellServerLNK ($ConnID;$numflds;$ActFileID;$OwnerFileID;$OwnerRef;$OwnerName)
									
							End case 
							FLUSH CACHE:C297  //Save status info immediately!
							If ((ut_fTestForSQLor4DError) & (DeletionOK_b) & (Not:C34(AbortDueToLockedRecord_b)))
								
								ut_SQLExecuteNoReturn("COMMIT")
								
								If (Not:C34(SQLError_b))
									VALIDATE TRANSACTION:C240
									X_ActLogLastSent_L:=$CurrActLogRefID_L
								Else 
									CANCEL TRANSACTION:C241
									X_SendError_txt:="Error on Commit of RefID "+String:C10([Activity Log:59]RefID:28)
									$i:=$NumberRecords_l+1
								End if 
							Else 
								ut_SQLExecuteNoReturn("ROLLBACK")
								CANCEL TRANSACTION:C241
								If (Not:C34(DeletionOK_b))
								Else 
									$i:=$NumberRecords_l+1
									X_SendError_txt:="Error on ROLLBACK of RefID "+String:C10([Activity Log:59]RefID:28)
								End if 
							End if 
							
							NEXT RECORD:C51([Activity Log:59])
							
						Else 
							SQLError_b:=True:C214
							ut_SQLExecuteNoReturn("ROLLBACK")
							CANCEL TRANSACTION:C241
							X_SendError_txt:="Internal Error "+String:C10($InternalNumber_l)+" at RefID "+String:C10([Activity Log:59]RefID:28)
							$i:=$NumberRecords_l+1
						End if 
						
					End if 
					Case of 
						: (SQLError_b)
						: (AbortDueToLockedRecord_b)
						: ($AbortDueToDuplicateNRC_B)
							
						Else 
							
							If (vbOnScreenMessage)
								If (($i%$Interval=0) | ($i=$NumberRecords_l))  //Don't slow down things just to display
									UpdateProgress($i; $NumberRecords_l)
								End if 
							End if 
					End case   // check to see if aborted from the Progress window
					If (<>Abort)
						<>vCancel:=True:C214
					End if 
				End for 
				If (vbOnScreenMessage)
					POST OUTSIDE CALL:C329(<>ProgressPID)
				End if 
				// ON EVENT CALL("")
				//unload records
				UNLOAD RECORD:C212([Activity Log:59])
				UNLOAD RECORD:C212([Owners of Data:62])
				G_CloseAllTables  //close all tables...  
				$TransferOk:=False:C215
				
				Case of 
						
					: (SQLError_b)
						PLAY:C290("ConAbort")
						ut_Message("* * * * * * * * * * * "+<>sCR)
						ut_Message("Data transfer failed due to SQL error…["+String:C10($InternalNumber_l)+"]"+<>sCR)
						ut_Message("* * * * * * * * * * * "+<>sCR)
						X_SendError_txt:=X_SendError_txt+Char:C90(13)+"Data transfer failed due to SQL error…["+String:C10($InternalNumber_l)+"]"
						If (vbOnScreenMessage)
							ut_MessageDia("Data transfer failed due to SQL error…Notify MADOT BMS Support"; "Transfer Messages"; 5; 2)
						End if 
						ut_DBSynchWriteOutErrors("SQL")
						
					: (4DError_b)
						PLAY:C290("ConAbort")
						ut_Message("* * * * * * * * * * * "+<>sCR)
						ut_Message("Data transfer failed due to 4D error…["+String:C10($InternalNumber_l)+"]"+<>sCR)
						ut_Message("* * * * * * * * * * * "+<>sCR)
						X_SendError_txt:=X_SendError_txt+Char:C90(13)+"Data transfer failed due to 4D error…["+String:C10($InternalNumber_l)+"]"
						If (vbOnScreenMessage)
							ut_MessageDia("Data transfer failed due to 4D error…Notify MADOT BMS Support"; "Transfer Messages"; 5; 2)
						End if 
						
						ut_DBSynchWriteOutErrors("4D")
						
					: ($BackupRunning_b)
						PLAY:C290("ConAbort")
						ut_Message("* * * * * * * * * * * "+<>sCR)
						ut_Message("Data transfer cancelled. Backup running..."+<>sCR)
						ut_Message("* * * * * * * * * * * "+<>sCR)
						X_SendError_txt:=X_SendError_txt+Char:C90(13)+"Remote Backup Running!!"
						If (vbOnScreenMessage)
							ut_MessageDia("Data transfer cancelled. Backup running..."; "Transfer Messages"; 5; 2)
						End if 
						
						
					: ($InternalNumber_l=-999)
						PLAY:C290("ConAbort")
						ut_Message("* * * * * * * * * * * "+<>sCR)
						ut_Message("Data transfer cancelled…["+String:C10($InternalNumber_l)+"]"+<>sCR)
						ut_Message("* * * * * * * * * * * "+<>sCR)
						X_SendError_txt:=X_SendError_txt+Char:C90(13)+"Data transfer cancelled…["+String:C10($InternalNumber_l)+"]"
						If (vbOnScreenMessage)
							ut_MessageDia("Data transfer cancelled…"; "Transfer Messages"; 5; 2)
						End if 
					: ($InternalNumber_l=-555) | (AbortDueToLockedRecord_b)
						PLAY:C290("ConAbort")
						ut_Message("* * * * * * * * * * * "+<>sCR)
						ut_Message("Data transfer cancelled…["+String:C10($InternalNumber_l)+"] due to locked record."+<>sCR)
						ut_Message("* * * * * * * * * * * "+<>sCR)
						X_SendError_txt:=X_SendError_txt+Char:C90(13)+"Data transfer cancelled…["+String:C10($InternalNumber_l)+"] due to locked record."
						If (vbOnScreenMessage)
							ut_MessageDia("Data transfer cancelled due to locked record"; "Transfer Messages"; 5; 2)
						End if 
					: ($AbortDueToDuplicateNRC_B) | ($InternalNumber_l=-333)
						PLAY:C290("ConAbort")
						ut_Message("* * * * * * * * * * * "+<>sCR)
						ut_Message("Data transfer cancelled…["+String:C10($InternalNumber_l)+"] due to duplicate [FileIDRes Table] record for NRC. [Activity Log]RefID was "+String:C10([Activity Log:59]RefID:28)+<>sCR)
						
						ut_Message("* * * * * * * * * * * "+<>sCR)
						X_SendError_txt:=X_SendError_txt+Char:C90(13)+"Data transfer cancelled…["+String:C10($InternalNumber_l)+"] due to duplicate [FileIDRes Table] record for NRC."
						If (vbOnScreenMessage)
							ut_MessageDia("Data transfer cancelled due to duplicate [FileIDRes Table] record for NRC. Notify MADOT BMS Support "; "Transfer Messages"; 5; 2)
						End if 
						
						
						
					: ($InternalNumber_l=0)
						ut_Message("* * * * * * * * * * * "+<>sCR)
						ut_Message("All data transferred…No errors occurred"+<>sCR)
						ut_Message("* * * * * * * * * * * "+<>sCR)
						$TransferOk:=True:C214
						
				End case 
				If (Not:C34($TransferOk))
					If (vbOnScreenMessage)
						UpdateProgress($i; $NumberRecords_l)
						POST OUTSIDE CALL:C329(<>ProgressPID)
					End if 
				End if 
			Else 
				ut_Message("There are no records to transfer for destination:"+<>Destination+"!"+<>sCR)
			End if   //if Records to be transfered
			
			
		Else 
			$vbServConnOK:=False:C215
			ut_SQLWriteErrorsToLog("Connection failure: "+Current method name:C684+" for destination: "+<>Destination+<>sCR)
			X_SendError_txt:="Connection failure: "+Current method name:C684+" for destination: "+<>Destination
		End if 
		
		ut_SQLLogout  //make sure we log out whether connection was made or not
		
		X_EndSend_txt:=ut_CreateTimeStamp
		
		vDUplFinishDate:=Current date:C33(*)
		vTUplFinishTime:=Current time:C178(*)
		$Elapsed_tm:=fElapsedTime(vDUplStartDate; vTUplStartTime; vDUplFinishDate; vTUplFinishTime)
		
		$msg:="Upload ended at "+String:C10(vDUplFinishDate; Internal date short special:K1:4)+" - "+String:C10(vTUplFinishTime; HH MM SS:K7:1)+<>sCR
		$msg:=$msg+"Upload Time Elapsed : "+String:C10($Elapsed_tm; Hour min sec:K7:3)+<>sCR
		If (vbToFileMessage)
			ut_Message($msg)
		End if 
		
		If (Not:C34(<>vCancel) & ($TransferOk))
			
			If ((<>AllowTxRx) & ($vbServConnOK))
				ut_CloseMessage
				If (tMailNote#"")
					C_TEXT:C284($tempSaveMsg_txt)
					$tempSaveMsg_txt:=tMailNote
					ut_ControlSendMail("INIT")
					tFromEmailAddress:=ut_GetSysParameter("EXT_Transf_Rpt_From"; "costas.manousakis@dot.state.ma.us")
					tToBuilt_txt:="costas.manousakis@dot.state.ma.us"
					tSubject:="Duplicate [FileIDRes Table] records found from 4D user "+Current user:C182+" on station "+Current machine:C483
					tMailNote:=$tempSaveMsg_txt
					
					ut_ControlSendMail("SEND")
					
				End if 
				ut_SQLDownloadNewRecords($Password; $viOnScreen)
			Else 
				BEEP:C151
				If ($TransferOk)
					PLAY:C290("Transfer Complete")
				End if 
				
				If (vbOnScreenMessage)
					//display message - ring every 5 min, stop after 2 times = 10 min
					ut_MessageDia($msg; "Transfer Messages"; 5; 2)
				End if 
				
				PLAY:C290("Goodbye")
				ut_CloseMessage
			End if 
			If ($Lpid>0)  //Restore logoff checker
				<>fUsrPresent:=True:C214  //Set as if the user has been here
				RESUME PROCESS:C320($Lpid)
			End if 
		End if   //if Password OK
		
	Else 
		
		ut_SQLLogout  //make sure we log out before downloading
		
		ut_Message("There are no records to transfer for destination:"+<>Destination+"!"+<>sCR)
		vDUplFinishDate:=Current date:C33(*)
		vTUplFinishTime:=Current time:C178(*)
		ut_CloseMessage
		
		
		ut_SQLDownloadNewRecords($Password; $viOnScreen)
	End if 
	<>MessageFileCycle_L:=$vStartMsgCycleNo_L
Else 
	
	ut_CloseMessage
	
	Case of 
		: ($Error_l=-2)
			ALERT:C41("Tranfer cancelled due to invalid password")
		: ($Error_l=-4)
			ALERT:C41("Tranfer cancelled due to Password entry screen cancelled")
		: ($Error_l=-9)
			ALERT:C41("You are trying to transfer to "+SeverStructureName_txt+" but should be transfering to "+<>Destination)
			
	End case 
	
End if 