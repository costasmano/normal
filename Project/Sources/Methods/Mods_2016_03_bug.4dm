//%attributes = {"invisible":true}
//Method: Mods_2016_03_bug
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/04/16, 12:26:42
	// ----------------------------------------------------
	//Created : 
	Mods_2016_03_bug
End if 
//

// Modified Method(s) : 
// Method: LSS_CloneFromImport
//  `fix in the SQL to get counts - need to  use  process var

//ut_ResetFileIDResRecords 
//ut_Fix 
//ut_DeleteNoMatchFileIDResRecord 

//**********`Modified by: CJMiller -(Designer)-(3/8/16)
// Created Method(s) : 
//Method: LSS_SendRecords

//**********`Modified by: Costas Manousakis-(Designer)-(3/9/16)
// Modified Method(s) : 
//MacroUtils
//  `added  param SQLTBL   to split a highlighted tablle and field name to a sql format [tbl].[field]

// Created Method(s) : 
//Method: ut_FixRefIDs_pt1
//Description
// fixes the "receiving" part where NRC records were received from the server but could not be updated 
// due to duplicates in FileIDres
// Parameters
// $1 : $Table_ptr
// $2 : $KeyField_ptr


// Created Method(s) : 
//Method: ut_FixFileIDRes_pt2
//Description
//  ` Fix the send part - act log records created locally that cannot be sent due to FileIDres errors
// Parameters
// $1 : $Tbl_ptr
// $2 : $KeyField_pt 

//**********`Modified by: CJMiller-(Designer)-(3/9/16)
// Created Method(s) : 
//Method: LSS_SendRecords
//

//**********`Modified by: Costas Manousakis-(Designer)-(3/9/16)
// Modified Form / Methods : 
// Form Method : [Activity Log];"Print"
//  `removed extra text in the ACTLOG_LocalKey_txt calculation 
//  ` removed CRs from the key texts ; made font of ACTLOG_ParentKey_txt and ACTLOG_LocalKey_txt Arial6

//**********`Modified by: Costas Manousakis-(Designer)-(3/10/16)
// Modified Method(s) : 
//Compiler_NewInspReports
//  `added C_LONGINT(◊INSP_MaxApprovalLevel_L)
//Compiler_TransfLog
//  `added ut_ControlDBSycnh 
//  `added ut_FixFileIDRes_pt2  ut_FixRefIDs_pt1 TRANSF_DestIP_txt
//Compiler_LSS
//  `added LSS_ExportInspection_L

//**********`Modified by: CJMiller-(Designer)-(3/10/16)
// Created Method(s) : 
//Method: LSS_ImportInspection
//Method: LSS_ControlDeleteOfInspection
//Method: LSS_ReceiveRecords


//**********`Modified by: Costas Manousakis-(Designer)-(3/11/16)
// Created Method(s) : 
//Method: ut_FixFileIDResTRansfers
//Description
//  ` calls all method to clean the FileIDRes table and re-send or check the activity log.
//  ` Saves the steps in [Parameters] under parameter "FILEIDRESFIX"

//**********`Modified by: Costas Manousakis-(Designer)-(3/14/16)
// Modified Forms : 
//LO:[Dialogs];"TransferSet"
//  `fixed attributes of Labels with black bkground to migrate correctly to v13 and on.
// Layout procedure : [Dialogs];"Progress"
//  `fixed format of ◊Remaining  variable

//```
//```   **** End of Release 6.5.0.g 03/14/2016
//```

//**********`Modified by: Costas Manousakis-(Designer)-(3/16/16)
// Modified Method(s) : 
//PON_ExportFHWANBE
//  `added code when designer and no NBI records in selection to allow searching;
//  `modified the parameters passed to the progress bar
//  `Corrected the search in  [PON_ELEM_INSP] for the latest inspection

//ut_SetUpBridgeInfoLinkTable
//  `show progress only  if there are more than 9 records to be fixed
//  `removed SET QUERY DEST INTO VARIABLE when fixing : the required [BridgeInfoLink] record was not being loaded

//ShowProgress
//  `moved the setting of ◊Ready  from here to the end of the onload event of the dialog[ Dialogs];"Progress")
// Layout procedure : [Dialogs];"Progress"
//  `moved the setting of ◊Ready  from ShowProgress to the end of the onload event here

//**********  `Modified by: CJMiller-(Designer)-(3/22/16)
// Modified Method(s): 
// Method: LSS_SaveDMorUTPicture
//  `added missing FlushGrpChanges before the Save Record

//```
//```   **** End of Release 6.5.0.h 03/23/2016
//```

//**********`Modified by: Costas Manousakis-(Designer)-(3/28/16)
// Created Method(s) : 
//Method: ut_db_RestoreROState
//Description
//Restore the RO state of all tables from a blob containing an array of booleans
// Parameters
// $1 : $BlobWithArray

//Method: ut_db_SaveROState
//Description
// Return the read only state of all tables. Can be used to re-set it if it has been modified
// Parameters
// $0: $ROStates_x : blob containing a boolean array with read only state of all tables

// Modified Method(s) : 
//COMPILER_Utilities
//  `added ut_db_RestoreROState  ut_db_SaveROState

// Modified Method(s) : 
//ExportNBI
//  `Added ErrorPrefix to every error line; one common header to make it easier to import to excel
//  `set all tables to read only and use ut_db_RestoreROState  and ut_db_SaveROState to save and restore states of all tables.
//SIA_DataCheck
//  `added and error line prefix

//**********`Modified by: Costas Manousakis-(Designer)-(3/29/16)
// Modified Method(s) : 
//SET_Item70
//  `fix bug where the rating is done as a RF not a weight - use item 63
//Compiler_SIA
//  `added new param 2 for SET_Item70
//SIA_AASHTO_SuffRat
//  `added item 63 to the call for SET_Item70

// Created Method(s) : 
//Method: ut_RunDBSynch
//Description
// just runs ut_ControlDBSycnh - needed because LSpawnProcess can only pass text parameters
// Parameters
// $1 : $password

//Method: ut_DelayDBSynch
//Description
// Set up to run a data  transfer at a later time. will open a dialog displaying a count down
// until the time to run the data transfer.
// will spawn a process named the same as the one createdd  from M_exec_transfer, so that two transfers do not occur at the same time

// Created Form(s) : 
//"DelayedTransfer"
//"CountDownTimer"

// Modified Method(s) : 
//M_Exec Transfer 
//  `if Shift is down launch process to do a delayed transfer; will check if there is either a transfer going on,
//  ` or a delay already in process
//M_Exec Download 
//  `check if a data transfer is in progress - all data transfer processes are now named "Data Transfer""
//Compiler_TransfLog
//  `added  ut_RunDBSynch 

// Modified Menu(s) : 
//Menu bar #1 /"Special"
//  `Moved Administratice tasks to the bottom;
//  `added Item "Run Act Log Check" after Download data  accessible only by field group

//```
//```   **** End of Release 6.5.0.i 29-Mar-2016
//```

//End Mods_2016_03_bug