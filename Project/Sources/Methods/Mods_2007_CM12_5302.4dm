//%attributes = {"invisible":true}
// **********  ` Modified by: root-(Designer)-(10/18/2007 14:28:16)
// Created Method(s) : 
//PV_ConfigureAsList 
//PV_DisableMenuShortcuts 
//PV_FixColWidths 
//PV_GetCellTextValue 
//PV_GetSelectedRow 
//PV_GetSelectedRows 
//PV_InitFormats 
//PV_NeverBeAButton 
//PV_SetColumnArrays 
//PV_SetColumnArrays2 
//PV_SetColumnFields 
//PV_SetColumnFields2 
//PV_SetColumnFormat 
//PV_SetColumnHeaders 
//PV_SetColumnHeaders2 
//PV_SetColumnWidths 
//PV_SetColumnWidths2 
//PV_SetFont 
//PV_SetRowHeight 
//PV_SetSelectedRow 
//PV_SetSelectedRows 
//  `Generic methods to help with setting up 4D View areas.  Most were copied from DBatton
//  `ViewHelper component and some were modified to work by passing arrays 
//  `instead of variable number of parameters.

//PRJ_ShowAdPrjStatus
//  `Method to list the status of projects after the bidopening stage

// Created Form(s) : 
//[PRJ_ProjectDetails];"AdStatusList"
//  `Display the status of projects after the bidopening stage using a 4D View area.

//PRJAD_OpentheRow 
//PRJAD_SortTheColumn 
//  `Methods used in [PRJ_ProjectDetails];"AdStatusList" to handle the listed projects.

// Modified Object Methods : 
//[PRJ_ProjectDetails];"ProjectDetails.i".bdelete
//  `Changed standard action of button to None; 
//  `added object method to handle validating the transaction .

// **********  ` Modified by: costasmanousakis-(Designer)-(10/19/2007 16:10:12)
// Modified Forms : 
//[ElementDict];"Dumb Input"
//  `Added fields [ElementDict]FullLabel, [ElementDict]FullLabelArch on the form;
//  `Fixed stylesheets.
//[ElementDict];"Output"
//  `Added field Part on the display; made all fields non-enterable

// Modified Form Methods : 
//[ElementDict];"Dumb Input"
//  `Use FlushGrpChgs method

// Modified Form Methods : 
//[Inspections];"Routine Arch Pr Pg 1"
//  `Combined all selection to array statements; Clear the process arrays at the end.

// Modified Method(s) : 
//G_InitInspVars
//  `Added variables for two more blank elements in Item 61.

// Created Method(s) : 
//INSP_FillElementInfo
//  ` Method to fill the element variables on a routine print form
//  ` variable INSP_NumItems_L and arrays INSP_Start_ai, INSP_Fin_ai must be defined from 
//  ` the calling form method

// **********  ` Modified by: costasmanousakis-(Designer)-(10/22/2007 08:38:32)
// Modified Method(s) : 
//INIT_FIELDS_DES
//ut_CompareStoredBlobData
//ut_RetrieveBlobDocument
//  `Addded calls for loading info in arrays from table [ElementDict] needed in inspections.
//ut_CompareStoredBlobData
//  `Modified logic to use an optional parameter to initialize the TEMP arrays in one piece of code.

// Modified Method(s) : 
//INSP_RoutinePrPg2_FM
//  `Make var/arrays that hold the number of items and the start /end range of elements in process vars; 
//  `Use new method INSP_FillElementInfo.

// Modified Forms : 
//[Inspections];"RoutinePrPg2_v2"
//[Inspections];"Routine Pr Pg 2"
//  `Added Elements 415,416 in item 61(blank 10,11); fixe some style sheets; 
//  `Added text vars for the custom element descriptions in item 61.

// Modified Form Methods : 
//INSP_CulvertPrPg1_FM
//INSP_RoutinePrPg2_FM
//  `Make var/arrays that hold the number of items and the start /end range of elements in process vars; 
//  `Use new method INSP_FillElementInfo.

// Modified Method(s) : 
//GetParentPrefix
//GetParentDescription
//  `Modified to use an optional parameter and use the new arrays instead of 
//  `pushing/poping [elementdict] records.

