//%attributes = {"invisible":true}
// **********  ` Modified by: costasmanousakis-(Designer)-(5/6/09 09:31:02)
// Created Method(s) : 
//ut_updateNBIRecords
//  ` Update [Bridge MHD NBIS] records from an NBI input data file. like the MFINPUT.dat submitted to FHWA


// **********  ` Modified by: costasmanousakis-(Designer)-(5/6/09 09:31:02)
// Modified Method(s) : 
//M_WRT_CsltRating_Complete
//  `Added the Score as part of the assignment list print.

// Modified Forms : 
//[PRJ_StructuralReview];"ProjectReview.i"
//  `Replaced the Title of the PRJ_Approval field to " " to avoid having phantom highlite appear on Win machines
//  `when the box was checked.

// Modified Method(s) : 
//P_ReviewInspcts
//  `Exclude Freeze Thaw inspections for MHD Area Engineers

// **********  ` Modified by: costasmanousakis-(Designer)-(5/12/09 14:25:08)
// Modified Forms : 
// Modified Form Methods : 
//[Cond Units];"Cond Units Prt 2"
//  `modified the form and replaced the [Cond Units]Percent check box with
//  ` a box and two cross lines called CHKLINE@
//  `SET VISIBLE(*;"CHKLINE@";[Cond Units]Percent)
//  `use this command to check/uncheck the percent check box since on Windows it comes out grey

// **********  ` Modified by: costasmanousakis-(Designer)-(5/15/09 10:19:11)
// Modified Method(s) : 
//Set Doc Margins
//  `Removed unnecessary set of WR SET TEXT PROPERTY ($MyArea;wr line spacing; commands
//  `they are called in G_Insp_ApplyLineSpacing
//INSP_ElmSft_Input_FM 
//  `Made sure the focus is on the Rating field on the on load event.
//  `Unload the record when in ReadOnly mode (vbInspectionLocked=true)
// Modified Object Methods : 
//[ElementsSafety];"SafetyElmtTemplate".asElmtSftyPulldwnName
//  `Check the Read Only state of the table before doing a modify record

// **********  ` Modified by: costasmanousakis-(Designer)-(5/19/09 08:34:30)
// Modified Method(s) : 
//CIR_InitInspTypeChkboxes
//  `Initialize the checkboxes to zero on load
// Modified Form Methods : 
//[zSpecialReports];"Input"
//  `Push the changes on COPYRECORD

// **********  ` Modified by: costasmanousakis-(Designer)-(5/26/09 11:53:13)
// Modified Forms : 
//[PRJ_ProjectDetails];"ProjectDetails.i"
//  `Adjusted size of included lists for Reports, Types, Sketch and Str Reviews;
//  `changed size to automatic size, and Window size to "with constraints" - fixed witdh, min ht=500

// Modified Method(s) : 
//ut_PRJRetrieveDesignContracts
//  `Added some checks on whether to replace the existing des contract id in [projectfile] table. will be fully addressed when
//  ` the new method of linking project files to des contracts gets implemented.
//ut_OpenNewWindow
//  `Get the height/width of application window not screen ht to take into consideration the difference
//  `in a windows enviroment.


//r002  `05/22/09, 13:32:23 `Add code and tables to retrieve pontis simulation data
//delete method LNextSequence
//rename [zSequences] to [Pontis_Metrics]

//rename [zReturnNumbers] to [Pontis_Metric_Data]
//[Pontis_Metrics];"PontisImport.dlg"
//[Pontis_Metrics];"User.i"
//PM_ControlMetricRetrieve 
//PM_CreateMetricRecord 
//SQL_ClearArrays
//SQL_FillBuiltStatements
