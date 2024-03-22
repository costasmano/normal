//%attributes = {"invisible":true}
//****** INTERNAL ******
// **********  ` Modified by: costasmanousakis-(Designer)-(2/7/11 08:40:48)
// Modified Method(s) : 
//SIA_UpdSelList
//  `was given new name from original TEMP_UpdSelList
//  `Presize the $aItem8;$aAASHTO... arrays to Records in selection([Bridge MHD NBIS]); use one Sele to Array command

//SIA_HelpTipCtrl
//  `Added definition of SIA_SelectListInfo_txt

// Modified Forms : 
//[Bridge MHD NBIS];"SI & A Input"
//  `Added Help Item SelectListInfo which uses variable SIA_SelectListInfo_txt; Assigned help to the SelectList checkbox on page 0

// **********  ` Modified by: costasmanousakis-(Designer)-(2/8/11 08:40:48)
// Modified Method(s) : 
//INIT_TOWN_DATA
//  `Presized arrays for [Town Data] fields; combined the separate Sele to array statements to two

//****** END OF INTERNAL ******

// **********  ` Modified by: costasmanousakis-(Designer)-(2/11/11 09:53:26)
//****** MINOR FIX ******

// Modified Method(s) : 
//DISPL_CUs 
//  `  `Do not search for [Cond Units] if [BMS Inspections]Inspection ID less than 1
//INSP_AddCU
//  `Do not Add a CU if [BMS Inspections]Inspection ID less than 1
//****** END MINOR FIX ******

//****** MINOR ENHANCEMENT ******
// Created Method(s) : 
//ut_ImportDBFToArchive
//  ` Import exported DBF files from Bridge Mhd NBIS table to the [BridgeMHDNBISArchive] table. 
//  `Import is designed to use form [BridgeMHDNBISArchive];"DBFImport" as a template
//  `for import. Contains code to set the Archive date and Archive reason fields.
//  `Will load first the .dbf files, then load text files to update some of the fields that are not
//  `included in the dbf export. IF a matching series of records in the [BridgeMHDNBISArchive]
//  `is not found, records will be created.
// ut_GenCondRepFromArchive
//  ` Generate a condition report from records in [BridgeMHDNBISArchive]
//ARCH_CurrOwner_s 
//  ` get the current owner Item2 owner of a BIN from the [BridgeMHDNBISArchive] table
//ARCH_CurrDistr_s
//  ` get the current district Item 2 of a BIN from the [BridgeMHDNBISArchive] table
// f_CountIFTrue
//  ` Return a count of 1 if the argument passed is true. A way to count items in 
//  ` a quick report. Then to get the count, sum the result of the column
// Created Form(s) : 
//[BridgeMHDNBISArchive];"DBFImport"
//  `Form used for the import to the table of DBF Files exported
//****** MINOR ENHANCEMENT ******

// **********  ` Modified by: costasmanousakis-(Designer)-(2/15/11 16:02:43)
//****** INTERNAL ******
// Created Method(s) : 
//ut_DeleteExtrasDoc
//  ` Delete a document from the list of folders specified from the 2nd param and on
//****** END OF INTERNAL ******

//****** DISTRICT MAINTENANCE CONTRACTS  ******
//  `Added Ability to log Daily Records of use of Bid Items
//  `Initial is for hours of the various artisan categories.
// Created Method(s) : 
//DCM_DailyControl_OM 
//DCM_DailyControl_FM 
//DCM_ProjDailyControl_OM

// Created Form(s) : 
//[DCM_ProjDailys];"DistrInput"

//****** END OF DISTRICT MAINTENANCE CONTRACTS  ******

// **********  ` Modified by: costasmanousakis-(Designer)-(2/18/11 08:39:14)
//****** GENERAL ENHANCEMENT  ******
// Created Method(s) : 
//ut_OpenHistorySite
//  ` open the browser in the history maps. Used in Menu "Tools" ; MenuBar #1
//****** END OF GENERAL ENHANCEMENT  ******

//****** INTERNAL ******
// Created Method(s) : 
//ut_SetAllPasswords
//  ` Set all Passwords for all users to delphi - mainly for testing purposes
//ut_switchUser
//  ` change current user
//****** END OF INTERNAL ******

// **********  ` Modified by: costasmanousakis-(Designer)-(2/22/11 11:56:44)
//****** INTERNAL ******
// Modified Forms : 
//[Town Address];"View Town Address"
//  `Deleted S2_field object that was not pointing to a valide field. Was found in check in v11.
//****** END OF INTERNAL ******

// **********  ` Modified by: costasmanousakis-(Designer)-(2/23/11 16:48:21)
//****** SCOUR POA Fixes ******

// Modified Method(s) : 
//SCPOA_PrintPG3_FM
//  `Added ut_FitPrintFormObject for  SCPOA_FldForecast_txt and SCPOA_FldWarnSys_txt

//****** END OF SCOUR POA Fixes ******

// **********  ` Modified by: costasmanousakis-(Designer)-(2/28/11 10:08:12)
//****** INTERNAL ******
// Modified Method(s) : 
//bObsolete
//  `Use Substring instead of $Item42≤2≥
// Created Entry Filter(s) : 
//Item5Main

// Modified Forms : 
//[Bridge MHD NBIS];"SI & A Input"
//  `Applied entry filter Item5Main to Item 5

//G_Insp_FmtSTOWN
//  `Set the format of sTown to "" - fix for v11 conversion

// Modified Method(s) : 
//ut_ControlSendMail 
//  `Added optional first parameter and case statement to initialize all needed variables
