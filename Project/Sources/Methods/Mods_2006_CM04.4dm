//%attributes = {"invisible":true}
// Modified by: costasmanousakis-(Designer)-(4/5/2006 10:43:02)
// Modified Object Methods : 
//[Contract Assignments];"Assignments In".btnRetrieveCost
//  `Added a REDRAW WINDOW at the end to force redraw of retrieved values.

// Modified by: costasmanousakis-(Designer)-(4/5/2006 16:57:00)
// Modified Method(s) : 
//fUpforInsp
//  `For routine insp Use Item27 for date if item90=00/00/00

// Modified by: costasmanousakis-(Designer)-(4/10/2006 09:27:48)
// Modified Forms : 
//[Bridge MHD NBIS];"SI & A Input"
//  `Renamed button bSDFO from Variablexx to bSDFO Button, to allow non-SIA Access users 
//  `ability to ask whether the structure is SD or FO.

// Modified by: costasmanousakis-(Designer)-(4/10/2006 14:10:46)
// Modified Object Methods : 
//[Inspections];"InspectionReview".bzSearchLay
//  `Allow Area engineers to search all inspections.
// Modified Forms : 
//[Inspections];"InspectionReview"
//  `Modified appearance of objects to be Automatic.

// Modified Method(s) : 
//WKHR_ClearOutCategory
//  `Fixed bug that cause runtime error. When cycling thru items store the number
//  `of the item at the start of the loop because the element might be deleted in
//  ` later Find in array commands.

// Modified by: costasmanousakis-(Designer)-(4/11/2006 08:44:32)
// Modified Method(s) : 
//INIT_UI_GV
//  `Added global variable C_BOOLEAN(◊CM_LogChanges_b)

// Modified Form Methods : 
//[Contract_Maintenance];"Contract Maintenance In"
//[ExtendTime_Maintenance];"ExtTime In"
//  `Added use of global variable ◊CM_LogChanges_b
// Created Method(s) : 
//CM_RecalcContrExtendDate
//  `Recalculate the Extension time for a maintenance contract
// Modified Object Methods : 
//[ExtendTime_Maintenance];"ExtTime In".btnSave
//[ExtendTime_Maintenance];"ExtTime In".btnDelete
//  `Added use of global variable ◊CM_LogChanges_b;
//  `and use new method CM_RecalcContrExtendDate.

// Modified by: costasmanousakis-(Designer)-(4/13/2006 11:09:58)
//To control the table for a QuickReport template.
// Modified Forms : 
//[Templates];"Input"
//  `Added a variable Template_Qrt_TableNo_L to display and modify the table number;
//  `and a pulldown to select from the list of tables.
//  `Adjusted the layout to fit the new objects.
// Modified Form Methods : 
//[Templates];"Input"
//  `Added code to initialize the table variable and arrays for the pulldown.
// Modified Object Methods : 
//[Templates];"Input".QRT_Template
//  `Recalculate the table no.

// Modified by: costasmanousakis-(Designer)-(4/13/2006 12:16:33)
// Modified Table(s) : 
//[Town Address]
//  `Added fields [Town Address]ContactPhone [Town Address]ContactFax [Town Address]ContactEmail
// Modified Forms : 
//[Town Address];"Input"
//  `Use the [Dialogs];"TypInputTemplate" as template.
//  `Adjusted location size of objects and buttons. 
//  `Added the three new fields.

// Modified Method(s) : 
//INIT_UI_GV
//  `Added variable ◊TWNAD_LogChanges_b to control loging changes to new [Town Address] fields

// Modified by: costasmanousakis-(Designer)-(4/19/2006 16:24:18)
// Created Form(s) : 
//[Activity Log];"Output-Fast"
//  `For quick list of Activity log entries- avoids parsing the data,

// Modified by: costasmanousakis-(Designer)-(4/20/2006 09:12:27)
// Modified Table(s) : 
//[RatingReports]
//  `Changed field [RatingReports]Consultant to A80 from A25 to allow use of the
//  `Rating Consl List in the input forms.
// Modified Forms : 
//[RatingReports];"RatReportsIn"
//  `Assigned list "Rating Consl" to the Consultants field.
//  `Changed appearance of all elements to Auto.

