//%attributes = {"invisible":true}
// ----------------------------------------------------
// Mods_2009_12
// User name (OS): charlesmiller
// Date and time: 12/03/09, 10:24:21
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2009_12  // r001 CJ Miller`12/03/09, 10:24:24     
End if 

//Fix output of consultant name
//PRJ_LoadDesignContractForOutput
//End Mods_2009_12

// Modified Method(s) : 
//G_SecureInspection
//  `Changed checking for Designer to checking for "Design Access Group"

// **********  ` Modified by: costasmanousakis-(Designer)-(12/4/09 12:06:02)
// Modified Forms : 
//[Status Report];"O_StatusReport"
//  ` Added the quick report button

// **********  ` Modified by: costasmanousakis-(Designer)-(12/8/09 10:33:22)
// Modified Method(s) : 
//SIA_SecureInputForm
//  `Added Bridge insp Engineer and Area Engineers to edit UW inspection info

// Modified Method(s) : 
//WRUTIL_Function
//  `Enhanced the CLEANCHARS functions to handle special characters for Win and Mac platforms
//INSP_4DWRITE_SaveToFld
//  `Enabled new method of cleaning characters - to execute the CLEANCHARS part of WRUTIL_Function

// **********  ` Modified by: costasmanousakis-(Designer)-(12/9/09 16:33:49)
// Modified Table(s) : 
//[BMS Inspections]
//  `Added fields [BMS Inspections]INSP_HI [BMS Inspections]INSP_TotV [BMS Inspections]INSP_CurrV
//[ScourPOA]
//  `Added Field [ScourPOA]Consultant

// Modified Method(s) : 
//SCPOA_MonitorChecks
//  `Adjustemnt in logic
// Created Method(s) : 
//SCPOA_FieldNoteCtrl 
//SCPOA_FieldNotes_OM
//SCPOA_TextVar_OM 
//SCPOA_DELDOCERROR

// **********  ` Modified by: costasmanousakis-(Designer)-(12/10/09 08:25:27)
// Created Method(s) : 
//INSP_PRINTPontis
// Modified Method(s) : 
//PRINT_ROUTINE_F
//PRINT_CULVERT_F
//  `Use method INSP_PRINTPontis

// Created Method(s) : 
//SCPOA_PrintPG1_FM 
//SCPOA_PrintPG2_FM 
//SCPOA_PrintPG4_FM 
//SCPOA_PrintPG3_FM 

// Modified Forms : 
//[ScourPOA];"Print"
//[ScourPOA];"Print2"
//[ScourPOA];"Print3"
//[ScourPOA];"Print4"
//[ScourPOA];"PrintTemplate"
//[ScourPOA];"SummaryPrint"
//[ScourPOA];"PrintMap"
//  `Changes/Additions for new version of POA

// Created Form(s) : 
//[ScourPOA];"PrintSelection"
//  `Changes/Additions for new version of POA

// Modified Method(s) : 
//SCPOA_POABtnCtrl
//  `Changes/Additions for new version of POA
//SCPOA_CopyInvPhotos
// r001 CJ Miller`12/10/09, 17:02:51     ``Fix bug when displaying consultant name
//PRJ_LoadDesignContractData
//PRJ_QR_ReturnConsultant
//PRJ_LoadDesignContractForOutput

// **********  ` Modified by: CharlesMiller-(Designer)-(12/10/09
//Integrate new status report 
//SR_ControlQuarterlyPrint `----- add this code to button on output form. It will conttrol and print all records in selection 
//SRQ_SetUpPrint 
//SR_ProcessQuarterly 
//Compiler_SR 

// **********  ` Modified by: costasmanousakis-(Designer)-(12/11/09 09:59:14)
// Modified Object Methods : 
//[Contract_Maintenance];"Contract Maintenance In".btnDelete
//[Contract_Project_Maintenance];"Project Maintenance In".btnDelete
//  `Added  better descriptions for the prompt.

// Modified Method(s) : 
//SCPOA_InpFormMethod
//  `Changes/Additions for new version of POA
// Modified Forms : 
//[ScourPOA];"Input"
//  `Changes/Additions for new version of POA
// Modified Method(s) : 
//SCPOA_Print
//SCPOA_Variables
//SCPOA_Print_FromList
//  `Changes/Additions for new version of POA

