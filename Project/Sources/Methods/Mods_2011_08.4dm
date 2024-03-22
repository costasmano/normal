//%attributes = {"invisible":true}
// ----------------------------------------------------
// Mods_2011_08
// User name (OS): charlesmiller
// Date and time: 08/11/11, 12:41:45
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2011_08
	
End if 

//Method will output new document which includes last 5 RTN comined inspections as well as other data based upon spreedsheet form the FED.
//utl_CompareFedDates

//utl_CompareFedFromandTo 

//PRJ_GetDataSheetFedAidNos
//  ` Get the FA numbers stored in the data sheets for a project Detail record.

// **********  ` Modified by: costasmanousakis-(Designer)-(8/24/11 09:306:21)
// Modified Method(s) : 
//G_WRT_MakeDocument
//  `Changed logic to copy the letterhead logo from a 4DWrtie doc in WRT_BMSLetterhead
//  `Has more consitant behavior across Mac and Window Platoforms.
//  `Re-Setting the margins does not seem to work though.

// **********  ` Modified by: costasmanousakis-(Designer)-(8/25/11 09:59:17)
// Created Method(s) : 
//G_Insp_ReviewUtils
//  ` Utitlities for  Inspection review screen
//  ` Parameters
//  ` $1 : $Task_txt (REMOVEApprove | REMOVEReview | DBIEREVIEW | AREAREVIEW)

// Modified Forms : 
//[Inspections];"InspectionReview"
//  `Added button mapped to CMD-Alt-U to execute G_Insp_ReviewUtils("REMOVEApprove")

// Modified Method(s) : 
//P_ReviewInspcts
//  `Added special case for Doug Consentino

// Modified Forms : 
//[Templates];"Input"
//  `Added button OpenWindow on the 4D Write page to open an external window with the ares.
//  `Helps with copying to other records.

// **********  ` Modified by: costasmanousakis-(Designer)-(8/30/11 08:34:05)
// Modified Method(s) : 
//SIA_RRVariableUtil
//  `Added Code to handle the new check boxes for dimensions over 30M.
// Modified Method(s) : 
//SIA_RRInput_FM
//  `Call SIA_RRVariableUtil ("LOAD") on the o load event to properly initialize checkboxes
// Modified Forms : 
//[RAILBridgeInfo];"Input"
//  `Added Checkboxes for dimensions over 30M
// Modified Object Methods : 
//[RAILBridgeInfo];"Input".MilePt
//  `convert milepoint to kilopoint for item11

// Created Method(s) : 
//ut_GenericHelp_OM
//  `Handle the Generichelpmessage in object methods. should be called from the object method.

// Modified Object Methods : 
//[DCM_Project];"DistrWorkOrderInput".DCM_DBIENOTIF_btn
//  `Added call to ut_GenericHelp_OM

// Created Method(s) : 
//DCM_ReloadContr_OM
//  ` Object method for button on [DCM_Contracts];"DistrMaintInput".DEDCM_ReloadInfo
// Modified Object Methods : 
//[DCM_Contracts];"DistrMaintInput".DEDCM_ReloadInfo
//  `Use method DCM_ReloadContr_OM

// **********  ` Modified by: costasmanousakis-(Designer)-(8/31/11 16:12:27)
// Modified Form Methods : 
//[Templates];"Input"
//  `Move declaration of Template_Qrt_TableNo_L at top of on load event

// Modified Method(s) : 
//PRJ_BPGM_ListDetailData
//  `move assignmnet of PRJ_ConsultantName_txt

//End Mods_2011_08
