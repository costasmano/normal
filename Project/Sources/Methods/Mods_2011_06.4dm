//%attributes = {"invisible":true}
// ----------------------------------------------------
// Mods_2011_06
// User name (OS): charlesmiller
// Date and time: 06/03/11, 16:15:36
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2011_06  //r001 CJ Miller`06/03/11, 16:15:38     
End if 
//Make vDistrict alpha 2

//M_WRT_BrInspRpt 
//M_WRT_GenericBridgeLetter 
//G_WRT_BrInspRpt 
//M_WRT_DiveInsp_TRAN 
//GetDistrictAddress 
//DCM_CreateWorkOrder 
//End Mods_2011_06

// **********  ` Modified by: costasmanousakis-(Designer)-(6/6/11 14:13:41)
// Modified Forms : 
//[Bridge MHD NBIS];"NBIS Stack Info"
//  `Made adjustments to the size of the window so width is 599<=2<=830

// Modified Method(s) : 
//SIA_BridgeInput_FM
//  `After the On Load release any other records loaded during the load event

// Modified Object Methods : 
//[InventoryPhotoInsp];"ReviewDialog".bsZearch
//  `Allow inspection Engineers to look thru all Inspections
//  `Don't do the rest if user Cancels the query

// Modified Forms : 
//[Work_Estimate];"Input"
//  ` set the format of the work hour arrays to ###,##0.#;-##0.#;0 This is to facilitate when
//  `the reviewer "zeroes" an item by entering a small hour item like 0.001
//  `increased the ht of the hour and dollar variables in the Totals page

// Modified Object Methods : 
//[ScourPOA];"Input".bCancel
//  `Changed the prompt to replace the default "OK" button

// Modified Method(s) : 
//SCPOA_Variables
//  `Added / Enabled personnel group SCPOA_MultipleView to be able to see and use both the old and new version of the POA
//  `Implemented the use of OLDNEWVERSION and SETVERSION method parameter
//  `Modified the page navigation drop down SectionSCPOASelect_atxt and SCPOA_SectionPage_aL to reflect that 

// Modified Method(s) : 
//SCPOA_Print_FromList
//SCPOA_Print
//  `To select between the old/new version of POA use call to  SCPOA_Variables ("OLDNEWVERSION")

// **********  ` Modified by: costasmanousakis-(Designer)-(6/9/11 09:24:40)
// Modified Method(s) : 
//PRJ_PT_GetConsRevLists
//  `Adjusted logic to get personnel from various lists and include Design access

//PRJ_BD_BrgDSht_OM
//  `Changed ut_LoadRecord to ut_LoadRecordInteractive; fixed call to LogNewRecord, the sequence name was missing!!

//PERS_GetMyInfo
//  `Added definition of  ◊PERS_MyFullName_txt

//New Object 
//[ScourPOA];"Input".SCPOA_PMLockButton_L
//  `Unlock / :Lock the POA for the PM to enter approval or not

// Modified Object Methods : 
//[ScourPOA];"Input".SCPOA_PMReviewChkBox
//[ScourPOA];"Input".SCPOA_ApproveChkBx
//  `bug Fixes and additional input when box is checked

// Modified Method(s) : 
//SCPOA_InpFormMethod
//  `Added Handling of the Lock button for the PM
//  `Use Wildcard to check if we are at the Photo or Detour page

// **********  ` Modified by: costasmanousakis-(Designer)-(6/10/11 08:35:52)
// Modified Method(s) : 
//M_ExecArchiveLog
//  `Do not send job to server if no Archive log records have been selected!

//CalcItem91 
//  `execute a PushChange (1;->[Bridge MHD NBIS]Item91) in this method

//ut_LoadUsersAndGroups
//  `Get the document list only if the folder  "UsersAndGroups" exists

// **********  ` Modified by: costasmanousakis-(Designer)-(6/13/11 16:52:06)
// Modified Table(s) : 
//[ScourPOA]
//  `Added field [ScourPOA]NTP_Date

// Modified Object Methods : 
//[ScourPOA];"Input".SCPOA_Consultant_atxt
//  `Added prompt for NTP date

// Modified Method(s) : 
//SCPOA_Variables
//  `Added varibales  SCPOA_FVCAttach_L; SCPOA_Inst_WaterSurf_r; SCPOA_Inst_WaterSurf_L; 

// Modified Forms : 
//[ScourPOA];"Print5A"
//  `Added variables (SCPOA_Inst_WaterSurf_r SCPOA_Inst_WaterSurf_L ; Adjusted objects to fit.
//[ScourPOA];"SummaryPrint"
//  `Added varibales  SCPOA_FVCAttach_L; relabeled and reordered other attachments ; made font 10 bold to fit
//[ScourPOA];"Input"
//  `Added varibales  SCPOA_FVCAttach_L; relabeled and reordered other attachments ; made font 10 bold to fit

