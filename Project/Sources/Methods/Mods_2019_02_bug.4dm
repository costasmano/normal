//%attributes = {"invisible":true}
//Method: Mods_2019_02_bug
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 02/13/19, 12:45:30
	// ----------------------------------------------------
	//Created : 
	Mods_2019_02_bug
End if 
//

//**********`Modified by: Costas Manousakis-(Designer)-(2/5/19)
// Modified Method(s) : 
// BID_RetrieveAwardDataFromTish
//  `changed all vars used in the SQL calls to process variables - otherwise did not work compiled

//**********`Modified by: Costas Manousakis-(Designer)-(2/6/19)
// Modified Method(s) : 
// PON_CombineRecent
//  `changed arrays used in SQL exec immediate to interprocess vars CallReference #608

// Created Method(s) : 
// NTI_CombineRecent
//Description
// Combine NTE elements from the previous inspections starting from the last routine inspection
// return an object containing the element tree.
// object can be used to create a new set of elements for a new inspection, or
// to export for FHWA submittal
// Parameters
// $0 : $NTEElements_o
// $1 : $completed_b
// $2 : $Dbieapproved_b
// $3 : $startdate_d

//**********`Modified by: Costas Manousakis-(Designer)-(2/8/19)
// Modified Method(s) : 
// NTI_LoadExportArrays
//  `modified to use method NTI_CombineRecent; also adjusted logic in determining element key and parent key; 

//**********`Modified by: Costas Manousakis-(Designer)-(2/11/19)
// Modified Method(s) : 
// NTI_ExportXML
//  `Change varname for export nte optios to NTI_FHWAExportOpt_txt from FHWAITEM8_txt
//  `Ask for the option only when exporting NTEs


//**********`Modified by: Costas Manousakis-(Designer)-(2/12/19)
// Modified Form  : 
// [LSS_Inventory];"Input"
//  `renamed Import insp button to LSS_ImportInspection, cleared var name

// Modified Method(s) : 
// FM_InventoryInput
//  `enable import button for Designer

//**********`Modified by: CJMIller-(Designer)-(2/13/19)

//Fix bug where elements not printing correctly CallReference #607
//Changed way we calculate the number of element pages
//Reset $k to 0 before loop
//changed to test (Size of array($v_163_002_aL)=0)
//Modified by: Chuck Miller (2/13/19 12:20:06)
//LSS_CountandPrintDamagePages  - CallReference #607

//**********`Modified by: Costas Manousakis-(Designer)-(2/13/19)
// Modified Object Methods : 
// [Dialogs];"Search Def Element".bFind
//  `do not search if there are no criteria selected

//**********`Modified by: Costas Manousakis-(Designer)-(2/15/19)
// Modified Method(s) : 
// INSP_ReportIncompleteInsp
//  `changed format of inspection date to internal date short so that the full year is shown. CallReference #604
//  `also changed template "LateInspectionsBody" to use #4DEVAL string(date;internal date short). CallReference #604

// SIA_BridgeInpNavCTRL
//  `for Rail/Transit SIA (page=9) use case for insp Resp to account also for DOTRT 
// SIA_RAILINPUT_FM
//  `use Case statement at the start for @RO to lock the record or not
//  `use Case statement for insp resp to account for DOTRT

//**********`Modified by: Costas Manousakis-(Designer)-(2/22/19)
// SIA_BridgeInput_FM
//  `for Rail/Transit SIA (page=9) use case for insp Resp to account also for DOTRT 

//**********`Modified by: Costas Manousakis-(Designer)-(2/26/19)
// Modified Method(s) : 
// ut_SQLDownloadNewRecords
//  `added missing case for TRS activity type - is in the dev version.
// Resource_SaveFileOnServer
//  `display message about file being saved

//**********`Modified by: Costas Manousakis-(Designer)-(2/27/19)
// Modified Method(s) : 
// PON_ExportFHWANBE
//  `added more info in the error lines separated by tab


//```
//```    **** End of Release 7.2.0.c 28-Feb-2019
//```


//End Mods_2019_02_bug