//%attributes = {"invisible":true}
// Modified by: costasmanousakis-(Designer)-(4/25/2007 11:43:39)
// Modified Method(s) : 
//CM_CalFor_AddenAssignm_Letter
//  `Added code to handle case where the addendum is a new record; 
//  `and to keep the current selection of records the same.


// Modified by: costasmanousakis-(Designer)-(4/30/2007 09:27:09)
// Created Method(s) : 
//ut_SetEnterable

// Modified Form Methods : 
//[Bridge Design];"Bridge Design In"
//  `Use the ut_SetEnterable method; enable logging of bridge design changes

// Modified Object Methods : 
//[Bridge Design];"Bridge Design In".Bdelete
//  `made no default action; log the deletion
//[Bridge Design];"Bridge Design In".bSave
//  `log the new record action
//[Bridge Design];"Bridge Design In".various pulldown methods
//  `Use POPUPMENUC instead of case statements
//[Bridge Design];"Bridge Design In".various variable methods in pg4
//  `Use round to 4 decimals when storing values in[Bridge MHD NBIS] fields
//[Bridge Design];"Bridge Design In".radio buttons in pg4
//  `Adjust logic; use ut_SetEnterable method

// Modified Forms : 
//[Bridge Design];"Bridge Design In"
//  `Re-order entry order on all pages.

// Created Form(s) : 
//[Dialogs];"FreezeThawListInput"
// Created Method(s) : 
//ut_LoadFrzThawSIAInfo
//  `Load FreezeThaw info into SIA

// Modified Method(s) : 
//ut_LoadRecordInteractive 
//  `Use method G_MyConfirm instead of Confirm. It allows to switch process to close
