//%attributes = {"invisible":true}
//Method: Mods_2021_03
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/03/21, 17:03:53
	// ----------------------------------------------------
	//Created : 
End if 
//

// [Bridge MHD NBIS];"Bridge Input".Inspections
//Make select and move inspectio reports always invisible

// PON_VerifyNBEQuantities
//  `added check on enforcing protective systems belonging to proper elements

//Method: PON_VerifyProtSys
//Description
// Verify that protective systems are assigned to correct parents
// Parameters
// $0 : $Errors_txt

// PON_VerifyElementForExport
//  `added check to verify that protective system is allowed for the parent.

//Method: PON_CheckNBELinks
//Description
// Check on NBE links to their children and create error report.
// Will scan all parents and verify that elements linked to them are from the same report

//**********`Modified by: Costas Manousakis-(Designer)-(3/8/21)
//[Inspections];"Culvert Pr Pg 2 wr"
//[Inspections];"Dive Pr Pg 2 wrt"
//  `remove putting debug text into clipboard

//[Inspections];"Critical Member"
//[Inspections];"Culvert Combined"
//[Inspections];"Damage Form"
//[Inspections];"FreezeThaw"
//[Inspections];"FreezeThawA"
//[Inspections];"PedestrianInspection-PED"
//[Inspections];"Routine Combined"
//[Inspections];"RailCulvertCombined-RRC"
//[Inspections];"RailRoutineInput"
//  `added project manager dropdown

// Mail_SendInspRevuNotif
//  `enabled use of [Inspections]ConsQCEngrID field.

// TMPL_WRDirectFind
//  `search for WRT@ (4D Write) templates to distinguish from WRP (Write Pro) 

//Add new Buttons to select and view approved inspection PDFs that are on the share
//SIA_BridgeInput_FM 
//INSP_LoadForApprInspections 
//SIA_BridgeInpNavCTRL 
//INSP_ViewApprvedInspection 
//[Bridge MHD NBIS];"Bridge Input"
//Method: [Bridge MHD NBIS].Bridge Input.ApprovedInspectionButton
//Method: [Bridge MHD NBIS].Bridge Input.ViewApprovedInspectionButton
//Method: Object Method: [Bridge MHD NBIS].Bridge Input.Inspections

//ut_PRJSortByBridge 
//Modified by: CJ (3/9/21 12:39:54)
//Fix so that changes on input form are updated on list box
//[PRJ_ProjectDetails];"ProjectDetails_LB"
//[PRJ_ProjectDetails];"ProjectDetails.i"
//PRJ_DetailsResetLBArrays 
//PRJ_DisplayBridgePgm 


//**********`Modified by: Costas Manousakis-(Designer)-(3/16/21)
// SFA_GetAvailRatingRpts
//  `modified to do the search from the local machine, not from the server.

//**********`Modified by: Costas Manousakis-(Designer)-(3/17/21)
// [Inspections];"InspectionReview_LB".InspectionReview
//  `added Redraw of the listbox after the double click event
// [Inspections];"InspectionReview_LB"
//  `added 3 date columns to the listbox : complete, 1st dbie approve, ae approve
//  `changed LB size so that form width is used to open the window 
// P_ReviewInspcts
//  `adjusted start window width based on LB form width
// M_Exec Transfer
//  `for district server user on district db ask if an immediate transfer is to be done or at intervals
// ut_TestUser
//  `if we cancel from the choice, ask to switch back.

// M_ChgPassword
//  `if passwords are not the same exit the char scan loop

//Method: EncryptDecryptString
//Description
// Encrypt or decrypt string 
// Parameters
// Parameters:
// $0 (Text) - Output string of encrypt/encrypt
// $1 (Text) - String for encrypt/decrypt

//**********`Modified by: Costas Manousakis-(Designer)-(3/18/21)
// ut_LoadRecord
//  `added process name and number to the message

//Method: PERS_UpdateLoginStats
//Description
// Update user login stats kept in Personnel table
// ----------------------------------------------------

//Method: PERS_ConvertStatsToObj
//Description
// Convert login stats tab delim text to an object ; return the object
// Parameters
// $0 : $Stats_o
// $1 : $statstabdelim_txt : tab delim text
// ----------------------------------------------------

//Method: PERS_ConvertAllStatsToObj
//Description
// convert login stats saved in Personnel table from tab delimited to object
// to be run only by Design access group
// ----------------------------------------------------

// [Bridge MHD NBIS];"Bridge Input".Inspections
//  `Check if there are any records hilighted (set LBSetBrgInsp)

// [Bridge MHD NBIS];"Bridge Input".TunnelInspections
//  `added the ViewApproved inspections buttons

// Startup
//  `use method PERS_UpdateLoginStats to collect login stats

// SIA_BridgeInpNavCTRL
//  `added INSP_LoadForApprInspections to the tunnel inspections also

//Method: INSP_AssignConsPrjMgr
//Description
// assign a consultant proj manager to the records selected in the
// inspection review screen

//Method: INSP_InspReviewDesTool_OM
//Description
// object method for the designer tools button in the inspection review form

//**********`Modified by: Costas Manousakis-(Designer)-(3/22/21)
// INSP_ConsProjMgr_OM
//  `If the ID is not in the list of Prj mgrs, get the name from the global list (aPeople / aPeople_ID)

// G_CreateImageLog
//  `make sure we only use photos sketches or charts in the image log

//**********`Modified by: Costas Manousakis-(Designer)-(3/24/21)
//Method: INSP_GetConsProjMgr
//Description
// Retrieve the project manager for a company 
// Parameters 
// $1 : $param_obj
//   -> .agency  : agency name
//   -> .structure : type of structure inspected "BIN" or "TIN"
//   <- .mgrID  : ID of project manager found
// ----------------------------------------------------


//**********`Modified by: Costas Manousakis-(Designer)-(3/31/21)
// RtgReq_LB_OM
//  `initialize the InDoubleClick_B var on load event

//End Mods_2021_03