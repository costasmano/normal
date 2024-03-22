//%attributes = {"invisible":true}
// **********  ` Modified by: costasmanousakis-(Designer)-(4/1/10 16:33:04) ---  571a
// Modified Method(s) : 
//SCPOA_POABtnCtrl
//  `Load and the unload scpoa record to find the consultant assigned to it.
//  `Dont use the Query Destination option. Caused SCPOA button not to be enables in some cases.
//P_ReviewInspcts
//  `Exclude  Freeze Thaw inspections that have been approved by DBIE

//END OF  ---  RELEASE v5.7.1.a

// **********  ` Modified by: costasmanousakis-(Administrator)-(4/5/10 12:39:47)
// Modified Method(s) : 
//SIA_BridgeInput_FM
//  `Added Variable $currUser_txt; Also allow users in BMS Admin to override the MDC restrictions 

// **********  ` Modified by: costasmanousakis-(Designer)-(4/7/10 10:58:51)
// Modified Method(s) : 
//ut_GoogleBIN
//  `Fix some errors of displaying the fac on /under

// **********  ` Modified by: costasmanousakis-(Designer)-(4/8/10 16:21:40)
// Modified Form Methods : 
//[Dialogs];"InspectConfig"
//  `Converted the filter for District inspectors to MHDInspectors group.

// **********  ` Modified by: costasmanousakis-(Designer)-(4/9/10 08:35:40)
// Created Method(s) : 
//ut_SearchTableField
//  ` Search any table by any field in a quick succession without the use of the
//  ` query editor. Can work from a text file; Working from clipboard is pending.

// Modified Method(s) : 
//P_ReviewInspcts
//  `Adjusted selection so that old MTA reviewers can review legacy MTA inspections

// **********  ` Modified by: costasmanousakis-(Designer)-(4/12/10 11:03:13)
// Modified Method(s) : 
//ut_SelectFieldNum
//  `Changed PickFIELDName_as to a text array.
//  `Added Field type and length in the field description.
//G_PickFromList
//  `made window type to regular window

// **********  ` Modified by: costasmanousakis-(Designer)-(4/13/10 10:04:37)
// Created Method(s) : 
//QR_AverageBridgeCondition
//  ` Returns the average of Items 58 59 60 62 for the current
//  ` Bridge mhd nbis record or of a list of BINs passed as parameter 1
//fn_BridgeConditionAvg
//  ` Get the average of a series of NBI coding Items 
//PRJ_QRNoBINs
//  ` Return Number of BINs according to criteria. Crtiteria can be SD, RANGE, NOTSDRANGE
//PRJ_QR_NumBridgesSamePFILE
//  ` Return the number of Bridges (BDEPTS) with the same Proj File No

// Modified Form Methods : 
//[Inspections];"FrzThawPg1"
//  `Added calls to INSP_KiloPtValues INSP_Item21Desc INSP_Item22Desc INSP_Item107Desc INSP_Item43Desc

// **********  ` Modified by: costasmanousakis-(Designer)-(4/20/10 10:55:43)
// Created Method(s) : 
//INSP_Approved_b
//  ` Return True|False whether the current inspection has been approved.
//  `Generally if InspReviewed = BMS Approved
//  `if the inspection type is FRZ - freeze thaw allow with only dbie approval
//  `Can also take optional parameters

// Modified Object Methods : 
//[Bridge MHD NBIS];"CombinedInspections".bDuplicate
//  `Use new method INSP_Approved_b to also account for Freezethaw inspections

// Modified Method(s) : 
//PRJ_UpdateLastAction
//  `Added actions for [PRJ_SketchPlans]SKT_ReceivedFromHydro_d & [PRJ_SketchPlans]SKT_ReceivedFromGeotech_d

// **********  ` Modified by: costasmanousakis-(Designer)-(4/22/10 08:44:30)
// Created Method(s) : 
//STATREP_ReportType 
//  ` Return the report type of the current Status report - legacy or mass dot, user or not

// Modified Forms and form method: 
//[Status Report];"I_StatusReport"
//  `added the MHD logo to indicate whether it is a legacy report or not
//  `uses the STATREP_ReportType for that

// Modified Object Methods : 
//[Status Report];"O_StatusReport".SRCreatedBy_txt
//  `use method STATREP_ReportType

// Modified Method(s) : 
//prt_substdrep
//  `use STATREP_ReportType to determine which is the default form to print when not Designer.

// //////Changes below implemented in release 5.7.1.b 26-Apr-2010 - only for
// //////BMS EXTERNAL SERVER
// **********  ` Modified by: costasmanousakis-(Designer)-(4/26/10 09:30:53)
// Modified Method(s) : 
//SCPOA_Variables
//  `Enable Scour log changes
//  `Added missing var SCPOA_PostFlood_L in store and load
//SCPOA_PhotoListBox_OM
//  `added needed code in the on load event
//  `on the double cilcked event, call the SCPOA_Variables ("PHOTOS") method to re   `load listbox arrays, 
//  `also sort by sequence number after exiting the input form
//  `on the row moved, renumber the sequence numbers
//  `Make sure the sequence array is kept in sync with the listbox order after any   `editing
//  `Also after deleting, and clearing the listbox arrays recreate the selection.
//SCPOA_ImageInput_FM
//  `set the sequence when new photo

// Modified Forms : 
//[ScourPOA];"Input"
//Gave unitque var names to all control buttons on the form on page 0

// Modified Object Methods : 
//[ScourPOA];"Input".SectionSCPOASelect_atxt
//  `Dont call   `SCPOA_PhotoListBox_OM (On Load ) when going to the photos page.

// //////END OF Changes  implemented in release 5.7.1.b 26-Apr-2010 - only for
// //////BMS EXTERNAL SERVER

// //////Changes below implemented in release 5.7.1.c 28-Apr-2010 - only for
// //////MHD BRIDGES
// **********  ` Modified by: costasmanousakis-(Designer)-(4/28/10 11:45:16)
// Modified Method(s) : 
//G_SecureInspection
//  `use var ◊CurrentUser_PID to check if current user is in the Team Leader/Member DBIE list
// //////END OF Changes implemented in release 5.7.1.c 28-Apr-2010 - only for
// //////MHD BRIDGES

// **********  ` Modified by: costasmanousakis-(Designer)-(4/30/10 11:45:33)
// Created Method(s) : 
//SETUTIL_Control
//  ` Do SET commands using record IDs instead of 4D Sets. Use for tables where there are additions/
//  ` deletions and 4D record sets become invalid between sessions
