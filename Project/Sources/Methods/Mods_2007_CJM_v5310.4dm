//%attributes = {"invisible":true}
// ----------------------------------------------------
// User name (OS): MillerC
// Date and time: 06/13/07, 15:15:08
// ----------------------------------------------------
// Method: Mods_2007_CJM_v5310
// Description
// 
//
// Parameters
// ----------------------------------------------------
//Add new field and retrieve 
//Modified sp_retrieveConstructionData parameter record
//New field
//[PRJ_ProjectFile]PF_Advertised_d
//Changed field name
//FROM [PRJ_ProjectFile]PF_Advertising_d
//to [PRJ_ProjectFile]PF_ScheduledAdvertising_d
//ut_PRJRetrieveConstructionCont
//SQL_ClearArrays
//SQL_FillBuiltStatements


//Fill with new data 
//PRJ_LoadProjectFileData
//PRJ_SetFormVariableToEmpty

//06/20/07
//Fix bug where errors occured if more bins selected than were available
//[PRJ_ProjectDetailsIncludedBINS];"BinSelection.dlg"
//Added a form method and made buttons visible or invisible depending upon selections made - the
//move individual buttons
//Added an alert "There are no additional bins that can be included or removed" when 
//selecting Included bins button on [PRJ_ProjectDetails];"ProjectDetails.i" input form


//06/20/07
//Add new fields to [PRJ_ConstructionProject] table and populate same from sql db
//CP_SQLID_l
//CP_SpecsToPrint_d
//CP_SpecsFromPrint_d
//CP_PlansToPrint_d
//CP_PlansFromPrint_d
//CP_ToCashier_d
//AcjmTest 
//ut_PRJRetrieveConstructionCont
//SQL_FillBuiltStatements 
//SQL_ClearArrays 
//Add display of new retrieved dates
//PRJ_LoadConstructionContract 
//Compiler_PRJ
//see [PRJ_ProjectDetails];"Form1" for new layout. If you like it copy and replace on the input form

//06/21/07
// Modified Forms : 
//[PRJ_ProjectDetails];"ProjectDetails.i"
//  `Incorporated changes from "Form1" for new layout on page 1 information.
