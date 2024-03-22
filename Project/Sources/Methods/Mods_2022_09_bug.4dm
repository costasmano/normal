//%attributes = {"invisible":true}
//Method: Mods_2022_09_bug
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Sep 15, 2022, 17:16:40
	Mods_2022_09_bug
	// ----------------------------------------------------
	
End if 
//

//**********`Modified by: Costas Manousakis-(Designer)-(2022-09-15)
// LSS_PrintMultipleInspections
//  `when calling LSS_PrintInspection_WP pass the selected record number. 
//  `Save in pasteboard a name for the file to be used when saving pdfs

// INSP_DuplicateInventoryPhotos
//  `assign a TL or a TM based on the current user

// SIA_BridgeInput_FM
//  `Enable all buttons to start with

// [Bridge MHD NBIS];"Bridge Input".InvImport
//  `set vsForward
// [Bridge MHD NBIS];"Bridge Input".InventoryPhotos
//  `set vsForward
// [Bridge MHD NBIS];"Bridge Input".DE bAddInvInsp
//  `set vsForward

// G_ListTable
//  `correct calculation of form width/ht taking account screen width/ht
// ut_NewTextToArray
//  `fixed bug in converting last element to a number

// ut_getFormVariables
// use name \"BMS VertCLRSign\" instead of pic if 886
// SCPOA_FormTester
// use picture name "BMS VertCLRSign" instead of RefID 886
// DEV_Create4StateBtnFromLibPic
//use the pic name instead of pic ID to get the picture from the library

// ut_SQLTellServerNRI
//replaced picref 30288 with the name "EmptyPicture"

//**********`Modified by: Costas Manousakis-(Designer)-(2022-09-16)
// [Inspections];"WPCmtsPrint"
//change line ht to 99% for MacOS
// [Inspections];"CulvertPrPg2wp"
//change line ht to 99% for MacOS
// [Inspections];"NTECmtsPrintWP"
//change line ht to 99% for MacOS
// [LSS_Inspection];"LSS_Comments_WP"
//change line ht to 99% for MacOS
// [LSS_Inspection];"LSS_PhotoLog_WP"
//change line ht to 99% for MacOS
// [TIN_Inspections];"WPCmtsPrint"
//change line ht to 99% for MacOS

//**********`Modified by: Costas Manousakis-(Designer)-(2022-09-26)
// INIT_UI_GV
//  `connected to boston server when str file = MHD BMS & is compiled mode

//**********`Modified by: Costas Manousakis-(Designer)-(2022-09-30)
// G_Insp_SetTitle
//  `always search in table [Inspection Type] for the description.

//```
//```    **** End of Release 8.0.0.f 2022-09-30
//```

//End Mods_2022_09_bug   