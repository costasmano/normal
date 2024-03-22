//%attributes = {"invisible":true}

//Mods_2004_CM12 

//10-Dec-2004 *********

//Modified Form:
//[Cond Units];"Cond Units Prt 2"
//  `Enabled On Header event for objects in header area.
//  `Added missing inspection date field.

//15-Dec-2004 *********

//Modified Form:
//[Cons Inspection];"Cslt Insp In"
//  `Added "Partially Submitted" to entry list of cboAssignmentStatus;
//  `modified object code of cboAssignmentStatus and cboContractType
//  `to use method POPUPMENUC .
//  `Changed labels and some fields to transparent, Form Appearance to Automatic,
//  `Form size options to resizable with limits
//[Conslt Rating];"Cslt Rating In"
//  `Changed labels and some fields to transparent, Form Appearance to Automatic,
//  `Form size options to resizable with limits, 
//  `replaced combinations of text and Rectangles with group boxes,
//  `Changed all Pulldown objects to use method POPUPMENUC.

//16-Dec-2004 *********

//Modified Form:
//[Conslt Rating];"Cslt Rating In"
//  `Added "Will be Assigned" to entry list of cboAssignementStatus.

//Created New method
//f_BrgStatus_PCT 
//  `Function to calculate a percentage to be used in a Bridge Status report;
//  `Will return -1 if the total value is zero.

//Modified Methods:
//PrepReportTotal 
//PrepStatusRep 
//  `Use function f_BrgStatus_PCT  for calculation of percentages.

//Modified forms:
//[Status Report];"I_StatusReport"
//  `Changed type of variables except vsDate to Numeric;
//  `Changed display of percentage vars to "##0;NA;0" 
//[Status Report];"P_StatusReport_new"
//  `Changed type of variables except vsDate to Numeric;
//  `Changed display of percentage vars to "##0;NA;0" 
//  `Grouped all non-variable/field objects.

//17-Dec-2004 *********

//Modified Form:
//[Inspections];"InspectionReview"
//  `Changed On Display Detail code to check for Spec members only for 
// `RT@ and CUL inspections.

//Modified Table
//[ElementsSafety]
//  `Made fields SpecMembFlag and Rating indexed using Traditional indexing.

//Modified Method
//G_Insp_FontAlert 
//  `New method to display the alert on font compatibility problems
//  `between Mac and PC versions.

//Modified Method
//Print_Dive_Cmt_a_new
//  `Added missing code for $bOrientation,etc.  that should have been there.
//  `Changed the IF((....)) statement that starts printing to be more 'logical'/si
//  `Use Method G_Insp_FontAlert 
//Print_RTN_Cmts 
//Print_CUL_Cmts 
//Print_DefElement_Cmts 
//  `Use Method G_Insp_FontAlert 

//21-Dec-2004 *********

//Created Method:
//G_Insp_ApplyRev1_Inp
//  `Apply changes for Rev1 of Inspection Input forms. Adjust size
//  `and location of objects at the same time.

//Modified Method:
//G_Insp_LockFormOnOff 
//  `Use method G_Insp_ApplyRev1_Inp

//Modified Forms:
//[Inspections];"Closed Bridge"
//[Inspections];"Critical Member"
//[Inspections];"Culvert Form"
//[Inspections];"Damage Form"
//[Inspections];"Routine Form"
//  `Use method G_Insp_ApplyRev1_Inp in object method of field Insp Date,
//  `so that changes to input forms are effective upon a date change.

//Modified Forms:
//[ElementsSafety];"Safety Elm Inp Dive"
//[ElementsSafety];"Safety Elm Inp DiveS"
//[ElementsSafety];"Safety ElmInput"
//[ElementsSafety];"SafetyElementInputEx"
//[Inspections];"Dive Form"
//[Inspections];"Dive LowCl"
//[Inspections];"Underwater Special Member"
//  `Changed size of FormatPulldown to be consistant with the one on the
//  `main Inspection input forms.

//Created Method:
//G_Insp_ElmtArray_setup 
//  `Set up arrays for the Element Safety Pulldown in input forms.

//Modified method:
//G_InspElmtCatPopup 
//  `Added check for Form event; Use method G_Insp_ElmtArray_setup.

//Modified Form:
//[Inspections];"Culvert Form"
//  `Use method G_InspElmtCatPopup in object method of .aInspType_ object.