// Modified Forms : 
//[Dialogs];"SelectTownAddress"
//  `Added a first line in the 'header' to better describe the purpose of the dialog.
//  `Adjusted the appearance and size of the form.
// Modified Method(s) : 
//GetTownAddress
//  `Declare variable vTownName_S

// Modified Method(s) : 
//M_WRT_GenericBridgeLetter
//  `Added READ ONLY and READ WRITE commands.
//G_WRT_GenericBridgeLetter
//  `Added READ ONLY and READ WRITE commands for [Bridge MHD NBIS] and [RatingReports]
//G_GetSIARecPosting
//  `Added READ ONLY and READ WRITE commands for [RatingReports]
//G_SIA_GetRecPostings
//  `Added READ ONLY and READ WRITE commands for [RatingReports]

// Modified by: costasmanousakis-(Designer)-(4/21/2006 09:26:09)
// Modified Forms : 
//[Activity Log];"Input"
//  `Changed Appearance of objects to Auto and list of owners to grow on resize.
//[Owners of Data];"Inc. Owner Data"
//  `Changed Appearance of objects to Auto .

// Modified by: costasmanousakis-(Designer)-(4/21/2006 10:44:31)
// Modified Method(s) : 
//P_ListConsAddress
//  `Set table to read write only for Bridge insp eng and designer

// Modified Form Methods : 
//[Conslt Address];"View Conslt Address"
//  `Enable Add button only for Bridge insp eng and designer
//[Conslt Address];"Conslt Address In"
//  `Enabled changes only for Bridge insp eng and designer. Others change the field color.

// Modified Forms : 
//[Conslt Address];"View Conslt Address"
//[Conslt Address];"Conslt Address In"
//  `Changed appearances and cleaned up objects.

// Modified by: ManousakisC (4/24/2006)
// Modified Forms : 
//[Inspections];"Closed Insp Pg1"
//  `Fixed spelling error in title

// Modified Forms  and Method: 
//[Cons Inspection];"Inspection Print Form"
//  `Added variable and code for Electronic Submittal status.

// Modified Forms : 
//[Cons Inspection];"Cslt Insp In"
//  `Added "Will be Assigned" to Assignement Status pulldown

// Modified by: costasmanousakis-(Designer)-(4/24/2006 15:26:08)
// Created Method(s) : 
//INSP_UWDate_OM
//  `Object method for UW Date object in routine insp forms.

// Modified Object Methods : 
//[Inspections];"Culvert Combined".Item 93B
//[Inspections];"Routine Combined".Item 93B
//  `Use method INSP_UWDate_OM.

// Modified by: costasmanousakis-(Designer)-(4/25/2006 15:45:59)
// Created Method(s) : 
//GetPersonInfo
//GetPersonInfo_CREng 
//GetPersonInfo_DPM 
//GetPersonInfo_IHEng 
//  `Methods used in retrieving name information from the personnel table. The info is used
//  `in form letters.
//M_WRT_CsltRating_Compl_DPM
//  `Generate an interoffice letter to the Dir of proj mgmt about the completion of ratings.

// Modified Menu : 
//Menu number 4 : ConsltRtgMenu
//  `Added call to M_WRT_CsltRating_Compl_DPM in Utilities menu

// Modified by: costasmanousakis-(Designer)-(5/1/2006 16:45:47)
// Modified Method(s) : 
//ut_SetNextRunTimeStamp
//  `Modified code setting next datetime to run, to avoid skipping scheduled runs, and
//  `to account if some have been missed and run out of schedule. Done for daily,
//  `weekly and monthly schedules.

// Modified by: costasmanousakis-(Designer)-(5/4/2006 11:46:36)
// Modified DB parameters/Properties
//  `Unchecked "Use 6.8 compatibility in text rendering"

// Created Method(s) : 
//G_DisplayTable_generic
//  `To display a table using generic code.

// Modified Method(s) : 
//P_ListTemplates
//P_ListSpecialReports
//  `Use new method G_DisplayTable_generic

// Created Method(s) : 
//P_ListServerProcesses
//M_ListServerProcesses
//  `To manage the [ServerProcesses] table

