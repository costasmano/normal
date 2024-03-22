//%attributes = {"invisible":true}
//----------------------------------------------------
//User name (OS): Chuck Miller
//Date and time: 10/01/15, 17:58:26
//----------------------------------------------------
//Method: Compiler_clone
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// 
	//Modified by: Chuck Miller (10/1/15 17:58:27)
	
End if 
If (False:C215)
	C_BLOB:C604(SQL_ClonePONELEMINSP; $1)
	C_TEXT:C284(SQL_ClonePONELEMINSP; $2)
	
	C_TEXT:C284(Clone_UpdateRecords; $1)
	C_LONGINT:C283(clone_UpdateLocalTable; $1; $2)
	C_LONGINT:C283(clone_SQLUpdateLocalTable; $1)
	C_LONGINT:C283(clone_SQLReturnFromFileForSQL; $1; $2)
	C_TEXT:C284(clone_sqlConnect; $1; $2; $3)
	C_POINTER:C301(clone_SQL_FillMethodHeader; $1; $2; $3; $4)
	C_LONGINT:C283(clone_ReturnUniqueKeys; $1)
	C_BOOLEAN:C305(clone_ReturnUniqueKeys; $0)
	C_POINTER:C301(clone_ReturnUniqueKeys; $2; $3)
	C_BOOLEAN:C305(clone_ReturnUniqueKeys; $4)
	C_DATE:C307(clone_ReturnTimeStampFromDate; $1)
	C_TIME:C306(clone_ReturnTimeStampFromDate; $2)
	C_LONGINT:C283(clone_ReturnKeyFldandVariable; $1)
	C_POINTER:C301(clone_ReturnKeyFldandVariable; $2; $3)
	C_BOOLEAN:C305(clone_ReturnKeyFldandVariable; $4)
	C_LONGINT:C283(Clone_ReturnFieldNumber; $1)
	C_TEXT:C284(Clone_ReturnFieldNumber; $2)
	C_LONGINT:C283(Clone_ReturnFieldNumber; $0)
	C_LONGINT:C283(clone_OpenNewWindow; $0; $1; $2; $3; $4)
	C_TEXT:C284(clone_OpenNewWindow; $5)  // old C_STRING length 80
	C_TEXT:C284(clone_OpenNewWindow; $6)  // old C_STRING length 41
	C_LONGINT:C283(clone_NewSQLUpdateLocalTable; $1)
	C_LONGINT:C283(clone_SQLReturnFromFileForSQL; $1; $2)
	C_POINTER:C301(clone_SQLReturnFromFileForSQL; $3; $4)
	
	C_POINTER:C301(clone_SQL_FillMethodHeader; $1; $2; $3; $4)
	C_LONGINT:C283(clone_SQL_FillMethodHeader; $5)
	
	C_DATE:C307(clone_ReturnTimeStampFromDate; $1)
	C_TIME:C306(clone_ReturnTimeStampFromDate; $2)
	C_TEXT:C284(clone_ReturnTimeStampFromDate; $0)
	C_TEXT:C284(clone_MoveElements; $1)
	C_BOOLEAN:C305(clone_LoadRecord; $0)
	C_POINTER:C301(clone_LoadRecord; $1)
	C_LONGINT:C283(clone_LoadRecord; $2)
	C_POINTER:C301(clone_DeleteSelection; $1)
	
	C_LONGINT:C283(clone_CloneSetUpSelectInto; $1)
	C_POINTER:C301(clone_CloneSetUpSelectInto; $2; $3)
	C_BOOLEAN:C305(clone_CloneSetUpSelectInto; $4)
	C_LONGINT:C283(clone_ClearFieldVariables; $1)
	C_LONGINT:C283(clone_BuildFieldDropDown; $1)
	C_LONGINT:C283(Clone_ArrayToSelection; $1)
	
	C_LONGINT:C283(clone_ReturnUUIDPrimaryKey; $0)
	C_LONGINT:C283(clone_ReturnUUIDPrimaryKey; $1)
	
	C_LONGINT:C283(clone_ProcessBlobs; $1)
	C_LONGINT:C283(clone_ProcessBlobs; $2)
	
	C_LONGINT:C283(clone_GetBlobs; $1)
	
	
	C_BLOB:C604(SQL_CloneElementSafety; $1)  // This method is obsolete and can be removed it has been replaced by SQL_NewCloneElementSafety
	C_TEXT:C284(SQL_CloneElementSafety; $2)
	
	C_LONGINT:C283(sql_CloneRemoveElement; $1)
	C_LONGINT:C283(sql_CloneRemoveElement; $2)
	C_BLOB:C604(SQL_CloneInspectionRelated; $1)
	C_TEXT:C284(SQL_CloneInspectionRelated; $2)
	C_LONGINT:C283(SQL_CloneInspectionRelated; $3)
	
	C_BLOB:C604(SQL_NewCloneElementSafety; $1)
	C_TEXT:C284(SQL_NewCloneElementSafety; $2)
	C_LONGINT:C283(SQL_NewCloneElementSafety; $3)
	
	
	C_LONGINT:C283(LSS_CloneSetUpSelectInto; $1)
	C_POINTER:C301(LSS_CloneSetUpSelectInto; $2; $3)
	C_BOOLEAN:C305(LSS_CloneSetUpSelectInto; $4)
	
	C_LONGINT:C283(clone_ResizeMissingArrays; $1)
	
	C_TEXT:C284(ut_ReturnRecordCountViaSQL; $1)
	C_TEXT:C284(ut_ReturnRecordCountViaSQL; $0)
	
	C_TEXT:C284(FN_ReturnRecordCount; $0)
	C_TEXT:C284(FN_ReturnRecordCount; $1)
	
