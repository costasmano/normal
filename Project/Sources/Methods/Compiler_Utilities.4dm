//%attributes = {"invisible":true}
//Method: COMPILER_Utilities
//Description
// compiler declarations for utility methods ut_@
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/10/12
	// ----------------------------------------------------
	//Created : 
	Mods_2012_09
	// Modified by: Costas Manousakis-(Designer)-(12/7/12 11:41:35)
	Mods_2012_12
	//  `added ut_SpecialReport
	// Modified by: Costas Manousakis-(Designer)-(3/22/13 15:11:17)
	Mods_2013_03
	//  `added  ut_EditList
	// Modified by: Costas Manousakis-(Designer)-(6/6/13 09:42:08)
	Mods_2013_06
	//  `added  ut_WindowSize
	// Modified by: Costas Manousakis-(Designer)-(9/25/13 16:13:21)
	Mods_2013_09
	//  `added  ut_ReturnSerialData
	// Modified by: Costas Manousakis-(Designer)-(11/5/13 )
	Mods_2013_11
	//  `added  variables for the 4D Write area test dialog
	// Modified by: Costas Manousakis-(Designer)-(11/18/13 10:30:06)
	Mods_2013_11
	//  `added vars  for the RELOG dialog
	// Modified by: Costas Manousakis-(Designer)-(12/4/13 13:01:58)
	Mods_2013_12
	//  `ut_formatTimeStamp
	// Modified by: Costas Manousakis-(Designer)-(12/23/13 10:19:37)
	Mods_2013_12
	//  `SETUTIL_Control
	// Modified by: Costas Manousakis-(Designer)-(2/13/14 09:43:28)
	Mods_2014_02_bug
	//  `Added all vars /arrays for the RELOG dialog
	// Modified by: Costas Manousakis-(Designer)-(3/10/14 12:17:23)
	Mods_2014_03
	//  `added ut_getURLfromText
	// Modified by: Costas Manousakis-(Designer)-(4/7/14 13:13:28)
	Mods_2014_04_bug
	//  `added G_listTable
	// Modified by: Costas Manousakis-(Designer)-(5/23/14 14:55:04)
	Mods_2014_05
	//  `added  utf_ConnectedToBoston_b
	// Modified by: Costas Manousakis-(Designer)-(8/15/14 16:41:18)
	Mods_2014_08
	//  `added ut_insertTxt2WRblb
	// Modified by: Costas Manousakis-(Designer)-(9/8/14 17:43:13)
	Mods_2014_09
	//  `added  ut_SysParamToArray ; ut_MessageArray
	// Modified by: Costas Manousakis-(Designer)-(10/16/14 11:58:13)
	Mods_2014_10
	//  `added  ut_Launch_IE and ut_DOM_To_Arrays
	// Modified by: Costas Manousakis-(Designer)-(4/27/15 16:36:53)
	Mods_2015_04
	//  `Added two SVG utilities
	// Modified by: Costas Manousakis-(Designer)-(9/9/15 15:21:20)
	Mods_2015_09_bug
	//  `added ut_ArrayToDynamicMenu
	// Modified by: Costas Manousakis-(Designer)-(10/20/15 17:36:23)
	Mods_2015_10_bug
	//  `added ut_DisplayArray
	// Modified by: Costas Manousakis-(Designer)-(11/18/15 17:49:37)
	Mods_2015_11
	//  `added  ut_runApplescript
	// Modified by: Costas Manousakis-(Designer)-(12/21/15 15:02:12)
	Mods_2015_12_bug
	//  `added ut_ArrayToText
	// Modified by: Costas Manousakis-(Designer)-(3/29/16 13:39:49)
	Mods_2016_03_bug
	//  `added ut_db_RestoreROState  ut_db_SaveROState
	// Modified by: Costas Manousakis-(Designer)-(4/20/16 11:50:40)
	Mods_2016_04_bug
	//  `added ut_FitPrintFormObject , ut_OpenNewWindow, ut_FitPrintFormObjectbyName
	// Modified by: Costas Manousakis-(Designer)-(5/17/16 10:13:42)
	Mods_2016_05_bug
	//  `add ut_CountFormVars
	// Modified by: Costas Manousakis-(Designer)-(6/14/16 14:58:33)
	Mods_2016_06
	//  `added ut_ReturnPictureType
	// Modified by: Costas Manousakis-(Designer)-(8/5/16 14:42:52)
	Mods_2016_08
	//  `add vars for print destination to pdf
	// Modified by: Costas Manousakis-(Designer)-(12/20/16 12:18:39)
	Mods_2016_12
	//  `added Print_TrimText
	Mods_2017_01  // Add Save of prefs folder and save of [ServerProcesses] records
	//Modified by: administrator (1/12/17 13:10:12)
	
	// Modified by: Costas Manousakis (1/13/17)
	Mods_2017_01
	//  // added missing declarations for v15
	
	// Modified by: Costas Manousakis (2/6/17)
	Mods_2017_02
	// Several Test_ methods
	Mods_2018_02  //Add new method to limit length of text variables on forms - call on after edit
	//Modified by: Chuck Miller (2/20/18 17:20:46)
	Mods_2019_07  //Modify code to save better folder structure when saving mnethdos and to identify Form methdods
	//Modified by: Chuck Miller (7/16/19 17:02:22)
	Mods_2020_01  //Add compiler directive fior search for uysing new search widget from BF
	//Modified by: CJ (1/21/20 11:09:17)
	Mods_2021_04  //Added code to allow for selected of previously saved Users and Group File
	//Modified by: CJ (4/13/21 15:57:01)
