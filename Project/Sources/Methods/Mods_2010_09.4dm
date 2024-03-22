//%attributes = {"invisible":true}
// **********  ` Modified by: costasmanousakis-(Designer)-(9/1/10 12:14:53)
// Modified Form Methods : 
//[RatingReports];"RatReportsIn"
//  `Added Recording of Items 67.68.69.70 when changed by the AASHTO_SuffRat method

// Modified Method(s) : 
//SIA_SecureInputForm
//  `Added more color changes to fields being set to editable/noneditable

// Modified Object Methods : 
//[Bridge MHD NBIS];"SI & A Input".Item103
//  `Added more color changes to fields being set to editable/noneditable

// Created Method(s) : 
//INSP_PrintInspBtn_OM
//  ` Object method for the button that prints inspections from the inspection list in the 
//  ` Combined Inspections list.

//ut_showRelStatus
//  ` Show the Relation status on a Field- from command GET FIELD RELATION

// Modified Forms : 
//[Bridge MHD NBIS];"CombinedInspections"
//  `Added Print Inspection Button - invisible for all but designer for a while

// Modified Method(s) : 
//VARIOUS METHODS : 
//ChgInspTypeBtn
//[Inspections];"BlankCombinedStarter
//PRINT_CULVERT_F
//PRINT_ROUTINE_F
//G_SecureInspection
//SIA_ReleaseBridgeRec
//QR_MinElementValue
//  `Removed calls to SET AUTOMATIC RELATIONS(True;True) which should not be needed.

// **********  ` Modified by: costasmanousakis-(Designer)-(9/2/10 09:40:46)
// Picture Library
//  `Added "ShowMenu" 3-stage icon
//  `Adjusted BMS Donwload icon to not show too much non-white background

//Help Tips
//  `Added Tip ShowWRMenu

// Modified Method(s) : 
//WRUTIL_Function
//  `Added Function "SHOWMENUBAR"

// Modified Forms : 
//[Inspections];"Closed Bridge"
//[Inspections];"Critical Member"
//[Inspections];"Culvert Combined"
//[Inspections];"Damage Form"
//[Inspections];"Routine Combined"
//  `Added buttons DE ShowMenuOR and DEShowMenuGR to show /hide the menu bar 
//  `for the 4D Write areas.

//[Inspections];"Dive Form"
//[Inspections];"Dive LowCl"
//[Inspections];"Underwater Special Member"
//  `Added buttons  DEShowMenuGR to show /hide the menu bar 
//  `for the 4D Write area.

// Modified Method(s) : 
//  `Modified VARIOUS object and Form methods to replace the (Before) call with
//  `either "Form event=On Load"  or 
//  ` "(Form event=On Load ) | (Form event=On Printing Detail ) | (Form event=On Display Detail )"

// Created Method(s) : 
//BMSUtil_BelongToBridge
//  ` Determine if bridge belongs to a user
//  ` Parameters
//  ` $0 : $Access_b
//  ` $1 : $CurrUser_txt (Optional) if not specified or blank use current user
//  ` $2 : $BridgeInspResp (Optional) if not specified or blank use [Bridge MHD NBIS]InspResp

// Modified Method(s) : 
//BRG_RWAccess
//SIA_BridgeInput_FM
//  `Use method BMSUtil_BelongToBridge for MDC users

// **********  ` Modified by: costasmanousakis-(Designer)-(9/8/10 12:16:31)
// Modified Forms : 
//[RatingReports];"RatReportsIn"
//  `Hid the Print button

//[RatingMember];"RatMemberIn"
//  `Added the color bar
//  `changed the format of the numbers to #,###,###.0
//[RatingMember];"RatElmInc"
//  `changed the format of the numbers to #,###,###.0

// **********  ` Modified by: costasmanousakis-(Designer)-(9/13/10 09:03:06)
//**** Transfer / Log changes
//X_CreateOwnRecs
//  ` common method to created owner records when creating
//  ` entries in the Activity log from the Logxxx/Flushxxx methods
//  ` Checks if there is an array of owners defined and adds them to the list
//ut_RelogBridgeMHDNBIS_record
//  ` Recreate LogNewrecord and Changes for a Bridge mhd nbis record

