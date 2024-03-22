//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Chuck Miller
//Date and time: 01/05/17, 16:01:19
//----------------------------------------------------
//Method: Mods_2017_01
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
End if 

//**********`Modified (1/5/17)

//Add code to enable saving of [Preferences] record for server
//ut_savePrefRecord   `add to on server shut down
//ut_LoadPrefRecord   `add to on server startup
//ut_ReturnFolderToPrefsRecord 
//form "ReLoadPreferences"
//on server dhut down
//on server startup

//**********`Modified by: Costas Manousakis-(Designer)-(1/6/17)
// Modified Method(s) : 
//NTI_RecordAllChanges
//  `change sequence name of [NTI_ELEM_TIN_INSP] to "NTI_ELEM_TIN_INSP" from "1NTI_ELEM_TIN_INSP"
//  `change sequence name of [NTI_ELEM_BIN_INSP] to "NTI_ELEM_BIN_INSP" from "1NTI_ELEM_BIN_INSP"

// Modified Method(s) : 
//ut_PRJRetrieveCPName
//  `removed $EOL:=char(10) before writing the stats message

//ut_ScanSequences 
//  `verified and ammended using ut_CheckMissingSeqScans

//**********`Modified by: Costas Manousakis-(Designer)-(1/11/17)
// Modified Method(s) : 
//G_WRT_GenericBridgeLetter 
//  `use save and retore RO state of tables using ut_db_SaveROState  and ut_db_RestoreROState
//  `add ability to use custom templates by inspection responsibility of the first bridge record
//G_WRT_BrInspRpt 
//  `use save and retore RO state of tables using ut_db_SaveROState  and ut_db_RestoreROState
//  `add ability to use custom templates by inspection responsibility of the first bridge record
//  `add GetBridgeEngineer; added split of copy and verb for D1 letter

// Modified Method(s) : 
//Compiler_Variables
//  `added new vars for the letters

// Modified Method(s) : 
//Duplicate_Inspection
//ADD_COMBINED_INSPECT
//INSP_AddInspRecs
//  `make current user TL only if they are TL or DBIE

// Method: GRP_GetGroupMembInfo
//  `added param for 1stInitLastName

// Created Method(s) : 
//Compiler_Personnel
// for methods / vars accessing the personnel table

//**********`Modified -(Designer)-(1/12/17)
// Modified Method(s) : 
//GetBIEinfo 
//  `added vBIE_FILastName_txt
//GetBridgeEngineer
//  `added vBE_FILastName_txt
//GetDBIEinfo 
//  `added vDBIE_FILastName_txt
//GetDHDinfo 
//  `added vDHD_FILastName_txt
//GetDBEInfo 
//  `added vDBE_FILastName_txt
//COMPILER_Utilities 
//  ` Add Save of prefs folder and save of [ServerProcesses] records

// Modified Method(s) : 
//ut_ReturnServerExportFolder     --copied to v15
//ut_savePrefRecord 
//ut_LoadPrefRecord 
//  `pass the name of the folder to ut_ReturnServerExportFolder

// Created Method(s) : 
//Method: ut_SaveServerProcessRecords
//Description
// Save server process records on server shutdown
//Method: ut_LoadServerProcessRecords
//Description
// Load server process records on startup if needed

// Created Form(s) : 
//"ImportServerProcess"
// has a 30 second timer to quit

// Modified Method(s) : 
//On Server Startup 
//Add code to auto save and load  [ServerProcesses] records

//On Server Shutdown 
//Add code to enable saving of [ServerProcesses] record for server - 1st stop process "Control Server Process"

//**********`Modified by: Costas Manousakis-(Designer)-(1/13/17)
//ut_PerformanceTest 
//  `move the request to mail right before sending - no need for the last alert now

//**********`Modified by: Costas Manousakis-(Designer)-(1/16/17)
// Modified Method(s) : 
//Duplicate_Inspection 
//ADD_COMBINED_INSPECT  
//INSP_AddInspRecs  
//  `fix select SQL to use [] around  <>CurrentUser_PID

//G_Insp_SetPersUI
//  `make current user TL only if they are TL or DBIE

// Created Method(s) : 
//Method: NTI_LoadAccessibility
//Description
// load the accesib vars from [TunnelInspection] table

// Modified Method(s) : 
//Form Method: [Inspections];"TunnelInspection" 
//Form Method: [Inspections];"TunnelOverheadInspection" 
//  `added call NTI_LoadAccessibility

//```
//```   **** End of Release 6.6.4.a 16-Jan-2017
//```

