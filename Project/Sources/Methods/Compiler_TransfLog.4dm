//%attributes = {"invisible":true}
//Method: Compiler_TransfLog
//Description
//  ` for saving stats of data transfer
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 12/04/13, 10:20:10
	// ----------------------------------------------------
	//Created : 
	Mods_2013_12
	Mods_2013_12  // Add ability to skip add record errors for certain tables
	//Modified by: Charles Miller (12/19/13 14:09:48)
	// Modified by: Costas Manousakis-(Designer)-(3/24/15 14:48:15)
	Mods_2015_03
	//  `moved some compiler declarations here
	// Modified by: Costas Manousakis-(Designer)-(12/2/15 11:42:54)
	Mods_2015_12_bug
	//  `placed method declarations in if (False)
	// Modified by: Costas Manousakis-(Designer)-(3/9/16 17:03:02)
	Mods_2016_03_bug
	//  `added ut_ControlDBSycnh 
	//  `added ut_FixFileIDRes_pt2  ut_FixRefIDs_pt1 TRANSF_DestIP_txt
	// Modified by: Costas Manousakis-(Designer)-(3/29/16 16:58:24)
	Mods_2016_03_bug
	//  `added  ut_RunDBSynch 
	Mods_2018_05  // Fix issue where we are not checing for locked and loaded record during download 
	//Modified by: Chuck Miller (5/17/18 16:45:49)
	Mods_2018_12  //Added missing boolean definitions
End if 
//
C_LONGINT:C283(X_NumActLogToBeSent_L; X_ActLogToBeSentStart_L; X_ActLogToBeSentEnd_L; X_ActLogLastSent_L)
C_LONGINT:C283(X_NumActLogToBeRecd_L; X_ActLogToBeRecdStart_L; X_ActLogToBeRecdEnd_L; X_ActLogLastRecd_L)
C_TEXT:C284(X_StartSend_txt; X_EndSend_txt; X_StartRec_txt; X_EndRec_txt; X_SendError_txt; X_RecdError_txt)
C_TEXT:C284(TRANSF_DestIP_txt; XFERCurrentProcessName_txt)
C_BOOLEAN:C305(DataRefernceError_b; XFERRecordLoaded_B; MissingParent_B; InWHKRUpdate_b; DataRefernceError_b; DeletionOK_b; SaveActivityLogRecord_b)
If (Type:C295(IgnoreDuplicateKeyTables_atxt)=Is undefined:K8:13)
	ARRAY TEXT:C222(IgnoreDuplicateKeyTables_atxt; 0)