//Modified Form Method:
//[Inspections];"Culvert Form"
//  `Use method G_InspElmtCatPopup in on Load event.
//  `Use method G_Insp_ElmtArray_setup in on Close Detail event.

//22-Dec-2004 *********

//Modified Form Method:
//[Bridge MHD NBIS];"SI & A Input"
//  `Added code in the On Load event to enable access to specify Item 91
//  `for BRI or CUL bridges which are not FHWA records (NBI).
//  `Deleted a rectangle around the InspWaiverText and added a border 
//  `to the Text field.

//Modified Method
//CalcItem91 
//  `Added code to disable recalculating of Item 91
//  `for BRI or CUL bridges which are not FHWA records (NBI).

//G_ConfigInspBtn_1 
//  `Use method G_Insp_ElmtArray_setup at the end.

//Modified Form Methods:
//[Inspections];"Closed Bridge"
//  `Use method G_Insp_ElmtArray_setup in on Load event.
//  `Add On Close Detail event check and use method G_Insp_ElmtArray_setup.
//[Inspections];"Critical Member",
//[Inspections];"Damage Form"
//  `Use method G_Insp_ElmtArray_setup in on Load event.
//  `Use method G_Insp_ElmtArray_setup in on Close Detail event.
//[Inspections];"Dive Form"
//[Inspections];"Dive LowCl"
//[Inspections];"Underwater Special Member"
//  `Use method G_InspElmtCatPopup in on Load event.
//  `Add On Close Detail event check and use method G_Insp_ElmtArray_setup.
//[Inspections];"Routine Form"
//  `Use method G_InspElmtCatPopup in on Load event.
//  `Use method G_Insp_ElmtArray_setup in on Close Detail event.

//Modified Object Methods:
//[Inspections];"Routine Form".bInspConfig
//[Inspections];"Culvert Form".bInspConfig
//  `Use method G_Insp_ElmtArray_setup.

//Modified Form:
//[ElementsSafety];"SafetyElmtTemplate"
//  `Added object .asElmtSftyPulldwnName to allow switching ad hoc between
//  `elements on the list.

//Created Method:
//G_Insp_ViewAllCmts 
//  `Method to be used to show all Comments in an Inspection report.

//Modified Method
//Print_Dive_Cmt_a_new
//Print_RTN_Cmts 
//Print_CUL_Cmts 
//  `Use method Set Doc Margins on the external 4D Write window opened.

//Modified Object Method
//[Inspections];"Routine Form".bViewAllCmts
//[Inspections];"Critical Member".bViewAllCmts
//[Inspections];"Culvert Form".bViewAllCmts
//[Inspections];"Dive Form".bViewAllCmts
//[Inspections];"Dive LowCl".bViewAllCmts
//[Inspections];"Underwater Special Member".bViewAllCmts
//[Inspections];"Closed Bridge".bViewAllCmts
//[Inspections];"Damage Form".bViewAllCmts
//  `Use Method G_Insp_ViewAllCmts

//28-Dec-2004 *********

//Modified Form
//[Conslt Rating];"Cslt Rating In"
//  `Renamed dropdowns to cboXXXXX from Combo Box1,2...etc on pages 1 and 2

//Modified Form Method
//[Conslt Rating];"Cslt Rating In"
//  `Added code declaring  variables cboXXXX to text arrays at the beginning
//  ` of the method in the non-executable part of the code.
//[Dialogs];"Search Def Element"
//  `Added declaration of pulldown variables in non-exec part of code
//  `for compilation.
//[Bridge Design];"Bridge Design In"
//  `Added declaration of pulldown variables in non-exec part of code
//  `for compilation. Enabled FlushChanges for [Bridge Design] table.

//Modified Form
//[Bridge Design];"Bridge Design In"
//  `Replaced Rectangles and Rect+Text combinations with Group Boxes; 
//  `Cleaned up transparencies of text, variable and some field objects.

//Modified Form Method
//[Contract FundTransfer];"TransferFund In"
//[Contracts];"Contracts In"
//  `Added declaration of pulldown variables in non-exec part of code
//  `for compilation.

//Created Method
//G_DeficientElmtQuery
//  `Execute Query on [SafetyElements] table for Methods used in
//  `M_SearchDefElement.

