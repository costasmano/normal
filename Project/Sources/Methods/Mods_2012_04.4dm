//%attributes = {"invisible":true}
//Method: Mods_2012_04
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/05/12, 16:00:57
	// ----------------------------------------------------
	//Created : 
	Mods_2012_04
End if 
//
// Modified Form Methods : 
//[Inspections];"RailRoutinePrPg1"
//[Inspections];"RailRoutineInput
//  `Make sure the [RailBridgeInfo] record is loaded

// Modified Forms : 
//[RAILBridgeInfo];"RailRoutinePrPg2"
//  `Fixed mismatched labels in the Stream flow velocity check marks

// Modified Method(s) : 
//ImportFEDrecord_Item8
//  `Switched to ut_StartMessage, ut_Message, ut_CloseMessage
//  `ut_LoadRecordInteractive
//  `added unload record commands at the end
//  `Added PushChange, FlushGrpChgs

//LoadNBIData
//  `adjustments to the date calculations

//ARCHIVE_Store 
//  `Added Message at the end about the completion after confirmation

// Created Method(s) : 
//ARCHIVE_ExportNBI 
//  `Export an NBI tape from records in the archive tables
//ut_LoadPicFromResources 
//  `Load a picture from the Resources folder. Pass the name of the picture file
//  ` including any subfolders
//  ` Parameters
//  ` $0 : PictureLoaded_pic
//  ` $1 : PicFileName_txt 

// **********` Modified by: Costas Manousakis-(Designer)-(4/10/12 13:01:48)
// Modified Method(s) : 
//INSP_ReviewAction
//  `Force InspComplete = TRUE when DBIE approves an inspection. to avoid crossing of information intransfers

//GetDHDinfo
//  `Use method GRP_GetGroupMembInfo

// **********` Modified by: Costas Manousakis-(Designer)-(4/13/12 11:03:16)
// Modified Method(s) : 
//M_HandlePrefs 
//M_HandleTrans 
//  `get the form size of the dialog,; window type and a window title

// Modified Form Methods : 
//[Dialogs];"TransferSet"
//  `Adjusted form size; disable all entry for non-Application Admin users;
//  `Now all Field Group users have access to this dialog

// **********` Modified by: Costas Manousakis-(Designer)-(4/17/12 11:10:49)
// Created Method(s) : 
//ut_testEmailSending
//  ` Perform a test of sending email.  Can change the SMTP server.
//ARCHIVE_ExportNBItabDelim 
//  ` Export an NBI tape from the current list of [BridgeMHDNBISArchive] records
//  ` to a tab delim file.  No error checks are done

// Modified Method(s) : 
//Server_QuitServer
//  `add code so that we skip until after the next scheduled time

//Object Method: [BridgeMHDNBISArchive].Output.ARCH_TOOL_BTN_L 
//  `added export of nbi tape to tab delim

// **********` Modified by: Charles Miller-(Designer)-(4/17/12 )
//SIA_SetUpListBoxes 
//  ` Add code to resize the listbox to better fit the screen when not Designer or Admin 
//SIA_GoToPage 
//  ` code duplicated in set up phase SIA_SetUpListBoxes do not need it here 

// **********` Modified by: Costas Manousakis-(Designer)-(4/17/12 16:47:37)
// Modified Method(s) : 
//SIA_SetUpListBoxes 
//  `Made format of all dates to Char(Internal date short +Blank if null date ) - seems to work  in mac and windows the same

// **********` Modified by: Costas Manousakis-(Designer)-(4/18/12 13:46:47)
// Created Method(s) : 
//ut_StoreGroupsToList
//  ` Tool to store 4D groups with theier members into hlist, save to file, compare two hLists
//  ` Parameters
//  ` $1 : $task_txt (optional)

// Modified Method(s) : 
//SCPOA_Variables
//  `added  2 pages to SectionSCPOASelect_atxt  for the FVC card data
//  `added var SCPOA_BrStructType_txt from item 43 also stored in the POA data
//  `added calculation of SCPOA_TrafEqDBE_txt based on the bridge district
//GRP_GetGroupMembInfo
//  `Added parameter for cell phone
//GetDBEInfo
//  `Added Cell phone

// **********` Modified by: Costas Manousakis-(Designer)-(4/24/12 )
// Modified Method(s) : 
//Temp_ChangeInspBIN
//  `Fixed methodology

// Modified Method(s) : 
//ut_PRJ_ControlDDChange
//  `Fixed bad pointer  $ReviewID_ptr
//CM_GetPersonnelData
//  `Changed to use [Contract_Maintenance]BridgePrjMgr, utf_GetUserPID and PERS_GetInfo to fill the information

// **********  `End of Release   `2012-04-25 : Version 6.0.4

// **********` Modified by: Costas Manousakis-(Designer)-(4/25/12 12:05:09)
// Modified Forms : 
//[PRJ_ProjectDetails]PRJ_Details.rpt 
//  `Adjusted object alignments, sizes to better fit more information.

// Modified Method(s) : 
//SIA_ResetWidths
//  `Removed re-initialization of the arrays if  [LB_QueryTable]ColumnWidths_txt#""
// Modified Object Methods : 
//[Bridge MHD NBIS].Bridge Input.Button 
//  `Added pages 7, (Inspections) and 8  (InventoryPhotos)

// **********  `End of Release   `2012-04-25 : Version 6.0.4a

// **********` Modified by: Costas Manousakis-(Designer)-(4/27/12 16:36:43)
// Modified Method(s) : 
//ut_SQLReturnActLogRecords
//  `added code to get deletions of  dive inspections.

// Modified Forms : 
//[Inspections]StormDamageInspection
//  `Adjusted form method , added code for logging changes

//End Mods_2012_04