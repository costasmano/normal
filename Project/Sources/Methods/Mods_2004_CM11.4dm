//%attributes = {"invisible":true}
//Mods_2004_CM11
//20-Oct-04 ********

//Modified method
//M_NEW_BIN : 
//  `Adjust Window size to fit the BDEPT Input screen.
//Set Doc Margins
//  `Added locking of wr cmd insert 4D expression to disable popup of fields
//  `menu when right-clicking(PC) or ctrl-click(Mac).

//Modified form :
//[Bridge MHD NBIS];"BDEPT Input" : 
//  `Adjusted width of pulldowns for Item6a
//  `and Item 7 and width of variables used in Display.
//[Dialogs];"Stats"
//  `Increased font size of message, font of Done button, 
//  `size and location of obj

//25-Oct-2004**********

//Modified method:
//ControlClientProcess
//  `Add code to mark record as not running.
//  `Calculate QueryValue_txt without any adjustments of whether $hour is
//  `> 22
//G_GetUWRatings 
//  `Changed logic of selecting UW inspections. Now : look for last approved Routi
//  `(DVE or DVL) inspection and get data up until that one.
//Modified form
//FilesPalette:
//  `Increased Button sizes by 10

//29-Oct-04*************

//Modified forms:
//[Bridge MHD NBIS];"SI & A Input"
//  `Fixed stylesheets for labels, data fields, pulldowns.
//[RatingReports];"RatReportsIn"
//  `Fixed stylesheets for labels, pulldowns, data fields, changed sizing opptions
//  `of form, tabs, Element data list, RatingInfo fld in page 2. Added help messag
//  `to buttons on page 0. Replaced rectangles and labels w group boxes.
//  `Deleted page 4 that was not used.
//[RatingMember];"RatMemberIn"
//  `Applied StyleSheets and group boxes
//[RatingMember];"RatElmInc"
//  `Applied Stylesheets - made rectangles and text transparent.
//[Bridge MHD NBIS];"SI & A (Insp)"
//  `Made all variables and fields transparent
//[Bridge MHD NBIS];"SI & A (Normal)"
//  `Fixed code in obj method of vItem63 : wrongly declaring vItem64 variable
//  `Made all variables and fields transparent
//[Standard Photos];"StdPhotosOutPut"
//  `Added BIN and Insp date in fields.

//03-Nov-04*************

//Added Project Method:
//f_BridgeInspected_MMYY :
//  `Determines whether a bridge has been inspected during a given month and year
//  `based on SIA fields only.

//04-Nov-04*************

//Modified Project Method:
//P_ReviewInspcts :
//  `Allow Bridge Insp Engineer group Farhad Rastegari to view all pending inspect
//  `without any approval.

//Modified Forms:
//[Contracts];"Contracts Print 2"
//[Conslt Rating];"Rating Print Form"
//[Cons Inspection];"Inspection Print Form"
//  `Changed Page setup to Letter from Letter(Small), adjusted location of markers
//  `to be no lower than 766, changed form margins to 0.

//Modified Object method
//[Bridge MHD NBIS];"Inspection Form".bDuplicate
//  `Removed initialization of some variables.

//Modified Table
//[Inspections]:
//  `Renamed field ConsQCEngrID, DamageCmtsPg1
//  `Added Fields InspDBIEApprDate (DATE), InspAreaEngApprDate (DATE),
//  `OrientationText (BLOB)

//08-Nov-04*************

//Modified Form
//[Inspections];"AboveWater Template":
//  `Removed shortcut for Cancel Button, Added Invisible button viTrapESC
//  ` to trap ESC Keypress, Assigned Pagup and PgDn shortcuts to invisible buttons

//09-Nov-04*************

//Modified Form
//[Dialogs];"ArchiveDlog":
//  `Added var vlArchRecstoExport to enter number of entries to be exported. 
//  `Initialize it to 10000 in form method

//Modified Method
//ArchiveLogFile:
//  `Use var vlArchRecstoExport to control number of entries exported ;
//  `Moved final Completion Alert message outside if(CBDelete) statement.

//12-Nov-04*************

//Modified method
//InitFOSDFields :
//  `Added one parameter to Set whether displaying messages on screen or not.
//Server_GenCondRep :
//  `Added call to method InitFOSDFields ; Added vars to time execution;
//  `Save comments in the [Status Report] record.
//ControlServerProcesses :
//  `Added code to save in the LastTimeRun the last time it checked the records.
//ControlClientProcess 
//  `Added code to save in the LastTimeRun the last time it checked the records.

//Modified Form
//[Status Report];"O_StatusReport" :
//  `Added Shortcuts to Search, Sort, All records, Subrecs. Applied Stylesheets.
//[ServerProcesses];"Output": 
//  `Changed field widths to fit better on startup screen.

//15-Nov-04*************

