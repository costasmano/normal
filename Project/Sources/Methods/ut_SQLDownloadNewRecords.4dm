//%attributes = {"invisible":true}
// Method: ut_SQLDownloadNewRecords
// Description
// Download new activity log records from remote server
//
// Parameters
// ---------------------------------------------------- 
//$1 $Password
//$2 $viOnScreen
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Charles Miller
	// Date and time: 06/21/10, 12:13:09
	// ----------------------------------------------------
	// Modified by: Charles Miller (6/21/10)
	
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (8/11/10 11:15:26) 
	//Ugrade to v11
	//Modified by: Charles Miller (4/28/11 17:00:21)
	//Modify how (Not(4DError_b)) and (Not(SQLError_b)) handled replace with (ut_fTestForSQLor4DError)
	//Modified by: Charles Miller (11/4/11 11:14:53)
	// Modified by: Costas Manousakis-(Designer)-(12/4/13 11:34:25)
	Mods_2013_12
	//  `added more tracking of the transfer  to be sent in the email at the end
	Mods_2013_12  // Add ability to skip add record errors for certain tables
	//Modified by: Charles Miller (12/19/13 14:55:24)
	// Modified by: Costas Manousakis-(Designer)-(6/10/14 10:52:51)
	Mods_2014_06_bug
	//  `add  ut_SQLWriteErrorsToLog if an error returning the remote act log record 
	Mods_2016_01_bug  //   `FIX BUG WHERE [Activity Log] records were being created where they should not have been 
	//  `added emailing of duplicate records found in FileIDRes table
	//Modified by: administrator (1/5/16 14:16:58)
	// Modified by: Charles Miller-(Designer)-(10/13/16 
	Mods_2016_10
	//  `Added check to verify that we there are no existing FileIDRes entries when receiving a NRC activity
	// Modified by: Costas Manousakis-(Designer)-(3/9/17 17:29:10)
	Mods_2017_03
	//  `SORT ARRAY(ActivityKeys_al;>)  before getting the first and last refIDs to be received
	// Modified by: Costas Manousakis-(Designer)-(9/18/17 15:37:49)
	Mods_2017_09_bug
	//  `missing parent is ok for transfers to Boston
	Mods_2018_05  // Fix issue where we are not checing for locked and loaded record during download 
	//Modified by: Chuck Miller (5/17/18 16:45:49)
	Mods_2018_12  // Add code to transfer Resource files
	//Modified by: Chuck Miller (12/4/18 11:47:18)
	Mods_2019_01  // Move ut_SQLLogout to directly after for loop so it does not wait for user to press enter on displayed form
	//Modified by: Chuck Miller (1/29/19 14:47:12)
	// Modified by: Costas Manousakis-(Designer)-(4/18/19 10:44:15)
	Mods_2019_04_bug
	//  `Reset MissingParent_B to false when it is OK (ie. for transfers to MHD BMS) CallReference #631
	// Modified by: Costas Manousakis-(Designer)-(7/15/20 10:53:22)
	Mods_2020_07
	//  `unchecked method property "Ececute on Server" - does not work in case of Client.
	// Modified by: Costas Manousakis-(Designer)-(8/28/20 17:51:04)
	Mods_2020_08_bug
	//  `moved ut_SQLLogout near the end.
	// Modified by: Costas Manousakis-(Designer)-(6/14/21 18:20:15)
	Mods_2021_06_bug
	//  `moved ut_SQLLogout before the final dialogue if transfers, 
	//  ` before the message if there are NRC entries, and before the last error checksa
	Mods_NewDownloadCode  //Replace [Preferences]Protocol with [Preferences]LastRefID_L
	//replace [Preferences]zoneinfo with [Preferences]DistrictInformation_s
	//and update code to reflect changes needed
	//Modified by: Chuck Miller (12/27/21 13:37:10)
	Mods_NewDownloadCode  //Make changes to address new upload and download code
	//These methods moved from single user to DEV Server 
	//Added $NextActivityRefID_L to ut_SQLReturnALRecordKeys
	//Modified by: Chuck Miller (1/11/22 10:57:26)
	// Modified by: Costas Manousakis-(Designer)-(2022-01-20T00:00:00 17:17:20)
	Mods_2022_01
	//  `when testing for pending NRC act log records, check also if their destination matched the <>Destination
	// Modified by: Costas Manousakis-(Designer)-(2022-06-13 10:28:11)
	Mods_2022_06
	//  `ignore value stored in [Preferences]LastRefID_L - 
	// Modified by: Costas Manousakis-(Designer)-(2022-06-15 13:32:45)
	Mods_2022_06
	//  `call method ACTFIX202206 to fix owners of data on remote server