// Modified Form Methods : 
//[Inspections];"Routine Pr Pg 1"
//  `Make var/arrays that hold the number of items and the start /end range of elements in process vars; 
//  `Use new method INSP_FillElementInfo.

// Modified Method(s) : 
//INIT_UI_GV
//  `Made var ◊k61f_ := 416 for the two extra Item 61 elements.

// **********  ` Modified by: costasmanousakis-(Designer)-(10/24/2007 08:34:29)
// Modified Method(s) : 
//SRC_DeclareBrgVars 
//SRC_SearchByBridge 
//CreateRandomSet 
//M_SearchBrgInInspections
//  `Added code to allow Designer and personnel who have final approval to search all records for a BIN 
//  `if the press the Option (win:ALT) key when clicking on the Find by Key button.
// Modified Forms : 
//[Inspections];"InspectionReview"
//  `Added button mapped to CMD-Option-F to allow that Keystroke.

// **********  ` Modified by: costasmanousakis-(Designer)-(10/25/2007 08:50:53)
// Modified Method(s) : 
//INSP_DamagePg1_FM
//  `Combine 4 selection to array commands into one.

// Modified Form Methods : 
//[Inspections];"Routine Arch Pr Pg 1"
//  `Use method INSP_FillElementInfo instead of all individual calls. 
//  `there will be variables that are filled but not displayed.

// Modified Method(s) : 
//ut_executeMethod
//  `Allow entry of up to 7 text parameters to a method that will be executed on a server.
//ArchiveLogFile
//  `Allow passing of parameters and other code so that it can be executed in batch mode on a server.
//  `Also added use of a semaphore so that multiple archive operations cannot happen at the same time.

// Created Method(s) : 
//Server_ArchiveLogFile
//  `Can be used in the ServerProcess table.

// Modified Forms : 
//[Bridge MHD NBIS];"CombinedInspections"
//  `Added button to allow changing of Inspection type for DBIEs, Team Leaders and designer.

// Modified Method(s) : 
//G_Insp_ElmtArray_setup
//  `Use loading info in arrays and then looping thru arrays instead of looping thru and  loading the records.
//GetElmtNumber
//  `Accept an optional parameter for the Element number.

// **********  ` Modified by: costasmanousakis-(Designer)-(10/29/2007 08:40:07)
// Modified Method(s) : 
//PRJ_FillPersonnelDropDowns
//  ` accept muliple group names; use arrays for [Personnel] fields
//PRJ_LoadDropDownLists
//  `Reviewers are a combo of reviewers and strmgrs
// Modified Form Methods : 
//[PRJ_ProjectDetails];"ProjectDetails.i"
//  `added check in close detail events to re-order lists

// Modified Form Methods : 
//[PRJ_SketchPlans];"SketchPlans.i"
//[PRJ_StructuralReview];"ProjectReview.i"
//[PRJ_TypeStudy];"TypeStudy.i"
//  `Moved code to avoid continuing adding records from on Validate event to Validate button.
//[PRJ_ReportData];"ReportData.i"
//  ` set curr date as received for new records

// Modified Forms : 
//[PRJ_ReportData];"ReportData.i"
//  `Added button to date approved date to today's date

// Modified Form Methods : 
//[Conslt Address];"Conslt Address In"
//  `made some more initializations

// Modified Method(s) : 
//GetConsltAddress1
//  `Fix some logic errors; provide some initialization vallues when addingan address record.

// Created Method(s) : 
//F_AnglicizeOrder
//  `Return english version of 1,2,3.. up to 20.
//GetStructReviewerInfo
//  `Fill info regarding a reviewer

// Modified Method(s) : 
//CONS_Address_O_FM
//  `Include Des function in the description of the function variable "vContactFunction"

// Modified Forms : 
//[PRJ_StructuralReview];"ProjectReview.i"
//[PRJ_SketchPlans];"SketchPlans.i"
//[PRJ_TypeStudy];"TypeStudy.i"
//  `Added buttons to print some of the letters

// **********  ` Modified by: costasmanousakis-(Designer)-(10/31/2007 08:31:50)
// Modified Method(s) : 
//M_SearchConsltAddress
//  ` declare vars, use form dims
//CreateRandomSetinConsltRating
//  ` made changes in the search :if user has a wild card, then use it.

