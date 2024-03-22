//%attributes = {"invisible":true}
// ----------------------------------------------------
// Compiler_SQL
// User name (OS): cjmiller
// Date and time: 06/30/06, 13:11:23
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	// Modified by: Costas Manousakis-(Designer)-(10/4/13 14:36:44)
	Mods_2013_10
	//  `added all SQL_@ methods
	// Modified by: Costas Manousakis-(Designer)-(8/5/14 08:33:53)
	Mods_2014_08_bug
	//  `added SQL_SCHEMA_s
	Mods_2022_02  //Create new interprocess variable <>BackUpStarted_B used during transfers to know when backup is occurring
	//Modified by: Chuck Miller (2/22/22 12:28:01)
	
End if 
C_BOOLEAN:C305(<>BackUpStarted_B)
C_DATE:C307(SQL_Change_d)
C_TEXT:C284(SQL_UserName_s; SQL_DatabaseName_s; SQL_SCHEMA_s)  // Command Replaced was o_C_STRING length was 80
C_TEXT:C284(SQL_Password_s)  // Command Replaced was o_C_STRING length was 30
C_TEXT:C284(SQL_ODBCName_s)  // Command Replaced was o_C_STRING length was 31
C_TEXT:C284(SQLCOUNT_TXT)
C_TEXT:C284(SQLQUERY_TXT)
C_TEXT:C284(SQL_COMMAND_TXT)
C_TEXT:C284(SQL_SELECT)
C_TEXT:C284(SQL_SEQUENCENAME_S)  // Command Replaced was o_C_STRING length was 40
C_TEXT:C284(SQL_TEXT)
C_TEXT:C284(SQL_TXT)
C_TEXT:C284(SQLLOCALID_TXT)
C_TEXT:C284(SQL_SELECTBYREF_TXT)
C_TEXT:C284(SQL_SELECTBYTABLE_TXT)
C_TEXT:C284(KeyValue_txt)
C_BOOLEAN:C305(SQLConnectionMade_b)
C_BOOLEAN:C305(MissingParent_B)
C_BLOB:C604(Send_Blb; Receive_Blb)
If (False:C215)
	C_BOOLEAN:C305(SQL_Connect_New; $0)
	C_TEXT:C284(SQL_Direct; $1)
	C_TEXT:C284(SQL_Direct; $2)
	C_BOOLEAN:C305(SQL_Direct; $0)
	
	C_POINTER:C301(SQL_Direct_ReturnArrays; ${1})
	
	
	C_TEXT:C284(SQL_ReturnErrorDescriptions; $0)
	
	C_TEXT:C284(SQL_ClearArrays; $1)
	//C_LONGINT(SQL_Errors; $1)
	//C_TEXT(SQL_Errors; $2)
	C_TEXT:C284(SQL_SetUpReturnArrays; $1)
	C_POINTER:C301(SQL_SetUpReturnArrays; ${2})
	
	//C_POINTER(SQL_SetUpReturnArrays ;$2)
	//C_POINTER(SQL_SetUpReturnArrays ;$3)
	//C_POINTER(SQL_SetUpReturnArrays ;$4)
	//C_POINTER(SQL_SetUpReturnArrays ;$5)
	//C_POINTER(SQL_SetUpReturnArrays ;$6)
	//C_POINTER(SQL_SetUpReturnArrays ;$7)
	//C_POINTER(SQL_SetUpReturnArrays ;$8)
	//C_POINTER(SQL_SetUpReturnArrays ;$9)
	//C_POINTER(SQL_SetUpReturnArrays ;$10)
	//C_POINTER(SQL_SetUpReturnArrays ;$11)
	//C_POINTER(SQL_SetUpReturnArrays ;$12)
	C_POINTER:C301(SQL_SetUpReturnArrays; ${2})
	C_TEXT:C284(SQL_SetUpStrings; $0)
	C_TEXT:C284(SQL_SetUpStrings; $1)
	C_TEXT:C284(SQL_sp_pontis_update_eleminsp; $0)
	C_TEXT:C284(SQL_sp_Update_NBI_Data; $0)
	C_TEXT:C284(SQL_sp_Update_NonNBI_Data; $0)
	C_TEXT:C284(SQL_sp_BRM_update_eleminsp; $0)
	C_BOOLEAN:C305(SQL_INSPDownloadRecords; $0)
	C_POINTER:C301(SQL_INSPDownloadRecords; $1)
	C_POINTER:C301(SQL_INSPDownloadRecords; $2)
	C_POINTER:C301(SQL_INSPDownloadRecords; $3)
	C_TEXT:C284(SQL_INSPDownloadRecords; $4)
	C_LONGINT:C283(SQL_INSPDownloadRecords; $5)
	C_LONGINT:C283(SQL_INSPDownloadRecords; $6)
	C_LONGINT:C283(SQL_RetrieveNextID; $0)
	C_TEXT:C284(SQL_RetrieveNextID; $1)  // was length of 40
	C_LONGINT:C283(SQL_SetSelectInto; $1)
	C_POINTER:C301(SQL_SetSelectInto; $2)
	C_POINTER:C301(SQL_SetSelectInto; $3)
	C_LONGINT:C283(SQL_utReturnStrings; $1)
	C_LONGINT:C283(SQL_utReturnStrings; $2)
	C_POINTER:C301(SQL_utReturnStrings; $3)
	C_POINTER:C301(SQL_utReturnStrings; $4)
	C_BLOB:C604(SQL_CloneInspectionRelated; $1)
	C_TEXT:C284(SQL_CloneInspectionRelated; $2)
	C_TEXT:C284(SQL_ControlClone; $1)
	C_TEXT:C284(SQL_CountRecords; $1)
	C_LONGINT:C283(SQL_CreateNewDBTable; $1)
	C_TEXT:C284(SQL_CreateNewDBTable; $2)
	C_TEXT:C284(SQL_TestConnection; $0)
	//SQL_CloneElementSafety
	C_BLOB:C604(SQL_CloneElementSafety; $1)
	C_TEXT:C284(SQL_CloneElementSafety; $2)
	C_TEXT:C284(SQL_BidItems_SELECTS; $0)
	C_TEXT:C284(SQL_BidItems_SELECTS; $1)
	C_TEXT:C284(ut_DBSynchWriteOutErrors; $1)
	
	C_BLOB:C604(FN_ReturnLockedRecords; $0; $1)
End if 
//End Compiler_SQL