End if 
READ WRITE:C146([Preferences:57])
ALL RECORDS:C47([Preferences:57])
If (Not:C34(ut_LoadRecordInteractive(->[Preferences:57])))
	ALERT:C41("Can not download  until you can load preferences table")
Else 
	
	ACTFIX202206
	
	Compiler_FieldVariables
	ut_InitFieldArray
	Compiler_forSQL
	Compiler_TransfLog
	Compiler_MailUtils
	C_LONGINT:C283($State_L; $Time_L)
	C_LONGINT:C283($NextActivityRefID_L)
	$NextActivityRefID_L:=[Preferences:57]LastRefID_L:8
	$NextActivityRefID_L:=0  // set to zero  - ignore value stored in [Preferences]LastRefID_L - 
	
	PROCESS PROPERTIES:C336(Current process:C322; XFERCurrentProcessName_txt; $State_L; $Time_L)
	
	MissingParent_B:=False:C215
	tMailNote:=""
	SQLError_b:=False:C215
	4D_Error_b:=False:C215
	InWHKRUpdate_b:=False:C215
	DataRefernceError_b:=False:C215
	
	X_NumActLogToBeRecd_L:=0
	X_ActLogToBeRecdStart_L:=0
	X_ActLogToBeRecdEnd_L:=0
	X_ActLogLastRecd_L:=0
	X_StartRec_txt:=""
	X_EndRec_txt:=""
	X_RecdError_txt:=""
	
	C_DATE:C307($Start_d; $End_d)
	C_TIME:C306($Start_tm; $Finish_tm; $Elapsed_tm)
	$Start_d:=Current date:C33(*)
	$Start_tm:=Current time:C178(*)
	C_TEXT:C284($CurrentUser_txt)
	C_LONGINT:C283($InternalNumber_l; $RemoteRefID_L)
	$CurrentUser_txt:=Current user:C182
	C_BOOLEAN:C305($AbortDueToDuplicateNRC_B)
	$AbortDueToDuplicateNRC_B:=False:C215
	If ((<>LockUserTx=True:C214) & (<>TxUserName#$CurrentUser_txt))
		If (Application type:C494#4D Server:K5:6)
			ALERT:C41("Sorry! You are not authorized to send or receive any data!")
		End if 
	Else 
		C_LONGINT:C283($viOnScreen; $Error_l)
		$viOnScreen:=3
		C_TEXT:C284($Password; vsPassword; vUserName)  // Command Replaced was o_C_STRING length was 80
		$Password:=""
		
		If (Count parameters:C259>0)
			C_TEXT:C284($1)  // Command Replaced was o_C_STRING length was 80
			$Password:=$1
			If (Count parameters:C259>1)
				C_LONGINT:C283($2)  //Command Replaced was o_C_INTEGER
				$viOnScreen:=$2
			End if 
		End if 
		C_BOOLEAN:C305(vbOnScreenMessage; vbToFileMessage; $BackupRunning_b)
		vbOnScreenMessage:=(($viOnScreen=1) | ($viOnScreen=3))
		vbToFileMessage:=(($viOnScreen=2) | ($viOnScreen=3))
		C_LONGINT:C283($Width; $Height)
		$Width:=600
		$Height:=300
		
		ut_FillIgnoreDupTableNames
		ut_StartMessage($viOnScreen; "DownLoad Log"; $Width; $Height; Regular window:K27:1)
		ut_Message("Download started at "+String:C10($Start_d; Internal date short special:K1:4)+" - "+String:C10($Start_tm; HH MM SS:K7:1)+<>sCR)
		C_BOOLEAN:C305($DoDownLoad; $TransferOk)
		$Error_l:=ut_SQLMakeConnnection($CurrentUser_txt; $Password; <>DestIP; $CurrentUser_txt+", you are about to download data from the central database.")
		$TransferOk:=False:C215
		
		If ($Error_l=1)
			$Error_l:=ut_TestServerStructureName
		End if 
		
		If ($Error_l=1)
			$DoDownLoad:=($Error_l=1)
			C_LONGINT:C283($vlActNRCs)
			SET QUERY DESTINATION:C396(Into variable:K19:4; $vlActNRCs)  //load query in variable
			QUERY:C277([Activity Log:59]; [Activity Log:59]Activity Type:3="NRC"; *)
			QUERY:C277([Activity Log:59];  & [Activity Log:59]Destination:1=<>Destination; *)
			QUERY:C277([Activity Log:59];  & ; [Activity Log:59]Status:9=0)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)  //reset the query dest.
			C_TEXT:C284($errMessage)
			If (($vlActNRCs>0) & ($DoDownLoad))
				
				ut_SQLLogout
				
				$errMessage:="There are new records in the local database to be transfered!!"+<>sCR
				$errMessage:=$errMessage+"You MUST Execute Transfer first before a Data Download!!"
				If (vbToFileMessage)
					ut_Message($errMessage)  //New record skipped
					ut_CloseMessage
				End if 
				
				If (vbOnScreenMessage)
					ut_MessageDia($errMessage; "Transfer Messages"; 5; 3)
				End if 
				$DoDownLoad:=False:C215  //disable the download....
				X_RecdError_txt:="There are new records in the local database to be transfered!!"
			End if 
			If ($DoDownLoad)  //Apr-2003 changed from $DoDownLoad=True
				C_LONGINT:C283($Lpid)
				$Lpid:=LProcessID("$Logoff")  //Is there a logoff checker
				If ($Lpid>0)
					PAUSE PROCESS:C319($Lpid)
				End if 
				
				If (Not:C34(SQLError_b))  //connection made
					
					//Get the profile of the Owers of Data file
					ActFileID_l:=Table:C252(->[Activity Log:59])
					OwnerFileID_l:=Table:C252(->[Owners of Data:62])
					//Get the profile of the Owers of Data file
					OwnerRef_l:=Field:C253(->[Owners of Data:62]RefID:1)
					OwnerName_l:=Field:C253(->[Owners of Data:62]Owner Name:2)
					//C_TEXT($vsDistServNo)  // Command Replaced was o_C_STRING length was 10
					//$vsDistServNo:=f_IsDistrictServer 
					C_TEXT:C284($Forward_txt)
					$Forward_txt:=<>Forward
					If (ut_CheckForBackup)
						$InternalNumber_l:=-777
					End if 
					
					Case of 
						: ($InternalNumber_l=-777)
							ARRAY LONGINT:C221(ActivityKeys_al; 0)
						: (<>Transfer=0)
							ut_SQLReturnALRecordKeys($Forward_txt; $CurrentUser_txt; $NextActivityRefID_L)
						: (<>Transfer=1)
							ut_SQLReturnALRecordKeys("ALL"; $CurrentUser_txt; $NextActivityRefID_L)
					End case 
					
					If (Size of array:C274(ActivityKeys_al)=0)
						If ($InternalNumber_l=-777)
							ut_Message("* * * * * * * * * * * "+<>sCR)
							ut_Message(<>sCR+"Download cancelled backup is running."+<>sCR)
							ut_Message("* * * * * * * * * * * "+<>sCR)
							X_RecdError_txt:="Download cancelled backup is running."
							
						Else 
							ut_Message("* * * * * * * * * * * "+<>sCR)
							ut_Message(<>sCR+"All information downloaded previously!"+<>sCR)
							ut_Message("* * * * * * * * * * * "+<>sCR)
							X_RecdError_txt:="All information downloaded previously!"
						End if 
					Else 
						X_StartRec_txt:=ut_CreateTimeStamp
						X_NumActLogToBeRecd_L:=Size of array:C274(ActivityKeys_al)
						SORT ARRAY:C229(ActivityKeys_al; >)  //do oldest first
						X_ActLogToBeRecdStart_L:=ActivityKeys_al{1}
						X_ActLogToBeRecdEnd_L:=ActivityKeys_al{X_NumActLogToBeRecd_L}
						
						C_TEXT:C284($BindToVariable_txt; $SQL_Select_txt)
						$SQL_Select_txt:=ut_SetSelectForAllFields(Table:C252(->[Activity Log:59]); ->$BindToVariable_txt)
						C_BOOLEAN:C305(DeletionOK_b)
						
						$SQL_Select_txt:=$SQL_Select_txt+" FROM [Activity Log] WHERE RefID = :vKey_l INTO "+$BindToVariable_txt+";"
						
						If (Not:C34(SQLError_b))
							SORT ARRAY:C229(ActivityKeys_al; >)  //do oldest first
							C_LONGINT:C283($Loop_l; $InternalNumber_l; $Interval)
							//OK let's build the [Activity Log] select
							ut_Message("Downloading "+String:C10(Size of array:C274(ActivityKeys_al))+" records…"+<>sCR)
							If (vbOnScreenMessage)
								<>ProgressPID:=StartProgress("DownLoad"; "Button"; "Receiving Data From Server")
								$Interval:=MaxNum(MinNum(Int:C8(Size of array:C274(ActivityKeys_al)/40); 20); 2)  // get an update interval between 2 and 20
								UpdateProgress(0; Size of array:C274(ActivityKeys_al))  //start it
							End if 
							
							For ($Loop_l; 1; Size of array:C274(ActivityKeys_al))
								XFERRecordLoaded_B:=True:C214
								If (ut_CheckForBackup)
									$InternalNumber_l:=-777
									X_RecdError_txt:=X_RecdError_txt+"Download cancelled backup is running. RefID # "+String:C10($Loop_l)+" ID ="+String:C10(ActivityKeys_al{$Loop_l})+Char:C90(13)
									$Loop_l:=Size of array:C274(ActivityKeys_al)+1
								Else 
									DeletionOK_b:=True:C214
									
									clone_ClearFieldVariables(Table:C252(->[Activity Log:59]))
									vKey_l:=ActivityKeys_al{$Loop_l}
									
									ut_SQLReturnRecord($SQL_Select_txt; "[Activity Log]"; String:C10(vKey_l))
									If (Not:C34(SQLError_b))
										ut_SQLExecuteNoReturn("START")
										START TRANSACTION:C239
										CREATE RECORD:C68([Activity Log:59])
										SaveActivityLogRecord_b:=True:C214
										//ut_SQLUpdateLocalTable (Table(->[Activity Log]))
										ut_NewSQLUpdateLocalTable(Table:C252(->[Activity Log:59]))
										$RemoteRefID_L:=[Activity Log:59]RefID:28
										$AbortDueToDuplicateNRC_B:=False:C215
										If ([Activity Log:59]Activity Type:3="NRC")
											SET QUERY DESTINATION:C396(Into variable:K19:4; $InternalNumber_l)
											QUERY:C277([FileIDRes Table:60]; [FileIDRes Table:60]File Number:1=[Activity Log:59]FileID Local:24; *)
											QUERY:C277([FileIDRes Table:60];  & ; [FileIDRes Table:60]Local ID:2=[Activity Log:59]Local ID:15; *)
											QUERY:C277([FileIDRes Table:60];  & ; [FileIDRes Table:60]Destination:4="here")
											SET QUERY DESTINATION:C396(Into current selection:K19:1)
											If ($InternalNumber_l=0)
											Else 
												$AbortDueToDuplicateNRC_B:=True:C214
												$InternalNumber_l:=-333
												$Loop_l:=Size of array:C274(ActivityKeys_al)+1
											End if 
										End if 
										If (Not:C34($AbortDueToDuplicateNRC_B))
											Inc_Sequence("Activity Log"; ->[Activity Log:59]RefID:28)  //Get the next sequence
											
											[Activity Log:59]Destination:1:=""
											[Activity Log:59]Transfer:12:=0
											[Activity Log:59]Forward:13:=""
											[Activity Log:59]User Name:4:=$CurrentUser_txt
											[Activity Log:59]dDate:5:=Current date:C33(*)
											[Activity Log:59]tTime:6:=Current time:C178(*)
											[Activity Log:59]Source:2:=<>Destination
											[Activity Log:59]Status:9:=1
											[Activity Log:59]Dest ID local:19:=""
											[Activity Log:59]Dest ID parent:16:=""
											SAVE RECORD:C53([Activity Log:59])
											
											Case of 
												: ([Activity Log:59]Activity Type:3="TRS")  //Copy resources
													ut_Message("Copying New or Modified Resources"+String:C10([Activity Log:59]RefID:28)+<>sCR)
													C_BLOB:C604($PassedInData_blb)
													$PassedInData_blb:=[Activity Log:59]Data:10
													C_TEXT:C284($X_RecdError_txt)
													$X_RecdError_txt:=Resource_SaveFileOnServer($PassedInData_blb)
													XFERRecordLoaded_B:=($X_RecdError_txt="")
													
												: ([Activity Log:59]Activity Type:3="FLD")  //Update a field
													ut_Message("Searching record to update…"+String:C10([Activity Log:59]RefID:28)+<>sCR)
													ut_SQLUpdateLocalField
													//XGetServerFld (;$ActFileID;$ActRefID;$OwnerFileID;$OwnerRef;$OwnerName)
												: ([Activity Log:59]Activity Type:3="NRC")  //Create a new record
													ut_Message("Creating new record…[Activity Log]RefID "+String:C10([Activity Log:59]RefID:28)+<>sCR)
													ut_SQLCreateNewRecord
													//XGetServerNRC ($ConnID;$ActFileID;$ActRefID;$OwnerFileID;$OwnerRef;$OwnerName)
												: ([Activity Log:59]Activity Type:3="DRC")  //Delete a record
													ut_Message("Deleting record…[Activity Log]RefID "+String:C10([Activity Log:59]RefID:28)+<>sCR)
													ut_SQLDeleteLocalRecord
													//XGetServerDRC ($ConnID;$ActFileID;$ActRefID;$OwnerFileID;$OwnerRef;$OwnerName)
												: ([Activity Log:59]Activity Type:3="GRP")  //Do a Group transfer for a record
													ut_Message("Searching record to group update…[Activity Log]RefID "+String:C10([Activity Log:59]RefID:28)+<>sCR)
													ut_SQLUpdateLocalFields
													//XGetServerGrp ($ConnID;$ActFileID;$ActRefID;$OwnerFileID;$OwnerRef;$OwnerName)
												: ([Activity Log:59]Activity Type:3="GRD")  //Do a Group deletion of records
													ut_Message("Searching records to group delete…[Activity Log]RefID "+String:C10([Activity Log:59]RefID:28)+<>sCR)
													ut_SQLDeleteLocalRecords
													//XGetServerGRD ($ConnID;$ActFileID;$ActRefID;$OwnerFileID;$OwnerRef;$OwnerName)
													//2004-07-28 ASL Handles Links between records.
												: ([Activity Log:59]Activity Type:3="LNK")  //Update a link to a record
													ut_Message("Updating a link to a local record…[Activity Log]RefID "+String:C10([Activity Log:59]RefID:28)+<>sCR)
													ut_SQLServerLink
													//XGetServerLnk ($ConnID;$ActFileID;$ActRefID;$OwnerFileID;$OwnerRef;$OwnerName)
											End case 
											
											If (XFERRecordLoaded_B)
												ut_SQLCreateOwnerRecords
												
												If (SaveActivityLogRecord_b)
													SAVE RECORD:C53([Activity Log:59])
												End if 
												UNLOAD RECORD:C212([Activity Log:59])
											Else 
												If ($X_RecdError_txt#"")
													$InternalNumber_l:=-999
													X_RecdError_txt:=X_RecdError_txt+$X_RecdError_txt
													ut_SQLWriteErrorsToLog("Error in saving resource document "+String:C10($Loop_l)+" Remote RefID ="+String:C10(ActivityKeys_al{$Loop_l}))
												Else 
													X_RecdError_txt:=X_RecdError_txt+"Could not load record "+String:C10($Loop_l)+" Remote RefID ="+String:C10(ActivityKeys_al{$Loop_l})+Char:C90(13)
													ut_SQLWriteErrorsToLog("Could not load record "+String:C10($Loop_l)+" Remote RefID ="+String:C10(ActivityKeys_al{$Loop_l}))
													$InternalNumber_l:=-555
												End if 
												$Loop_l:=Size of array:C274(ActivityKeys_al)+1
											End if 
										End if 
									Else 
										X_RecdError_txt:=X_RecdError_txt+"SQL Error ! Act log count # "+String:C10($Loop_l)+" Remote RefID ="+String:C10(ActivityKeys_al{$Loop_l})+Char:C90(13)
										ut_SQLWriteErrorsToLog("SQL Error ! Act log count # "+String:C10($Loop_l)+" Remote RefID = "+String:C10(ActivityKeys_al{$Loop_l}))  //Mods_2014_06_bug 
										$Loop_l:=Size of array:C274(ActivityKeys_al)+1
										
									End if 
									
									FLUSH CACHE:C297  //Save status info immediately!
									If ((ut_fTestForSQLor4DError) & (DeletionOK_b)) & (Not:C34(DataRefernceError_b)) & (Not:C34($AbortDueToDuplicateNRC_B) & (Not:C34(MissingParent_B)) & (XFERRecordLoaded_B))
										ALL RECORDS:C47([Preferences:57])
										If (Not:C34(ut_LoadRecordInteractive(->[Preferences:57])))
											CANCEL TRANSACTION:C241
											$InternalNumber_l:=-999
											X_RecdError_txt:=X_RecdError_txt+"Could not load preferences record "+String:C10($Loop_l)+" ID ="+String:C10(ActivityKeys_al{$Loop_l})+" MA DOT error -999"+Char:C90(13)
											$Loop_l:=Size of array:C274(ActivityKeys_al)+1
										Else 
											[Preferences:57]LastRefID_L:8:=ActivityKeys_al{$Loop_l}
											
											ut_SQLExecuteNoReturn("COMMIT")
											
											If (Not:C34(SQLError_b))
												SAVE RECORD:C53([Preferences:57])
												
												VALIDATE TRANSACTION:C240
												
												X_ActLogLastRecd_L:=ActivityKeys_al{$Loop_l}
												
												If (vbOnScreenMessage)
													If (($Loop_l%$Interval=0) | ($Loop_l=Size of array:C274(ActivityKeys_al)))  //Don't slow down things just to display
														UpdateProgress($Loop_l; Size of array:C274(ActivityKeys_al))
													End if 
												End if 
												
											Else 
												CANCEL TRANSACTION:C241
												$InternalNumber_l:=-888
												X_RecdError_txt:=X_RecdError_txt+"SQL or 4D Error ! RefID # "+String:C10($Loop_l)+" ID ="+String:C10(ActivityKeys_al{$Loop_l})+" internal error -888"+Char:C90(13)
												$Loop_l:=Size of array:C274(ActivityKeys_al)+1
											End if 
										End if 
									Else 
										
										If (DataRefernceError_b) | (MissingParent_B)
											ut_SQLExecuteNoReturn("COMMIT")  // save changes to remote server (marked as received)
										Else 
											ut_SQLExecuteNoReturn("ROLLBACK")
										End if 
										CANCEL TRANSACTION:C241  // cancel local changes
										DataRefernceError_b:=False:C215
										Case of 
												
											: (MissingParent_B)
												//missing parent is ok for transfers to boston (MHD BMS) - reset to False
												Case of 
													: (Current user:C182="District@ Server")
														MissingParent_B:=False:C215
													: (Current user:C182="BMSExernal Server")
														MissingParent_B:=False:C215
													: (<>Destination="MHD BMS")
														MissingParent_B:=False:C215
													Else 
														$Loop_l:=Size of array:C274(ActivityKeys_al)+1
												End case 
												
											: (SQLError_b)
												$InternalNumber_l:=-888
												X_RecdError_txt:=X_RecdError_txt+"SQL Error ! RefID # "+String:C10($Loop_l)+" ID ="+String:C10(ActivityKeys_al{$Loop_l})+" internal error -888"+Char:C90(13)
												$Loop_l:=Size of array:C274(ActivityKeys_al)+1
												
											: (4DError_b)
												X_RecdError_txt:=X_RecdError_txt+"4D Error ! RefID # "+String:C10($Loop_l)+" ID ="+String:C10(ActivityKeys_al{$Loop_l})+" internal error -666"+Char:C90(13)
												$InternalNumber_l:=-666
												$Loop_l:=Size of array:C274(ActivityKeys_al)+1
												
										End case 
										
									End if 
									
								End if 
								If (<>vCancel) | (<>Abort)
									$Loop_l:=Size of array:C274(ActivityKeys_al)+1
								End if 
							End for 
							
							If (vbOnScreenMessage)
								POST OUTSIDE CALL:C329(<>ProgressPID)
							End if 
							
							Case of 
								: ($InternalNumber_l=-999)
									PLAY:C290("ConAbort")
									
									ut_Message("* * * * * * * * * * * "+<>sCR)
									ut_Message("Data transfer cancelled. Could Update local resource files..."+<>sCR)
									ut_Message("* * * * * * * * * * * "+<>sCR)
									X_RecdError_txt:=X_RecdError_txt+"Data transfer cancelled. Could not load record.. Error -999"+Char:C90(13)
									
								: ($InternalNumber_l=-555)
									PLAY:C290("ConAbort")
									ut_Message("* * * * * * * * * * * "+<>sCR)
									ut_Message("Data transfer cancelled. Could not load record..."+<>sCR)
									ut_Message("* * * * * * * * * * * "+<>sCR)
									X_RecdError_txt:=X_RecdError_txt+"Data transfer cancelled. Could not load record.. Error -555"+Char:C90(13)
									
								: ($InternalNumber_l=-888)
									ut_Message("* * * * * * * * * * * "+<>sCR)
									ut_Message(<>sCR+"All information downloaded previously!"+<>sCR)
									ut_Message("* * * * * * * * * * * "+<>sCR)
									X_RecdError_txt:=X_RecdError_txt+"All information downloaded previously! Error -888"+Char:C90(13)
									
								: ($InternalNumber_l=-777)
									PLAY:C290("ConAbort")
									ut_Message("* * * * * * * * * * * "+<>sCR)
									ut_Message("Data transfer cancelled. Backup running..."+<>sCR)
									ut_Message("* * * * * * * * * * * "+<>sCR)
									X_RecdError_txt:=X_RecdError_txt+"Data transfer cancelled. Backup running.. Error -777"+Char:C90(13)
									If (vbOnScreenMessage)
										ut_MessageDia("Data transfer cancelled. Backup running..."; "Transfer Messages"; 5; 2)
									End if 
									
								: (SQLError_b)
									PLAY:C290("ConAbort")
									ut_Message("* * * * * * * * * * * "+<>sCR)
									ut_Message("Data transfer failed due to SQL error…["+String:C10($InternalNumber_l)+"]"+<>sCR)
									ut_Message("* * * * * * * * * * * "+<>sCR)
									X_RecdError_txt:=X_RecdError_txt+"Data transfer failed due to SQL error…["+String:C10($InternalNumber_l)+"]"+Char:C90(13)
									
									If (vbOnScreenMessage)
										ut_MessageDia("Data transfer failed due to SQL error…Notify MADOT BMS Support"; "Transfer Messages"; 5; 2)
									End if 
									
								: ($AbortDueToDuplicateNRC_B) | ($InternalNumber_l=-333)
									PLAY:C290("ConAbort")
									ut_Message("* * * * * * * * * * * "+<>sCR)
									ut_Message("Data transfer cancelled…["+String:C10($InternalNumber_l)+"] due to duplicate [FileIDRes Table] record for NRC. Remote [Activity Log]RefID was "+String:C10($RemoteRefID_L)+<>sCR)
									
									ut_Message("* * * * * * * * * * * "+<>sCR)
									X_SendError_txt:=X_SendError_txt+Char:C90(13)+"Data transfer cancelled…["+String:C10($InternalNumber_l)+"] due to duplicate remote [FileIDRes Table] record for NRC. Remote [Activity Log]RefID was "+String:C10($RemoteRefID_L)
									If (vbOnScreenMessage)
										ut_MessageDia("Data transfer cancelled due to duplicate [FileIDRes Table] record for NRC. Notify MADOT BMS Support "; "Transfer Messages"; 5; 2)
									End if 
									
								: (4DError_b)
									PLAY:C290("ConAbort")
									ut_Message("* * * * * * * * * * * "+<>sCR)
									ut_Message("Data transfer failed due to 4D error…["+String:C10($InternalNumber_l)+"]"+<>sCR)
									ut_Message("* * * * * * * * * * * "+<>sCR)
									
									X_RecdError_txt:=X_RecdError_txt+"Data transfer failed due to 4D error…["+String:C10($InternalNumber_l)+"]"+Char:C90(13)
									
									If (vbOnScreenMessage)
										ut_MessageDia("Data transfer failed due to 4D error…Notify MADOT BMS Support"; "Transfer Messages"; 5; 2)
									End if 
									
								: (<>vCancel) | (<>Abort)
									PLAY:C290("ConAbort")
									ut_Message("* * * * * * * * * * * "+<>sCR)
									ut_Message("Data transfer cancelled…["+String:C10($InternalNumber_l)+"]"+<>sCR)
									ut_Message("* * * * * * * * * * * "+<>sCR)
									X_RecdError_txt:=X_RecdError_txt+"Data transfer cancelled…["+String:C10($InternalNumber_l)+"]"+Char:C90(13)
									If (vbOnScreenMessage)
										ut_MessageDia("Data transfer cancelled…"; "Transfer Messages"; 5; 2)
									End if 
									
								: (MissingParent_B)
									PLAY:C290("ConAbort")
									ut_Message("* * * * * * * * * * * "+<>sCR)
									ut_Message("Data transfer cancelled…[-111]"+<>sCR)
									ut_Message("* * * * * * * * * * * "+<>sCR)
									X_RecdError_txt:=X_RecdError_txt+"Data transfer cancelled…[-111]"+Char:C90(13)
									If (vbOnScreenMessage)
										ut_MessageDia("Data transfer failed due to Missing Parent record, Notify MADOT BMS Support"; "Transfer Messages"; 5; 2)
									End if 
									
								: ($InternalNumber_l=0)
									ut_Message("* * * * * * * * * * * "+<>sCR)
									ut_Message("All data transfered…No errors occurred"+<>sCR)
									ut_Message("* * * * * * * * * * * "+<>sCR)
									
							End case 
						End if 
						
						X_EndRec_txt:=ut_CreateTimeStamp
						
					End if 
					
				End if   //end if connection made
				
				ut_SQLLogout
				
				$End_d:=Current date:C33(*)
				$Finish_tm:=Current time:C178(*)
				$Elapsed_tm:=fElapsedTime($Start_d; $Start_tm; $End_d; $Finish_tm)
				
				C_TEXT:C284($msg)
				$msg:="Download ended at "+String:C10($End_d; Internal date short special:K1:4)+" - "+String:C10($Finish_tm; HH MM SS:K7:1)+<>sCR
				$msg:=$msg+"Download Time Elapsed : "+String:C10($Elapsed_tm; Hour min sec:K7:3)+<>sCR
				If (Type:C295(vDUplStartDate)=Is date:K8:7)
					//start of upload has been defined
					If (vDUplStartDate#!00-00-00!)
						//and initialized
						If (vDUplFinishDate#!00-00-00!)
							//end of upload has been calculated also          
							$Elapsed_tm:=fElapsedTime(vDUplStartDate; vTUplStartTime; vDUplFinishDate; vTUplFinishTime)
							$msg:=$msg+"Upload Transfer Time Elapsed : "+String:C10($Elapsed_tm; Hour min sec:K7:3)+<>sCR
						End if 
						$Elapsed_tm:=fElapsedTime(vDUplStartDate; vTUplStartTime; $End_d; $Finish_tm)
						$msg:=$msg+"Total Transfer Time Elapsed : "+String:C10($Elapsed_tm; Hour min sec:K7:3)+<>sCR
					End if 
				End if 
				
				If (vbToFileMessage)
					ut_Message($msg)
				End if 
				
				If (vbOnScreenMessage)
					ut_MessageDia($msg; "Transfer Messages"; 5; 2)
				End if 
				
				If ($Lpid>0)  //Restore logoff checker
					<>fUsrPresent:=True:C214  //Set as if the user has been here
					RESUME PROCESS:C320($Lpid)
				End if 
				
			End if 
			
			G_CloseAllTables  //close all tables...      
			ut_CloseMessage
			
		Else 
			
			ut_SQLLogout
			
			Case of 
				: ($Error_l=-2)
					ALERT:C41("Tranfer cancelled due to invalid password")
				: ($Error_l=-4)
					ALERT:C41("Tranfer cancelled due to Password entry screen cancelled")
				: ($Error_l=-9)
					ALERT:C41("You are trying to transfer to "+SeverStructureName_txt+" but should be transfering to "+<>Destination)
			End case 
			PLAY:C290("Goodbye")
		End if 
		
	End if 
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
	
End if 