// Modified Form Methods : 
//[Conslt Rating];"Cslt Rating In "
//[Cons Inspection];"Cslt Insp In"
//  ` ' Get write access to the Cost record when loading ; Unload the Cost record on unload.

// **********  ` Modified by: costasmanousakis-(Designer)-(11/1/2007 08:36:40)
// Modified Method(s) : 
//GetParentDescription 
//GetParentPrefix
//  `Check for the case of a bad Element number, ie not in the list

//G_DeleteInspection
//  `Simplify the restore of the selection using a record array. Also no need to sort at the end.
// Modified Form Methods : 
//[Inspections];"InspectionReview"
//  `Added code in the on Open Detail to track the selected record; and on Close Detail to adjust the display 
//  `when a record has been deleted (a change in the number of selected records).

// **********  ` Modified by: costasmanousakis-(Designer)-(11/2/2007 10:45:19)
// Modified Method(s) : 
//P_ReviewInspcts
//  `Limit Greg Krikoris to Districts 3,4

// Created Method(s) : 
//ARCH_SearchforField
//  `Search for a field logged in the activity log table
// Created Form(s) : 
//[Activity Log];"SearchForField"
//  `Provide the UI for method M_SearchACTLOG_field
//M_SearchACTLOG_field
//  `Method to search in the current selection of activity log records for changes to a field in a table.
// Modified Forms : 
//[Activity Log];"Output"
//  `Added button to call M_SearchACTLOG_field

// **********  ` Modified by: costasmanousakis-(Designer)-(11/5/2007 11:27:12)

// Modified Method(s) : 
//WKHR_ComputeAvgs
//  `Set the output folder for the log.

// Created Method(s) : 
//ut_BarCodeFontSetup
//  ` Copy the Barcode font to the local font folder.
// Modified Method(s) : 
//Startup_PL
//  `Added code to define the local 4DX folder
//Startup
//  `Call new method ut_BarCodeFontSetup before the INIT_UI_GV call.

// Modified Form Methods : 
//[Activity Log];"Print"
//  `combine new and old data in one display..
// Modified Forms : 
//[Activity Log];"Print"
//  `Add datetime, print page, remove old data, use new + old data

// **********  ` Modified by: costasmanousakis-(Designer)-(11/6/2007 09:10:55)
// Modified Forms : 
//[Contract Invoice];"ContractInvoice In"
//  `Added Mail Invoice notification button.
// Modified Object Methods : 
//[Contract Invoice];"ContractInvoice In".btnSave
//  `Mail Invoice if it has been date of processing was entered.
//[Contract Invoice];"ContractInvoice In".dateprocessforward
//  `Flag if it was changed
// Modified Form Methods : 
//[Contract Invoice];"ContractInvoice In"
//  `Initialize the dateprocessforward flag

// Modified Forms : 
//[Town Address];"View Town Address"
//  `Added button to display by district

// **********  ` Modified by: costasmanousakis-(Designer)-(11/7/2007 10:11:09)
// Modified Method(s) : 
//ut_CustomTableExport
//   `Allow choise to export all recors, current selection, or make an new query 
//ut_CustomTableLoad
//  `Changed logic on deleting existing records. 
//  `  `1st set key field to something else (zero for numbers, blank for alpha) 
//  `  `and then delete the existing record.

// Modified Method(s) : 
//M_SetItem75
//  `Use the ut_SetMessageDir to save the message file;
//  `Launch the message file at the end.

// **********  ` Modified by: costasmanousakis-(Designer)-(11/8/2007 08:57:01)
// Modified Method(s) : 
//QR_ConsInspElecSubm
//  `Look ahead for a full 3 months from start month.  Per F.R. 

// **********  ` Modified by: costasmanousakis-(Designer)-(11/9/07 15:30:24)
// Modified Forms : 
//[Conslt Address];"View Conslt Address"
//  `Added Add button visible only to Designer
// Modified Forms : 
//[Conslt Address];"Conslt Address In"
//  `Changed colors of the non-editable fields
// Modified Object Methods : 
//[Conslt Address];"Conslt Address In".Edit Company
//  `Added code to set the color of the cons name field, and move to it
// Modified Method(s) : 
//P_ListConsAddress
//  `Call Menu Bar (3)