End if 
//
ARRAY TEXT:C222(<>DesignMethodNames_atxt; 0)
ARRAY TEXT:C222(<>DesignMethodCode_atxt; 0)

ARRAY REAL:C219(<>BRG_CONDRANGE_aR; 0)
ARRAY TEXT:C222(<>BRG_CONDRANGE_atxt; 0)

//Method: ut_SpecialReport
ARRAY TEXT:C222(Item8_atxt; 0)
ARRAY LONGINT:C221(Item27_aL; 0)
ARRAY LONGINT:C221(Item106_aL; 0)
ARRAY TEXT:C222(Item43_atxt; 0)
ARRAY TEXT:C222(Item58_atxt; 0)
ARRAY TEXT:C222(Item59_atxt; 0)
ARRAY TEXT:C222(Item60_atxt; 0)
ARRAY TEXT:C222(Item62_atxt; 0)

//Method: ut_EditList
ARRAY TEXT:C222(LISTEDIT_Lists_atxt; 0)
C_TEXT:C284(LISTMODIFIER_txt)

ARRAY TEXT:C222(TOL_Values_atxt; 0)

C_TEXT:C284(WrtTest_codes_txt; WrtTest_txt; WrtTest_Props_txt; WrtTest_FormatTxtBlb_txt)
C_LONGINT:C283(WriteArea)

C_LONGINT:C283(RELOGSEARCH)
C_LONGINT:C283(RELOGCANCEL)
C_LONGINT:C283(RELOGDO)
C_LONGINT:C283(LogDelfirst_L; LogNewRecfirst_L)
C_LONGINT:C283(RELOG_TBLNum_L; RELOG_Relation_L; RELOG_DELFIRST_L; RELOG_RecsFound_L; RELOG_KeyField_L; RELOG_ParentTbl_L; RELOG_FK_L; RELOG_PK_L; RelogTransfer_L)
C_TEXT:C284(RelogForward_txt)
C_TEXT:C284(RELOG_SEQ_txt; RELOG_DEST_txt; RelogDestination_txt)
ARRAY TEXT:C222(TableList_atxt; 0)
ARRAY TEXT:C222(KeyFieldList_atxt; 0)
ARRAY TEXT:C222(Sequence_atxt; 0)
ARRAY TEXT:C222(ParentTableList_atxt; 0)
ARRAY TEXT:C222(ForeignKeyList_atxt; 0)
ARRAY TEXT:C222(ParentKeyList_atxt; 0)
ARRAY TEXT:C222(RelationsList_atxt; 0)
ARRAY TEXT:C222(RelationsFlushList_atxt; 0)
ARRAY LONGINT:C221(TableList_aL; 0)
ARRAY LONGINT:C221(ParentTableList_aL; 0)

C_TEXT:C284(web Area; web area_url)

C_TEXT:C284(SQLStmt_txt; SQLResult_txt)
ARRAY BOOLEAN:C223(NEWLB; 0)
C_REAL:C285(HEADER1)
C_REAL:C285(HEADER2)
C_REAL:C285(HEADER3)
C_REAL:C285(HEADER4)
C_REAL:C285(HEADER5)
C_REAL:C285(HEADER6)
C_REAL:C285(HEADER7)
C_REAL:C285(HEADER8)
C_REAL:C285(HEADER9)
C_REAL:C285(HEADER10)
C_REAL:C285(HEADER11)
C_REAL:C285(HEADER12)
C_REAL:C285(HEADER13)
C_REAL:C285(HEADER14)
C_REAL:C285(HEADER15)
C_REAL:C285(HEADER16)
C_REAL:C285(HEADER17)
C_REAL:C285(HEADER18)
C_REAL:C285(HEADER19)
C_REAL:C285(HEADER20)
C_REAL:C285(HEADER21)
C_REAL:C285(HEADER22)
C_REAL:C285(HEADER23)
C_REAL:C285(HEADER24)
C_REAL:C285(HEADER25)
C_REAL:C285(HEADER26)
C_REAL:C285(HEADER27)
C_REAL:C285(HEADER28)
C_REAL:C285(HEADER29)
C_REAL:C285(HEADER30)

ARRAY TEXT:C222(COLUMN1; 0)
ARRAY TEXT:C222(Column2; 0)
ARRAY TEXT:C222(Column3; 0)
ARRAY TEXT:C222(Column4; 0)
ARRAY TEXT:C222(Column5; 0)
ARRAY TEXT:C222(Column6; 0)
ARRAY TEXT:C222(Column7; 0)
ARRAY TEXT:C222(Column8; 0)
ARRAY TEXT:C222(Column9; 0)
ARRAY TEXT:C222(Column10; 0)
ARRAY TEXT:C222(Column11; 0)
ARRAY TEXT:C222(Column12; 0)
ARRAY TEXT:C222(Column13; 0)
ARRAY TEXT:C222(Column14; 0)
ARRAY TEXT:C222(Column15; 0)
ARRAY TEXT:C222(Column16; 0)
ARRAY TEXT:C222(Column17; 0)
ARRAY TEXT:C222(Column18; 0)
ARRAY TEXT:C222(Column19; 0)
ARRAY TEXT:C222(Column20; 0)
ARRAY TEXT:C222(Column21; 0)
ARRAY TEXT:C222(Column22; 0)
ARRAY TEXT:C222(Column23; 0)
ARRAY TEXT:C222(Column24; 0)
ARRAY TEXT:C222(Column25; 0)
ARRAY TEXT:C222(Column26; 0)
ARRAY TEXT:C222(Column27; 0)
ARRAY TEXT:C222(Column28; 0)
ARRAY TEXT:C222(Column29; 0)
ARRAY TEXT:C222(Column30; 0)

