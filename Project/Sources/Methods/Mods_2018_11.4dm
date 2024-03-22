//%attributes = {"invisible":true}
//Method: Mods_2018_11
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 11/01/18, 16:05:12
	// ----------------------------------------------------
	//Created : 
	Mods_2018_11
End if 
//

//**********`Modified by: Costas Manousakis-(Designer)-(11/1/18)
// InitPrefs
//  `Removed case where transfer was set to 0 (=Send) when "Inspection Engineers" connect to Boston Server - UserCall Ref = 577


//**********` Modified by: Chuck Miller (11/1/18 16:05:50)
//ADD ability to export and then import
//[InventoryPhotos]
//Method: INSP_ImportInventoryPhotos
// [Bridge MHD NBIS];"Bridge Input"
//  `added buttons on page 8 (inventory photos) to export / import inv photo inspection
//Method: [Bridge MHD NBIS];"Bridge Input".InvExport
//Method: [Bridge MHD NBIS];"Bridge Input".InvImport

//Method: LSS_SetUpP2Recommendation
//Form Method: [LSS_Inspection];"LightStructurePg2"
//Form Method: [LSS_Inspection];"ITSStructurePg2"
//Form Method: [LSS_Inspection];"TrafficSignalStructurePg2"
//Form Method: [LSS_Inspection];"SignStructurePg2"


//**********`Modified by: Costas Manousakis-(Designer)-(11/2/18)
// ut_SQLReturnActLogRecords
//  `added table [NTI_ELEM_BIN_INSP] in the search by parent inspectionID and moved [Field Trip] in it too.
//  `added checking for inspection responsibility by district in addition to Item 2
//  `added all tables related via the [BridgeInfoLink] table to the bridge table to the list of tables to full download
//  `added [NTI_TunnelInfo] to the list of tables to full download
//  `added searches for [TIN_Inspections] similar to bridge inspections, and search for [NTI_TunnelRatings]
// ut_ACTLOG_addInsp
//  `added table [NTI_ELEM_BIN_INSP] in the search by parent inspectionID and moved [Field Trip] in it too.
//  `added task "TININSPECTIONS" for TIN inspections


//**********`Modified by: Costas Manousakis-(Designer)-(11/5/18)
// LSS_PrintInspection
//  `removed extra ":" from photo/sketch log text
// [InventoryPhotoInsp];"Input".DE Orientation
//  `added progress bar while photos are being renamed
// [LSS_Inspection];"LSS_PhotoLog"
//  `removed border from Lss_CommentsPrint_pct object

///Remove test tab when in as designer
//Modified by: Chuck Miller (11/6/18 11:00:31)
// Method: Form Method: [InventoryPhotoInsp];"Input"

//**********`Modified by: Costas Manousakis-(Designer)-(11/7/18)
// P_ListServerProcesses
//  `added a window title and the output form name


//Modified by: Chuck Miller (11/8/18 15:34:43)
// Method: Object Method: [LSS_Inventory].Input.LSS_Add_L
//Add LSS_EditingInspection_B = true if we can addfa dfn do so we are automatically editing the record aswell
//This fixed issue with adding Ut record for a new inspection.


//Method: Object Method: [LSS_Inventory].Edit_SIN.Button
//Fix issue where LSS_VerifyNewInventoryNumber was called with no pointer and added alert

//Made sure note about sequnce numbers will be updated on image page was wide enough
//[LSS_Inspection];"Input_ITS"
//[LSS_Inspection];"Input_Light"
//[LSS_Inspection];"Input_Sign"
//[LSS_Inspection];"Input_Signal"


//On Damage page of forms below, modified the entry filter of completion date to use 2 digit year
//[LSS_Inspection];"Input_ITS"
//[LSS_Inspection];"Input_Light"
//[LSS_Inspection];"Input_Sign"
//[LSS_Inspection];"Input_Signal"


//**********`Modified by: Costas Manousakis-(Designer)-(11/9/18)
// Modified Method(s) : 
// G_Insp_LockFormOnOff
//  `changed _O_Enable/disable commands with object set enabled versions
// [Inspections];"Damage Form"
//  `when blnBostonOffice is true, make sure [Inspections] record in loaded Read write

// Created Method(s) : 
//Method: PON_VerifyElementForExport
//Description
// verify an element if it is ok to export for FHWA submission. 
// Parameters
// $1 : $ParamObject_o
// object attributes
//  // "elemkey" : element key to check - on return it will be updated with the correct key 
//  // "parentkey" : parent key to check - on return it will be updated with the correct key 
//  // "error" 0:no error; 1:element not found; 
//  //  // 2:elemrollup not found; 3:parentnotfound; 4:parentrollup not found 
//  //  // 5:elem not reportable ; 6: parent not reportable
//  // "errortxt" explanation of error 
//  // "reported" true or false
//  // "Keylist" : pointer to array of keys from element defs
//  // "rollupkeys" : pointer to array of roll up keys from element defs
//  // "reportables" : pointer to array of reported_txt = Y or N