//Modified Forms
//[Dialogs];"Search Bridge" ,
//[Dialogs];"Search Bridge in Bridge Design" ,
//[Dialogs];"Search Bridge in Cons Inspectio",
//[Dialogs];"Search Bridge in Conslt Rating"
//  `Changed vBIN object size to accomodate "WWW" and applied stylesheets.

//18-Nov-04*************

//Modified Forms
//[BMS Inspections];"Inspections In"
//  `Added Re-Sizable option in form properties and set up min sizes.

//19-Nov-04*************

//Modified method
//InitProcessVar 
//  `Increased aIRatMethD_, aORatMethD_ to a(50)
//INIT_FIELDS_DES ; ut_RetrieveBlobDocument 
//  `Increased ◊aRatMethDes to a(50)
//G_InitInspVars 
//  `Added var vsInspDepartment a(150) ; initialized according to InspResp.
//INIT_UI_GV 
//  `Added var ◊InspFormRevDate_1 (DATE)

//Modified forms :
//[Bridge MHD NBIS];"SI & A (Insp)" ,[Bridge MHD NBIS];"SI & A (Normal)"
//  `Changed size of vars vItem63,65 to a(50) in object methods.

//22-Nov-04*************

//Added method
//G_FormatItm6466 

//Modified Form:
//[Bridge MHD NBIS];"SI & A Input" 
//  `Changed obj method of Item 63,65 to use method G_FormatItm6466, created
//  `text variables for unit labels.
//[Bridge MHD NBIS];"SI & A (Insp)" ,[Bridge MHD NBIS];"SI & A (Normal)"
//  `Changed object code of vars vItem63,65 use method G_FormatItm6466. Also
//  `increased their size.
//[RatingReports];"RatReportsIn" :
//  `Adjusted Object methods of aORatMethD_ , aIRatMethD_ to use G_FormatItm6466 ,
//  `created text variable for unit labels, changed object sizes to fit better.

//Modified method
//ExportNBI :
//  `Adjust format of $vItem64, $vItem66 based on 63 and 65 values.

//Modified Forms :
//[Inspections];"Closed Insp Pg1" - [Inspections];"Culvert Pr Pg 1";
//[Inspections];"Damage Pg1" - [Inspections];"FC Pr (Pg 1)"
//[Inspections];"Routine Arch Pr Pg 1" - [Inspections];"Routine Pr Pg 1"
//  `Added variable VSINSPDEPARTMENT to replace "MassHighway" label.

//Modified method:
//G_Insp_SetDirLbl :
//  `Use Var $vsBoundOnOff to check for var ◊InspFormRevDate_1 'DATE_1'

//Created Method
//G_AddHeader 

//modified methods:
//Print_RTN_Cmts,  Print_CUL_Cmts , Print_Dive_Cmt_a_new :
//  `Added calls to G_AddHeader to implement adding overall Item headers in
//  `Inspection comments.

//Created form
//[Inspections];"SpecialExtra" :
//  `New form to display extra elements for Special, Damage, FC inspections.

//Modified methods
//G_SetInspFont 
//  `Reset Selections of ElementsSafety and StandardPhotos
//G_CountSpMbPgs , G_CountInspSpecMPgs ,Print_SpecMem_pg1 , Print_SpecMem_pg3 
//  `Adjust for 22 elements per additional pages of special members

//Created method
//G_Insp_HideRatReq 
//  `Hide ReRating request items.

//Modified Form methods:
//[Inspections];"Culvert Pr Pg 1" , [Inspections];"Damage Pg 1",
//[Inspections];"FC Pr (Pg 1)", [Inspections];"Routine Pr Pg 2"

//24-Nov-04*************

//Modified Form:
//[Personnel];"Inspectors Out"
//  `Added Shortcut keys to tool buttons.
//[BMS Inspections];"Inspections In"
//  `Added help messages to buttons ; Applied stylesheets to labels and fields.

//29-Nov-04*************

//Added methods 
//G_ApplySheet 
//  `General method to apply a style sheet to a 4D Write Area
//G_OrientationTxtArea
//  `General method to handle Inspection Orientation text 4D Write Area in input f
//G_Insp_AddOrientation 
//  `General method to add Inspection Orientation text to a 4D Write Area
//G_Insp_AddGenCmts 
//  `General method to add Inspection general comments to a 4D Write Area
//G_Insp_LockFormOnOff
//  `General method to lock Inspection form objects.
//f_Insp_Revision1
//  `General function to check whether a date is on or after ◊InspFormRevDate_1

