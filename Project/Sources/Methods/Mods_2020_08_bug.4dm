//%attributes = {"invisible":true}
//Method: Mods_2020_08_bug
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/07/20, 13:56:51
	// ----------------------------------------------------
	//Created : 
	Mods_2020_08_bug
End if 
//
//**********`Modified by: Costas Manousakis-(Designer)-(8/7/20)

// QR_ConsInspElecSubm
//  `check Inspections table only if status is not Completed or Rescinded or if NTP and NTP verbal are 00/00/00
//  `set auto relations to false at start

//**********`Modified by: Costas Manousakis-(Designer)-(8/11/20)

//Method: StopControlClientProc
//Description
// stop the control client process running on current machine - Client
// Parameters

//Method: Dev_buildCaseStatements
//Description
// build case statement from data on clipboard
// Clipboard
// label1 \t valu1
// label2 \t valu2
//result in clipboard
// :($1=valu1)
//  $0:="label1"
// :($1=valu2
//  $0:="label2"
// Parameters

//Method: Dev_procStatus
//Description
// text of process status from process properties
// Parameters
// $0: $proc status desc
// $1 : $procStatus

//Method: Dev_ProcOrigin
//Description
// text of process origin from process properties
// Parameters
// $0: $proc origin desc
// $1 : $procorigin

//Method: EditBMSExternalTransf
//Description
// edit the BMSEXternal_transfer record in ServerProcesses
// Parameters
// $1 : if not passed launch a process

//Method: EditDelayDBSyncParam
//Description
// Ediy the DelayDBSync parameter record
// Parameters
// $1 : if not passed launch a process

//Form  "BMSExternalClientControl"
//Description
// form created for user BMSExternal server - will be launched at startup

// Form [ServerProcesses];"Input"
//  `changed entry filter on dates to allow 4 digit year - fixed tab order to go to the time after the date entry

// [Parameters];"Input".EditJson
//  `when parameter is blank make a starting object with a single attribute

// Launch_CtrlClientProc
//  `modified to launch in a local process the Control panel for BMS External server instead of starting ControlClientProcess method

//Method: BMSExternal_test
//Description
// test method for controlclientprocess - similar to BMSExternal_transfer
//Method: BMSExternal_test2
//Description
// test nethod only for use with controlClientProcess method

// ControlClientProcess
//  `added checking for <>ABORTCONTROLCLIENTPROC from StopControlClientProc

// Test_Memory
//  `use results from GET MEMORY STATISTICS command.

// ut_DelayDBSynch
//  `fixes with catching of OK variable when dialogs/confirms close - added send to debug clipboard

//**********`Modified by: Costas Manousakis-(Designer)-(8/13/20)
// ut_NewSaveMethod
//  `check if BOX volume or Box Sync folder are found. fix 000 file created outsode folder (there was an extra folder separator)

//**********`Modified by: Costas Manousakis-(Designer)-(8/14/20)
// NTI_DuplicateElements
//  `fixed bug [NTI_ELEM_TIN_INSP]ELEM_GRANDPARENT_ID were referencing as a parent table [Inspections] not [Tin_inspections] 
//  `Call Reference #742

//```
//```    **** End of Release 7.3.0.e 14-Aug-2020
//```

//**********`Modified by: Costas Manousakis-(Designer)-(8/17/20)
// BMSExternal_Transfer
//  `When designer runs this ask to send email
// BMSExternal_test
//  `changed semaphore to BMSEXTERNALTEST
// BMSExternal_test2
//  `changed semaphore to BMSEXTERNALTEST
//Method: Test_SetClientTimeout
//Description
// method to set client timeouts
//Method: Test_setServerTimeouts
//Description
//method to set timeouts on server - Execute on server attribute = on

//**********`Modified by: Costas Manousakis-(Designer)-(8/20/20)
// Launch_CtrlClientProc
//  `changed location of new window to upper left (2)

