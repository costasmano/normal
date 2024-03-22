//%attributes = {"invisible":true}
//Mods_2011_03

// **********  ` Modified by: costasmanousakis-(Designer)-(3/1/11 09:29:39)
//****** INTERNAL ******
// Modified Method(s) : 
//ut_SRVMonthlyReports
//  `use ut_ControlSendMail ("INIT") to initialize mail variables; 
//  `Added optional 1st param to just run a check - pass any nonblank string to run the test
//  `Test is basically everything as normal except the To and CC  values from the db.
//Server_GenCondRep
//  `Added temporarily at the end call to ut_SRVMonthlyReports ("TEST") for execute on server
//****** END INTERNAL ******

//****** MINOR ENHANCEMENT ******
// Modified Method(s) : 
//P_AllBridges 
//P_DISTRICT1 
//P_DISTRICT2 
//P_DISTRICT3 
//P_DISTRICT4 
//P_DISTRICT5 
//P_LoadSelection 
//P_MBTA 
//P_MDC 
//P_MTA 
//P_OtherAgc 
//P_MHD 
//M_DISTRICT6 
//`Change width of form from 620 to 830
//****** END MINOR ENHANCEMENT ******

// **********  ` Modified by: costasmanousakis-(Designer)-(3/2/11 10:19:42)
//M_GenerateCondRep 
//  `Added prompt for designer to pick type of report to be generated

// **********  ` Modified by: CJ Miller-(Designer)-(3/3/11 10:23:55)
// Created Method(s) : 
//ut_CompareUsersToPersonnel
//  ` Create a report comparing info from the Personnel table and
//  ` the 4D Users  

// **********  ` Modified by: costasmanousakis-(Designer)-(3/4/11 16:25:14)
// Modified Method(s) : 
//ut_DateToExcel
//  `If a date is Zero  return a blank string

// **********  ` Modified by: costasmanousakis-(Designer)-(3/7/11 08:42:42)
// Created Method(s) : 
//ut_HFS_to_POSIX
//  ` Convert a Mac HFS path to a POSIX path
//ut_OpenDocument
//  ` Open a document on disk. Requires variables ◊MacPL_b and ◊WindowsPL_b defined in
//  ` Startup_PL; A replacement for the AP Shellexecute command.

// Modified Method(s) : 
//ExportNBI
//M_SetItem75
//ut_CheckCombines 
//G_WRT_MakeDocument
//ut_CheckForPontisErrors
//G_GetServerDoc_Client
//SC_CalcScourCategories
//SCPOA_FieldNoteCtrl
//DCM_CreateWorkOrder
//DCM_PrintWorkOrder
//DCM_PrintContractReport
//DCM_PrintProject
//  `Use  ut_OpenDocument instead of AP ShellExecute

// Created Method(s) : 
//STATREP_DefaultPrintForm 
//  ` Determine the appropriate print form to be used for a bridge status report

// Modified Method(s) : 
//prt_substdrep
//SR_PrintSelection
//  `use method STATREP_DefaultPrintForm

// **********  ` Modified by: costasmanousakis-(Designer)-(3/11/11 16:38:33)
// Created Method(s) : 
//ut_MakeDocErrorHandler
//  ` Catch make doc errors

// Modified Method(s) : 
//ut_CreateMSOfficeDoc
//  `Modified logic in the Mac OS enviroment; added ON ERR CALL("ut_MakeDocErrorHandler")
//G_WRT_MakeDocument
//  `use ut_CreateMSOfficeDoc to create the word document

// **********  ` Modified by: costasmanousakis-(Designer)-(3/14/11 16:46:02)
// Modified Method(s) : 
//ut_OpenDocument
//  `Added _4D_OPTION_HIDE_CONSOLE";"true"
//G_WRT_MakeDocument`
//  `had to adjust the case when Win platform. 4D Write still creates a file with .RTF extension

// **********  ` Modified by: CJ Miller-(Designer)-(3/15/11 )
// Created Method(s) : 
//ut_prtSubrepError
//  `Error handler to identify why report does not get created
//ut_SRVMonthlyReports
//  `Add code to report errors if anny occurred
//  `Repeat loops trying to print a report each time testing if report has been generated.

// **********  ` Modified by: costasmanousakis-(Designer)-(3/18/11 09:43:43)

// Modified Method(s) : 
//Compiler_SR 
//  `Added compiler directives for Montly bridge status reports
//G_InitCondRepVars
//  `Added at the end code that generates comipler directives for all variables
//  `Call Compiler_SR 

// **********  ` Modified by: costasmanousakis-(Designer)-(3/23/11 08:26:11)
//****** MINOR ENHANCEMENT ******
// Created Method(s) : 
//QR_Item75a
//  ` Provide translation for Item 75A
//****** END MINOR ENHANCEMENT ******

//****** MINOR BUG FIX ******
// Modified Method(s) : 
//ut_CompareStoredBlobData
//  `Bug Fix in declaration of TEMP_A_CatDesc_as, TEMP_A_CatCode_as
//****** END MINOR BUG FIX ******