// Modified Form Methods : 
//[Dialogs];"GetInspExtraCmts"
//  `added code to keep in front and center the buttons upon resize

// **********  ` Modified by: costasmanousakis-(Designer)-(12/14/09 11:01:09)
// Modified Method(s) : 
//WRUTIL_Function
//  `Added Char 211 for Mac cleanchar; do the same translations for Mac and Win

// **********  ` Modified by: costasmanousakis-(Designer)-(12/15/09 13:26:59)
// Modified Forms : 
//[ScourPOA];"Print2"
//[ScourPOA];"Print3"
//[ScourPOA];"Print4"
//  `Bolded some text, adjusted some text  and location of some objects
// Modified Method(s) : 
//SCPOA_Print
//  `Changed order of printing pages - first page3 then page2

// Created Method(s) : 
//SCPOA_FldMonPgmChecks
//  `Manage the chekboxes in the Flood Monitoring program
//SCPOA_PostFloodChecks 
//  `Manage the chekboxes in the Post Flood Monitoring program
//SCPOA_PageControl
//  `Do Next/prev page in the input form
// Modified Forms : 
//[ScourPOA];"Input"
//  `Added method SCPOA_FldMonPgmChecks in the object methods of the checkboxes in the Flood Monitoring program
//  `Added method SCPOA_PostFloodChecks in the object methods of the checkboxes in the Post Flood Monitoring program
//  `Added Next / Previous page buttons using SCPOA_PageControl; adjusted the arrangement and size of the buttons

// Modified Method(s) : 
//ut_FitPrintFormObject
//  `Added a 3 pt margin to allow for lowercase g's p's etc.
//WRUTIL_Function
//  `Added function  "ZOOM"
//  `Changed the CleanChars  to loop thru the text backwards. Then we don't need a repeat loop
//  `Removed the condition to check for platform.

// Modified Forms : 
//[ScourPOA];"Print2"
//[ScourPOA];"Print3"
//[ScourPOA];"Print4"
//  `Adjusted size of some of the text variables.

// Modified Method(s) : 
//SCPOA_InputHelpSetup
//  `Added the help for the Accept button
//SCPOA_Print
//  `set the preview boolean to a proccess var.
// Modified Form Methods : 
//[ScourPOA];"PrintSelection"
//  `Change buttons and text depending on print/preview

// Modified Method(s) : 
//ut_ImportFromOldScour
//  `Added Loging changes to activity log
//SCPOA_POABtnCtrl
//  `Allow creation of POAs only on Client connected to the MHD BMS server; also do
//  `a check for Item113 and FHWARecord

// **********  ` Modified by: costasmanousakis-(Designer)-(12/17/09 13:24:38)
// Modified Method(s) : 
//SCPOA_POABtnCtrl
//SCPOA_ScourInpButton_OM
//  `Use the system parameter SC_Item113Filter to come up with the item 113 filter

// **********  ` Modified by: costasmanousakis-(Designer)-(12/18/09 15:48:06)
// Created Method(s) : 
//SIA_Item113_OM
// ` Object method for the Item113 field in the SIA Input form
// Modified Form Methods : 
//[Dialogs];"MyConfirm"
//  `Adjusted the code so that the 'cancel' button moves if the OK is resized
// Created Method(s) : 
//SIA_HelpTipCtrl
//Cotnrol the help tips for the SIA input form
// Modified Forms : 
//[Bridge MHD NBIS];"SI & A Input" 
//  `Added help tip on the navigation, page and accept, cancel  buttons and control with the method SIA_HelpTipCtrl 

// Modified Method(s) : 
//SCPOA_Variables
//  `List of consultants down to 2

// **********  ` Modified by: costasmanousakis-(Designer)-(12/21/09 16:01:05)
// Modified Object Methods : 
//[Contract_Assignment_Maintenance];"Assignment Maintenance In".ProjectIS
//  `Changed the comparison to match the new description of the ABP attributes

// Modified Method(s) : 
//ut_updateCMAssgnABP 
//  `Changed the comparison to match the new description of the ABP attributes

// **********  ` Modified by: costasmanousakis-(Designer)-(12/23/09 13:41:28)
// Created Method(s) : 
//SR_PrintSelection
//  `Print from the output list of the Status report table

