//%attributes = {"invisible":true}
//Method: Mods_2022_03
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 2022-03-14, 16:25:24
	// ----------------------------------------------------
	//Created : 
	Mods_2022_03
End if 
//
//**********`Modified by: Costas Manousakis-(Designer)-(2022-03-14)

// ReApplyLogEntries  ***** Copied from v15 Dev
//  `Request only the ID for the [CombinedInspections] record.  Extract the other IDs from LNK records.
//  `Include search for records related to [ElementsSafety] records
//  `Continue till the end of list of [activity log] records found, ignoring deletion (DRC) records for 
//  `[combinedinspections] [inspections] and [bmsinspection] records. 

// ExportNBI  ***** Copied from v15 Dev
//  `for Items 64, 66 check for values greater than 99.9 (Load) or 9.99 (rating factor)

//**********`Modified by: Costas Manousakis-(Designer)-(2022-03-16)
//Method: ut_FixBINSequence  ***** Copied from v15 Dev
//Description
// Fix the "BIN" sequence in the [Sequences] table

// ut_ScanSequences  ***** Copied from v15 Dev
//  `added ut_FixBINSequence

//**********`Modified by: Costas Manousakis-(Designer)-(2022-03-17)
// INSP_ReviewAction
//  `added call to Synch_ReturnForward to set the Forward destination in Activity log

// [Templates];"Input"
//  `added NotSupported text objects on pages 1 , 4 for 4D write and 4D Chart templates
//  `replaced quick report area with a subform with same variable (longint)
//  `Added Tools button on quick report page to load/save quickreport to/from record or file

// INSP_SpellCheckAll
//  `modified for Write Pro


//**********`Modified by: Costas Manousakis-(Designer)-(2022-03-18)
// ADD_COMBINED_INSPECT
//  `use <>CurrentUser_PID for call to Synch_ReturnForward : Team leader is not known yet.
// Duplicate_Inspection
//Add call to Synch_ReturnForward to reset new style vsForward
// INSP_ReAssignDBIE
//Add call to Synch_ReturnForward to reset new style vsForward
// [Bridge MHD NBIS];"Bridge Input".ChangeType
//Add call to Synch_ReturnForward to reset new style vsForward

//Method: INSP_ReassignReport
//Description
//method to re-assign inspection report to another user by
//changing the Modified by field

// [Inspections];"InspectionReview".ReAssignButton
// call new method INSP_ReassignReport
// [Inspections];"InspectionReview_LB".ReAssignButton
//  `call new method INSP_ReassignReport

//**********`Modified by: Costas Manousakis-(Designer)-(2022-03-21)
// NTI_ExportXML  ***** Copied from v15 Dev
//  `allow personnel group NTI_Administrators to choose status of inspections
// ut_RenameInspAgency
//  `modified to request old and new names ; combine [Inspections] and [bms inspections] to use the new vsForward
//  `confirm each table after inspections.

// [Dialogs];"About"
//  `replaced details with a scrollable form variable; get connection info from the Database folder

// ut_SQLReturnActLogRecords
//  `Don't search thru Act log for records related to  [Inventoryphotoinsp]. All inventory photo inspection related activity is downloaded

// Synch_ReturnForward
//  `added check in array $Temp_axt to avoid blank elements

//```
//```    **** End of Release 8.0.0 beta 2022-03-21
//```

//**********`Modified by: Costas Manousakis-(Designer)-(2022-03-24)
// [NTI_TunnelInfo];"NTIED_Print"
//  `fixed wrong object name for overhead item end inspection date

//```
//```    **** End of Release 7.3.1.i  2022-03-24
//```

// ut_SQLReturnActLogRecords
//  `don't search for [NTI_Tunnelinfo] records that are not in the forward list, search only for records in the forward list.

// Startup
//  `when checking for user access allow any active user to connect to a server - now we have only one server