C_POINTER:C301(makeBielief_p)
ARRAY TEXT:C222(LocalIDs_atxt; 0)
ARRAY TEXT:C222(RemoteIDs_atxt; 0)
ARRAY TEXT:C222(Reasons_atxt; 0)
ARRAY BOOLEAN:C223(NoLocal_aB; 0)

C_LONGINT:C283(<>CurrentLoop_L)
C_BLOB:C604(<>Report_blb)

C_TEXT:C284(PRINT_DestFolder_txt; PRINT_DestFileName_txt; PRINT_TempDestFolder_txt)
C_BOOLEAN:C305(PRINT_PdfDest_b)
C_LONGINT:C283(PRINT_destCount_L)

ARRAY TEXT:C222(Bridgekey; 0)
ARRAY TEXT:C222(BridgeID; 0)
ARRAY TEXT:C222(BridgeStrNum; 0)
ARRAY TEXT:C222(BridgeGroup; 0)
ARRAY TEXT:C222(InspKey; 0)
ARRAY TEXT:C222(InspDateText; 0)
ARRAY DATE:C224(InspDate_ad; 0)
ARRAY TEXT:C222(INSPNAME; 0)
ARRAY LONGINT:C221(NBINSPDONE; 0)
ARRAY LONGINT:C221(ELINSPDONE; 0)
ARRAY LONGINT:C221(UWINSPDONE; 0)
ARRAY LONGINT:C221(FCINSPDONE; 0)
ARRAY LONGINT:C221(OSINSPDONE; 0)
ARRAY LONGINT:C221(PontisCUCount; 0)
ARRAY TEXT:C222(BMSBIN; 0)
ARRAY LONGINT:C221(BMSInspID; 0)
ARRAY DATE:C224(BMSInspDate; 0)
ARRAY TEXT:C222(BMSInspType; 0)
ARRAY LONGINT:C221(BmsNBEID; 0)
ARRAY LONGINT:C221(BmsComplete; 0)
ARRAY LONGINT:C221(BmsReviewed; 0)
ARRAY LONGINT:C221(BmsApproved; 0)
ARRAY LONGINT:C221(BMSBMSInspID; 0)
ARRAY LONGINT:C221(BmsNBECount; 0)


//For Server Process
ARRAY TEXT:C222(DocumentNames_atxt; 0)
ARRAY LONGINT:C221(Counts_aL; 0)
ARRAY DATE:C224(CreatedDates_ad; 0)
ARRAY TEXT:C222(CreatedTimes_atxt; 0)