// Modified Object Methods : 
//[Status Report];"O_StatusReport".bzPrint
//  `use SR_PrintSelection

//[Personnel];"Inspectors Out".bzAdd
//  `Made this button visible only on 4D Client from the MHD BMS database
//   `Unless the user has  Designer privileges

// Modified Method(s) : 
//InitFOSDFields
//  `Log the changes if any only for 4D client or 4D server running on the Boston DB "MHD BMS.4DB"

// **********  ` Modified by: costasmanousakis-(Designer)-(12/29/09 10:39:29)
// Modified Method(s) : 
//Server_GenCondRep
//  `Added code to initialize ptr_Changes and InitPrefs
//RecalcAASHTO
//  `Log the changes if any only for 4D client or 4D server running on the Boston DB "MHD BMS.4DB"


// r004 CJ Miller`12/29/09, 12:41:15    `Add [Bridge MHD NBIS]LegacyOwner to SD Data

//NEW FIELD
//[SD_History]SD_PreviousOwner_s
//ut_UpgradeSDPreviousOwner
//SD_CreateMonthlyData
//Compiler_SD 
//SD_NewDetailReport
//SD_QueryForDetailReport
//[SD_History];"DetailData.rpt"
//  ` Object Method: SD_Owner_s
//SD_ReportByOwner

//[SD_History];"QryForm"
//  ` Form Method: QryForm
//SD_CreateHistoryRecord 
//SD_CreateMonthlyRecords 

// **********  ` Modified by: costasmanousakis-(Designer)-(12/30/09 08:59:26)
// Created Method(s) : 
//MinDate
// ` Get the minimum of a set of dates - ignore null dates

// Modified Method(s) : 
//SD_CreateMonthlyData
//  `Save the  YYYY_MM.txt file to and "Exports" folder next to the structure file

// Modified Forms : 
//[Dialogs];"InspDialog1"
//  `Added checkbox on form for bridges needing inspection
// Modified Method(s) : 
//M_inspSchedule
//  ` Include NonNfCombineUWInspBI bridges needing inspections - added var o8=UW routine, o9=UWSpec -
//  ` use new method fCombineUWInsp ;
//  ` Added var SIA_INSPECTIONMONTH_d to be used in a quick report when using QR_NextInspDate
//fCombineUWInsp
//  `Determine if a bridge is due for inspection for UW Routine, UW Special
// Modified Method(s) : 
//fUpforInsp
//  `Added Options $t
//  ` 8 = Regular UW inspection
//  ` 9 = UW Special Member inspection
// Modified Method(s) : 
//fOutofFreq
//  `Added Special case for UW Inspections to use the new mods in fUpforInsp
// Modified Forms : 
//[Bridge MHD NBIS];"Other Info"
//  `Added checkbox field [Bridge MHD NBIS]InspRequired

// Created Method(s) : 
//QR_NextInspDate
//  ` Get the next inspection date - can ask for any, above, uw types, and a start date. 
//  ` Also uses var SIA_INSPECTIONMONTH_d if defined

// Modified Method(s) : 
//SCPOA_Footing_OM
//  `When choosing OTHER, clear the foundation type field instead of highlighting it

// **********  ` Modified by: costasmanousakis-(Designer)-(12/31/09 10:41:39)
// Modified Method(s) : 
//M_DeficientElementRpt
//M_PontisElementRpt
//M_ContractRpt_Invoice
//M_ContractRpt_Cost
//M_ContractRpt_Assignment
//  `Changed header to Massschusetts DOT...

// **********  ` Modified by: costasmanousakis-(Designer)-(1/4/10 12:14:02)
// Created Method(s) : 
//ut_EditVariableList
//  ` Allow editing of process variables. They are passed in a form of a text string defined as :
//  ` {Varname1 ; Vartype1}  { Varname2 ; Vartype2} ...  {VarnameN ; VartypeN }
//  ` The type can be one of 
//  `  ` text , string , int , long, real, date
// Created Form(s) : 
//[zDialogs];"EditListBox"
//  `Used in method ut_EditVariableList

// Modified Method(s) : 
//INV_InvInspRWAccess
//  `Remove restriction on External Inspectors