End if 
ARRAY LONGINT:C221(ProcessLocalCount_aL; 0)
ARRAY LONGINT:C221(ProcessRemoteCount_aL; 0)
ARRAY TEXT:C222(ProcessTableNames_atxt; 0)
ARRAY LONGINT:C221(ProcessTableNumber_aL; 0)
ARRAY TEXT:C222(RemoteQueryType_atxt; 0)
ARRAY TEXT:C222(RemoteKey_atxt; 0)
ARRAY TEXT:C222(RemoteKeyName_atxt; 0)
ARRAY TEXT:C222(RemoteCustomQuery_atxt; 0)
ARRAY LONGINT:C221(LocalCount_al; 0)
ARRAY LONGINT:C221(RemoteCount_al; 0)
ARRAY TEXT:C222(TableNames_atxt; 0)
ARRAY LONGINT:C221(TableNumber_al; 0)
ARRAY LONGINT:C221(RemoteType_aL; 0)
ARRAY TEXT:C222(clone_TablesWithUniqueKey_atxt; 0)
ARRAY POINTER:C280(clone_UniqueKeys_aptr; 0)
ARRAY POINTER:C280(clone_Array_aptr; 0)
ARRAY POINTER:C280(clone_Table_aPtr; 0)
ARRAY TEXT:C222(SQL_LimitNames_atxt; 0)
ARRAY LONGINT:C221(SQL_Limits_AL; 0)
ARRAY LONGINT:C221(FieldTypes_al; 0)
ARRAY POINTER:C280(KeysToReset_aptr; 0)
ARRAY LONGINT:C221(KeyIndextType_aL; 0)
ARRAY LONGINT:C221(clone_PrimaryKeyTable_aL; 0)
ARRAY LONGINT:C221(clone_PrimaryField_aL; 0)
ARRAY TEXT:C222(clone_RemoteTables_atxt; 0)
C_DATE:C307(SQLKeyValue_d)
C_LONGINT:C283(SQLKeyValue_L)
C_BOOLEAN:C305(SQLKeyValue_b)

C_LONGINT:C283(SQL_Limit_L; clone_IncludeUUIDS_L; clone_UseBlobArrays_L)
C_BOOLEAN:C305(clone_IncludeUUIDS_B; clone_UseBlobArrays_B)
//C_BLOB(BlobHoldUpdates_blb)

C_TEXT:C284(Clone_IPAddress_txt; UserName_txt; Password_txt)
C_TEXT:C284(BlobPrimaryKey_txt)
C_LONGINT:C283(BlobPrimaryKey_L)
C_LONGINT:C283(FillEmptydb_L)
ARRAY TEXT:C222(clone_MissRemoteTableFld_atxt; 0)
ARRAY TEXT:C222(clone_MissingArrayNames_atxt; 0)

C_POINTER:C301(Clone_FirstArray_ptr)