//%attributes = {"invisible":true}
//Method: Mods_2024_03_bug
//Description
//
//**********`Modified by: Costas Manousakis-(Designer)-(2024-03-14)
// LSS_PrintMultipleInspections - copied from v18Bug 2024-03-22
// //ask for destination of pdf files only if not in print preview

// LSS_PrintInspection_WP - copied from v18Bug 2024-03-22
// //set preview to false only if we will be showing the print dialog
// //use the case statement to get the main prefix of pages 1 and 2.
// //check if user canceled after printing page 1 and abort the rest if they did.  
//  // //happens when printing to Ms print to pdf and user cancels on the save file dialog

// LSS_PrintDamageInspection_WP - copied from v18Bug 2024-03-22
// //set preview to false only if we will be showing the print dialog
// //added spooler document name and place the name on the clipboard

//**********`Modified by: Costas Manousakis-(Designer)-(2024-03-15)
// LSS_CountandPrintDamagePages_WP - copied from v18Bug 2024-03-22
//  `use open / close printing job to control if user cancels out of selecting a file on 
//  `the ms print to pdf save dialog,


//**********`Modified by: Costas Manousakis-(Designer)-(2024-03-19)
// FM_SaveInventoryInput - copied from v18Bug 2024-03-22
//  `disabled calls related to activity log

// [LSS_Inventory];"Input".LSS_Duplicate_L - copied from v18Bug 2024-03-22
//  `disabled all calls related to activity log

//**********`Modified by: Costas Manousakis-(Designer)-(2024-03-21)
// M_WRT_CsltInsp_ComplexNTP - copied from v18Bug 2024-03-26
//  `moved getting the Get selected menu item parameter before the call to CSLTINSP_ProceedWithLetter
//  `confirm dialogs would 'loose' the parameter
// M_WRT_CsltInsp_ComplexReqFee - copied from v18Bug 2024-03-26
//  `moved getting the Get selected menu item parameter before the call to CSLTINSP_ProceedWithLetter
//  `confirm dialogs would 'loose' the parameter

//**********`Modified by: Costas Manousakis-(Designer)-(2024-03-26)
// PRINT_SIA - copied from v18Bug 2024-03-26
//  `added Open/Close printing job and spooler doc name to prevent crash when printing to Adobe PDF
// with MS print to pdf the save as dialog shows at the Open print job command and user can cancel here
// other pdf printers show the save as dialog at the Close print job command. 

// M_PrintRecords - copied from v18Bug 2024-03-26
//  `added Open/Close printing job and spooler doc name to prevent crash when printing to Adobe PDF


//End Mods_2024_03_bug