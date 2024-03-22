//%attributes = {"invisible":true}
//03-Feb-2005 *********

//Modified Form
//[Inspections];"Damage Form"
//  `Changed variables of Clearance Posting N/E-S/W indicators to match the
//  `Sidewalk variables.

//Created Method:
//G_Insp_ApproveReject 
//  `Created to replace code in bzApprove button.
//  `Adjusted code to record approval dates depending on Structure Version.

//Modified Object Method
//[Inspections];"InspectionReview".bzApprove
//  `Replaced code with call to method G_Insp_ApproveReject

//04-Feb-2005 *********

//Modified Menu #2
//  `Allow All Groups Access to  Menu Records/Search by Element Deficiency.
//  `Change Access group to New Bridge Access for menu Records/Create BIN.

//Modified Method
//Temp_setItem8
//  `Allow execution only for Designer.

//Modified Form Method
//[Inspections];"Inc. Inspection"
//  `Adjusted so that Spec. Mem. check is done only for RT@ and CUL inspections.
//  `Also use the InspRtnSpcMbFlag field for Version >=5.0

//Modified Form Method
//[Inspections];"InspectionReview"
//  `Adjusted so that Spec. Mem. check is done only for RT@ and CUL inspections.
//  `Use the InspRtnSpcMbFlag field for Version >=5.0

//Modified Method:
//G_Insp_SaveInspection
//G_Insp_SaveContinue
//  `Add code to save InspRtnSpcMemFlag flag and pushchange for
//  `versions >=5.0

//Created Method
//Temp_IniInspCmbdFld
//  `Initialize field [Inspections]InspRtnSpcMemFlag

//08-Feb-2005 *********

//Modified Method
//G_InspParagProt
//  `Added a check after the addition of (cont'd) line, to verify that the car-ret
//  `places the cursor at line one. If not, go back to beginning of (cont'd) title
//  `and add a carriage return.

//09-Feb-2005 *********

//Modified Method
//G_Insp_LockFormOnOff
//  `Allow inspectors to view all comments even for locked inspections.

//Modified Form
//[Inspections];"Routine Form"
//  `Added Horizontal splitter and Spaceholder buttons in Page 8. Set the 
//  `comments fields to grow on vertical resizing.
//*****Need to do this on other forms.

//Modified Method
//G_SpellCheckArea
//  `Added code to check for characters with Ascii = 0.
//  `They are the fraction ones.

//14-Feb-2005 *********

//Modified Object
//[Personnel];"Inspectors In".ZZ5 (Delete button)
//  `Changed default Action to None; Modified Object code to prevent deletion
//  `if Inspector is part of an inspection.

//17-Feb-2005 *********

//Modified Method
//M_LoadBINfile 
//  `Added code to get only the first x characters from each line depending on
//  `whether looking for BINs, BDEPTs or BRKEYs.

//22-Feb-2005 *********

//Modified Form Method
//[Bridge MHD NBIS];"SI & A (Insp)"
//[Bridge MHD NBIS];"SI & A (Normal)"
//  `Use Query([townlineInfo]) instead of relate many([bridge mhd  nbis])

//Modified Method
//G_GetSIARecPosting 
//  `Use Query([ratingreports]) instead of relate many([bridge mhd  nbis])

//23-Feb-2005 *********

//Modified Object Methods
//[Inspections];"Closed Bridge".vbPgPreview
//[Inspections];"Critical Member".vbPgPreview
//[Inspections];"Damage Form".vbPgPreview
//  `Changed Page Break(>) to plain Page Break after printing page 1s.

//Modified Objects
//[Inspections];"Dive Form".Configure ; .Spellcheck
//[Inspections];"Dive LowCl".Configure ; .Spellcheck
//[Inspections];"Underwater Special Member".Configure ; .Spellcheck
//[Inspections];"Closed Bridge".Configure
//[Inspections];"Critical Member".Configure
//[Inspections];"Culvert Form".Configure
//[Inspections];"Damage Form".Configure
//[Inspections];"Routine Form".Configure
//  `Increased widths to accomodate transition to 2003.

//24-Feb-2005 *********

//Modified Forms
//[Inspections];"Dive Special Pr Pg 1"
//[Inspections];"Closed Insp Pg1"
//[Inspections];"Culvert Pr Pg 2"
//[Inspections];"Damage Pg1"
//[Inspections];"Dive Pr  LowCl Pg1"
//[Inspections];"Dive Pr Pg 1"
//[Inspections];"FC Pr (Pg 1)"
//[Inspections];"Routine Arch Pr Pg 1"
//[Inspections];"Routine Pr Pg 2"
//  `Adjusted Page setup, Markers and some positions.

//Modified Method
//CheckDependencies
//  `Changed Query selection by Formula[RatingReports]; 
//  `to Query Selection[RatingReports];  using a date variable.

//Modified Form Methods
//[Inspections];"Closed Bridge"
//[Inspections];"Critical Member"
//[Inspections];"Damage Form"
//[Inspections];"Dive Form"
//[Inspections];"Dive LowCl"
//[Inspections];"Underwater Special Member"
//  `Use method G_Insp_RelateInsp instead of Relate Many