//**********`Modified by: Costas Manousakis-(Designer)-(1/17/17)
// Created Method(s) : 
//NTI_ut_fixSequence    -- NOT copied to v15 should only affect the v11 version. after v15 upgrade there is no need.
// fix the sequences NTI_ELEM_BIN_INSP and 1NTI_ELEM_BIN_INSP. make sure they match
// must be run on startup of standalone or startup of server

// Modified Method(s) : 
//On Startup   -- NOT copied to v15 should only affect the v11 version. after v15 upgrade there is no need.
//  `added NTI_ut_fixSequence on Startup for Volume desktop apps
//On Server Startup    -- NOT copied to v15 should only affect the v11 version. after v15 upgrade there is no need.
//  `added NTI_ut_fixSequence on Server Startup


//```
//```   **** End of Release 6.6.4.b 17-Jan-2017
//```


//**********`Modified by: Costas Manousakis-(Designer)-(1/18/17)
// Created Method(s) : 
// Test_getResources
//Description
// Execute on Server - gets a list of names in the resources folder based on subpath in param 2
// Parameters
// $1 : Pointer to text array to receive the list
// $2 : optional - sub path from the  (Current Resources folder)

// Test_SelectSRVFile
//Description
// Select a File trom the Resources
// Parameters
// $0 : Text : selected file name including subfolder
// $1 : Text : optional : prompt used in the selection dialog

// Test_GetFileFromSRVR
//Description
// EXECUTE ON SERVER attribute 
// Get a file from the resources folder
// Parameters
// $0 : BLOB : file contents
// $1 : Text : Name of file including subfolder from Current Resources folder

// Test_SaveFileOnSRVR
//Description
// EXECUTE ON SERVER
// Save a file on server in the resources folder
// $0 : 
// $1 : Text : filespec
// $2 : BLOB  : filecontents

//**********`Modified by: Costas Manousakis-(Designer)-(1/19/17)
// Modified Method(s) : 
//G_Insp_SaveInspection     --copied to v15
//  `remove ImageCheck call

// Modified Object Methods : 
//Object Method: [Inspections];"Dive Template".bzAccept     --copied to v15
//  `remove ImageCheck call

// Test_SendFileToSRVR
//Description
// Send a local file to a server - has various tasks for testing

// Test_SaveSRVRfileLocal
//Description
// retrieve a resouce file from server and save it locally

// Test_SQLDownloadRes
//Description
// start of test to download resource from a server in an activity log record - probably would be called in the downloadrecords


//```
//```   **** End of Release 6.6.4.c 19-Jan-2017
//```

//**********`Modified by: Costas Manousakis-(Designer)-(1/23/17)
// Created Method(s) : 
//Method: FN_MilliSec2TimeStr
//Description
// convert milliseconds to a time string xd xh xm x.xxxs
// Parameters
// $0 : $timestr_txt
// $1 : $DT_L (milliseconds)

// Modified Method(s) : 
//XImportLogFile
//  //Update using Progress component ; check for errors during importing; create log

//**********`Modified by: Costas Manousakis-(Designer)-(1/26/17)
// Modified Method(s) : 
//ActualDataToAssignmnt
//NegotiatedDataToAssignmnt
//  `Tunnels_b set to False - everyone uses same template

//**********`Modified by: Costas Manousakis-(Designer)-(1/30/17)
// Modified Object Methods : 
// Object Method: [NTI_TunnelInfo];"ListBoxOutput".bShowSubset
//  `added resetting of  named selection NTI_TunnelInfoSet
// Object Method: [NTI_TunnelInfo];"ListBoxOutput".bQuery
//  `changed QUERY to QUERY SELECTION

// Modified Method(s) : 
// ControlMenuBar
//  `added  TunnelInformation to MPA
// FM_NTITunnelInput
//  `fixed wrong parameter passed to LSS_SetPrevNextButtons


//**********`Modified by: Costas Manousakis-(Designer)-(1/31/17)
// Modified Method(s) : 
//XImportLogFile   
//  //added ability to stop the import from the progress bar

// Modified Form : 
// Form : [NTI_TunnelInfo];"ListBoxOutput"
//  `made OK button to NOT move horizontally


// Created Method(s) : 
// NTI_GetInspResp
//Description
// Get the inspection responsibility based on Item 1
// Parameters
// $0 : $InspResp_txt
// $1 :$NTI_i1_txt

// Modified Method(s) : 
// NTI_SetModDeleteAccess
//  `added case for inspection responsibility so that agencies (MPA) can edit tunnel info

// Modified Method(s) : 
// NTI_InspReviewLB_OM
//  `use NTI_GetInspResp

//End Mods_2017_01