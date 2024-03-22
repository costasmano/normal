//%attributes = {"invisible":true}
// **********  ` Modified by: costasmanousakis-(Designer)-(8/2/10 11:31:57)
// Modified Method(s) : 
//prt_substdrep
//  `Changed Parameter 1 to Longint to have more than two options of print form selection
//ut_SRVMonthlyReports
//  `Added printing of the MDOT report for 6 Districts
//  `Changed calls to prt_substdrep with first param = longinteger
//Mail_BridgeStatusRpt
//  `Changed call to prt_substdrep with 1st param=longint
//Compiler_Methods
//  `changed 1st param of prt_substdrep to longint

//SCPOA_Variables
//  `Replaced the second occurance of SCPOA_WatchUW_txt  with SCPOA_InstLoc_txt
// Modified Forms : 
//[ScourPOA];"Input"
//[ScourPOA];"Print3"
//  `Replaced the second occurance of SCPOA_WatchUW_txt  with SCPOA_InstLoc_txt
//[ScourPOA];"Print4"
//  `Adjusted some text object sizes on item 6 header for better printign on Win.

// **********  ` Modified by: costasmanousakis-(Designer)-(8/3/10 11:29:37)
// Created Method(s) : 
//ARCHIVE_Store
//  ` Copy data from source tables to the archive tables

// **********  ` Modified by: costasmanousakis-(Designer)-(8/5/10 10:56:34)
// Modified Method(s) : 
//STATREP_DistrNo
//  `changed STATREP_DistrictMethod_b to STATREP_DistrictMethod_L
//  `0 : false - previous default - uses 1st param Item2
//  `1 : true - previous uses BDEPT and D6Towns array
//Server_GenCondRep
//  `changed STATREP_DistrictMethod_b to STATREP_DistrictMethod_L
//  `0 : false - previous default - uses 1st param Item2
//  `1 : true - previous uses BDEPT and D6Towns array
//  `2 : use BDEPT and get info from the [Town Data]District field
//  `3 : use BDEPT and get info from the [Town Data]OldDistrictNo3 field. If it is blank use [Town Data]District 
//GenerateCondRep
//G_InitCondRepVars
//  `changed STATREP_DistrictMethod_b to STATREP_DistrictMethod_L
//MENU_EnableEnterItem
//  `Fixed problem with District 6 search. added "@" at front and back of the search item.

// Modified Forms : 
//[zDialogs];"FilesPalette"
//  `Added button bDist6 for district 6; rearranged the other buttons.

// Created Form(s) : 
//[Town Data];"Output"
//  `New form to replace the old one for better display

// Modified Method(s) : 
//M_DISTRICT6
//  `Chnaged window title to remove the "Future" word

// **********  ` Modified by: costasmanousakis-(Designer)-(8/6/10 11:00:43)
// Modified Method(s) : 
//ControlMenuBar
//  `Changed the access to District 6 item to be same as other distrcts

// **********  ` Modified by: costasmanousakis-(Designer)-(8/9/10 11:09:38)
// Modified Object Methods : 
//[Dialogs];"ReportTemplateSelect".RptSaveToDisk 
//  `Fixed problem where report saved was not the correct one.

// **********  ` Modified by: costasmanousakis-(Designer)-(8/10/10 14:45:22)
// Modified Method(s) : 
//INIT_TOWN_DATA
//ut_RetrieveTOWNDATADoc
//  `Added new array ◊aOldDist3
//ut_CompareStoredTOWNData
//  `Added code for new array ◊aOldDist3

// **********  ` Modified by: costasmanousakis-(Designer)-(8/11/10 10:48:45)
// Modified Method(s) : 
//MHD_GetSIA
//GetServerBIN
//  `Commented out all code - uses 4D Open commands that will be disabled- Also method not called anymore
// Created Method(s) : 
//ut_convert2Distr6
//  ` Convert info in Town Data and [Bridge MHD NBIS]Item2 from D4 to the new D6
//Server_GenCondRep
//  `Made code changes to use the new options 2,3 in STATREP_DistrNo. 
//  `The data in [Town Data] was changed to the new D6 arrangement

// **********  ` Modified by: costasmanousakis-(Designer)-(8/12/10 09:16:21)
// Modified Method(s) : 
//RtgMethod_OM
//  `Added formats for the MetricTon rating and FactorRatings in the call to G_FormatItm6466
// Modified Forms : 
//[Bridge MHD NBIS];"BDEPT Input"
//  `Fixed Move preferences of some objects.

// **********  ` Modified by: costasmanousakis-(Designer)-(8/16/10 10:55:56)
//QR_SearchInspections
//  ` Search for inspections and load the latest from the list found
//Startup
//  `Added District 6 to the launch of initial windows

