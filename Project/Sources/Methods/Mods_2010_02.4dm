//%attributes = {"invisible":true}
// **********  ` Modified by: costasmanousakis-(Designer)-(2/1/10 12:33:28)
// Created Method(s) : 
// Method: HI_CalcInspectionHI
//  ` Calculate the HI for a given inpsection
// Method: INSP_HICalcControl
//  ` Control Flow of HI Calculations in a Pontis Inspection
// Method: INSP_PontisCTRL
//  ` Called from form methods using Pontis inspections
// Method: TEMP_RecalcBMSInspHI
//  ` Temp utility to calculate the HI Values for past inspections if they have
//  ` not been calculate.  Only Designer can execute this method
// Method: INSP_CalcHI_BTN_OM
//  ` Method for the CalcHI Button Object method.
// Method: INSP_AddCU
//  ` Object Method to Add CU button

// Modified Method(s) : 
//INSP_PRINTPontis
//  `Added check to run only if there are cond units

// Modified Object Methods : 
//[Inspections];"Routine Combined".bAddCU
//[Inspections];"Culvert Combined".bAddCU
//  `Use method INSP_AddCU

// Modified Method(s) : 
//WRUTIL_Function
//  `For the "ZOOM" option  added cases for the On load event to initialize the zoom dropdown
//  `and the remember the last zoom used for this dropdown

// Modified Forms : 
//[ElementsSafety];"SafetyElementInputEx"
//[ElementsSafety];"Safety ElmInput"
//[ElementsSafety];"Safety Elm Inp Dive"
//[ElementsSafety];"Safety Elm Inp DiveS"
//  `Added a Zoom Button and adjusted resizing properties to allow 4D Write area to increase

//[Inspections];"AboveWater Template"
//[Inspections];"Dive Template"
//  `Allowed buttons and any Tabs on page 0 to move or grow on resize

//[Inspections];"Closed Bridge"
//[Inspections];"Critical Member"
//[Inspections];"Culvert Combined"
//[Inspections];"Damage Form"
//[Inspections];"Routine Combined"
//[Inspections];"Dive Form"
//[Inspections];"Dive LowCl"
//[Inspections];"Underwater Special Member"
//  `Added  zoom buttons on the comments page; Adjusted Resize properties to allow
//  `increasing the size of the 4D Write areas and the buttons to move with the resize on
//  `the comments page and the last remarks page

// Modified Method(s) : 
//INSP_Comments_OM
//  `Added commands to suppress the update mode of the area on the On Load event.

// **********  ` Modified by: costasmanousakis-(Designer)-(2/2/10 08:22:41)
// Modified Forms : 
//[Cond Units];"Cond Units Prt 2"
//[Cond Units];"Cond Units Prt"
//[Cond Units];"Cond Units Out"
//  `Changed Print Settings to match the other Inspection print Forms

// Modified Method(s) : 
//PERS_GetMyInfo
//  `Added ◊PERS_MyCompany_txt
//SCPOA_POABtnCtrl
//  `add a check if the user is externaldesigner/inspector then check if the poa is assigned 
//  `to his company and then allow edit


// Modified Object Methods : 
//[ScourPOA];"Input".SCPOA_Consultant_atxt
//  `Added PushChange

// **********  ` Modified by: costasmanousakis-(Designer)-(2/3/10 09:50:12)
// Created Method(s) : 
//M_GetRailRoadOnly
//  ` Get the RailRoad Bridges.

// Added Menu Item
// BridgeListMenu/Records/Carrying RailRoad Only = M_GetRailRoadOnly

// Modified Form Methods : 
//[Bridge MHD NBIS];"Rpt Mstr"
//[Bridge MHD NBIS];"Rpt Mstr Hdr0"
//  `change font size of header text to 6 for windows

// **********  ` Modified by: costasmanousakis-(Designer)-(2/5/10 16:31:06)
// Modified Method(s) : 
//P_MTA 
//  `Allow switching of inspection responsibility to districts, and letting MTA users get to the bridges.

// Modified Method(s) : 
//INSP_PRINTPontis
//  `Store and then re-set the current printer at the end of printing

// **********  ` Modified by: costasmanousakis-(Designer)-(2/10/10 12:05:16)
// Modified Form Methods : 
//[InventoryPhotoInsp];"Input"
//  `Pass the user's company name to InitPers to populate the team leader and member arrays

//r001 CJ Miller`02/11/10, 
//Add new server processing of monthly reports
//ut_SRVMonthlyReports 
//SR_ProcessQuarterly 
//Add methods to control sending of email
//ut_ControlSendMail 
//SMTPAddHeaders 
//SMTPAttachments 

// **********  ` Modified by: costasmanousakis-(Designer)-(2/12/10 13:48:37)
// Modified Method(s) : 
//G_Insp_ApproveReject
//  `Adjustments to allow reviews of multiple Insp resp bridges.
//  `And on DBIE Reject/Approve dont prompt to send email if Cancel was pressed on the dialog 
//P_ReviewInspcts
//  `Added temporary special case for Mark Griffin

