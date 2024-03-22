//%attributes = {"invisible":true}
//Method: Mods_2023_12

//**********`Modified by: Costas Manousakis-(Designer)-(2023-12-01)
//Method: INSP_PrintSelectedReports - copied from v18Bug 2023-12-20
//Description
// Print the current selection of [Inspections] records - meant to be run interactively

//**********`Modified by: Costas Manousakis-(Designer)-(2023-12-05)
// ut_ImportFHWADataToArchive - merged from v18Bug 2023-12-20
//  `modified to use the File object and .getText to read the file
//  `display progress bar 
//  `consider 3 different cases of Item8 coding in the NBI tape file

//**********`Modified by: Costas Manousakis-(Designer)-(2023-12-06)
//[LSS_Inspection];"ITSStructurePg1" - merged from v18Bug 2023-12-22
//[LSS_Inspection];"LightStructurePg1" - merged from v18Bug 2023-12-22
//[LSS_Inspection];"SignStructurePg1" - merged from v18Bug 2023-12-22
//[LSS_Inspection];"SignStructurePg1v0" - merged from v18Bug 2023-12-22
//[LSS_Inspection];"StructureDamage_HS_P1" - merged from v18Bug 2023-12-22
//[LSS_Inspection];"StructureDamage_ITS_P1" - merged from v18Bug 2023-12-22
//[LSS_Inspection];"StructureDamage_Light_P1" - merged from v18Bug 2023-12-22
//[LSS_Inspection];"StructureDamage_TS_P1" - merged from v18Bug 2023-12-22
//[LSS_Inspection];"TrafficSignalStructurePg1" - merged from v18Bug 2023-12-22
//  Changed label for field [LSS_Inventory]LSS_YearRemoved_s to "YR REMOVED"

//**********`Modified by: Costas Manousakis-(Designer)-(2023-12-08)
// INIT_UI_GV - merged from v18Bug 2023-12-22
//  `  <>LwinY - set to 50
// NewWindow - merged from v18Bug 2023-12-22
//  ` When re-setting <>LwinY - set to 50
//  ` top left corner is set to 50 from 40
// ut_OpenNewWindow - merged from v18Bug 2023-12-22
//  ` remove the (*) parameter in screen height/width - Need the MDI dimensions
//  ` When re-setting <>LwinY - set to 50
//  ` top left corner is set to 50 from 40


//```
//```    **** End of Release 8.0.4.a 2023-12-14
//```

//**********`Modified by: Costas Manousakis-(Designer)-(2023-12-14)
//Method: Menu_AddDocumentsMenu - copied from v18Bug 2023-12-22
//Description
// add the DownloadDocuments menu item to the Tools menu of the current tool bar
// uses system parameter DocumentsMenu
// Parameters
// ----------------------------------------------------

//Method: DOC_SaveFileToLocal - copied from v18Bug 2023-12-22
//Description
// Save a document stored in a Templates record to a local file
// Templates record should be a DOC_ type where the default filename and the doc
// are stored in the Template_ blob field
// Can be called from a menu using the menu item parameter to specify the template 
// or with the template name as parameter 1
// for menu item parameter to work, the menu item should be executed in the same process
// Parameters
// $1 : $Template_txt : 


//**********`Modified by: Costas Manousakis-(Designer)-(2023-12-15)
// [Templates];"Input".Description1 - merged from v18Bug 2023-12-22
//  `added case for WRP or WPT name (Write Pro) ; also alert if the name prefix is not correct
// [Templates];"Input"
//  `added help text in [Templates]TemplateName field

//**********`Modified by: Costas Manousakis-(Designer)-(2023-12-19)
// [Status Report];"P_StatusReport_MDOT_POFA" - merged from v18Bug 2023-12-22
//  `adjusted width of all _HI fields to allow display of 100.00 HI


//**********`Modified by: Costas Manousakis-(Designer)-(2023-12-22)
// INSP_ReportIncompleteInsp - merged from v18Bug 2023-12-22
//  `added summary for UW inspections - summary sent to BIE and UWE 
//  `consider the Acting ID in [pers_groups] if the Primary ID is not defined. Include [Pers_groups][Acting] field
//  `in the SQL calls


//
//End Mods_2023_12   