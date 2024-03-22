//%attributes = {"invisible":true}
//Method: Mods_2017_10
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 10/05/17, 14:30:41
	// ----------------------------------------------------
	//Created : 
	Mods_2017_10
End if 
//

//**********`Modified by: Costas Manousakis-(Designer)-(10/5/17)
// Modified Table(s) : 
// added field [NTI_TunnelInfo]NTI_InspResp A(5) - will replace usage of NTI_I6 (district)

// Modified Forms : 
// [NTI_TunnelInfo];"Input"
//  `added InspResp field and drop down

// Modified Method(s) : 
// FM_NTITunnelInput
//  `added coding for InspResp field


//**********`Modified by: Costas Manousakis-(Designer)-(10/6/17)

// Created Method(s) : 
//Method: ut_StructListsToBlob
//Description
// Return in a blob the structure lists. Mainly for calls via SQL connection
// attribute : available through SQL = true
// Parameters
// $0 : $StructureLists_blob

//Method: ut_BlobToStructureLists
//Description
// read from a blob created by method ut_StructListsToBlob and save lists to current structure
// Parameters
// $1 : $StructListBlob_blb

//Method: ut_GetStructListsFromServer
//Description
// get the structure lists from a remote server.
// main use is to update a Development structure with lists from a prod server before deploying

//Method: ut_GetUsersToBlob
//Description
// Return in a blob the users. Mainly for calls via SQL connection
// attribute : available through SQL = true
// Parameters
// $0 : $UsersAndGroups_blob

//Method: ut_GetUsersFromServer
//Description
// get the users and groups from a remote server and update the local structure



//**********`Modified by: Charles Miller (10/10/17 
// clone_ProcessBlobs
//  `use local progress bar if param $2 is -10
// LSS_DeleteImportedRecords
//  `import up to 8, new format is 00
// clone_CloneSetUpSelectInto
//  `handle case of UUID fields
// LSS_CloneFromImport
//  `Adjustments for  new call to cloneBlob and handling of UUIDs

// [Dialogs];"SaveLists".Variable7
//  `clear list after using it when saving to file
//  // clear all lists loaded when reading from file

//**********`Modified by: Costas Manousakis-(Designer)-(10/11/17)
// Modified Object Methods : 
// [LSS_Inspection];"Inspection_Template".bValidate1
//  `if user cancels at the Confirm, do not Cancel the entry.

// Created Method(s) : 
//Method: NTI_GroupSuffix
//Description
// set the suffix to be used in searching in personnel groups
// Parameters
// $0 : $Suffix_txt
// $1 : $InspRespField_txt
// $2 : $DistrField_txt

// Modified Method(s) : 
// NTI_AllowAdd_Tin_insp
//  `use new field [NTI_TunnelInfo]NTI_InspResp - method NTI_GroupSuffix
// Mail_SendTINRevuNotif
//  `use new field [NTI_TunnelInfo]NTI_InspResp - method NTI_GroupSuffix
// NTI_GetInspResp
//  `if NTI_InspResp] is blank, then do the rest
// NTI_InspectionInput_FM
//  `use NTI_GroupSuffix method

//**********`Modified by: Costas Manousakis-(Designer)-(10/12/17)

// Created Method(s) : 
//Method: SIA_LoadSelectionListInfo
//Description
// Load the FHWA selectList dates - update date variables passed as pointers
// Parameters
// $1 : $FHWADate_ptr
// $2 : $LoadedDate_ptr

// Modified Method(s) : 

// [Bridge MHD NBIS];"SI & A (Insp)"
//  `Removed var sFHWASelect from form; renamed text label to FHWASelect;
//  //use method SIA_LoadSelectionListInfo to get dates and update the text label 
// [Bridge MHD NBIS];"MHD Specific Items"
//  `Removed var sFHWASelect from form; renamed text label to FHWASelect;
//  //use method SIA_LoadSelectionListInfo to get dates and update the text label 
// [Bridge MHD NBIS];"SI & A (Normal)"
//  `Removed var sFHWASelect from form; renamed text label to FHWASelect;
//  //use method SIA_LoadSelectionListInfo to get dates and update the text label 
// SIA_HelpTipCtrl
//  `use SIA_LoadSelectionListInfo
// [Bridge MHD NBIS];"SI & A Input"
//  `added Multistyle text var to display the Select List status; use hidden label object "FHWASelect" as the base for the label.
//  //use the color of the AASHTO field
// SIA_UpdSelList
//  `Save FHWASELECT_Info parameter in XML format in Description instead of VALUE
//  // Added info at the start of the report about the application name, structure, data file, and server IP/port

