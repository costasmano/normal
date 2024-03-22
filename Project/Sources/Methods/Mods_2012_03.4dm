//%attributes = {"invisible":true}
//Method: Mods_2012_03
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/06/12, 13:55:25
	// ----------------------------------------------------
	//Created : 
	Mods_2012_03
End if 
//

// **********  ` Modified by: Costas Manousakis-(Designer)-(3/6/12 )

// Modified Object Methods : 
//[Bridge MHD NBIS];"Bridge Input".bInspection
//[Bridge MHD NBIS];"Bridge Input".bCsltInsp
//[Bridge MHD NBIS];"Bridge Input".bCsltRating
//[Bridge MHD NBIS];"Bridge Input".bCsltRating
//[Bridge MHD NBIS];"Bridge Input".bSecond
//[Bridge MHD NBIS];"Bridge Input".bDesign
//  `Fix in case problems in the [LB_QueryTable] to revert to the old method

// Modified Form  : 
//[Bridge MHD NBIS];"Cslt Insps"
//  `No Need for the Listbox on second page

// Modified Object Methods : 
//[LB_QueryTable].Input.bValidate
//  `make sure that for a new record or zero unique key a new key is created and logged.

// Modified Form Methods : 
//Form Method: [LB_QueryTable]Input
//  `do not save record on load for a new rec - just make sure there is a unique key

// Modified Method(s) : 
//ut_PRJRetrieveAEData  
//  `Added missing call to ut_ResetSQLLastUpdateDate

// **********  `End of Release   `2012-03-06 : Version 6.0.2.a 

// **********  ` Modified by: Costas Manousakis-(Designer)-(3/12/12 14:53:55)
// Modified Method(s) : 
//P_ReviewInspcts
//  `Removed the extra code for testing, and the old way of retrieving inspections.

// **********  ` Modified by: Costas Manousakis-(Designer)-(3/13/12 09:53:54)
// Modified Method(s) : 
//SCPOA_FillFormPicButtons
//  `added  check for  pictures from resource files (format contains ";#" )

// Modified Forms : 
//[ScourPOA]Summary-A
//[ScourPOA]Print1-A
//[ScourPOA]Print4-A
//  `Changed checkboxes to resource file "checkbox.png"
//[ScourPOA]Print2-A
//  `changes in some labels as requested by CHA.
//  `Changed checkboxes to resource file "checkbox.png"
//[ScourPOA]Print3-A
//  `Changed checkboxes to resource file "checkbox.png"
//  `changes in some layout in 2d.

//[ScourPOA]Print5-A
//  `changes in some formatting  in 5c. requested by CHA.

//[ScourPOA]FieldVerificationCardpg1
//  `Changed checkboxes to resource file "checkbox.png"
//  `Changed vertical text to resource files also

// **********  ` Modified by: Costas Manousakis-(Designer)-(3/14/12 10:24:36)
// Created Method(s) : 
//INSP_SpellCheckAll
//  ` Go through all 4D Write blobs in an inspection and execute a spell check on each.

// Modified Method(s) : 
//SCPOA_AddtlVars 
//SCPOA_Variables 
//  `added var SCPOA_Nav88_NGVD29_txt

// Modified Method(s) : 
//INSP_ViewAllComments
//  `Moved external window to  top letft corner 20,60 to clear the menubar

// **********  ` Modified by: Costas Manousakis-(Designer)-(3/14/12 10:24:36)
// Modified Forms : 
//[ScourPOA].Input-A
//  `Added button SCPOA_ViewoldSumm on 2nd page

// **********  ` Modified by: Costas Manousakis-(Designer)-(3/16/12 09:51:39)
// Modified Form Methods : 
//[Dialogs];"GetInspExtraCmts"
//  `Added  On Outside Call to cancel form

// Created Method(s) : 
//ut_ShowText
//  `Launch a separate window to display a text.
// Parameters
// $0 : ProcessID_L : process Id created
// $1 : Text : text to be displayed
// $2 : vsExtraTextLabel : Label of text (optional)
// $3 : $TextDispWinTitle : title of the window (optional)


// Modified Method(s) : 
//GetBridgeEngineer
//GetChiefEngineer
//  `use method GRP_GetGroupMembInfo
//  `added phone and email variables

//SCPOA_Print_FromList
//  `use the new method SCPOA_Print_A
//SCPOA_Variables
//  `added var SCPOA_EvalTextProcess_L
//SCPOA_InpFormMethod_A
//  `added CALL PROCESS(SCPOA_EvalTextProcess_L) to close  any window opened