//Modified StyleSheet TabText to use Geneva 12 Plain.
// Modified Forms : 
//[Inspections];"Closed Bridge"
//[Inspections];"Critical Member"
//[Inspections];"Culvert Combined"
//[Inspections];"Damage Form"
//[Inspections];"Routine Combined"
//  `Removed Bold from Tab control

// Created Method(s) : 
//Batch_ControlProcess
//Launch_BatchControl


// Modified by: costasmanousakis-(Designer)-(5/17/2006 12:15:59)
// Modified Method(s) : 
//ArchiveLogFile
//  `Changed format of archive log file name to be YYYY-MM-DD.
//  `Changed method of opening the starting dialog - use open form window.
//  `Added selection of output folder.

//Modified Picture Library
//Modified Picture 950 = Sort buttons.
//  `Changed grey button to have two arrows.

// Modified by: costasmanousakis-(Designer)-(5/18/2006 11:38:21)
// Created Method(s) : 
//INSP_SortByTmLeader
//  `Sort a list of Inspections by the team leader name.
//INSP_SortbyBDEPT
//  `Sort a list of Inspections by BDEPT.

// Modified Object Methods : 
//[Inspections];"InspectionReview".SorttmLdr
//  `Use the method INSP_SortByTmLeader.
//[Inspections];"InspectionReview".SortBdept
//  `Use the method INSP_SortbyBDEPT.

// Modified Form Methods : 
//[Inspections];"InspectionReview"
//  `Removed sort on the On Load event.

// Modified Method(s) : 
//MULTILEVEL
//  `Added short_mesage when sorting more than 500 records.

// Modified Method(s) : 
//Duplicate_Inspection
//  `When copying, unset the InitialInsp flag.

// Modified Form Methods : 
//[Bridge MHD NBIS];"BDEPT Input"
//  `Use FlushGrpChgs instead of FlushChanges at the On Validate event.

// Modified Method(s) : 
//INSP_ExportInspection
//  `Added target folder location, Clean "/" from inspection date.

// Modified by: costasmanousakis-(Designer)-(5/22/2006 08:53:35)
// Modified Method(s) : 
//G_Method_SavePhoto
//  `Photo width chgd 800-> 900
//  `Depth in Create thumbnail cmd : 32 for photos , 8 for sketches/charts.

//Added Entry Filter
//|AlphaNumPlus

// Modified Forms : 
//[Conslt Rating];"Cslt Rating In"
//  `For field CrtgStatus use filter |AlphaNumPlus

// Modified by: costasmanousakis-(Designer)-(5/23/2006 16:28:24)
// Modified Method(s) : 
//G_PickFromList
//  `Added optional parameter 1 = a pointer to a text or string array.
//  ` use the 1st 80 chars for item display.

// Modified by: costasmanousakis-(Designer)-(5/30/2006 10:28:26)
//CM_RecalcAddFunds
//  `Don't save the [contract_maintenance] record if there is no contract, or is a new record.
//  `Otherwise, the contractNo field is not enterable in the input form

//XGetServerFld
//  `Added a check to verify that the field name and type from the remote server 
//  `match the local field.

// Modified by: costasmanousakis-(Designer)-(6/2/2006 11:59:26)
// Modified Forms : 
//[Inspections];"InspectionReview"
//  `Added a button below the form footer, mapped to key comb Shift-Cmd-G,
//  `to retrieve all inspections for a district if executed by a DBIE.
// Modified Form Methods : 
//[Inspections];"InspectionReview"
//  `Declare the aPtrSortxxx arrays
//  `Adjusted the On Header code to sort Bdept and Teamleader using the new methods.

// Modified by: costasmanousakis-(Designer)-(6/5/2006 16:46:55)
// Modified Forms : 
//[Personnel];"Inspectors Out"
//  `Added Active column; Adjusted sizes and arrangements of other columns.

// Modified by: costasmanousakis-(Designer)-(6/13/2006 15:06:25)
// Modified Method(s) : 
//CM_Print_NTP_Letter
//  `Round the Des , Constr TLF and Dir Expenses; then add to get the Maxobligation.

// Modified by: costasmanousakis-(Administrator)-(6/15/2006 14:33:52)
// Created Form(s) : 
//[BMS Field Trip];"Output"
//[Field Trip];"Output"
//  `New Forms to replace the old Output forms; added search,sort buttons.