// **********  ` Modified by: costasmanousakis-(Designer)-(8/17/10 13:49:02)
// Modified Form Methods : 
//[RatingReports];"RatReportsIn"
//  `ignore Operating Ratings for Masonrty Arch-Deck

// **********  ` Modified by: costasmanousakis-(Designer)-(8/19/10 10:59:29)
// Modified Object Methods : 
//[Bridge MHD NBIS];"CombinedInspections".vItem107
//  `Replaced call to INSP_Item107Desc with SIA_Item107Desc

// **********  ` Modified by: costasmanousakis-(Designer)-(8/23/10 12:07:05)
// Modified Method(s) : 
//GetDHDinfo
//GetDBIEinfo 
//  `Added District 6

// **********  ` Modified by: costasmanousakis-(Designer)-(8/25/10 09:47:26)
// Modified Method(s) : 
//QR_GetProjInfoNo
//  `Added reducing the selection of tables to 0

// **********  ` Modified by: costasmanousakis-(Designer)-(8/26/10 09:18:54)
// Modified Method(s) : 
//LSpawnProcess
//  `Added the declaration for the 6th and more parameters- up to 13 parameters
//  `or, up to 8 text parameters passed to the called method

//QR_SearchInspections
//  `Modified search for InspStage=2 to include inspections with a 1 step final approval

//G_DeleteInspection
//  `Moved the SELECTION TO ARRAY command after the DELETE RECORD commands
//  `It was removing the current record from the [Inspections] table.

// **********  ` Modified by: costasmanousakis-(Designer)-(8/27/10 11:04:08)
// Created Method(s) : 
//ut_Read_Write_Tables
//  ` Set tables to Read or Write

//Print_Dive_F
//PRINT_Critical
//PRINT_FREEZE_F
//PRINT_Closed
//  `added   `added call to font setup  G_SetInspFont 
//PRINT_Damage
//  `added   `added call to font setup  G_SetInspFont 
//  `Added call to INSP_PRN_InitVars

// Modified Form Methods : 
//[Inspections];"InspectionReview"
//  `Removed the disbaling of the Print button
// Modified Object Methods : 
//[Inspections];"InspectionReview".bzPrint
//  `Added all known inspection types
//  `Added calls to read only befroe abd read write after
//  `Changed method of looping thru records : Go thru the whole selection and check if the record is highlighted

// Modified Form Methods : 
//[Bridge MHD NBIS];"BDEPT Input"
//  `Added Item 8 Owner
// Modified Object Methods : 
//[Bridge MHD NBIS];"BDEPT Input".bGetRef
//[Bridge MHD NBIS];"BDEPT Input".aItem7
//  `Added Item 8 Owner

// Modified Method(s) : 
//G_Insp_ApproveReject
//  `Changed method of looping thru records : Go thru the whole selection and check if the record is highlighted
//  `Modified the ALerts when Inspection is not ready for review to add more info re the inspection

// **********  ` Modified by: costasmanousakis-(Designer)-(8/30/10 10:09:18)
// Created Method(s) : 
//ut_SelectionFromUserSet
//  ` Create or restore a selection from the UserSet in the same order as the current selection of a Table

// Modified Method(s) : `
//G_Insp_ApproveReject
//  `Create a selection that is in the same order as the current llist from the UserSet 
//  `- use new method ut_SelectionFromUserSet
// Modified Object Methods : 
//[Inspections];"InspectionReview".bzPrint
//  `Create a selection that is in the same order as the current llist from the UserSet 
//  `- use new method ut_SelectionFromUserSet
//  `Also make sure the BMS Inspection record and CUs are loaded if needed

// **********  ` Modified by: costasmanousakis-(Designer)-(8/31/10 15:50:05)
// Modified Method(s) : 
//ut_executeMethod
//  `Fixed a bug in the assigning of parameters Param(1...7)_txt
//ut_Delete4DXDocument
//  `Added extra case for deleting documents on server so that both Mac4DC and Win4DX
//  `documents are deleted

// Created Method(s) : 
//ut_PRJRetrieveProjTypes
//  ` This method will retrieve and update Project Type records.

// Created Table(s) : 
//[PRJ_ProjectTypes] 
//[PRJ_ProjectTypes]PRTP_TypeCode_s
//[PRJ_ProjectTypes]PRTP_Description_txt
//[PRJ_ProjectTypes]PRTP_Created_d
//[PRJ_ProjectTypes]PRTP_Modified_d
//Set manual relation between 
//[PRJ_ProjectFile]PF_TypeCode_s and [PRJ_ProjectTypes]PRTP_TypeCode_s

// Modified Method(s) : 
//ut_PRJCtrlRetrieveProjectData 
//  `Added call to retrieve project types ut_PRJRetrieveProjTypes
//SQL_FillBuiltStatements
//SQL_ClearArrays
//  `Added call to retrieve Project Type descriptions sp_RTRVProjTypes
