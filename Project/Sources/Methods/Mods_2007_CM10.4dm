//%attributes = {"invisible":true}
// Modified by: costasmanousakis-(Designer)-(5/21/2007 09:21:22)

// Modified Forms : 
//[Conslt Rating];"View Cslt Rating"
//  `added text variables on page 0 for color
//  `added drop downs to search and modify color of ratings

// Modified Form Methods : 
//[Conslt Rating];"View Cslt Rating"
//  `Added code to apply the color

// Modified Method(s) : 
//ut_CustomTableExport
//ut_CustomTableLoad

// Modified Forms : 
//[Cond Units];"Cond Units In"
//  `Map "Enter" key to save button. To fix case when data was saved by pressing enter key which caused changes not to be logged properly.

// Modified Method(s) : 
//Duplicate_Inspection
//  `Added SAVE RECORD([inspectioins])
//  `And modified some code at the end.

//G_GetUWRatings
//  `Added code to make sure the correct inspection record is the current;
//  `added READ ONLY for [inspections]
//  `Set the selection to the current record at the end of the retrieve.

// Modified Forms : 
//[Dialogs];"ReportTemplateSelect"
//  `named HList variable to "SelectionList"
// Created Method(s) : 
//TMPL_HList_OM

// Modified Object Methods : 
//[Dialogs];"ReportTemplateSelect".aHL_ReportTemplates
//  `use nethod TMPL_HList_OM

// Modified Form Methods : 
//[Dialogs];"ReportTemplateSelect"
//  `Select the first line of the hlist;
//  `Call method TMPL_HList_OM

// Created Method(s) : 
//CM_MailInvoiceNotice
//  `mail notification of invoice approval.

// Created Object Method(s) : 
//[Invoice_Maintenance];"Invoice Maintenance In".DateProcessFoward
//  `Use method CM_MailInvoiceNotice

// Modified by: costasmanousakis-(Designer)-(5/22/2007 15:29:07)
// Modified Method(s) : 
//G_CheckRoutineInsp 
//G_CheckCulvertInsp 
//  `Added code to check if Bridge Orientation has been filled.