// Created Method(s) : 
//GetDBEInfo
//  ` get info for district bridge engineer

// Modified Method(s) : 
//SQLAuthenticationError
//ut_LogExternalConnects
//Database method : On SQL Authentication
//  `Include the password in the error message if a system parameter SQLAUTHSAVEPW is set to "SAVE"

// **********  ` Modified by: Charles Miller-(Designer)-(3/20/12 )
// Modified Method(s) : 
//ut_PRJRetrievePRJ_Bridge
//  `Fix beg where call to PRJ_CreateIncludedBINRecord was passing in concatenated BDEPT

// Created Method(s) : 
//Compiler_Clone

//ut_ControlClone
//  `Added code to allow for different method in retrieving [Activity Log] records
//ut_ReturnKeyFldandVariable
//  `Add key drop index code for non unique indices

// Modified Forms : 
//"CloneActivityLogListBox"
//  `Added code and objects on form to allow for different method in retrieving [Activity Log] records

// **********  ` Modified by: Costas Manousakis-(Designer)-(3/21/12 13:51:55)
// Modified Form Methods : 
//[Bridge MHD NBIS];"SI & A (Insp)"
//[Bridge MHD NBIS];"SI & A (Normal)"
//[Bridge MHD NBIS];"RailTransitSIA"
//[BridgeMHDNBISArchive];"SI & A (Insp)"
//[BridgeMHDNBISArchive];"SI & A (Normal)"
//  `changed sMissingSignstext from A(30) to text


// **********  ` Modified by: Costas Manousakis-(Designer)-(3/23/12 16:04:29)
// Modified Method(s) : 
//SCPOA_Variables
//  `FV Photo changes : can have more than 4 or 5 photos -
// ` sort first before getting the 1st 4 in "PRINTPG1"
//SCPOA_InpFormMethod_A
//  `FV Photo changes : can add more than 4 photos
//  `removed on load event from photo listbox
//  `removed calls to Object methods not in use in this form

//SCPOA_PhotoListBox_OM 
//SCPOA_CopyInvPhotos 
//SCPOA_PrintFormsA_FM 
//  `FV Photo changes : can add more than 4 photos

// Modified Forms : 
//[ScourPOA]Print1-A
//  `adjusted size and location of pictures and pict labels
//[ScourPOA];"Input-A"
//  `modified page 0 : removed Scour Eval  info
//  `modified page 2 : added section 1a and added button View old Eval Summary
//  `modified page 10 Photos : changed photo listbox, added notes, and button to switch between FVC and inventory list

// Modified Object Methods : 
//Object Method: [Dialogs].ApproveInsp.vbAccept
//  `Fixed typo in the variable INSP_InDepthReview_L

// Created Method(s) : 
//INSP_CommentTools
//  ` Controls the comment tools button in the General comments page of inspection input forms.

//Object Method: [Inspections].Closed Bridge.bViewAllCmts  
//Object Method: [Inspections].Critical Member.bViewAllCmts 
//Object Method: [Inspections].Culvert Combined.bViewAllCmts 
//Object Method: [Inspections].Damage Form.bViewAllCmts
//Object Method: [Inspections].Dive Form.bViewAllCmts 
//Object Method: [Inspections].Dive LowCl.bViewAllCmts 
//Object Method: [Inspections].RailRoutineInput.bViewAllCmts 
//Object Method: [Inspections].Routine Combined.bViewAllCmts 
//Object Method: [Inspections].Underwater Special Member.bViewAllCmts 
//  `New method INSP_CommentTools

// Modified Method(s) : 
//G_SetInspFont
//  `use db parameters for the default fonts

// Modified Form Methods : 
// Method: Form Method: [ScourPOA]Summary-A
//  `use same method in SCPOA_Variables("PRINTPG1") to get the 1st picture

// **********  `End of Release   `2012-03-26 : Version 6.0.3 

//Add code to use list box for Inventory button on 
//Modified by: Charles Miller (3/29/12 14:09:09)

//[Bridge MHD NBIS];"Bridge Input"
//  `Method: Object Method: [Bridge MHD NBIS].Bridge Input.bInventory

//SIA_BridgeInpNavCTRL 
//SIA_OnDisplayDetail 
//SIA_ControlDoubleClick 
//SIA_SetUpListBoxes 
//SIA_ResetWidths 

//End Mods_2012_03