// SFA_GetAvailRatingRpts
//  `use the <>SCRRPT_SavedData_o for mouse coords
// SFA_GetBridgeFolder
//  `added interprocess object to save time searching.

// [Bridge MHD NBIS];"Bridge Input".ListAvailScanRtgsb
//  `Enable long click on button object and object method to refresh folder seearches.
//  `Updated Help Tip ListOfSCannedRt 

//**********`Modified by: Costas Manousakis-(Designer)-(8/21/20)
//added button
// "BMSExternalClientControl".EditClientTimouts

//added button
// [Bridge MHD NBIS];"Bridge Input".RefreshPersonnelCache
// resource MADOTIcons/UnknownUser 4state.png
// helptip RefreshPersonCa  Call Reference #706

//Method: Dev_Create4StateBtnFromImage
//Description
// Create a 4 State button from image file. 

//**********`Modified by: Costas Manousakis-(Designer)-(8/24/20)
// [LSS_Photos];"PhotoSubFormLB"
//  `made all buttons 3D buttons type bevel 

// [LSS_UT];"UltraSonicSubForm"
//  `added case  statement - hide the results lb and the plusbutton for results button
//  `made all buttons on form 3D buttons and bevel; removed focus on listboxes;
//  `removed all events from form except on load, clicked and double click

// LSS_SelectUTResults
//  `get UTResults first then show the results LB and plus btn; also make sure plubtn for result si enabled if editable

//**********`Modified by: Costas Manousakis-(Designer)-(8/25/20)
//Method: DEV_OpenRuntimeExplorer
//Description
// post keys CMD-Shift-F9 / CTRL-Shift-F9 to open runtime explorer
// Parameters

//**********`Modified by: Costas Manousakis-(Designer)-(8/26/20)
//Method: SYSUTIL_GetServerInfo
//Description
// get  infromation about the server - execute on server
// Parameters
// $0: $infoObject

//Method: SYSUTIL_GetActLogArchiveInfo
//Description
// get information for the act log archive export tag
// Parameters
// $0 : $infoObject

// ArchiveLogFile
//  `added info about the export to the tag variable at the start of the export
// XImportLogFile
//  `adjust checking of tag for the additional info added when exporting - added a confirmation whether to continue with import

//Method: DEV_ApplicationType
//Description
// Show text of application type
// Parameters
// $0 : $description
// $1 : $apptypecode

//Method: AddToDateTime
//Description
// add to a date and time similar to add to date include a time variable
// update the data pointed to in $1 and $2 
// Parameters
// $1 : $date_ptr
// $2 : $time_ptr
// $3 : $years_L
// $4 : $months_L
// $5 : $days_L
// $6 : $TimeToadd_t - to subtract time multiply by -1 (-1*?12:00:00?)

// "BMSExternalClientControl".StartTransferatInterval
//  `moved alert after launch

// BMSExternal_Transfer
//  `When designer runs this method ask to send email - adjusted the composing of tMailNote

//**********`Modified by: Costas Manousakis-(Designer)-(8/28/20)
// On Startup
//  `cleared up code
// Launch_CtrlClientProc
//  `on load will launch the controlclient process after a delay of 5 minutes

// Modified Form and Form Methods : 
// "RatingReportDisplayandMove"
//  `adjusted location and size of objects; vert marg of form; made web areas grow vert; and bottom obj move vert.
//  `switch from using set values for window widths to calculated from form width

// OM_ControlOpenandMoveRatingPDF
//  `use half width of form to open window

// ut_SQLDownloadNewRecords
//  `moved ut_SQLLogout near the end.

//```
//```    **** End of Release 7.3.0.f 29-Aug-2020
//```

//**********`Modified by: Costas Manousakis-(Designer)-(8/31/20)
// ut_RunDBSynch
//  `added process Delayed transfer to the list to be skipped

//End Mods_2020_08_bug