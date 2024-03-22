//%attributes = {"invisible":true}
// **********  ` Modified by: costasmanousakis-(Designer)-(11/1/10 15:32:40)
// **** SIA Enhancement ****
// **** Display the description of  the  'OTHER' item in the Accessibility items on the SIA form for Inspection ****
// Modified Forms : 
//[Bridge MHD NBIS];"SI & A (Insp)"
//  `Adjusted alignment / height of some text labels, variables and fields; moved some labels to page 0; 
//  `added the Other accessibility info on the Accessibility section

//[Bridge MHD NBIS];"MHD Specific Items"
//  `Adjusted alignment / height of some text labels, variables and fields

// Modified Form  : 
//[Design Load];"Output"
//  `Added button addDesBtn 
// Modified Form Methods : 
//[Design Load];"Input"
//  `(Changed num of chars MHDDB_NumCodeChars to 1 - added entry filter MHDDB_CodeFilter_txt

// Modified Method(s) : 
//MHDDB_LookupTbl_FM
// `Added use of new filter variable code - init of ptr_Changes array

// Created Method(s) : 
// **** DB ADMIN Additions ****
//ARCHIVE_LoadDBF
//  ` Import an exported DBF file into [BridgeMHDNBISArchive] table. Uses an
//  `Import settigns file. 
//ARCHIVE_SetReasonDate
//  ` Set the reason and date...

// **********  ` Modified by: costasmanousakis-(Designer)-(11/8/10 10:03:43)
// **** SIA Enhancement  ****
// ****  Addition of HL-93 load in Item 31 coded as Z ****
//[Design Load];"Translation"
//  `Changed dialog to ListBox, added the description, button Update
// Modified Method(s) : 
//DESLOAD_GeneralMethod 
//  `Changed dialog to ListBox, added the description, initialize the translation if it does not exist at the start,
//  `options to reload codes from the table and adjust translation. 
//ExportNBI
//  `Use method SIA_DesignLoadTrans to tranlsate [Bridge MHD NBIS]Item31 from MHD code to FHWA code


// ut_DropIndices
// User name (OS): charlesmiller
// Date and time: 11/09/10, 15:10:02

// **********  ` Modified by: costasmanousakis-(Designer)-(11/9/10 11:14:47)
// Created Method(s) : 
// **** DB ADMIN Additions ****
//ADDUSER_Utils
//  ` Perform tasks used for dialog [Personnel];"ADDUserDialog". Controls the
//  `Form method and object methods on the form.
// Created Form(s) : 
//[Personnel];"ADDUserDialog"
//  `see method ADDUSER_Utils

// Created Method(s) : 
//ut_LoadSysParamError
//  ` Attempt to load a parameter using the ut_GetSysParameter method
//  ` Return error if not found
// Modified Method(s) : 
//DCM_PrintContractReport
//DCM_PrintProject 
//DCM_PrintWorkOrder
//  `Change logic to use ut_LoadSysParamError method

// **********  ` Modified by: costasmanousakis-(Designer)-(11/10/10 12:20:13)
// Created Method(s) : 
// **** NEW QUICK REPORT Formula ****
//QR_NextInspInfo
//  ` Determine the next inspection and the type. assigns the values to process variables
//  ` SIA_NEXTINSP_DATE and SIA_NEXTINSPTYPE_TXT; Also returns the combined result in a text string
//  ` in the form "SIA_NEXTINSPTYPE_TXT SIA_NEXTINSP_DATE"
// **** NEW QUICK REPORT Formula ****
// QR_BridgeArea_r
//  ` Calculate the Bridge Area for the current bridge record

// **********  ` Modified by: costasmanousakis-(Designer)-(11/12/10 09:07:25)
// Modified Method(s) : 
// **** Bug Fix ****
// **** Occasional errors when calling google maps caused by uncommon chars in Items 6 or 7 ****
//ut_GoogleBIN
//  `Changed code and url string to use PROCESS HTML Var command;
//  `Added change to replace parens with brackets in Item 6 and 7

// **********  ` Modified by: costasmanousakis-(Designer)-(11/15/10 10:34:43)
// Modified Table(s) : 
//[DCM_WorkOrders]
//  `Changed last hidden field to [DCM_WorkOrders]DistrictArea_s A2
// Modified Forms : 
//[DCM_WorkOrders];"DistrMaintInput"
//  `Added pulldown DCM_DistrAreas_as 
// Created Method(s) : 
//DCM_WO_DistrAreaCtrl
//  `Control the initializing of the DCM_DistrAreas_as pulldown
// Modified Method(s) : 
//DCM_WO_Input_FM
//  `Added call to DCM_WO_DistrAreaCtrl on the on load event

// **********  ` Modified by: costasmanousakis-(Designer)-(11/16/10 11:31:47)
// Created Method(s) : 
// **** NEW QUICK REPORT Formula ****
//QR_CountRelated
//  ` Get a Count of the related records
//  `$count;=QR_CountRelated(->MasterTblKeyField;->ChildTableFKGield)

// Modified Forms : 
//[Bridge MHD NBIS];"NBIS Stack Info"
//  `Added button  SIA_QSelByFormula : 
//  ` Do A query selection by Formula visible only to Designer

// Modified Method(s) : 
//On server  Startup
//  `Added call to Startup_PL to initialize the dir separator needed in GetPath

// Modified Table(s) : 
//[DCM_Contracts]
//  `Added fields
//  `[DCM_Contracts]ContractRates_x Blob invisible
//  `[DCM_Contracts]Dummy A2 - invisible

// **********  ` Modified by: costasmanousakis-(Designer)-(11/18/10 12:18:16)
// Modified Method(s) : 
// **** Bug Fix ****
// **** Error when deleting Inspections ****
//G_DeleteInspection
//  `Fixed the SELECTION TO ARRAY setting. a) search for the just deleted record, rec num=-1 
//  `b) reduce the selection to 0 if the array is zeroed out

// Modified Method(s) : 
// **** Inspection Fix  ****
// **** Printing of Cons Company name in Inspection forms ****
//G_InspConsCompany
//  `Chnaged logic of cleaning up the company name-use a while loop;
//  `Increased limit to 25 chars from 20 ;  added a call to G_FitPrintObject

//**********
//**********   END OF VERSION 5.8.1 11/23/2010
//**********
//**********

// **********  ` Modified by: costasmanousakis-(Designer)-(11/23/10 11:53:52)
// Modified Method(s) : 
//ut_LoadBridgeRank
//  `Added Alert at the end to adjust parameter BRG_RANKINGDATE in Parameters table
//TEMP_UpdSelList
//  `Added Alert at the end to adjust parameter FHWASELECT_INFO in Parameters table

// **********  ` Modified by: costasmanousakis-(Designer)-(11/29/10 11:47:56)
// Created Method(s) : 
//SETALLOWEDMETHODS
//  ` Create an array containing the allowed methods for users in the  Formulas editor
//  ` Designer and Admin have access to all visible - set in parameters.

// **** Enhancement  ****
// **** Search by element description.  ****
// Modified Form Methods : 
//SRC_ResetForm
//G_DeficientElmtQuery
//M_SearchDefElement
// Modified Forms and Form Method : 
//[Dialogs];"Search Def Element"
//  `Mods for search by element description.

// Modified Method(s) : 
//ControlMenuBar
//[Bridge MHD NBIS];"NBIS Stack Info".bzSearchLay
//  `change CMD-S to 4D Query instead of EZSearch for Designer