If (False:C215)
	C_LONGINT:C283(ut_FixGetActivityLogRecords; $0)
	C_LONGINT:C283(ut_FixGetActivityLogRecords; $1)
	
	C_TEXT:C284(ut_EditVariableList; $1)
	
	C_TEXT:C284(ut_defineBrgCondRtg; $1)
	
	C_POINTER:C301(ut_GetChildTables; $1)
	C_POINTER:C301(ut_GetChildTables; $2)
	C_POINTER:C301(ut_GetChildTables; $3)
	C_POINTER:C301(ut_GetChildTables; $4)
	C_POINTER:C301(ut_GetChildTables; $5)
	
	C_TEXT:C284(ut_WindowSize; $1)
	C_POINTER:C301(ut_WindowSize; $2)
	C_POINTER:C301(ut_WindowSize; $3)
	C_POINTER:C301(ut_WindowSize; $4)
	C_TEXT:C284(ut_WindowSize; $5)
	
	C_TEXT:C284(TOL_ListToArray; $1)
	C_POINTER:C301(TOL_ListToArray; $2)
	
	C_BLOB:C604(ut_ReturnSerialData; $0)
	
	C_TEXT:C284(ut_FilepathToRFC; $0)
	C_TEXT:C284(ut_FilepathToRFC; $1)
	
	C_REAL:C285(ut_degToDegMinSec; $1)
	C_POINTER:C301(ut_degToDegMinSec; $2; $3; $4)
	
	C_REAL:C285(ut_DegMinSecToDeg; $0)
	C_REAL:C285(ut_DegMinSecToDeg; $1)
	C_REAL:C285(ut_DegMinSecToDeg; $2)
	C_REAL:C285(ut_DegMinSecToDeg; $3)
	
	C_TEXT:C284(ut_formatTimeStamp; $0)
	C_TEXT:C284(ut_formatTimeStamp; $1)
	
	C_BOOLEAN:C305(SETUTIL_Control; $0)
	C_TEXT:C284(SETUTIL_Control; $1)
	C_POINTER:C301(SETUTIL_Control; $2)
	
	C_POINTER:C301(ut_ComboMenuC; $1)
	C_POINTER:C301(ut_ComboMenuC; $2)
	
	C_TEXT:C284(ut_ParseVersionString; $1)
	C_POINTER:C301(ut_ParseVersionString; $2)
	
	C_LONGINT:C283(ut_VersionCheck; $0)
	C_TEXT:C284(ut_VersionCheck; $1)
	C_TEXT:C284(ut_VersionCheck; $2)
	
	C_TEXT:C284(ut_UpdateSysParameter; $1)
	C_TEXT:C284(ut_UpdateSysParameter; $2)
	C_TEXT:C284(ut_UpdateSysParameter; $3)
	
	C_LONGINT:C283(ut_CompareParts_L; $0)
	C_TEXT:C284(ut_CompareParts_L; $1; $2)
	
	C_TEXT:C284(ut_getURLfromText; $0)
	C_TEXT:C284(ut_getURLfromText; $1)
	
	C_POINTER:C301(ut_Rank; $1)
	C_POINTER:C301(ut_Rank; $2)
	C_TEXT:C284(ut_Rank; $3)
	
	C_PICTURE:C286(ut_ImageFromPasteboard; $0)
	
	C_TEXT:C284(G_ListTable; $1)
	
	C_BOOLEAN:C305(utf_ConnectedToBoston_b; $0)
	
	C_POINTER:C301(ut_insertTxt2WRblb; $1)
	C_TEXT:C284(ut_insertTxt2WRblb; $2)
	C_LONGINT:C283(ut_insertTxt2WRblb; $3)
	
	C_TEXT:C284(ut_SysParamToArray; $1)
	C_POINTER:C301(ut_SysParamToArray; $2)
	C_TEXT:C284(ut_SysParamToArray; $3)
	C_TEXT:C284(ut_SysParamToArray; $4)
	C_TEXT:C284(ut_SysParamToArray; $5)
	
	C_POINTER:C301(ut_MessageArray; $1)
	
	C_TEXT:C284(ut_Launch_IE; $1)
	
	C_LONGINT:C283(fn_MinBridgeCondition; $0)
	C_TEXT:C284(fn_MinBridgeCondition; ${1})  // old C_STRING length 1
	
	C_TEXT:C284(fn_BridgeCondMeasure; $0)
	C_LONGINT:C283(fn_BridgeCondMeasure; $1)
	
	C_POINTER:C301(getTableByName; $0)
	C_TEXT:C284(getTableByName; $1)
	C_POINTER:C301(getFieldbyname; $0)
	C_TEXT:C284(getFieldbyname; $1)
	C_TEXT:C284(getFieldbyname; $2)
	
	C_TEXT:C284(ISODateTime; $0)
	C_DATE:C307(ISODateTime; $1)
	C_TIME:C306(ISODateTime; $2)
	
	C_DATE:C307(ISOStringToDate; $0)
	C_TEXT:C284(ISOStringToDate; $1)
	
	C_TEXT:C284(SVG_GetALLObjects; $1)
	C_POINTER:C301(SVG_GetALLObjects; $2; $3; $4)
	
	C_POINTER:C301(SVG_TranslatePath; $1)
	C_REAL:C285(SVG_TranslatePath; $2; $3)
	
	C_TEXT:C284(ut_ArrayToDynamicMenu; $0)  // old C_STRING length 16
	C_POINTER:C301(ut_ArrayToDynamicMenu; $1)
	C_POINTER:C301(ut_ArrayToDynamicMenu; $2)
	C_TEXT:C284(ut_ArrayToDynamicMenu; $3)  // old C_STRING length 1
	
	C_TEXT:C284(ut_PerformanceTest; $1)  // old C_STRING length 20
	C_TEXT:C284(ut_PerformanceTest; ${2})  // old C_STRING length 20
	C_BLOB:C604(ut_TestBlob)
	C_TEXT:C284(ut_sStatus)  // old C_STRING length 10
	C_LONGINT:C283(ut_iPerformanceProcess)
	
	C_TEXT:C284(ut_ArrayToPopupMenu; $0)
	C_POINTER:C301(ut_ArrayToPopupMenu; $1)
	C_TEXT:C284(ut_ArrayToPopupMenu; $2)
	
	C_POINTER:C301(Dev_pickFields; $1)
	C_POINTER:C301(Dev_pickFields; $2)
	
	C_POINTER:C301(ut_DisplayArray; $1)
	C_TEXT:C284(ut_DisplayArray; $2)
	C_TEXT:C284(ut_DisplayArray; $3)
	
	C_POINTER:C301(utl_ExportTOLFromArrays; $1; $3)
	C_TEXT:C284(utl_ExportTOLFromArrays; $2)
	
	
	C_TEXT:C284(ut_runApplescript; $0)
	C_TEXT:C284(ut_runApplescript; $1)
	
	C_TEXT:C284(ut_ArrayToText; $0)
	C_POINTER:C301(ut_ArrayToText; $1)
	C_TEXT:C284(ut_ArrayToText; $2)
	C_TEXT:C284(ut_ArrayToText; $3)
	C_TEXT:C284(ut_ArrayToText; $4)
	
	C_TEXT:C284(ut_ReturnProcessName; $0)
	C_LONGINT:C283(ut_ReturnProcessName; $1)
	
	C_BLOB:C604(ut_db_RestoreROState; $1)
	C_BLOB:C604(ut_db_SaveROState; $0)
	
	C_BOOLEAN:C305(ut_FitPrintFormObject; $0)
	C_POINTER:C301(ut_FitPrintFormObject; $1)
	C_LONGINT:C283(ut_FitPrintFormObject; $2)
	C_LONGINT:C283(ut_FitPrintFormObject; $3)
	C_LONGINT:C283(ut_FitPrintFormObject; $4)
	C_LONGINT:C283(ut_FitPrintFormObject; $5)
	
	C_LONGINT:C283(ut_OpenNewWindow; $0)
	C_LONGINT:C283(ut_OpenNewWindow; $1)
	C_LONGINT:C283(ut_OpenNewWindow; $2)
	C_LONGINT:C283(ut_OpenNewWindow; $3)
	C_LONGINT:C283(ut_OpenNewWindow; $4)
	C_TEXT:C284(ut_OpenNewWindow; $5)  // old C_STRING length 80
	C_TEXT:C284(ut_OpenNewWindow; $6)  // old C_STRING length 41
	
	C_BOOLEAN:C305(ut_FitPrintFormObjectbyName; $0)
	C_TEXT:C284(ut_FitPrintFormObjectbyName; $1)
	C_LONGINT:C283(ut_FitPrintFormObjectbyName; $2)
	C_LONGINT:C283(ut_FitPrintFormObjectbyName; $3)
	C_LONGINT:C283(ut_FitPrintFormObjectbyName; $4)
	C_LONGINT:C283(ut_FitPrintFormObjectbyName; $5)
	
	C_LONGINT:C283(ut_CountFormVars; $0)
	C_TEXT:C284(ut_CountFormVars; $1)
	
	C_PICTURE:C286(ut_ReturnPictureType; $1)
	C_LONGINT:C283(ut_ReturnPictureType; $0)
	
	C_TEXT:C284(ut_GetSysParameter; $0)
	C_TEXT:C284(ut_GetSysParameter; $1)
	C_TEXT:C284(ut_GetSysParameter; $2)
	C_TEXT:C284(ut_GetSysParameter; $3)
	
	C_TEXT:C284(ut_SaveSysParam; $1)
	C_TEXT:C284(ut_SaveSysParam; $2)
	C_TEXT:C284(ut_SaveSysParam; $3)
	
	C_LONGINT:C283(Print_TrimText; $0)
	C_POINTER:C301(Print_TrimText; $1)
	C_LONGINT:C283(Print_TrimText; $2)
	
	C_TEXT:C284(ut_ReturnServerExportFolder; $0)
	C_TEXT:C284(ut_ReturnServerExportFolder; $1)
	
	C_TEXT:C284(ut_ClearSavedPassword; $1)
	
	C_TEXT:C284(ut_ResetWindowDefaults; $1)
	
	C_TEXT:C284(ut_ReturnDayorMonthName; $1; $0)
	C_LONGINT:C283(ut_ReturnDayorMonthName; $2)
	
	ARRAY TEXT:C222(<>Weekdays_atxt; 0)
	
	C_TEXT:C284(FN_MilliSec2TimeStr; $0)
	C_LONGINT:C283(FN_MilliSec2TimeStr; $1)
	
	C_TEXT:C284(Test_SelectSRVFile; $0)
	C_TEXT:C284(Test_SelectSRVFile; $1)
	
	C_POINTER:C301(Test_getResources; $1)
	C_TEXT:C284(Test_getResources; $2)
	
	C_BLOB:C604(Test_GetFileFromSRVR; $0)
	C_TEXT:C284(Test_GetFileFromSRVR; $1)
	
	C_BOOLEAN:C305(Test_SaveFileOnSRVR; $0)
	C_TEXT:C284(Test_SaveFileOnSRVR; $1)
	C_BLOB:C604(Test_SaveFileOnSRVR; $2)
	
	C_TEXT:C284(Image_Parser; $1)
	C_POINTER:C301(Image_Parser; $2)
	C_POINTER:C301(Image_Parser; $3)
	C_POINTER:C301(Image_Parser; $4)
	C_POINTER:C301(Image_Parser; $5)
	C_TEXT:C284(Image_Parser; $6)
	C_POINTER:C301(Image_Parser; $7)
	C_POINTER:C301(Image_Parser; $8)
	
	C_PICTURE:C286(Make4StateButton; $1)
	C_PICTURE:C286(Make4StateButton; $0)
	
	C_POINTER:C301(dev_mergeCodeAndDesc; $1)
	C_POINTER:C301(dev_mergeCodeAndDesc; $2)
	
	C_POINTER:C301(ut_GetRandomSet; $1)
	C_POINTER:C301(ut_GetRandomSet; $2)
	C_LONGINT:C283(ut_GetRandomSet; $3)
	
	C_TEXT:C284(ut_ResetIPToServer; $1)
	
	C_TEXT:C284(DEV_logEventPath; $1)
	C_LONGINT:C283(DEV_logEventPath; $2)
	
	C_OBJECT:C1216(DEV_LogEvents_o)
	
	C_POINTER:C301(popup_MenuFromTablePtr; $0; $1; $2; $3; $5)
	C_TEXT:C284(popup_MenuFromTablePtr; $4)
	
	C_TEXT:C284(ut_OpenMethod; $1)
	C_TEXT:C284(ut_NewSaveMethod; $1)
	C_TEXT:C284(ut_NewSaveMethod; $2)
	C_TEXT:C284(ut_NewSaveMethod; $3)
	
	C_TEXT:C284(DEV_ShowModDateTimes; $1)
	
	C_BLOB:C604(ut_StructListsToBlob; $0)
	C_BLOB:C604(ut_BlobToStructureLists; $1)
	C_BLOB:C604(ut_GetUsersToBlob; $0)
	
	C_OBJECT:C1216(ProgressNew; $0)
	C_TEXT:C284(ProgressNew; $1)
	C_LONGINT:C283(ProgressNew; $2)
	C_BOOLEAN:C305(ProgressNew; $3)
	C_TEXT:C284(ProgressNew; $4)
	C_LONGINT:C283(ProgressNew; $5)
	
	C_OBJECT:C1216(UpdateProgressNew; $1)
	C_LONGINT:C283(UpdateProgressNew; $2)
	
	C_TEXT:C284(InsertTabsInNBILine; $0)
	C_TEXT:C284(InsertTabsInNBILine; $1)
	
	C_TEXT:C284(TabbedNBITapeHeader; $0)
	
	C_TEXT:C284(DBG_Get4DWriteDocProps; $0)
	C_LONGINT:C283(DBG_Get4DWriteDocProps; $1)
	
	C_TEXT:C284(DBG_Get4DWriteAreaProps; $0)
	C_LONGINT:C283(DBG_Get4DWriteAreaProps; $1)
	
	C_TEXT:C284(DBG_Get4DWritePrintProps; $0)
	C_LONGINT:C283(DBG_Get4DWritePrintProps; $1)
	
	C_TEXT:C284(DBG_GetPrintOptions; $0)
	
	C_BOOLEAN:C305(ACT_PushGroupChanges; $0)
	C_LONGINT:C283(ACT_PushGroupChanges; $1)
	C_LONGINT:C283(ACT_PushGroupChanges; $2)
	C_POINTER:C301(ACT_PushGroupChanges; $3)
	C_BOOLEAN:C305(ACT_PushGroupChanges; $4)
	
	C_TEXT:C284(fGetProcessOrigin; $0)
	C_LONGINT:C283(fGetProcessOrigin; $1)
	
	C_BOOLEAN:C305(DEV_ConvertButtonCmd; $0)
	C_POINTER:C301(DEV_ConvertButtonCmd; $1)
	
	C_BOOLEAN:C305(DEV_Convert_o_c_Declarations; $0)
	C_POINTER:C301(DEV_Convert_o_c_Declarations; $1)
	
	C_BOOLEAN:C305(DEV_ConvertObjectSetColor; $0)
	C_POINTER:C301(DEV_ConvertObjectSetColor; $1)
	
	C_TEXT:C284(DEV_MethodPathToName; $0)
	C_TEXT:C284(DEV_MethodPathToName; $1)
	
	C_POINTER:C301(ut_LimitLength; $1)
	C_LONGINT:C283(ut_LimitLength; $2)
	
	C_TEXT:C284(ut_FormGetObjects; $1)
	C_POINTER:C301(ut_FormGetObjects; $2)
	
	C_TEXT:C284(DEV_GetFormObjects; $1)
	C_LONGINT:C283(DEV_GetFormObjects; $2)
	C_POINTER:C301(DEV_GetFormObjects; $3)
	
	C_LONGINT:C283(MatchArrayRegex; $0)
	C_POINTER:C301(MatchArrayRegex; $1)
	C_TEXT:C284(MatchArrayRegex; $2)
	C_LONGINT:C283(MatchArrayRegex; $3)
	C_LONGINT:C283(MatchArrayRegex; $4)
	
	C_BOOLEAN:C305(ut_FormGetObjects; $3)
	
	C_TIME:C306(GEN_TimestampDifference; $0)
	C_TEXT:C284(GEN_TimestampDifference; $1)
	C_TEXT:C284(GEN_TimestampDifference; $2)
	
	C_TEXT:C284(GEN_GetTimeZoneOffset; $0)
	
	C_OBJECT:C1216(GEN_DateTim_GMT_To_Local; $0)
	C_TEXT:C284(GEN_DateTim_GMT_To_Local; $1)
	
	C_TEXT:C284(DBG_Collect4DWRData; $1)
	C_TEXT:C284(DBG_Collect4DWRData; $2)
	C_LONGINT:C283(DBG_Collect4DWRData; $3)
	
	C_BLOB:C604(DBG_Collect4DWRData_o)
	
	C_TEXT:C284(TextToSpeach; $1)
	
	C_OBJECT:C1216(GetChildTables; $1)
	
	C_TEXT:C284(ut_ArraysToText; $0)
	C_TEXT:C284(ut_ArraysToText; $1)
	C_POINTER:C301(ut_ArraysToText; ${2})
	
	C_POINTER:C301(ut_SelectRandomRecords; $1)
	C_LONGINT:C283(ut_SelectRandomRecords; $2)
	C_TEXT:C284(ut_SelectRandomRecords; $3)
	C_TEXT:C284(ut_SelectRandomRecords; $4)
	
	C_TEXT:C284(FORM_HideEnclosedObjs; $1)
	C_LONGINT:C283(FORM_HideEnclosedObjs; $2)
	C_TEXT:C284(FORM_HideEnclosedObjs; $3)
	
	C_LONGINT:C283(FORM_FitWindowToCurrPage; $1)
	C_BOOLEAN:C305(ut_LoadRecordNoWait; $0)
	C_POINTER:C301(ut_LoadRecordNoWait; $1)
	C_TEXT:C284(ut_ReturnMountIfMounted; $1)
	C_TEXT:C284(ut_ReturnMountIfMounted; $0)
	
	C_TEXT:C284(ut_MountVolume; $1)
	C_TEXT:C284(ut_MountVolume; $2)
	C_TEXT:C284(ut_MountVolume; $3)
	C_TEXT:C284(ut_MountVolume; $4)
	C_TEXT:C284(ut_MountVolume; $0)
	
	C_TEXT:C284(ut_ReturnWindowsMountInfo; $1; $0)
	
	C_TEXT:C284(ut_SetWindowSize; $1; $2)
	
	C_BOOLEAN:C305(ut_isSharedFolderMounted; $0)
	C_TEXT:C284(ut_isSharedFolderMounted; $1; $2)
	C_POINTER:C301(ut_isSharedFolderMounted; $3)
	C_TEXT:C284(ut_isSharedFolderMounted; $4)
	
	C_TEXT:C284(ut_RunScript; $0; $1)
	C_POINTER:C301(ut_Posix; $1)
	C_TEXT:C284(dev_ObjectTotextColumns; $0)
	C_OBJECT:C1216(dev_ObjectTotextColumns; $1)
	
	C_TEXT:C284(dev_SVG_DrawStructure; $1)
	
	C_TEXT:C284(CleanFileName; $0)
	C_TEXT:C284(CleanFileName; $1)
	
	C_OBJECT:C1216(SysDoc_IsShareMounted; $0)
	C_TEXT:C284(SysDoc_IsShareMounted; $1)
	
	C_COLLECTION:C1488(SysDoc_GetMountedShares; $0)
	
	C_TEXT:C284(SysDoc_GetAvailDriveLetter; $0)
	
	C_OBJECT:C1216(SysDoc_FindShare; $1)
	C_TEXT:C284(SysDoc_FindShare; $2)
	
	C_TEXT:C284(ut_ArrayToText_CSV; $0)
	C_TEXT:C284(ut_ArrayToText_CSV; $1)
	C_POINTER:C301(ut_ArrayToText_CSV; ${2})
	
	C_OBJECT:C1216(Form_GetObjDims; $1)
	
	C_POINTER:C301(SetSortButton; $1)
	
	C_TEXT:C284(test_wordgenerator; $1)
	C_POINTER:C301(test_wordgenerator; $2)
	
	C_TEXT:C284(ut_GetSysParamAttribute; $0)
	C_TEXT:C284(ut_GetSysParamAttribute; $1)
	C_TEXT:C284(ut_GetSysParamAttribute; $2)
	C_TEXT:C284(ut_GetSysParamAttribute; $3)
	
	C_BOOLEAN:C305(CompareVersion; $0)
	C_TEXT:C284(CompareVersion; $1; $2)
	
	C_OBJECT:C1216(getTablesAndFields; $0)
	C_OBJECT:C1216(getRelations; $0)
	C_OBJECT:C1216(getIndex; $0)
	
	C_TEXT:C284(DEV_GetKeysPressed; $0)
	
	C_POINTER:C301(WIN_FitWindowInScreens; $1; $2; $3; $4)
	
	C_LONGINT:C283(WIN_PointVis; $0; $1; $2)
	C_OBJECT:C1216(WIN_FindVisibleNode; $1)
	
	C_BOOLEAN:C305(ut_UseListBox; $0)
	C_TEXT:C284(ut_UseListBox; $1)
	
	C_TEXT:C284(Dev_procStatus; $0)
	C_LONGINT:C283(Dev_procStatus; $1)
	
	C_TEXT:C284(Dev_ProcOrigin; $0)
	C_LONGINT:C283(Dev_ProcOrigin; $1)
	
	C_BLOB:C604(ut_SQLReturnServerCProcesses; $0)
	
	C_OBJECT:C1216(SYSUTIL_GetServerInfo; $0)
	C_OBJECT:C1216(SYSUTIL_GetActLogArchiveInfo; $0)
	
	C_TEXT:C284(DEV_ApplicationType; $0)
	C_LONGINT:C283(DEV_ApplicationType; $1)
	
	C_POINTER:C301(AddToDateTime; $1; $2)
	C_LONGINT:C283(AddToDateTime; $3; $4; $5)
	C_TIME:C306(AddToDateTime; $6)
	
	C_PICTURE:C286(GetPictureTypes; $1)
	C_POINTER:C301(GetPictureTypes; $2)
	
	C_PICTURE:C286(Rotate_Picture; $0)
	C_PICTURE:C286(Rotate_Picture; $1)
	C_REAL:C285(Rotate_Picture; $2)
	
	C_PICTURE:C286(ut_Rotate_Image; $1; $0)
	C_REAL:C285(ut_Rotate_Image; $2)
	
	C_PICTURE:C286(ut_RotatePicture_New; $1)
	C_REAL:C285(ut_RotatePicture_New; $2)
	C_PICTURE:C286(ut_RotatePicture_New; $0)
	
	C_POINTER:C301(TimeStamp_ut; $1; $2; $3; $4; $5)
	
	C_POINTER:C301(PrintListBox; $1)
	C_TEXT:C284(PrintListBox; $2; $3)
	
	C_OBJECT:C1216(PrintListBoxUsingObject; $1)
	
	C_TEXT:C284(EncryptDecryptString; $0; $1)
	
	C_POINTER:C301(CTRL_SubFormDoubleClick; $1)
	C_TEXT:C284(CTRL_SubFormDoubleClick; $2)
	C_TEXT:C284(CTRL_SubFormDoubleClick; $3)
	
	C_BLOB:C604(ut_ReturnUGFilesFromServer; $0)
	
	C_TEXT:C284(ut_LoadUGOnServer; $1)
	C_TEXT:C284(UG_deleteSelectedFile; $1)
	C_TEXT:C284(ut_DeleteUGOnServer; $1)
	
	C_LONGINT:C283(RandomNumber; $0)
	C_LONGINT:C283(RandomNumber; $1)
	C_LONGINT:C283(RandomNumber; $2)
	
	C_POINTER:C301(GetRandomArrayElmts; $1)
	C_LONGINT:C283(GetRandomArrayElmts; $2)
	C_POINTER:C301(GetRandomArrayElmts; $3)
	
	C_POINTER:C301(CreateRandomSelection; $1)
	C_LONGINT:C283(CreateRandomSelection; $2)
	
	C_LONGINT:C283(Col_paletteToRGB; $0)
	C_LONGINT:C283(Col_paletteToRGB; $1)
	
	C_OBJECT:C1216(Xml_ToObject; $0)
	C_TEXT:C284(Xml_ToObject; $1)
	
	C_TEXT:C284(CurrentFormName; $0)
	C_TEXT:C284(CurrentFormName; $1)
	
	C_POINTER:C301(PDF_CombinePdfs; $1)
	C_TEXT:C284(PDF_CombinePdfs; $2)
	C_TEXT:C284(<>PDFTKLocation_txt)
	
	C_POINTER:C301(SORT_Object_Array; $1)
	C_TEXT:C284(SORT_Object_Array; $2)
	C_BOOLEAN:C305(SORT_Object_Array; $3)
	
	C_OBJECT:C1216(OpenWordDoc; $1)
	
	C_POINTER:C301(USR_AddGroupMemberships; $1)
	C_LONGINT:C283(USR_AddGroupMemberships; $2)
	
	C_COLLECTION:C1488(USR_GetUserGroupMemberships; $0)
	C_LONGINT:C283(USR_GetUserGroupMemberships; $1)
	
	C_TEXT:C284(USR_GeneratePassword; $0)
	C_OBJECT:C1216(USR_GeneratePassword; $1)
	
	C_TEXT:C284(PERS_ShowMemberships; $1)
	
	C_TEXT:C284(SRV_ServerLogRecording; $1)
	
	C_BLOB:C604(SRV_RetrieveLogFromServer; $0)
	C_OBJECT:C1216(SRV_RetrieveLogFromServer; $1)
	
	C_OBJECT:C1216(SRV_GetListOfLogsFromServer; $0)
	
	C_BOOLEAN:C305(Ptr_isField; $0)
	C_POINTER:C301(Ptr_isField; $1)
	C_LONGINT:C283(Ptr_isField; ${2})
	
	C_POINTER:C301(DB_getSqlPK; $0)
	C_LONGINT:C283(DB_getSqlPK; $1)
	C_POINTER:C301(DB_getSqlPK; $2)
	
	C_TEXT:C284(Client_EnableLogsOnClient; $1)
	
	C_COLLECTION:C1488(OB_CopyToSharedCollection; $1; $2)
	C_OBJECT:C1216(OB_CopyToSharedObject; $1; $2)
	
	C_OBJECT:C1216(DB_ModifiedRecord; $0)
	C_POINTER:C301(DB_ModifiedRecord; $1)
	C_POINTER:C301(DB_ModifiedRecord; ${2})
	
	C_TEXT:C284(DOC_SaveFileToLocal; $1)
	
	C_OBJECT:C1216(DB_ReturnLockStatusInfo; $1)
	
	C_BOOLEAN:C305(DB_LockEntityInteractive; $0)
	C_OBJECT:C1216(DB_LockEntityInteractive; $1)
	C_TEXT:C284(DB_LockEntityInteractive; $2)
	
End if 

C_OBJECT:C1216(processTags_o)

C_BOOLEAN:C305(CORE_bo_GetFormObject)
C_TEXT:C284(CORE_T_ParseFormName)
C_OBJECT:C1216(CORE_ob_FormObject; WindowSize_o)
C_TEXT:C284(vSearch)
C_TEXT:C284(OutputStream_txt; inputStream_txt; ErrorStream_txt)

ARRAY TEXT:C222(Search_Value; 0)
C_LONGINT:C283(SEARCH_Table; SEARCH_Field; SEARCH_Criterion; SEARCH_Destination)

C_BOOLEAN:C305(Testinghere_b)

//Used in tasklist form
ARRAY LONGINT:C221(ProcessNumber_al; 0)
ARRAY TEXT:C222(ProcessName_atxt; 0)
ARRAY LONGINT:C221(ProcessState_al; 0)

C_COLLECTION:C1488(ugroups)

//End COMPILER_Utilities