//Delete the followong code connected to PONTIS as obsolete
//ut_UpdatePontis
//SQL_Connect
//ut_CheckPontisRecords
//ut_PontisUpdateNBI
//ut_PontisUpdateInspections
//ut_PontisUpdateNonNBI
//ut_PontisCleanUp
//SQL_Do
//SQL_DoSQL_Execute
//SQL_FillBuiltStatements
//SQL_FillRetrieve
//SQL_FillUpdate
//SQL_FilLLInsert
//SQL_FillStatement
//PM_ControlMetricRetrieve
//PRJ_TempUpdateSQLID
//ut_FixPRJRetrieve
//ut_FixPRJRetrievePart2
//ut_PRJRetrieveOffice_EstAndOpen
//ut_CheckPontisRecords
//SQL_Disconnect


//removed following variables from compiler declaration methods
//C_TEXT(SQL_FilLLInsert;$0)
//C_TEXT(SQL_FilLLInsert;$1)
//C_TEXT(SQL_FillBuiltStatements;$0)
//C_TEXT(SQL_FillBuiltStatements ;$1)
//C_BOOLEAN(SQL_Connect;$0)
//C_BOOLEAN(SQL_Do;$0)
//C_TEXT(SQL_Do;$1)
//C_TEXT(SQL_Do ;$2)
//C_TEXT(SQL_FillRetrieve;$0)
//C_TEXT(SQL_FillRetrieve;$1)
//C_TEXT(SQL_FillStatement;$0)
//C_TEXT(SQL_FillStatement;$1)
//C_TEXT(SQL_FillStatement;$2)
//C_TEXT(SQL_FillUpdate;$0)
//C_TEXT(SQL_FillUpdate ;$1)
//C_LONGINT(SQL_DoSQL_Execute ;$0)
//C_BOOLEAN(ut_CheckPontisRecords;$0)
//C_TEXT(ut_CheckPontisRecords;$1)
//C_BOOLEAN(ut_PontisUpdateInspections;$0)
//C_TEXT(ut_PontisUpdateInspections;$1)
//C_BOOLEAN(ut_PontisUpdateNBI;$0)
//C_TEXT(ut_PontisUpdateNBI;$1)
//C_BOOLEAN(ut_PontisUpdateNonNBI;$0)
//C_TEXT(ut_PontisUpdateNonNBI;$1)

//C_BOOLEAN(bODBC_Continue)
//C_REAL(ODBCERROR_L)
//C_LONGINT(ODBC_ERRORNUMBER_L)
//C_TEXT(ODBC_ERROR_TXT)
//C_LONGINT(ODBC_Session_l;ODBC_Cursor_l)

//c_text(<>ODBC_DEBUG_WINDOW)
//remove references in sompiler stuff

//**********`Modified by: Costas Manousakis-(Designer)-(2022-03-25)
// ut_ResizeWindow
//  `added 4th optional parameter to center the new window around the current center of window

//**********`Modified by: Costas Manousakis-(Designer)-(2022-03-28)
// ut_prtSubrepError
//  `added error stack info to the ReportError var
// ut_ShowAppFolders
//  `modified to build a list and select folder to show on disk ;
// "BinRequestDisplayandMove"
//  `check if windows/mac when using ut_ReturnMountIfMounted; trim end of $Volume string 
//  `when resizing the window use the new Horizontally centerec option of ut_ResizeWindow

//**********`Modified by: Costas Manousakis-(Designer)-(2022-03-30)
// INIT_UI_GV
//  `fixed parameter name "SIA_LoadRtg_63_RF"

// [Bridge MHD NBIS];"RailTransitSIA"
//  `added two Revenue cars
// [Bridge MHD NBIS];"RAIL_SIA_Input"
//  `added two revenue cars

// [PERS_Groups];"Input"
//  `added ability to have groups as members of groups. the ID of the groups is stored as a negative number

// GRP_4DUIDinGroup
//  `modified to account for groups having subgroups
// GRP_UserInGroup
//  `modified to account for groups having subgroups
// PRJ_FillPersonnelDropDowns
//  `account for groups being members of groups

//Method: GRP_GetPersonGroups
//Description
// get list of all groups that a person belongs to.
// Parameters
// $1 : $parametersObject
//  // "grpIDsPtr" : $GrpIDs_ptr
//  // "grpNamesPtr" : $GrpNames_ptr
//  // "personID" : $PersonID (optional - pass 0 for current PID
//  // "getParents" : $getparentgroups_b :  (optional)
//  // "showlevel" : $Showgroplevel_b :  (optional only used if "getParents":true)

//End Mods_2022_03