// ***** Bridge input form changes
//SIA_BridgeInpNavCTRL
//  ` Control Navigation in Bridge Input form

// ***** Inspection delete
//G_DeleteInspection
//  `Execute method only if on page 1 of a form???
//  `Also require user Password before deleting

// Modified Forms : 
//[Bridge Design];"Bridge Design In"
//  `Added buttons to go to ProjectInfo Pages

//****** DCM Mods
// Created Method(s) : 
//DCM_UtilLoadXMLTemplate
//  ` Read an excel workbook in xml format and create the templates used for 
//  ` generating the excel workbook reports from the district maintenance screens
//ut_DateToExcel
//  ` Return a string of date in eXcel yyyy-mm-dd
//ut_CreateMSOfficeDoc
//  ` Create an MS office document
//DCM_ContrProjControl
//  ` Initialize and load arrays used in the DCM project input screen
//DCM_P_Input_FM
//  ` Form method for [DCM_Project];"DistrWorkOrderInput"
//DCM_PROJITEMS_CTRL
//  ` Control method for Bridge project items in a work order input form
//DCM_WO_PrjLB_Control
//  `  Control the list box on a work order input form
//DCM_PrintWorkOrder
//  `"Print" - export work order to an excel -xml workbook
//DCM_WO_BrgList_OM
//  `Method for the Bridge List box in the work order input form
//DCM_WO_Input_FM
//  ` form method for [DCM_WorkOrders];"DistrMaintInput"
//DCM_PrintContractReport
//  `"Print" - export DCM Contract to an excel -xml workbook
//DCM_PrintProject
//  `"Print" - export DCM Bridge Project to an excel -xml workbook

// Modified Method(s) : 
//DCM_ControlCUs
//  `Set the insp date array to 0 on start.
//DCM_4DWriteDlg_FM 
//  `Adjustments in the form method
//DCM_ControlWOBlobs
//  `Changes additions for Bid items
//DCM_ContrBidItems
//  `Additions for bid items used 

// Modified Object Methods : 
//[DCM_Contracts];"DistrMaintInput".btnSave
//  `removed (False ) code
//[DCM_WorkOrders];"DistrMaintInput".btnSave
//  `Use the on validate event on method DCM_WO_Input_FM
//  `the On Validate event has been disabled in the form properties, so it should not fire twice
//[DCM_WorkOrders];"DistrMaintInput.btnDelete 
//[DCM_WorkOrders];"DistrMaintInput". AddProjectBtn
//  `Adjusted Code

// Modified Forms : 
//[DCM_WorkOrders];"DistrMaintInput"
//  `Form and form method additions / Adjustments / fixes
//  `Added 2nd page for Bid Item summary, Replaced Bridge include form with ListBox

// Modified Object Methods : 
//[DCM_Project];"DistrWorkOrderInput". btnSave
//[DCM_Project];"DistrWorkOrderInput". btnDelete
//  `Use new method DCM_P_Input_FM
// Modified Forms/Methods : 
//[DCM_Project];"DistrWorkOrderInput"
//  `Additions / Modifications - use new DCM_P_Input_FM
//  `Added 2nd page with bid items

// **********  ` Modified by: costasmanousakis-(Designer)-(9/15/10 15:28:25)
// Modified Form and Form Methods : 
//[Activity Log];"Print"
//  `Changed form to add the destination Parent and Local IDs ; cleaned up so that it prints better
//  `had to move the Data variable lower

//[Bridge MHD NBIS];"Bridge Input"
//  `Added 8 poages in preparation of switrching to a one form method with multiple pages
//  ` instead of launching new forms.