End if 
If (False:C215)
	C_TEXT:C284(fActLogData2Txt; $0)
	C_POINTER:C301(LogLink; $1)
	C_POINTER:C301(LogLink; $2)
	C_POINTER:C301(LogLink; $3)
	C_POINTER:C301(LogLink; $4)
	C_LONGINT:C283(LogLink; $5)
	C_POINTER:C301(LogLink; $6)
	C_LONGINT:C283(FlushChanges; $1)
	C_POINTER:C301(FlushChanges; $2)
	C_POINTER:C301(FlushChanges; $3)
	C_POINTER:C301(FlushChanges; $4)
	C_LONGINT:C283(FlushChanges; $5)
	C_LONGINT:C283(FlushGrpChgs; $1)
	C_POINTER:C301(FlushGrpChgs; $2)
	C_POINTER:C301(FlushGrpChgs; $3)
	C_POINTER:C301(FlushGrpChgs; $4)
	C_LONGINT:C283(FlushGrpChgs; $5)
	C_POINTER:C301(FlushGrpDeletions; $1)
	C_POINTER:C301(FlushGrpDeletions; $2)
	C_POINTER:C301(FlushGrpDeletions; $3)
	C_LONGINT:C283(FlushGrpDeletions; $4)
	C_POINTER:C301(FlushGrpDeletions; $5)
	C_LONGINT:C283(PushChange; $1)
	C_POINTER:C301(PushChange; $2)
	C_POINTER:C301(PushGrpDelete; $1)
	C_POINTER:C301(LogChanges; $1)
	C_POINTER:C301(LogChanges; $2)
	C_POINTER:C301(LogChanges; $3)
	C_POINTER:C301(LogChanges; $4)
	C_LONGINT:C283(LogChanges; $5)
	C_POINTER:C301(LogDeletion; $1)
	C_POINTER:C301(LogDeletion; $2)
	C_POINTER:C301(LogDeletion; $3)
	C_LONGINT:C283(LogDeletion; $4)
	C_POINTER:C301(LogDeletion; $5)
	C_POINTER:C301(LogNewRecord; $1)
	C_POINTER:C301(LogNewRecord; $2)
	C_POINTER:C301(LogNewRecord; $3)
	C_LONGINT:C283(LogNewRecord; $4)
	C_TEXT:C284(LogNewRecord; $5)  // was length of 80
	C_POINTER:C301(LogNewRecord; $6)
	C_POINTER:C301(LogNewRecordChanges; $1; $2; $3)
	C_LONGINT:C283(LogNewRecordChanges; $4)
	C_TEXT:C284(LogNewRecordChanges; $5)
	C_LONGINT:C283(LogNewRecordChanges; $6)
	C_POINTER:C301(LogNewRecordChanges; ${7})
	C_POINTER:C301(PushAllChanges; ${3})
	C_LONGINT:C283(PushAllChanges; $1)
	C_POINTER:C301(PushAllChanges; $2)
	C_LONGINT:C283(ut_ControlDBSycnh; $1)
	C_TEXT:C284(ut_ControlDBSycnh; $2)  // was length of 80
	C_TEXT:C284(ut_SQLDownloadNewRecords; $1)  // was length of 80
	C_LONGINT:C283(ut_SQLDownloadNewRecords; $2)
	C_LONGINT:C283(ut_TestServerStructureName; $0)
	C_TEXT:C284(f_IsDistrictServer; $0)  // was length of 10
	C_BOOLEAN:C305(ut_CheckForBackup; $0)
	C_TEXT:C284(ut_SQLReturnALRecordKeys; $1)
	C_TEXT:C284(ut_SQLReturnALRecordKeys; $2)
	C_LONGINT:C283(ut_SQLReturnALRecordKeys; $3)
	
	C_BLOB:C604(ut_SQLReturnActLogRecords; $0)
	C_TEXT:C284(ut_SQLReturnActLogRecords; $1)
	C_TEXT:C284(ut_SQLReturnActLogRecords; $2)
	C_LONGINT:C283(ut_SQLReturnActLogRecords; $3)
	
	C_LONGINT:C283(ut_SQLReturnINSActRecords; $0)
	C_TEXT:C284(ut_SQLReturnINSActRecords; $1)
	C_TEXT:C284(ut_SQLReturnINSActRecords; $2)
	C_TEXT:C284(ut_SQLReturnINSPRecordKeys; $1)
	C_TEXT:C284(ut_SQLReturnINSPRecordKeys; $2)
	C_LONGINT:C283(ut_SQLReturnFromFileForSQL; $1)
	C_LONGINT:C283(ut_SQLReturnFromFileForSQL; $2)
	C_POINTER:C301(ut_SQLReturnFromFileForSQL; $3)
	C_POINTER:C301(ut_SQLReturnFromFileForSQL; $4)
	C_LONGINT:C283(ut_SQLReturnFromVariablesForSQL; $1)
	C_LONGINT:C283(ut_SQLReturnFromVariablesForSQL; $2)
	C_LONGINT:C283(ut_SQLReturnFromVariablesForSQL; $3)
	C_POINTER:C301(ut_SQLReturnFromVariablesForSQL; $4)
	C_POINTER:C301(ut_SQLReturnFromVariablesForSQL; $5)
	C_TEXT:C284(ut_SetSelectForAllFields; $0)
	C_LONGINT:C283(ut_SetSelectForAllFields; $1)
	C_POINTER:C301(ut_SetSelectForAllFields; $2)
	C_TEXT:C284(ut_SQLReturnRecord; $1)
	C_TEXT:C284(ut_SQLReturnRecord; $2)
	C_TEXT:C284(ut_SQLReturnRecord; $3)
	C_TEXT:C284(ut_SQLExecuteNoReturn; $1)
	C_LONGINT:C283(ut_NewSQLUpdateLocalTable; $1)
	C_BOOLEAN:C305(ut_fTestForSQLor4DError; $0)
	C_POINTER:C301(ut_FixRefIDs_pt1; $1)
	C_POINTER:C301(ut_FixRefIDs_pt1; $2)
	C_POINTER:C301(ut_FixFileIDRes_pt2; $1)
	C_POINTER:C301(ut_FixFileIDRes_pt2; $2)
	C_TEXT:C284(ut_FixFileIDResTransfers; $1)
	C_TEXT:C284(ut_RunDBSynch; $1)
	C_POINTER:C301(ut_SQLDownLoadLoadRecord; $1)
	
	C_TEXT:C284(BMSExternal_Transfer; $1)
	C_BOOLEAN:C305(BMSExternal_Transfer; $2)
	
	C_TEXT:C284(Launch_CtrlClientProc; $1)
	C_TEXT:C284(EditBMSExternalTransf; $1)
	C_TEXT:C284(EditDelayDBSyncParam; $1)
	
	C_POINTER:C301(LogNewRecordInit; $1; $2; $3)
	C_LONGINT:C283(LogNewRecordInit; $4)
	C_TEXT:C284(LogNewRecordInit; $5)
	C_LONGINT:C283(LogNewRecordInit; $6)
	C_POINTER:C301(LogNewRecordInit; ${7})
	
	C_TEXT:C284(LOGIN_BMSPontisTransfer; $1)
	
	C_TEXT:C284(ut_RelogRecords; $1)
	C_TEXT:C284(Synch_ReturnForward; $0)
	C_TEXT:C284(Synch_ReturnForward; $1)
	C_TEXT:C284(Synch_ReturnForward; $2)
	C_TEXT:C284(Synch_ReturnForward; $3)
	C_LONGINT:C283(Synch_ReturnForward; $4)
	C_TEXT:C284(ut_ReturnDestination; $0)
	
End if 
//End Compiler_TransfLog