// Modified Method(s) : 
//ControlMenuBar
//  `Change code to allow users assigned to multiple districts access to them

// **********  ` Modified by: costasmanousakis-(Designer)-(2/16/10 08:37:08)
// Modified Method(s) : 
//SCPOA_FieldNoteCtrl
//  `FIX return variable declaration ; 
//  `added new tasks "ADDFIELDNOTE" |"VIEWFIELDNOTE" |"DELFIELDNOTE"
// Modified Object Methods : 
//[ScourPOA];"Input".scpoa_AddFldNote
//[ScourPOA];"Input".scpoaViewFldNote
//[ScourPOA];"Input".scpoa_DelFldNote
//  `Use new task in SCPOA_FieldNoteCtrl

// Modified Method(s) : 
//fGetFormEvent
//  `added some new form events

// Created Method(s) : 
//SIA_BridgeInput_FM
//  ` Method for the [Bridge MHD NBIS];"Bridge Input" form
// Modified Method(s) : 
//SIA_MountModule
//  `use new method SIA_BridgeInput_FM
// Modified Form Methods : 
//[Bridge MHD NBIS];"Bridge Input"
//  `use new method SIA_BridgeInput_FM

// Modified Method(s) :
//INSP_ElmtSfty_ItemNo
//  `Fix display of item 58

// Created Method(s) : 
//fn_ConvertPic2JPEG
//  ` Utility to convert a picture to JPEG and scale it to a size

// **********  ` Modified by: costasmanousakis-(Designer)-(2/17/10 16:16:16)
// Modified Form Methods : 
//[Work_Estimate];"List"
//  `Fix so that the list keeps track of the work hour that was edited.
// Modified Method(s) : 
//ut_WarmUpDatabase
//  `Change the table to one with a lot of records - [Activity Log]

// **********  ` Modified by: costasmanousakis-(Designer)-(2/19/10 13:18:38)
// Modified Method(s) : 
//InitPrefs
//  `If district inspection engineers connect to the boston server
//  `set to no transfer ◊Transfer:=0 until the district inspection resp is cleared up

// Modified Method(s) : 
//ut_RetrieveTOWNDATADoc 
//  `Added a global array ◊D6Towns_atxt for D6 towns - temporary until final setup is complete

// **********  ` Modified by: costasmanousakis-(Designer)-(2/22/10 12:36:34)
// Created Method(s) : 
//M_DISTRICT6
//  ` Added to display the future District 6 bridges

// Modified Method(s) : 
//CM_Print_NTP_Letter
//Modified by: Kenny Yang-(Designer) `02/23/10, 11:20:29  added field survey variables need to define
//it in a table

// **********  ` Modified by: costasmanousakis-(Designer)-(2/24/10 15:47:45)
// Modified Method(s) : 
//SIA_Feature_OM
//  `Fixed a bug where for a new record the route variable was not getting unlocked for I,US,ST features
//  `on the first go around.

// Modified Method(s) : 
//INSP_PreviewBtn_OM
//  `Modifications for PONTIS in spec member inspections

// **********  ` Modified by: costasmanousakis-(Designer)-(2/25/10 11:44:26)
// Modified Method(s) : 
//ut_PRJRetrieveModifiedProjects
//  `Get the full first name of the expeditor instead of just first initial

//HI_CalcElmtHI
//  `Fixed a coding issue with parameter $8 - which is not being used anyway

// Created Method(s) : 
//ut_custom4Dview
//  ` do a custom 4D View document for a table as a quick report replacement

// Modified Table(s) : 
//[PRJ_ConstructionProject]
//  ` Added Field [PRJ_ConstructionProject]CP_FederalAidNo_s

// Modified Method(s) : 
//ut_GoogleBIN 
//  `Added code to show facility on/under

//PRINT_Critical 
//  `Added INSP_PRINTPontis call

// Modified Form Methods : 
//[Cond Units];"Cond units In"
//  `keep track of INSP_CurrCUID_L variable as record is loaded

// Modified Form  : 
//[Inspections];"Culvert Combined"
//[Inspections];"Routine Combined"
//  `Added button to calc inspection HI and display the field HI
// Modified Forms method : 
//[Inspections];"Culvert Combined"
//[Inspections];"Routine Combined"
//  `Call method INSP_PontisCTRL ("INIT") INSP_PontisCTRL ("CLOSEDETAIL")  on load and on close detail

// **********  ` Modified by: costasmanousakis-(Designer)-(2/26/10 12:15:40)
// Modified Form and Form Methods : 
//[Inspections];"Critical Member"
//  `Add Pontis tab for CMI inspections in the form and in code

//Duplicate_Inspection
//  `Mods for Bridge Inspection  HI
//G_CopyPontisToCombined
//  `Changes for new HI fields in BMS inspections.

//M_GenerateCondRep
//  `Display the Bridge STatus report that was just generated.