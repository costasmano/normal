//%attributes = {"invisible":true}
//Method: Mods_2019_03
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/08/19, 17:15:04
	// ----------------------------------------------------
	//Created : 
	Mods_2019_03
End if 
//
//**********`Modified by: Costas Manousakis-(Designer)-(3/6/19)
// M_WRT_IOMcover_cslt
//  `use field CRtgSource to pick the consultant representative

//**********`Modified by: Costas Manousakis-(Designer)-(3/20/19)
//Method: PON_Util_CreateElemChildTrees
//Description
// create the XMLs from tab delimited file. 
// column one is parent element, column2 is child, col3 is protsys (Y/N), col4 is defect (Y/N)
// compares defects found with defect tree stored in DB.
// Parameters

//**********`Modified by: Costas Manousakis-(Designer)-(3/22/19)
//Method: ut_DOM_LoadXML
//Description
// Return the parsed XML reference from a resource file or from a 
// record in the [Parameters] table. Will use parameter RES_PARAM_XREF
// to determine which parameter to use
// Parameters
// $0 : $ParsedXML
// $1 : $Resource file Folder
// $2 : $Resourcefile

// NTI_CheckXMLvsDB
//  `use ut_DOM_LoadXML to switch from Resource files to Parameters table.
// NTI_Export_Elem_Defects
//  `use ut_DOM_LoadXML to switch from Resource files to Parameters table.
// NTI_FindAllowedDefects
//  `use ut_DOM_LoadXML to switch from Resource files to Parameters table.;
//  `changed references of PON_DEFECT_LANG_TREE to NTI_DEFECT_ELEM_TREE 
// NTI_INIT
//  `use ut_DOM_LoadXML to switch from Resource files to Parameters table.
// NTI_LoadElementHelp
//  `use ut_DOM_LoadXML to switch from Resource files to Parameters table.
// NTI_NoQuantityState
//  `use ut_DOM_LoadXML to switch from Resource files to Parameters table.
// NTI_NoQuantityState1
//  `use ut_DOM_LoadXML to switch from Resource files to Parameters table.
// NTI_UpdateDBfromXML
//  `use ut_DOM_LoadXML to switch from Resource files to Parameters table.
// NTI_UpdateDBonStartup
//  `use ut_DOM_LoadXML to switch from Resource files to Parameters table.
// NTI_ut_UpdateDEFS
//  `use ut_DOM_LoadXML to switch from Resource files to Parameters table.
// PON_Export_Elem_defects
//  `use ut_DOM_LoadXML to switch from Resource files to Parameters table.
// PON_ExportdefstoExcel
//  `use ut_DOM_LoadXML to switch from Resource files to Parameters table.
// PON_FindAllowedDefects
//  `use ut_DOM_LoadXML to switch from Resource files to Parameters table.
// PON_LoadElementHelp
//  `use ut_DOM_LoadXML to switch from Resource files to Parameters table.
// PON_NoQuantityState1
//  `use ut_DOM_LoadXML to switch from Resource files to Parameters table.

//**********`Modified by: Costas Manousakis-(Designer)-(3/25/19)
// Modified Object Methods : 
// [PON_ELEM_INSP];"Input".PON_ELEMSELECT_atxt
//  `Use a case statement when checking for Type (prot sys or defect)
//  `for Prot sys check if selection is in the list of FHWA recommended. - show alert if it is not.

//**********`Modified by: Costas Manousakis-(Designer)-(3/26/19)
// Created Method(s) : 
//Method: RES_Find_Parameter
//Description
// Find the record in [parameters] that corresponds to a resources file.
// Parameters
// $0 : $Param_txt
// $1 : $Resource file Folder
// $2 : $Resourcefile
//Method: RES_Load_to_Blob
//Description
// Load a resource file or data from a [parameter] record to a blob
// Parameters
// $0 : $Blob_x
// $1 : $ResFolder_txt
// $2 : $ResFile_txt

// Modified Method(s) : 
// PON_LoadElementHelp
//  `use method RES_Load_to_Blob to load the required web template
// NTI_LoadElementHelp
//  `use method RES_Load_to_Blob to load the required web template

//**********`Modified by: Costas Manousakis-(Designer)-(3/27/19)
// Modified Method(s) : 
// ut_ClearSavedPassword
//  `to get Engine link file, need the folder of the application file to get to the .4Dlink file

//**********`Modified by: Costas Manousakis-(Designer)-(3/28/19)
// Modified Forms : 
// [Town Address];"View Town Address"
//  `resized and moved ojects to make them larger

//End Mods_2019_03