//**********`Modified by: Costas Manousakis-(Designer)-(10/13/17)

// Modified Method(s) : 

// G_Insp_SaveInspection
//  `do a INSP_SaveRecords right after the first confirm in case things get locked up
// NTI_SetUpCanAdd
//  `use the last element of NTI_ADDTunnelInfo_aB for ALL
// NTI_GetInspResp
//  `if field [NTI_InspResp] is blank, then do the rest
// NTI_SetModDeleteAccess
//  `use only inspResp instead of NTI_i6
//  // if user can add, they can also modify - deletion is explicitly controlled

//**********`Modified by: Costas Manousakis-(Designer)-(10/13/17)

// Modified Method(s) : 

// NTI_CheckTownSelection
//  `new way of calculating arrays in NTI_SetUpPermissions using <>aInspRcod
// NTI_SetUpPermissions
//  `new way of calculating arrays in NTI_SetUpPermissions using <>aInspRcod
// [NTI_TunnelInfo];"ListBoxOutput".SelectListBox
//  `use NTI_GroupSuffix and NTI_GetInspResp to check if can add inspections for this TIN


//**********`Modified by: Costas Manousakis-(Designer)-(10/17/17)
// NTI_SetUpPermissions
//  `new way of calculating arrays in NTI_SetUpPermissions using <>aInspRcod

//**********`Modified by: Costas Manousakis-(Designer)-(10/20/17)
// SIA_UpdSelList
//  `Added making logchanges for the changed records - using the new progress bar

//**********`Modified by: Costas Manousakis-(Designer)-(10/25/17)
// FN_MilliSec2TimeStr
//  `round seconds to 1 dec

//Method: ProgressNew
//Description
//
// Parameters
// $0 : $progressObj_o
// $1 : $Title_txt
// $2 : $TotalCount_L
// $3 : $Button_b
// $4 : $msgTempl_txt -used in message ie "x of $TotalCount_L $mestempl_txt"
// $5 : TimeOption - if 0:no time ;1:time elapsed ; 2:time left ; 3:both

//Method: UpdateProgressNew
//Description
// Update the 4D progress bar
// Parameters
// $1 : $ProgressObj_o
// $2 : $Curr_L

// BrgRank_CopyToBridge
// ARCHIVE_UpdateRecord
// ARCHIVE_FOSDFields
// ArchiveLogFile
// ARCHIVE_UpdateField
// ARCHIVE_Store
// ARCHIVE_RecalcAASHTO
// ARCHIVE_GenCondReport
// ARCHIVE_ExportNBItabDelim
// ARCH_M_RPC_Report
// ARCHIVE_ExportNBI_full 
// ARCHIVE_ExportNBI
// GenerateCondRep
// ut_AddOwnerRecs
//  `use new ProgressNew and UpdateProgressNew


//**********`Modified by: Costas Manousakis-(Designer)-(10/26/17)
// ut_GenCondRepFromArchive
//  `added comments in the comment field

//**********`Modified by: Costas Manousakis-(Designer)-(10/30/17)
// G_ListTable
//  `if output form ends in _LB assume it is a listbox and use the dialog command
// [ServerProcesses];"Output_LB"
//  `changes to make it better when used in a DIALOG - left only "Running" as enterable

//**********`Modified by: Costas Manousakis-(Designer)-(10/31/17)
// [Inspections];"Culvert Combined"
//  `re-arranged barrel width and height on pg 1
// INSP_CulvertPrPg1_FM
//  `changed format of vBarrelSize to n.nnWxn.nnH

//End Mods_2017_10