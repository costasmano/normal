//%attributes = {"invisible":true}
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 08/11/10, 11:03:02
//----------------------------------------------------
//Method: Mods_OPNToSQLUpgrade
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (8/11/10 11:03:03) 
End if 

//Modified code
//Inc_Sequence

//new code

//ut_ControlDBSycnh
// `Compiler_FieldVariables
// `ut_SQLConnect
// `ut_CheckForBackup
// `ut_SQLExecuteNoReturn
// `Clear_FieldVariables
// `ut_SQLTellServerField
// `ut_SQLTellServerNRC
// `ut_SQLTellServerDRC
// `ut_SQLTellServerGrp_2
// `ut_SQLTellServerGRD
// `ut_SQLTellServerField
// `ut_SQLWriteErrorsToLog
// `ut_SQLDownloadNewRecords

//ut_SQLDownloadNewRecords
// `Compiler_FieldVariables
// `ut_SQLReturnALRecordKeys
// `ut_SetSelectForAllFields
// `ut_CheckForBackup
// `Clear_FieldVariables
// `ut_SQLReturnRecord
// `ut_SQLExecuteNoReturn
// `ut_SQLUpdateLocalTable
// `ut_SQLUpdateLocalField
// `ut_SQLCreateNewRecord
// `ut_SQLDeleteLocalRecord
// `ut_SQLUpdateLocalFields
// `ut_SQLDeleteLocalRecords
// `ut_SQLServerLink
// `ut_SQLCreateOwnerRecords
// `  `ut_SQLCreateRemoteOwnerRecord


//ut_SQLReturnFromFileForSQL
//ut_SQLSetAllVariables
//ut_SQLDeleteRecord
//ut_SQLSelectForLoad

//ut_SQLReturnownerRecords
//ut_SQLWriteCommonError
//ut_SQLGetCorrectRecord
//ut_SQLReturnSelect
//ut_SQLUpdateServerActLog

//New generic
//ut_CreateSQLVariables`You will need to run this any time fields are added, changed or deleted. It will create 2 documents
//The first document will contain compiler directives used in retrieveing and updating information using SQL for upload and download of data between DB's
//Compiler_FieldVariables replace all after else till end if
//The second document will contain commands to clear each of these variables
// clear_FieldVariables replace all after else till end if
//4D_Errors
//ut_SQLConnect
//ut_SQLExecuteNoReturn
//SQL_ERROR
//SQL_RetrieveNextID
//SQL_utReturnStrings


//Speicalty
//Function calls to server
//ut_NextSEQAL called by SQL_RetrieveNextID
//ut_CTRLReturnActKeys called by ut_SQLReturnALRecordKeys
//  `calls ut_SQLReturnActLogRecords
//ut_CheckForBackup
//  `ut_TestForBackup
//ut_SQLReturnALRecordKeys


//Generic to v11
//AddHeader


//Wrtten but not used
//ut_SQLFillTypeArrays
//ut_SQLSetAllVariables



//Modified 
//M_Exec Download
//INSP_DownloadMissing 
//M_Exec Transfer

//WKHR_ProposalToAssignRemote 
//INSP_DownLoadInsp
//WKHR_ProposalToAssignRemote 

//The following methods will need to be deleted

//G_UpdateServerActLog

//IncSeqRemote 
//GetServerBIN
//TellServerGRD
//TellServerNRC
//INSP_UpdateInspection 
//INSP_DWNLD_CUs
//INSP_DWNLD_ElmtsSfty
//INSP_DWNLD_Images 
//INSP_DWNLD_PontisRec 
//INSP_DWNLD_PONTmMembers 
//INSP_DWNLD_Record 
//INSP_DWNLD_Task 
//INSP_DWNLD_TmMembers 
//INSP_PrepareDWNLD 
//INSP_UpdateInspection 
//INSP_UpdateLocalInspFromRemote 
//INSP_UPDATE_Combined 
//INSP_DWNLD_InspRec 
//INSP_UPDATE_getRemoteIDs 
//INSP_UPDATE_InspChildren 
//INSP_UPDATE_PontisRec 
//INSP_UPDATE_Record 
//INSP_UPDATE_TmMembers 
//MHD_GetSIA 
//M_ListServers 
//NewTellServer 
//OP_ErrorCheck 
//OP_ErrorText 
//OP_GetPassword 
//OP_LoadRecord 
//OP_TestForBackup 
//OPN_Error 
//ReApplyDRC 
//ReApplyFLD 
//ReApplyGRP 
//ReApplyNRC 
//ReApplyLogEntries 
//TellServerDRC
//TellServerfld
//TellServergrd
//TellServergrp_2
//TellServerlnk
//TellServernrc
//TestRemoteSeq 
//TestServerID 
//ut_CheckExternalTransf 
//WKHR_PAREMOTE_LoadRec 
//WKHR_PAREMOTE_Search 
//WKHR_PAREMOTE_SetLinks 
//WKHR_PAREMOTE_UpdateValues 
//WKHR_ProposalToAssgn 
//xdownloadserver
//XGetServerDRC
//XGetServerfld
//XGetServergrd
//XGetServergrp
//XGetServerlnk
//XGetServernrc
//x_addownerrec
//x_CheckRemoteLog
//GetCompID 
//GetServerBIN   ` remember to remove button from [Bridge MHD NBIS].bdept Input.bGetRBIN
//End Mods_OPNToSQLUpgrade