// **********  ` Modified by: costasmanousakis-(Designer)-(9/17/10 10:13:10)
// Modified Form Methods : 
//[Conslt Rating];"View Cslt Rating"
//  `Added column for Contract Type
// Modified Method(s) : 
//G_CSRTG_InitSortBtns
//  `Added Cotnract Type arrow button variable
// Modified Forms : 
//[Conslt Rating];"Cslt Rating In"
//  `Added option "Review" to cboContractType
//[Contracts];"Contracts In"
//  `Added option "Review Rating" to cboType

// Created Method(s) : 
//GRP_Primary_Acting
//  `Handle the primary and Acting buttons in the Pers Group input forms
// Modified Forms /Methods : 
//[PERS_Groups];"Input"
//  `Enable the Primary and Acting fields. Added buttons to handle that. 
// Modified Method(s) : 
//GRP_RemoveFromGroup
//  `Added changes to hanlde the Acting-promary roles when removing a member
// Created Method(s) : 
//PERS_EditGroups
//  ` Edit the Personnel Groups table
//  `Launched from a designer pulldown on the Personnel output form

// **********  ` Modified by: costasmanousakis-(Designer)-(9/20/10 09:13:05)
// Created Method(s) : 
//GRP_EditGroup
//  ` Edit an existing Group of Personnel. Designed to open a group for editing
//  ` without allowing changing the group name.
// Modified Form Methods : 
//[PERS_Groups];"Input"
//  `Added var GRP_NotAllowGrpNmEdit_b to lock changes to the group name
// Modified Method(s) : 
//PRJ_ProcessUnassigned
//  `If record being added is a DES record make NEWBIN_b=true , move to Group 1
//PRJ_QR_BridgeRank
//  ` Retrieve the Bridge Rank of Bridges Related to a project file number

// **********  ` Modified by: costasmanousakis-(Designer)-(9/22/10 16:54:35)
// Modified Method(s) : 
//TMPL_WRDirectFind
//  `Added an ON ERR CALL to avoid errors when loading some docs with formulas that cause errors
//  `Also loop thru the "Frames" main body , headers , footers

// **********  ` Modified by: costasmanousakis-(Designer)-(9/23/10 16:33:18)
// Created Method(s) : 
//CRTG_ShowListbox
//  ` Display a list box for Cons rating reports
//CRTG_SetReviewVars 
//  ` Set process variables used in cons ratings
// CRTG_ReviewLB_OM
//  `Object method for the listbox shown by the CRTG_ShowListbox method
//CRTG_ReviewLBControl 
//  ` method to control the listbox  shown by the CRTG_ShowListbox method
//CRTG_RecentSubm_OM
//  ` Most Recent submission object method
//CRTG_ReviewerCBO_OM
//  ` Rating Reviewer Obj method
//CRTG_RecentAction_OM
//  ` Recent Action object method for Rating review section
//CRTG_RecentAction
//  ` Get the recent action for rating review group
// Modified Object Methods : 
//[Conslt Rating];"Cslt Rating In".NBISLetter
//  `use the CRTG_RecentAction_OM method

// Modified Forms : 
//[Templates];"Input"
//  `Added button SaveCRTToDBFld

// **********  ` Modified by: costasmanousakis-(Designer)-(9/24/10 16:33:18)
// Created Method(s) : 
//GRP_UserInGroup
//  ` Determine whether the current user is a member of a group(s) in [Pers_Groups]
//CRTG_LoadReviewerLists
//  ` Load the lists of the Rating Reviewers
//CRTG_ToolBox_OM
//  ` Object method for the Toolbox button on cons rating input form
// Modified Form : 
//[Conslt Rating];"View Cslt Rating"
//  `added button CRTGShowLBBTN to launch the rating review list box

// **********  ` Modified by: costasmanousakis-(Designer)-(9/28/10 16:15:43)
// Created Method(s) : 
//INSP_UserAllowed
//  ` Determine whether the user is allowed to Open an inspection
// Modified Form Methods : 
//[Inspections];"BlankCombinedStarter"
//  `Use new method INSP_UserAllowed

// Modified Method(s) : 
//RtgMethod_OM
//  `Changed metric Ton format passed to G_FormatItm6466 to "" (no format)