//Modified Form
//[Inspections];"InspectionReview"
//  `Adjusted Form Markers.

//2-Mar-2005 *********

//Created Method
//G_Insp_VerifyItem
//  `Method to Make sure that an NBI Rating Item is an allowable value.
//  `If not will return N. Applies to Items 58-62.

//Modified method
//G_SIA2Inspection 
//  `Use method G_Insp_VerifyItem when getting values from SIA table.
//InitPers
//  `Add Code to Sort Team leaders and Team Members puting first the inspectors
//  `from the current district when $Agency="Mass highway"

//Modified Forms:
//[Inspections];"Closed Bridge"
//[Inspections];"Critical Member"
//[Inspections];"Damage Form"
//[Inspections];"Dive Form"
//[Inspections];"Dive LowCl"
//[Inspections];"Underwater Special Member"
//  `Made sure all objects have Stylesheets; Adjusted DBIE,Agency and TmLeader 
//  `pulldowns ; Cleaned up some combinations of labels and rectangles.

//Modified Method
//DUPLIC_INSP_NEW 
//  `Replaced Relate Many[bms inspections] with 
//  `query[cond units]inspid=vinsptocopy
//P_ReviewChanges 
//  `Use Plain Window type.

//Modified Form
//[zDialogs];"EasySearch"
//  `Assigned StyleSheets ; Added Hor Splitter ; Set form properties to resizable 
//  `Made groups re-size vertically ; Made bottom row of buttons invisible ,
//  `made their size 2x2 and moved them up inside the visible form (this to fix
//  `display problem in 2003 version).

//Modified Method
//M_EZSearch
//  `Set Window type  to Plain Window

//Modified Method
//Shutdown 
//  `Added Origin in the parameters for Process Properties;
//  `Ignore processes which were originated by 4D ($LOrigin < 0 )

//4-Mar-2005 *********

//Modified Form
//[Bridge MHD NBIS];"SI & A Input"
//  `Adjusted tab order on all pages; and some object properties
//[Bridge MHD NBIS];"BDEPT Input"
//  `Applied stylesheets to all objects and removed Delete Record button.
//[zDialogs];"FilesPalette"
//  `Assigned Menu bar 1

//Modified Method
//P_FilesPalette
//  `Added call to ControlMenuBar(1)

//7-Mar-2005 *********

//Modified Form
//[ClientAccess];"Output"
//  `Changed Marker locations;Added Entry filters to TimeStamp fields; 
//  `Set Min Width and Ht.
//[ClientAccess];"Input"
//  `Added Entry filters to TimeStamp fields; Set Min width and Ht.

//Modified Method
//ut_BigAlert 
//  `Changed window type to Plain Fixed Size window, from Modal Dialog. (Window di
//  `show during startup)

//Modified Method
//G_Insp_ApproveReject 
//  `Added extra sCR between comments.

//Created Method
//Server_CheckLoginStatus 
//  `To scan [ClientAccess] table for messages.

//10-Mar-2005 *********

//Modified Method
//G_Insp_SaveInspection
//  `Added code to log date of when Consultant mark inspection as ready.

//Modified Method
//INIT_UI_GV
//  `Added declaration for variable ◊InspFormRevDate_2

//Created method
//f_Insp_Revision2 
//G_Insp_ApplyRev2_PR 
//G_InspConsCompany 
//  `Created to print the Consultant QC Engineer Box in inspection forms.

//Modified Forms and Form Methods:
//[Inspections];"Closed Insp Pg1"
//[Inspections];"Culvert Pr Pg 1"
//[Inspections];"Damage Pg1"
//[Inspections];"FC Pr (Pg 1)"
//[Inspections];"Routine Arch Pr Pg 1"
//[Inspections];"Routine Pr Pg 1"
//  `Added Line, Label and Text Variable to show Consultant Company; Added code in
//  `Form method use method G_Insp_ApplyRev2_PR.

//Modified Form and Method
//[ServerProcesses];"Input"
//  `Added Time variables and adjusted form and object methods to get a complete
//  `TimeStamp for Last and Next TimeStamps

//Modified Form
//[Dialogs];"ApproveInsp"
//  `Added horizontal splitter, Adjusted properties of objects to allow resizing o
//  `comments areas.

//10-Mar-2005 *********

//Created Methods
//G_SIA_GetRecPostings 
//G_SIA_BuildTownLine 
//  `To Condense code, and use QUERY instead of RELATE MANY

//Modified Form Methods:
//[Bridge MHD NBIS];"SI & A (Insp)"
//[Bridge MHD NBIS];"SI & A (Normal)"
//[Bridge MHD NBIS];"SI & A Input"
//[Bridge MHD NBIS];"MHD Specific Items"
//[Bridge Design];"Design Print Form"
//[Cons Inspection];"Inspection Print Form"
//[Conslt Rating];"Rating Print Form"
//[Inspections];"DivePg1 Blank"
//  `Use methods G_SIA_BuildTownLine and G_SIA_GetRecPostings.