//Modified methods:
//G_AddElmtTxt2Area ;   G_addItemtoWr 
//  `Use method G_ApplySheet
//G_CountSpMbPgs ; G_CountInspSpecMPgs ; Print_SpecMem_pg1;
//Print_SpecMem_pg3
//  `Use function f_Insp_Revision1, adjust logic accordingly.
//Print_RTN_Cmts ;  Print_CUL_Cmts ; Print_Dive_Cmt_a_new 
//  `Added calls to G_Insp_AddOrientation, G_Insp_AddGenCmts, 
//  ` added var $bOrientation.

//30-Nov-04*************

//Create method:
//G_Insp_SetPersUI 
//  `General method to initialize Personnel and agency fields in
//  `Inspection input forms.

//Modified Form Methods
//[Inspections];"Closed Bridge"
//  `Use methods G_Insp_LockFormOnOff ,     G_Insp_SetPersUI
//  `moved code checking Item 93b inside if(vbInspectionLocked) statement.
//[Inspections];"Critical Member"
//  `Use methods G_Insp_LockFormOnOff ,     G_Insp_SetPersUI 
//  `moved code checking Item 93b inside if(vbInspectionLocked) statement.
//[Inspections];"Culvert Form"
//  `Use methods G_Insp_LockFormOnOff ,     G_Insp_SetPersUI 
//[Inspections];"Damage Form"
//  `Use methods G_Insp_LockFormOnOff ,     G_Insp_SetPersUI 
//  `moved code checking Item 93b inside if(vbInspectionLocked) statement.
//[Inspections];"Routine Form"
//  `Use methods G_Insp_LockFormOnOff , G_Insp_SetPersUI
//[Inspections];"InspectionReview"
//  `In Insp title indicate whether it is a Comb inspection

//Modified Form
//[Dialogs];"InspDialog1"
//  `Applied stylesheet to all objects.

//3-Dec-04*************

//Modified Form Method:
//[Standard Photos];"Standard Photos"
//  `Do not set vInspTitle if it is already defined as non-blank.
//[Inspections];"Damage Pg1"
//  `Added code to display either the field DamageCmts or extract from
//  `field general remarks depending on inspection date.

//Modified Method:
//G_AddHeader
//  `Add "Item XX - " in the header labels.
//G_AddElmtTxt2Area ,G_addItemtoWr 
//  `Added declaration of variable vtHeaderLbl

//Modified Form:
//[Inspections];"AboveWater Template"
//  `Changed all pictures and labels to transparent. Centered all labels.

//[Inspections];"Damage Form",[Inspections];"Closed Bridge",
//[Inspections];"Critical Member",[Inspections];"Culvert Form",
//[Inspections];"Routine Form"
//  `Added field for orientationtext and associated buttons, sliders
//  `and adjusted object names and sizes for General comments field.

//6-Dec-04*************

//Modified Forms:
//[Inspections];"Closed Insp Pg1" , [Inspections];"Culvert Pr Pg 1" ,
//[Inspections];"Damage Pg1", [Inspections];"FC Pr (Pg 1)" ,
//[Inspections];"Routine Arch Pr Pg 1", [Inspections];"Routine Pr Pg 1"
//  `Adjusted Size of variable VSINSPDEPARTMENT

//Modified Form Methods:
//[Inspections];"Closed Insp Pg1" , [Inspections];"Culvert Pr Pg 1" ,
//[Inspections];"Damage Pg1", [Inspections];"FC Pr (Pg 1)" ,
//[Inspections];"Routine Arch Pr Pg 1", [Inspections];"Routine Pr Pg 1"
//  `Adjust Font size of variable VSINSPDEPARTMENT

//7-Dec-04*************

//Modified Method:
//G_InitInspVars
//  `Changed MDC to "Department of Conservation and Recreation"

//Modified Form:
//[ElementsSafety];"Debug"
//  `Added BIN and InspDate fields.

//8-Dec-04*************

//Added Method:
//G_Insp_SetDeptFont 
//  `Adjust font size of var VSINSPDEPARTMENT in Inspection print forms.

//Modified Form Methods:
//[Inspections];"Closed Insp Pg1" , [Inspections];"Culvert Pr Pg 1" ,
//[Inspections];"Damage Pg1", [Inspections];"FC Pr (Pg 1)" ,
//[Inspections];"Routine Arch Pr Pg 1", [Inspections];"Routine Pr Pg 1"
//  `Use Method G_Insp_SetDeptFont.

//Modified Forms:
//[Dialogs];"Search Bridge in Bridge Design",
//[Dialogs];"Search Bridge in Cons Inspectio"
//[Dialogs];"Search Bridge in Conslt Rating"
//[Dialogs];"Search by ContractNo in CI"
//[Dialogs];"Search by ContractNo in CR"
//[Dialogs];"Search Conslt Address"
//[Dialogs];"Search Def Element"
//  `Adjusted Tab order

//Modified Method:
//M_InspSchedule 
//  `When checking for out of frequency (P1=1) pass the $Waive
//  `parameter to the fOutofFreq method