//CM_MailInvoiceNotice
//CM_MailInvoiceNotice_2
//  `Use method ut_GetSysParameter and global variables defined in  PERS_GetMyInfo

// **********  ` Modified by: costasmanousakis-(Designer)-(6/15/11 17:34:05)
// Modified Method(s) : 
//SCPOA_PrintPG1_FM
//  `Added fit for vars SCPOA_PierSCChordDist_txt ,SCPOA_AbutSCChordDist_txt
//  `Added code to move the abut and pier elevation and distance text closer to
//  `the labels to allow morespace for printing.

//ut_FitPrintFormObject
//  `Graduate the margin depeneding of font size

// **********  ` Modified by: costasmanousakis-(Designer)-(6/16/11 17:14:02)
// Modified Method(s) : 
//ut_OpenHistorySite
//  `In case of windows platoform use the ping command in LEP mode

// **********  ` Modified by: costasmanousakis-(Designer)-(6/20/11 10:45:10)
// Modified Form Methods : 
//[Bridge MHD NBIS];"BDEPT Input"
//[Bridge MHD NBIS];"BDEPT Input".bGetRef 
//[Bridge MHD NBIS];"BDEPT Input".aItem7 
//  `Added RR info, Agency Bridge no

// Modified Object Methods : 
//[Conslt Rating];"View Cslt Rating".CRTGShowLBBTN
//  `Removed declataion of a parameter $1 ; object methods do't accept parameters

// **********  ` Modified by: costasmanousakis-(Designer)-(6/23/11 17:43:10)
// Modified Method(s) : 
//SCPOA_PrintPG1_FM
//  `defined new var SCPOA_ApproveChkBx_2 = SCPOA_ApproveChkBx due to some
//  `strange behavior during printing. box would show shaded....

// Created Method(s) : 
//ut_CreateCheckBoxPic
//  ` Generate / Update the CheckBox pictures in the picture library
// Modified Form Methods : 
//[ScourPOA]SummaryPrint
//  `Added Fit for town text and bridge number

// Modified Method(s) : 
//SCPOA_InpFormMethod
//  `Added check to verify we have the correct [bridge mhd nbis]BIN record loaded

//```******    ***********
//```******   END OF v 5.9.1 ***********
//```******    ***********

// **********  ` Modified by: costasmanousakis-(Designer)-(6/27/11 12:35:08)
// Modified Object Methods : 
//[Templates];"Input".IMG_Template
//  `Added code to handle popup menu on the image variable

// Modified Method(s) : 
//G_WRT_MakeDocument
//  `Load LetterHead picture from the templaces "IMG_BMSLetterHead"

// Modified Forms : 
//[Inspections];"Closed Bridge"
//[Inspections];"Critical Member"
//[Inspections];"Culvert Combined"
//[Inspections];"Damage Form"
//[Inspections];"RailRoutineInput"
//[Inspections];"Routine Combined"
//  `Removed a dissplay format on all SignsInPlace fields for Posting, clearances. Address issue in v11 where theentry was not shown

// **********  ` Modified by: costasmanousakis-(Designer)-(6/29/11 09:37:04)
// Created Method(s) : 
//Temp_SomrvileToD4
//  ` Transfer Sommervi bridges to D4 Item 2 and Insp Resp -


// **********  ` Modified by: CJ Miller`06/28/11, 12:13:30   
// Created Form(s) : 
//[Dialogs];"ConfirmWithTimer"
//  `Dialog to display a message with a timer Delay.
// Created Method(s) : 
//ut_LoadUsersandGroupsFromFile
//  ` Load the User and groups file specified

// Modified Method(s) : 
//ut_LoadUsersAndGroups
//  `Change how user and groups loaded by adding a dialog with a 30 second timer event

// Created Method(s) : 
//ut_SetInspModDateForPontis
//  ` Set the [Inspections]DateModified date to today, to force the update of
//  ` CondUnits for these inspections. Then can execute ut_UpdatePontis.

// Created Method(s) : 
//ARCHIVE_GenCondReport
//  ` Copy of GenerateCondRep for the Archive table [BridgeMHDNBISArchive]
//ARCHIVE_CondRptCtrl
//  ` Control the creation of a condition report based on the [BridgeMHDNBISArchive] table

// Modified Method(s) : 
//ut_RetrieveTOWNDATADoc
//ut_Distr6Towns
//INIT_UI_GV 
//  `Removed Somerville from the D6 towns

//STATREP_DistrNo
//  `Added option 4 to move somerville back to d6 for comparison purposes

//Server_GenCondRep 
//  `Added creating a report with Somerville back to District 6 for comparison purposes after Jul-1-11
