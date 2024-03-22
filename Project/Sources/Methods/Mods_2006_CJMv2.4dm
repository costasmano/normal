//%attributes = {"invisible":true}
// ----------------------------------------------------
// Mods_2006_CJMv2
// User name (OS): cjmiller
// Date and time: 02/03/06, 12:39:33
// ----------------------------------------------------
// Description
// This method will outline changes made during project to control project file, details entry and maintenance
//that are not direcvtly related 

//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
End if 
//There are 2 new style sheet 
//PRJ_InputVariable
//PRJ_InputBoldLable

//New tables
//[SQL_Connections]
//[PRJ_ConstructionProject]
//[PRJ_Contractor]
//[PRJ_DesignContracts]
//[PRJ_ProjectDetailsIncludedBINS]
//[PRJ_ProjectDetails]
//[PRJ_ProjectFile]
//[PRJ_ProjectTimeTracking]
//[PRJ_ReportData]
//[PRJ_SketchPlans]
//[PRJ_StructuralReview]
//[TableOfLists]

//All  forms associated with  tables above
//new field to existing tables

//[Conslt Address]Func_Design
//
//Modified form 
//[Conslt Address];"Conslt Address In"
//added drop down to control entry of consulatnat names (Company)
//added list maintenance functioality. 
//LST_MaintainListTable `follow this to 

//New methods
//PRJ_ControlSelect 
//PRJ_GetSelectedBridges 
//PRJ_PerformSelectionSetUp 
//PRJ_LoadDropDownLists 
//m_MaintainLists 
//PRJ_MakeSelection 
//PRJ_StartOrResumeProjSelection 
//ut_ResizeWindow 
//PRJ_GetSelectedProjectFiles 
//PRJ_DisplayProjects 
//PRJ_SetManyTablesReadOnly 
//PRJ_AdditionalBridges 
//Mods_2006_CJMv2 
//PRJ_SetCorrectOrder 
//ut_CreateOrUpdateSQLConnectionD 
//ut_PRJRetrieveModifiedProjects 
//SQL_FillBuiltStatements 
//ut_PRJCtrlRetrieveProjectData 
//ut_PRJRetrieveDesignContracts 
//ut_ResetSQLLastUpdateDate 
//PRJ_SetEntry 
//m_MaintainProjectFile 
//M_ControlProjectDetails 
//PRJ_GetTableofListsSelection 
//PRJ_SetUpBinArrays 
//PRJ_MoveToAvailable 
//PRJ_LoadProjectFileData 
//PRJ_LoadDesignContractData 
//PRJ_LoadBridgeData 
//PRJ_SummaryAddDivider 
//PRJ_LoadBasedUponBIN 
//PRJ_LoadPage_1 
//PRJ_BridgesEntry 
//PRJ_NoBridgeFound 
//PRJ_OneBridgeFound 
//PRJ_LoadPage2Bins 
//PRJ_ControlPageMovement 
//PRJ_MoveToSelected 
//PRJ_SetUpPrimaryBinDD 
//PRJ_LoadPage_0 
//PRJ_SetEntryCheckBoxes 
//m_DisplayProjectDetail 
//ut_PRJRetrieveConstructionCont 
//ut_PRJImportData 
//PRJ_LoadConstructionContract 
//PRJ_SetFormVariableToEmpty 
//ut_PRJRetrieveAdDate 
//ut_IsaRealNumber 
//ut_IsALongint 
//ut_ParseTextToArray 
//ut_PRJImportCreateHydraulic 
//ut_PRJImportCreateGeotech 
//ut_PRJImportCreateBorePlan 
//ut_PRJCreateTypeStudy 
//ut_PRJCreateSketchPlan 
//ut_PRJParseTextToArray 
//ut_PRJCreateStructuralReview 
//ut_PRJRetrieveCPName 
//ut_PRJ_SetDate 
//ut_PRJReturnEarliestDate 
//ut_PRJRemoveExtraCharacters 
//Compiler_PRJ 
//  `Changed methods
//Shutdown 
//P_ListConsAddress 
//AcjmTest 
//SQL_Connect 
//Compiler_SQL 
//SQL_Disconnect 
//SQL_Errors 
//SQL_Do 
//SQL_FillStatement 
//SQL_FillRetrieve 
//SQL_FillUpdate 
//SQL_ClearArrays 
//SQL_SetUpReturnArrays 
//ut_UpdatePontis 
//ut_PontisUpdateNBI 
//ut_PontisUpdateInspections 
//ut_CheckPontisRecords 
//ut_LoadSQLConnectionInfo 
//M_PontisConnectionInfo 
// 

//Changed forms
//[Conslt Address];"Conslt Address In"
//[TableOfLists];"TableOfLists.i"
//[TableOfLists];"TableOFLists.o"
//Forms that can be deleted
//[Preferences];"Pontis_dlg"

//10/19/06, 11:43:34`
//Modify project detail output form to display Bridge no, city/town,consultant,project file no. strprj mgr addate last action





Mods_2006_CJMv2  //03/29/07, 10:42:01  `03/29/07, 10:39:25`Modify to use new method for selecting new / existing bins
//PRJ_LoadPage2Bins
//End Mods_2006_CJMv2