//Modified by: Chuck Miller (11/13/18 12:28:01)
// LSS_CheckTeamMembership
//Add code to disallow when <>PERS_MyCompany_txt="Mass. Highway Dept."

//**********`Modified by: Costas Manousakis-(Designer)-(11/13/18)
// PON_ExportFHWANBE
//  `modified to use method PON_VerifyElementForExport

//**********`Modified by: Costas Manousakis-(Designer)-(11/14/18)
// G_InspParagProt
//  `to avoid incorrect counting of page location, call G_Insp_ApplyLineSpacing after every insert of text.
//  //use brute force method of going char by char from top of page to get to the start of the next page
//  //also no need to add page breaks when spliting a commnent block in multiple pages. just add lines with the appropriate headers

// Created Method(s) : 
//Method: GetChildTables
//Description
// retrieve child tables related to a field on a table
// Parameters
// $1 : $params_o : object containing input parameters and output paramaters
// attributes  : 
//  // "parentfield" : pointer to parent field
//  // "childTables" : pointer to array of pointers. filled with pointers to children field
//  // "showprogress" : show progress bar (boolean)

// Modified Method(s) : 
// Insp_PrintRemarks
//  `added progress while scanning pages

//**********`Modified by: Costas Manousakis-(Designer)-(11/15/18)
// Created Method(s) : 
//Method: TextToSpeach
//Description
// speak a text from  kb.4d  http://kb.4d.com/assetid=78019
// Parameters
// $1 : Text to speak

//**********`Modified by: Costas Manousakis-(Designer)-(11/16/18)
// [ClientAccess];"Input"
//  `added button to test the display of the message 
//  //made message field multistyle
// [Dialogs];"BigAlert"
//  `added form method to resize window to display better the message
//  // made Message field multistyle

//Modified by: Chuck Miller (11/19/18 12:28:01)
// Modified Method(s) : 
// CM_RelateWorkHour
// CONS_Address_O_FM
// FM_DMeterInput
// FM_ElementInspection
// CreateRandomSet
// FM_PhotoInput
// FM_SignPanel
// FM_TowerDistance
// FM_UTInput
// FM_UTResults
// LSS_SetUpButtonsForNewRecords
// Change code from   //_ o _ENABLE BUTTON and _ o _DISABLE to   //OBJECT SET ENABLED

//Modified by: Chuck Miller (11/20/18 12:28:01)
// Created Form(s) : 
// SelectResources
// Created Method(s) : 

// Server_ReturnResourceFile
// Server_ReturnResourceStructure

// Modified Object Methods : 
// [LSS_Inspection];"Inspection_Template".bValidate1
//Add code so that if only editing damage chewck to mark as complete is not displayed if already approved

//**********`Modified by: Costas Manousakis-(Designer)-(11/20/18)
// Startup
//  `use system parameter MADOTBMSContact for contact
// [Inspections];"Critical Member"
//  `enable Pontis / NBE for Other inspections also

//**********`Modified by: Costas Manousakis-(Designer)-(11/26/18)
//Method: DEV_compareFolders
//Description
// compare contents of two folders
// DEV_UPDATE_STRUCTURE_LOG
//  `at the end show the log file, not the folder

//Modified by: Chuck Miller (11/27/18 12:28:01)
//Method: Resource_control
//Method: Server_SetBlobToDocument

//**********`Modified by: Costas Manousakis-(Designer)-(11/29/18)
// LSS_InspReviewLB_OM
//  `use method LSS_SetUpReviewButton
// LSS_SetUpReviewButton
//  `modified to allow MassDOTReps belonging to the same district as the inventory record to do a review

// Modified Forms : 
// [LSS_Inspection];"InspectionReview"
//  `made all columns in listbox not enterable
//  `make sure the print and review buttons are hidden when the selection is changed in 
//  `obj methods of buttons in top of form

// Modified Forms : 
// [ScourPOA];"Input-A"
//  `removed the variable name from all buttons that open URLs and made sure the obj 
//  `name is not SCPOA@ - does not disable them for read only users

//Modified by: Chuck Miller (11/29/18 12:28:01)
//Method: Resource_SaveFileOnServer


//```
//```    **** End of Release 7.2.0 30-Nov-2018
//```

//End Mods_2018_11