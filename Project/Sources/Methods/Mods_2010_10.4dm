//%attributes = {"invisible":true}
// **********  ` Modified by: costasmanousakis-(Designer)-(10/6/10 12:35:40)
// Modified Form Methods : 
//[RatingReports];"RatReportsIn"
//  `Made sure to check if any of the [bridge mhd nbis] fields have been modified already before
//  `the on validate event and add them to the message display
// Modified Method(s) : 
//ut_GoogleBIN
//  `Added option for shift key down to show the lat long finder instead of the default google map

// **********  ` Modified by: costasmanousakis-(Designer)-(10/7/10 12:04:14)
// Created Method(s) : 
//SIA_PasteLatLon
//  ` Copy the Lat and or Long values from the clipboard to the respective fields on
//  ` the [Bridge MHD NBIS] table. Designed to be run from a button on the input form.

// Modified Forms : 
//[Bridge MHD NBIS];"SI & A Input"
//  `Added hidden button SIA_CopyLatLon mapped to Shift-Ctrl-V (Shift-CMD-V) to copy from the clipboard values in the
//  `lat long fields

// **********  ` Modified by: costasmanousakis-(Designer)-(10/12/10 09:08:19)
// Modified Method(s) : 
//ut_RetrieveTableArrDoc 
//  `Added the * param at the end of the SET FIELD TITLES and SET TABLE TITLES so that they appear
//  `sorted in the formula editors also
//G_SortTable_new
//  `Added the * param at the end of the SET FIELD TITLES and SET TABLE TITLES so that they appear
//  `sorted in the formula editors also. Check if table is deleted ie. starts with "(" .

// Modified Table(s) : 
//[BridgeMHDNBISArchive]
//  `added fields [BridgeMHDNBISArchive]LegacyOwner, [BridgeMHDNBISArchive]InspRequired

// **********  ` Modified by: costasmanousakis-(Designer)-(10/13/10 10:04:43)
// Created Method(s) : 
//ut_GetBackupInfo
//  ` Return backup information and statistics

//SCPOA_CompleteAction
//  ` Perform data changes when POA is marked as complete
// Modified Object Methods : 
//[ScourPOA];"Input".Completed
//  `Use method SCPOA_CompleteAction
//[ScourPOA];"Input".DateCompleted
//  `Make changes to the field [ScourPOA]Completed when the date is entered

// Modified Method(s) : 
//SCPOA_Variables
//  `Added variables SCPOA_Item91_L SCPOA_UWInspFreq_L for the summary page addition of Inspection frequency
// Modified Forms : 
//[ScourPOA];"SummaryPrint"
//  `Changes additions to display the Inspection frequency information
//[ScourPOA];"Print3"
//  `Added Letter labels (a. b. etc) to the sections of the recommended program
//[ScourPOA];"Input"
//  `Added Letter labels (a. b. etc) to the sections of the recommended program. Adjusted a few of the
//  `boxes. 

// Created Form(s) : 
//[Conslt Rating];"RatingPrintForm_2"
//  ` New Form for Rating and overload use only. Copy from [Conslt Rating];"Rating Print Form".

// **********  ` Modified by: costasmanousakis-(Designer)-(10/15/10 10:34:51)
// Created Method(s) : 
//CRTG_PrintForm_FM
//  ` Method for the Print Forms used in Consultant Ratings
// Modified Form Methods : 
//[Conslt Rating];"Rating Print Form"
//  `Use method CRTG_PrintForm_FM
// Modified Object Methods : 
//[Conslt Rating];"Rating Print Form".btnPrint
//  `Print the new form "RatingPrintForm_2" for Ratings and Overloads and set to Landscape

// **********  ` Modified by: costasmanousakis-(Designer)-(10/18/10 09:20:19)
// Created Method(s) : 
//TMPL_ApplyMargins
//  ` Copy the margins from one selected (USERSET) 4D Write template to the  others in the selection
// Modified Method(s) : 
//WRT_GetSetMargins
//  `Changed the order of the SET commands
// Modified Forms : 
//[Templates];"Output"
//  `added button TMPL_ApplyMargins_btn

// **********  ` Modified by: costasmanousakis-(Designer)-(10/19/10 14:55:44)
// Modified Method(s) : 
//P_ReviewInspcts
//  `Added check to show inspections where current user is the DBIE


// **********  ` Modified by: costasmanousakis-(Designer)-(10/20/10 08:55:44)
// Created Method(s) : 
//Server_CheckBackup
//  `Method to run the backup check method

// Modified Form Methods : 
//[Bridge MHD NBIS];"BDEPT Input"
//  `Added [Bridge MHD NBIS]LegacyOwner
// Modified Object Methods : 
//[Bridge MHD NBIS];"BDEPT Input".bGetRef
//[Bridge MHD NBIS];"BDEPT Input".aItem7
//  `Added [Bridge MHD NBIS]LegacyOwner

// **********  ` Modified by: costasmanousakis-(Designer)-(10/22/10 09:42:22)
// Modified Method(s) : 
//InitPers 
//  `Changed 'Dive Division' to 0449, and  ($distNum<9)) instead of <6
//GetUOEInfo
//  `Changed 'Dive Division' to 0449

// Modified Table(s) : 
//[Personnel]
//Added fields
//  `[Personnel]CellPhone_s
//  `[Personnel]PagerNo_s
//  `[Personnel]HomePhone_s

// **********  ` Modified by: costasmanousakis-(Designer)-(10/25/10 16:45:38)
// Modified Forms and Form Method : 
//[Dialogs];"ut_Request""
//  `Added option to go to a second page for a method using the Combo box and
//  `to allow to delete entries in the dropdown.
// Modified Method(s) : 
//ut_Request 
//  `Added optional parameter 6 to go to a second page for a method using the Combo box and
//  `to allow to delete entries in the dropdown.

// **********  ` Modified by: costasmanousakis-(Designer)-(10/26/10 08:31:58)
// Modified Method(s) : 
//ut_executeMethod
//  `Changes to remember list of commands between sessions. The list is stored as
//  ` a Blob in file UTEXEC_Command_file.txt in the active 4D folder.
//  `Also can "pass" parameters to the method when executed locally, by concatenating them 
//  `in the command executed. 

// Created Method(s) : 
//fn_MaxElement_L 
//  ` Return the index of the 'largest/max element of an array.
//  `Will show and alert if the pointer passed is not a 'comparable' array
//  `Will return 0 if the array size is 0

// Modified Method(s) : 
//DCM_WO_Input_FM
//  `Added code in the case of not a new record to catch any changes or omissions
//  `Use new method fn_MaxElement_L to get the max current assignment number.

// **********  ` Modified by: costasmanousakis-(Designer)-(10/28/10 09:46:26)
// Modified Form Methods : 
//[DCM_Contracts];"DistrMaintInput"
//  `Added a Short message to wait for the on load event
// Modified Method(s) : 
//DCM_PrintWorkOrder 
//DCM_PrintContractReport
//  `Added Short message
//DCM_AttachmentCtlr 
//  `In the INIT phase check if the LB boolean array has been defined

// Created Method(s) : 
//DCM_BridgeProjMgr_OM
//  ` Method for the Bridge Manager pulldown in cboBridgePrjMgr

// Modified Method(s) : 
//DCM_ContractNo_OM 
//  `Added calls to update the Bridge proj manager  and contract status dropdowns