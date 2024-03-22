//%attributes = {"invisible":true}
// **********  ` Modified by: costasmanousakis-(Designer)-(3/3/10 07:52:05)
// Modified Method(s) : 
//M_DISTRICT6
//  `Added declaration of $1. would fail in compiled mode.
// Modified menu(s) : 
//  `Made item "Insp by fut Dist 6" disabled for all users will be enabled in the ControlMenuBar method
//ControlMenuBar
//  `for all users enable the "@ 6" menu item in the enter menu - for the District 6 menu item

// **********  ` Modified by: costasmanousakis-(Designer)-(3/4/10 10:15:45)
// Modified Method(s) : 
//ExportNBI 
//  `changed extension of output file to .txt

// ----------------------------------------------------
// ut_StructureNumberChangeReport
// ut_ResetSecondaryNBISItem8
// User name (OS): charlesmiller


// **********  ` Modified by: costasmanousakis-(Designer)-(3/5/10 14:44:04)
// Modified Form Methods : 
//[Out of Freq];"I_OutofFreq"
//  `Changed to Form event
//  `Added code to control entry /deletion buttons depending on whether user ahs read write access
//[Out of Freq];"O_OutofFreq"
//  `Added code to control entry /deletion buttons depending on whether user ahs read write access

// **********  ` Modified by: costasmanousakis-(Designer)-(3/8/10 08:42:05)
// Modified Method(s) : 
//BRG_RWAccess
//  `Adjusted security so that users in BMS Admin get RW access to the Bridge info

// **********  ` Modified by: costasmanousakis-(Designer)-(3/9/10 12:31:29)
// Modified Form Methods : 
//[Conslt Address];"Conslt Address In"
//  `Added initialization variables that are passed by the ADD button on the list form.
//[Conslt Address];"View Conslt Address".bzAddLay
//  `Added initialization variables that are passed by the ADD button on the list form.
//  `they get filled from the first record in the usetset ("highlighted")

// **********  ` Modified by: costasmanousakis-(Designer)-(3/11/10 16:42:12)
// Modified Forms : 
//[Dialogs];"MetricConverter"
//  `Added conversion for Degrees min secs
// Modified Method(s) : 
//P_MetricConv
//  `Get the form properties to determine window size


// Add code to allow for printing different sections of the SD report
//Compiler_SD
//SD_NewDetailReport
//SD_NewSummaryReport
//SD_ReportByOwner

//[SD_History];"QryForm" `Removed page 2
//  ` Form Method: QryForm

//  ` Object Method: ◊SD_PrintHistory_l - new object
//  ` Object Method: ◊SD_PrintPosted_l - new object

// **********  ` Modified by: costasmanousakis-(Designer)-(3/12/10 15:32:56)
// Modified Method(s) : 
//ut_ScanSequences
//  `Added messages on what is happening...

// **********  ` Modified by: costasmanousakis-(Designer)-(3/15/10 12:28:43)
// Modified Method(s) : 
//ut_BigAlert
//  `made window type Plain Window
// Modified Forms : 
//[Dialogs];"BigAlert"
//  `Changed font to a size 14 font
//  ` made Text area grow horizontal and button to move horiz
//  `Set min and max window witdhs

// Created Method(s) : 
//ReApplyDRC 
//ReApplyFLD 
//ReApplyGRD 
//ReApplyGRP 
//ReApplyLNK 
//ReApplyLogEntries 
//ReApplyNRC 
//Reapply_MakeNewLogEntry 
//ReApply_StoreRecRes
//  `Methods used to re-run activity log entries. Designed mainly to re-create inspection reports
//  `from [Activity log] entries. The main method is   ReApplyLogEntries. It will prompt for the 
//  `record IDs of the combined inspection, inspection and BMS inspection records.
//  `Will execute all in sequence until reaching a DRC command on one of the 'master' inspection
//  `records

// **********  ` Modified by: costasmanousakis-(Designer)-(3/23/10 08:35:32)
// Created Method(s) : 
//QR_Ceiling
//  ` Return the lowest multiple of 2nd param that is greater than or equal to the 1st Param.
//  ` Emultates the Floor Excel function.
// QR_Floor
//  ` Return the largest multiple of 2nd param that is less than or equal to the 1st Param.
//  ` Emultates the Floor Excel function.

// Modified Method(s) : 
//GetConsltAddress 
//  `corrected adding of the person's title to account for any commas in the first pos of the title

//M_WRT_IOMcover_inhouse
//  `Changed Title to show Assistant Bridge Engineer, Ratings and overloads for inhouse memos
//  `Added structure type Item 43, and no of spans for in-house memos
//  `changed vBridgeInfo1;vBridgeInfo2 to text
//  `Changed the lookup of the person to In-House Ratings from In-house Design
//  `made RO [Templates] and unload record after it is loaded
//  `in the template reduced line spacing from 1.5 to 1 on some of the lines to conserve space. made 
//  `the underlined ones to 1.25 from 1.5
//  `changed the logo to the new DOT logo
//M_WRT_IOMcover_cslt
//  `changed vBridgeInfo1;vBridgeInfo2 to text

// Created Method(s) : 
//QR_Decade
//  ` Return the Decade as a String of the year passed as parameter 1.
//  ` Optional params 2,3 min and max decades
//  ` QR_Decade(1949) = "1940"
//  ` QR_Decade(1890) = "1890"
//  ` QR_Decade(1890;1900) = "Pre-1900"
//  ` QR_Decade(2021;1900;2020) = "2020"
//  ` QR_Decade(2031;1900;2020) = "Post-2020"

// **********  ` Modified by: costasmanousakis-(Designer)-(3/31/10 17:08:33)
// Modified Method(s) : 
//M_SetItem75
//  `Added code to check for current selection of records.
//  `and verification of whether to save changes to data.
