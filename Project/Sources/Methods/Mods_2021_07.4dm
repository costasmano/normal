//%attributes = {"invisible":true}
//Method: Mods_2021_07
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 07/08/21, 13:06:02
	// ----------------------------------------------------
	//Created : 
	Mods_2021_07
End if 
//

//**********`Modified by: Costas Manousakis-(Designer)-(7/8/21)
// ut_ArrayToText - copied from v15 2021-07-08
//  `added boolean and time arrays; 
//  `for date and time arrays use Num of the format passed in $4
//  `for boolean if the format passed is "valueIftrue;valueifFalse", split the two values and use Choose (bool;"valueiftrue";"valueifFalse")


//**********`Modified by: Costas Manousakis-(Designer)-(7/9/21)
//Method: SRC_PasteboardSearch - copied from v15 2021-07-09
// Perform a search through the bridge table from data in the pasteboard. 
// Parse the text data in the pasteboard to determine the search type
//Object Method: [Dialogs];"Search Bridge".bFind  - copied from v15 2021-07-09
//  `Use method SRC_PasteboardSearch when searching from Pasteboard

//Method: ut_NewSaveMethod - copied from v15 2021-07-12
//  `added on error call to catch error creating first folder

//**********`Modified by: Costas Manousakis-(Designer)-(7/12/21)
// PHOTO_LoadSIAorConsultantPages - copied from v15 2021-07-12
//  //use constants BMS Cons Transmittal and BMS Cons QA form
// [Inspections];"Routine Combined".GotoPage10 - copied from v15 2021-07-12
//  //use constants BMS Cons Transmittal and BMS Cons QA form
// PHOTO_DelSIAorConsultantPages - copied from v15 2021-07-12
//  //use constants BMS Cons Transmittal and BMS Cons QA form
// PHOTO_ViewSIAorConsultantPages - copied from v15 2021-07-12
//  //use constants BMS Cons Transmittal and BMS Cons QA form


//**********`Modified by: Costas Manousakis-(Designer)-(7/14/21)
// INSP_ResetToOnlyImages - copied from v15 2021-07-14
//  `use BMS constants for types

//**********`Modified by: Costas Manousakis-(Designer)-(7/19/21)
// Dev_pickFields - copied from v15 2021-07-19
//  `if $2 array has data populate the omit list
// Modified Forms : 
// "ReLogRecords" - copied from v15 2021-07-19
//  `added a invisible variable to hold JSON of object with specific field data.
//  `added selecting specific fields create act log GRP record - save the 
//  `added selecting specific fields to create act log LNK record

// Modified Object Methods : 
//  "ReLogRecords".logfields - copied from v15 2021-07-19
// object method to collect specific fields to log instead of doing all fields
//  "ReLogRecords".linkfields - copied from v15 2021-07-19
// object method to select fields for LNK act log records
//  "ReLogRecords".LinkTablemenu - copied from v15 2021-07-19
// object method to define a [table]field to link fields to
// "ReLogRecords".TableList_atxt - copied from v15 2021-07-19
//  `initialize the new form var "fieldsToLog" and label "LinkToField"
// "ReLogRecords".RelogDo - copied from v15 2021-07-19
//  `adjusted logic of error checks so that they are shown all at the end, if any.
//  `added use of Fields to log and link fields. If there are any link (LNK) fields exclude them from the logged.
//  `if there is a Link-to field, create activity log LNK records.

//End Mods_2021_07