//Modified Methods
//CreateRandomSetForDefElement
//M_DeficientElementRpt
//  `Use method G_DeficientElmtQuery.

//Modified Object Methods
//[Dialogs];"Search Def Element".cboUrgOp
//[Dialogs];"Search Def Element".cboUrgency
//  `Adjusted code to exclude not 'logical' cases such as searching for 
//  `Urgency of repair less than Prioritize, or more than 'Immediate'.
//[Dialogs];"Search Def Element".cboDefOp
//[Dialogs];"Search Def Element".cboDeficiency
//  `Adjusted code to exclude not 'logical' case such as searching for 
//  `Deficiency more than C-H.

//29-Dec-2004 *********

//Modified Forms:
//[Conslt Rating];"Cslt Rating In"
//[Cons Inspection];"Cslt Insp In"
//  `Added Help messages to the all buttons in the toolbar; 
//  `Created new help messages for the print buttons;
//  `Assigned shortcuts to the navigation and save/cancel buttons

//Modified Form:
//[Activity Log];"Print"
//  `Renamed Variables showing blob data to vLogData, vOldLogData_S (A254);
//  `Increased width/height of form; width/height of Data/OldData variables;
//  `Made vLogData variable to Print Variable Frame;
//  `Changed Page Setup to 'Letter'

//Modified Form Method:
//[Activity Log];"Print"
//  `Changed method that calculates vLogData and vOldLogData 
//  `(similar as in "Input" form).

//29-Dec-2004 *********

//Added StyleSheets
//Courier07, Courier06, Helvetica8, Helvetica7, Helvetica6.

//Modified Forms:
//[Bridge MHD NBIS];"Rpt Mstr"
//[Bridge MHD NBIS];"Rpt Mstr Detail"
//[Bridge MHD NBIS];"Rpt Mstr Hdr0"
//[Bridge MHD NBIS];"Rpt RPC"
//[Bridge MHD NBIS];"Rpt RPC Detail"
//[Bridge MHD NBIS];"Rpt RPC Footer"
//[Bridge MHD NBIS];"Rpt RPC Header0"
//[Bridge MHD NBIS];"Rpt RPC Header1"
//  `Apply stylesheets to all objects; Made all objects transparent.

//Modified Method:
//M_MasterList 
//  `Adjusted code to avoid printing extra blank page at the end of job.

//Created Method
//G_Insp_ApplyLineSpacing 
//  `Apply line spacing to a 4D Write Area for Inspection reports.

//Modified Methods:
//Set Doc Margins 
//G_addItemtoWr 
//G_AddElmtTxt2Area 
//G_Insp_AddOrientation 
//G_Insp_AddGenCmts 
//  `Use method G_Insp_ApplyLineSpacing

//05-Jan-2005 *********

//Modified Object Methods:
//[Conslt Rating];"Cslt Rating In".cboAssignmentStatus
//[Conslt Rating];"Cslt Rating In".NBISLetter
//  `Changed them to use POPUPMENUC when changing the value 
//  `of AssignStatus field.

//07-Jan-2005 *********

//Added Form
//[Dialogs];"3OptionConfirm"

//Added Method
//ut_3Option_Confirm 

//Modified Form:
//[Dialogs];"GetInspExtraCmts"
//  `Applied StyleSheets to labels and buttons.

//Modified Method:
//G_InspExtraCmtsBtn
//  `Added Close Window command.

//Modified Form Object methods:
//[Bridge MHD NBIS];"ID Input".aIt8BrCatDes_
//  `Added code to crosscheck with FHWARecord field.
//[Bridge MHD NBIS];"BDEPT Input".aIt8BrCatDes_
//  `Added code to crosscheck with FHWARecord field.
//[Bridge MHD NBIS];"BDEPT Input".FHWARecord
//  `Added code to crosscheck with Item8 BridgeCat field.
//[Bridge MHD NBIS];"Other Info".FHWARecord
//  `Added code to crosscheck with Item8 BridgeCat field.

//Modified Forms:
//[Bridge MHD NBIS];"ID Input"
//  `Added Help messages to navigation buttons.
//[Bridge MHD NBIS];"BDEPT Input"
//  `Added Help messages and shortcuts to navigation buttons;
//  `Changed stylesheets of some objects.
//[Bridge MHD NBIS];"Other Info"
//  `Added Help messages to navigation buttons.