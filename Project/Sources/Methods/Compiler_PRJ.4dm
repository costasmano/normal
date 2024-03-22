//%attributes = {"invisible":true}
// ----------------------------------------------------
// Compiler_PRJ
// User name (OS): cjmiller
// Date and time: 01/10/06, 15:53:19
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_2006_CJMv2  //12/14/06, 14:53:29`Add transaction control to project details input form
	Mods_2006_CJMv2  //03/15/07, 12:34:00`Modify to use group description
	Mods_2006_CJMv2  //03/15/07, 12:37:25  `Change name from Reviewers to StructReviewers
	Mods_2006_CJMv2  //03/29/07, 10:42:01  `03/29/07, 10:39:25`Modify to use new method for selecting new / existing bins
	Mods_2007_CJMv2  //04/12/07, 10:49:42`Add bridge section responsible
	Mods_2007_CJMv2  //r060   `05/16/07, 11:51:22` `Add code to control access 
	Mods_2007_CJMv3  //06/13/07`Add actual advertised date
	Mods_2007_CJM_v5310  //Add display of new retrieved dates
	Mods_2007_CJM_v5310  //06/28/07 `Make sure amounts display blank `Add new variables to display ad cost and project total
	// Modified by: costasmanousakis-(Designer)-(8/28/2007 15:40:24)
	Mods_2007_CM12_5301  //added ◊PRJ_SelectedBIN_txt
	// Modified by: costasmanousakis-(Designer)-(9/26/2007 12:33:04)
	Mods_2007_CM12_5301  //added var PRJ_CPComplDate_s
	Mods_2007_CJM_v5303  //r003 `10/09/07, 16:51:44`Chapter85
	Mods_2007_CJM_v5303  //r006 `11/06/07, 12:11:26
	Mods_2007_CJM_v54  //r002 `11/20/07, 12:42:38     `Fix display issues when new record is created
	Mods_2007_CJM_v54  //r003 `11/27/07, 15:35:40`Add NBI - Non NBI display variable
	Mods_2008_v55  //r004 `04/15/08, 16:32:10     
	Mods_2008_v55  //r005 `04/28/08, 11:24:34    
	Mods_2008_v55  //Copied to Server on : 06/20/08, 16:00:53   `r010 `06/02/08, 14:19:13  
	Mods_2008_December  //CJM `r001    `12/17/08, 12:55:04 `Add new page to project input form with project file and design contract information    
	Mods_2009_10  //r001 CJ Miller`10/01/09, 16:54:43  `Add Item 2 to page 0 (District)
	// Modified by: costasmanousakis-(Designer)-(6/16/11 11:00:56)
	Mods_2011_06
	//  `PRJ_Posting_s to A32
	// Modified by: Costas Manousakis-(Designer)-(12/23/13 10:47:31)
	Mods_2013_12
	//  `moved declarations of methods from Compiler_methods to here ; added PRJ_SETUTILITY
End if 
C_TEXT:C284(PRJ_DEBridgeNo_s)  // Command Replaced was o_C_STRING length was 28
C_TEXT:C284(PRJ_LastAction_txt; PRJ_Reviewer_txt)
C_LONGINT:C283(Button1; PRJ_AllowBinEntry_l; PRJ_AllowBridgeEntry_l; PRJ_Button_l; PRJ_DEProjectFileNo_l; PRJ_LastReviewer_l; PRJ_LastReview_l)
C_LONGINT:C283(SortColumn1_l; SortColumn2_l; SortColumn3_l; SortColumn4_l; SortColumn5_l; SortColumn6_l; SortColumn7_l; PRJ_ConsultantHList_l)
C_LONGINT:C283(PRJ_ADT_l; PRJ_Program_l; PRJ_SelectFederal_l; PRJ_FindBtn_l; PRJ_ContractID_l; PRJ_ConsultantButton_l)
C_LONGINT:C283(PRJ_PFFileID_L)
C_TEXT:C284(PRJ_EstimatedBid_txt; PRJ_Posting_txt; PRJ_RoadwayOver_txt; PRJ_ProjectReviewLast_txt; PRJ_SketchPlanLast_txt; PRJ_TypeStudyLast_txt; PRJ_ReportLast_txt)
C_TEXT:C284(PRJ_ConsultantName_txt; PRJ_SelectedBins_txt)
C_TEXT:C284(PRJ_RetrievedConstructionEWO_S; PRJ_ProjectReviewButtonTitle_s)  // Command Replaced was o_C_STRING length was 21
C_TEXT:C284(PRJ_OnSystemBridge_s; PRJ_NTPDate_s; PRJ_AwardDate_s; PRJ_BidOpeningDate_s; PRJ_InspectionDate_s; PRJ_ReportButtonTitle_s; PRJ_RatingReceivedDate_s; PRJ_RatingApprovedDate_s; PRJ_InspectionDate_s)  // Command Replaced was o_C_STRING length was 10
C_TEXT:C284(PRJ_ActualAdvertisedDate_s; PRJ_CPComplDate_s)  // Command Replaced was o_C_STRING length was 10
C_TEXT:C284(PRJ_TypeStudyButtonTitle_s)  // Command Replaced was o_C_STRING length was 14
C_TEXT:C284(PRJ_SketchPlansButtonTitle_s)  // Command Replaced was o_C_STRING length was 16
C_TEXT:C284(PRJ_Posting_s)  // Command Replaced was o_C_STRING length was 32
C_REAL:C285(PRJ_AASHTO_r)
C_TEXT:C284(PRJ_Item37_s)  // Command Replaced was o_C_STRING length was 80
C_TEXT:C284(PRJ_Detail_s)  // Command Replaced was o_C_STRING length was 23
C_TEXT:C284(PRJ_ConstuctionEWO_s; PRJ_ContractNumber_s)  // Command Replaced was o_C_STRING length was 50
C_TEXT:C284(PRJ_Material_s; PRJ_DeckArea_s)  // Command Replaced was o_C_STRING length was 50
C_TEXT:C284(PRJ_DEBin_s; PRJ_Owner_s)  // Command Replaced was o_C_STRING length was 3
C_TEXT:C284(PRJ_StructurallyDeficient_s)  // Command Replaced was o_C_STRING length was 6
C_TEXT:C284(PRJ_FWHASelect_s)  // Command Replaced was o_C_STRING length was 8
C_TEXT:C284(PRJ_DeckAreaUnits_s)  // Command Replaced was o_C_STRING length was 9
C_TEXT:C284(<>SelectionOption_txt; <>PRJ_SelectedData_txt; <>PRJ_SelectedBIN_txt)
C_TEXT:C284(PRJ_SQLRetrieveStats_txt)
C_TEXT:C284(PRJ_NBINonNBI_s)  // Command Replaced was o_C_STRING length was 7
C_TEXT:C284(PRJ_Item2_s)  // Command Replaced was o_C_STRING length was 2
C_LONGINT:C283(<>ProjectProcess_l; <>ProjectSelectionProcess_l)
C_BOOLEAN:C305(<>RESTART_B)
C_BOOLEAN:C305(ProjectChangesMade_b)
C_LONGINT:C283(PRJ_SRCH_ATTRIBUTEKEY_L)
C_TEXT:C284(PRJ_SRCH_ATTRIBUTEKEY_TXT)
C_TEXT:C284(PRJ_SRCH_BDEPT_S)  // Command Replaced was o_C_STRING length was 6
C_TEXT:C284(PRJ_SRCH_CONSLTANT_S)  // Command Replaced was o_C_STRING length was 80
C_TEXT:C284(PRJ_SRCH_CONTRACTOR_S)  // Command Replaced was o_C_STRING length was 80
C_TEXT:C284(PRJ_SRCH_DISTRNO_S)  // Command Replaced was o_C_STRING length was 80
C_TEXT:C284(PRJ_SRCH_EXPEDITERS_TXT)
C_TEXT:C284(PRJ_SRCH_PFILE_S)  // Command Replaced was o_C_STRING length was 10
C_TEXT:C284(PRJ_SRCH_PROGRAM_S)  // Command Replaced was o_C_STRING length was 80
C_TEXT:C284(PRJ_SRCH_RESULT_TXT)
C_TEXT:C284(PRJ_SRCH_SECTION_TXT)
C_LONGINT:C283(PRJ_SRCH_STATE)
C_LONGINT:C283(PRJ_SRCH_STRPRJMGR_L)
C_TEXT:C284(PRJ_SRCH_STRPRJMGR_S)  // Command Replaced was o_C_STRING length was 10
C_TEXT:C284(PRJ_SRCH_TOTALVARS_S)  // Command Replaced was o_C_STRING length was 80
C_TEXT:C284(PRJ_SRCH_TOWNNAME_S)  // Command Replaced was o_C_STRING length was 80
C_DATE:C307(PRJ_BPGM_ADDATE_D)
C_DATE:C307(PRJ_BPGM_DATEPR)
C_BOOLEAN:C305(PRJ_BPGM_LONGWAY_B)
C_LONGINT:C283(PRJ_BPGM_NUMSORT_L)
C_TEXT:C284(PRJ_BPGM_PRINTTITLE)
C_TEXT:C284(PRJ_PT_COMENTS_TXT)
C_TEXT:C284(PRJ_PT_EWO_S)  // Command Replaced was o_C_STRING length was 21
C_REAL:C285(PRJ_PT_HOURS_R)
C_TEXT:C284(PRJ_PT_SCOPE_S)  // Command Replaced was o_C_STRING length was 20
C_TEXT:C284(PRJ_PT_VALIDERRMSG_TXT)
C_DATE:C307(PRJ_PT_WEEKENDING_D)
C_LONGINT:C283(PRJ_SEARCHALL_RB)
C_LONGINT:C283(PRJ_SEARCHCURR_RB)
C_LONGINT:C283(PRJ_BD_BRGDATASHT_HL)
C_REAL:C285(PRJ_ORDERBYBRIDGE_L)
C_REAL:C285(PRJ_ORDERBYCITY_L)
C_REAL:C285(PRJ_ORDERBYFEDERALAID_L)
C_REAL:C285(PRJ_ORDERBYNONBRIDGE_L)
C_REAL:C285(PRJ_ORDERBYTEMP_L)
C_REAL:C285(PRJ_ORDERBYTYPE_L)
C_TEXT:C284(PRJ_PRIMARYBIN_TXT)
C_LONGINT:C283(PRJ_DONEBTN)
C_LONGINT:C283(PRJ_GOTOPRJINFO_FN)
C_LONGINT:C283(PRJ_CUSTOMSRCH)
C_LONGINT:C283(PRJ_SORTBUTTON)
C_LONGINT:C283(PRJ_SORTBUTTON1)
C_LONGINT:C283(PRJ_SORTBUTTON2)
C_TEXT:C284(PRJ_ROADWAYUNDER_TXT)
C_TEXT:C284(PRJ_UNDERCONSTR_TXT)
C_DATE:C307(PRJ_INITINSP_D)
C_TEXT:C284(PRJ_RATINGDONE_S)  // Command Replaced was o_C_STRING length was 3
C_LONGINT:C283(PRJ_GOTOPRJINFOCONTR_FN)
C_TEXT:C284(PRJ_STRUCTPRJMGR_TXT)
C_TEXT:C284(PRJ_BEAMUNITCOST_S)
C_LONGINT:C283(PRJ_ALLOWPROJECTENTRY_L)
C_TEXT:C284(PRJ_PRJMGRHISTORY_TXT)
C_LONGINT:C283(PRJ_SELECTBYDESIGNCONTRACT_L)
C_LONGINT:C283(PRJ_CHAPTER85_L)
C_TEXT:C284(PRJ_ADVERTISINGDATE_S)
C_LONGINT:C283(PRJ_SHOWADSTAT_L)
C_LONGINT:C283(PRJ_RELATEDQRS)
C_TEXT:C284(PRJ_PROJEXPEDITORSHORT_TXT)
C_TEXT:C284(PRJ_PROJISTOTALPGS_S)  // Command Replaced was o_C_STRING length was 10
C_TEXT:C284(PRJ_PRINTEWO_TXT)
C_TEXT:C284(PRJ_EDITACTION_TXT)
C_TEXT:C284(PRJ_FILEMESSAGE_TXT)
C_TEXT:C284(PRJ_CURRENTPRJMGR_TXT)
C_REAL:C285(PRJ_SELECTNAME_ATXT)
C_TEXT:C284(PRJ_DETAILINFO_TXT)
C_TEXT:C284(PRJ_DISTRNO_TXT)  // Command Replaced was o_C_STRING length was 2
C_BOOLEAN:C305(PRJ_RATINGDONE_B)
C_TEXT:C284(PRJ_WINTITLE)
C_TEXT:C284(PRJ_RTRV_CONTRACTNO_TXT)
C_LONGINT:C283(PRJ_RTRV_CONTRACTID_L)
C_BOOLEAN:C305(PRJ_PRINT_RELOADVARS_B)
C_BOOLEAN:C305(PRJ_WRT_INLIST_B)
C_DATE:C307(PRJ_LTR_SKLTRTODE_D)
C_TEXT:C284(PRJ_CURRENTACTION_TXT)
C_LONGINT:C283(PRJ_CURRENTRECNUM_L)
C_TEXT:C284(PRJ_DCPROJECTINFOAMOUNT_R)
C_TEXT:C284(PRJ_DCREMAININGAMOUNT_R)
C_BOOLEAN:C305(PRJ_DETAILSNEWRECORD_B)
C_BOOLEAN:C305(PRJ_2NDADDSUBRECORD_B)
C_TEXT:C284(PRJ_FiscalYear_s)  // Command Replaced was o_C_STRING length was 4
C_TEXT:C284(PRJ_ToCashierDate_s; PRJ_PlansFromPrintDate_s; PRJ_PlansToPrintDate_s; PRJ_SpecsFromPrintDate_s; PRJ_SpecsToPrintDate_s)  // Command Replaced was o_C_STRING length was 10
C_TEXT:C284(PRJ_MembershipGroup_txt)
C_LONGINT:C283(PRJ_Save_l; PRJ_Validate_l; PRJ_RemovePF_l; PRJ_SelectConsultant_l)
C_TEXT:C284(PRJ_AdCost_txt; PRJ_TotalProjCost_txt; PRJ_LowBid_txt)
C_TEXT:C284(NewBin_s)  // Command Replaced was o_C_STRING length was 3
C_TEXT:C284(PRJ_ExistSelected_txt; PRJ_NewSelected_txt)
C_TEXT:C284(PRJ_DCDescription_txt; PRJ_PFDescription_txt)
C_TEXT:C284(PRJ_DCContrFederalAidNos_s)  // Command Replaced was o_C_STRING length was 80
C_TEXT:C284(PRJ_DCActualAmount_s; PRJ_DCProjectInfoAmount_s; PRJ_DCRemainingAmount_s)  // Command Replaced was o_C_STRING length was 15
C_DATE:C307(PRJ_DCCompletion_d; PRJ_DCEstComplete_d)
C_TEXT:C284(PRJ_DENewValue_txt; <>PRJ_DENewValue_txt)
If (False:C215)
	
	C_BLOB:C604(PRJ_SetUpArraysForList; $0)
	C_BLOB:C604(PRJ_SetUpArraysForList; $1)
	
	C_TEXT:C284(PRJ_BD_OpenBridgeDataSheet; $1)  // was length of 3
	C_POINTER:C301(PRJ_BPGM_ClearOtherSrch; $1)
	C_LONGINT:C283(PRJ_BPGM_DoSort; $1)
	C_BOOLEAN:C305(PRJ_BPGM_ListDetailData; $1)
	C_POINTER:C301(PRJ_BPGM_SearchVar_OM; $1)
	C_POINTER:C301(PRJ_ControlReviewerChange; $1)
	C_TEXT:C284(PRJ_ControlReviewerChange; $2)
	C_POINTER:C301(PRJ_ControlReviewerChange; $3)
	C_TEXT:C284(PRJ_CreateIncludedBINRecord; $1)  // was length of 3
	C_TEXT:C284(PRJ_CreateIncludedBINRecord; $2)  // was length of 6
	C_POINTER:C301(PRJ_DC_OpenProjectDetail; $1)
	C_LONGINT:C283(PRJ_DC_OpenProjectDetail; $2)
	C_TEXT:C284(PRJ_FillPersonnelDropDowns; ${3})
	C_POINTER:C301(PRJ_FillPersonnelDropDowns; $1)
	C_POINTER:C301(PRJ_FillPersonnelDropDowns; $2)
	C_POINTER:C301(PRJ_FillReviewersDisplay; $1)
	C_LONGINT:C283(PRJ_FillReviewersDisplay; $2)
	C_TEXT:C284(PRJ_GetTableofListsSelection; $1)
	C_LONGINT:C283(PRJ_MakeSelection; $1)
	C_POINTER:C301(PRJ_MoveToAvailable; $1)
	C_POINTER:C301(PRJ_MoveToAvailable; $2)
	C_LONGINT:C283(PRJ_MoveToAvailable; $3)
	C_POINTER:C301(PRJ_MoveToSelected; $1)
	C_POINTER:C301(PRJ_MoveToSelected; $2)
	C_BOOLEAN:C305(PRJ_PT_ValidEntry; $0)
	C_TEXT:C284(PRJ_QR_ReturnBridge; $0)
	C_TEXT:C284(PRJ_QR_ReturnConsultant; $0)
	C_TEXT:C284(PRJ_QR_ReturnRoadwayOver; $0)
	C_TEXT:C284(PRJ_QR_ReturnRoadwayUnder; $0)
	C_BOOLEAN:C305(PRJ_SetEntry; $1)
	C_POINTER:C301(PRJ_SetProjectChangesMade; $1)
	C_POINTER:C301(PRJ_SetProjectChangesMade; $2)
	C_POINTER:C301(PRJ_SetProjectChangesMade; $3)
	C_TEXT:C284(PRJ_SetProjectChangesMade; $4)
	C_LONGINT:C283(PRJ_SetUpDetailDDs; $0)
	C_POINTER:C301(PRJ_SetUpDetailDDs; $1)
	C_POINTER:C301(PRJ_SetUpDetailDDs; $2)
	C_POINTER:C301(PRJ_SetUpStructuralPrjMgr; $1)
	C_LONGINT:C283(PRJ_SetUpStructuralPrjMgr; $2)
	C_LONGINT:C283(PRJ_SummaryAddDivider; $0)
	C_LONGINT:C283(PRJ_SummaryAddDivider; $1)
	C_TEXT:C284(ut_PRJCreateSketchPlan; $1)
	C_TEXT:C284(ut_PRJCreateSketchPlan; $2)
	C_TEXT:C284(ut_PRJCreateSketchPlan; $3)
	C_TEXT:C284(ut_PRJCreateSketchPlan; $4)
	C_LONGINT:C283(ut_PRJCreateSketchPlan; $5)
	C_LONGINT:C283(ut_PRJCreateStructuralReview; $1)
	C_LONGINT:C283(ut_PRJCreateStructuralReview; $2)
	C_TEXT:C284(ut_PRJCreateStructuralReview; $3)
	C_TEXT:C284(ut_PRJCreateStructuralReview; $4)
	C_TEXT:C284(ut_PRJCreateStructuralReview; $5)
	C_LONGINT:C283(ut_PRJCreateStructuralReview; $6)
	C_TEXT:C284(ut_PRJCreateTypeStudy; $1)
	C_TEXT:C284(ut_PRJCreateTypeStudy; $2)
	C_LONGINT:C283(ut_PRJCreateTypeStudy; $3)
	C_TEXT:C284(ut_PRJImportCreateBorePlan; $1)
	C_TEXT:C284(ut_PRJImportCreateBorePlan; $2)
	C_TEXT:C284(ut_PRJImportCreateGeotech; $1)
	C_TEXT:C284(ut_PRJImportCreateGeotech; $2)
	C_TEXT:C284(ut_PRJImportCreateHydraulic; $1)
	C_TEXT:C284(ut_PRJImportCreateHydraulic; $2)
	C_BLOB:C604(ut_PRJParseTextToArray; $0)
	C_TEXT:C284(ut_PRJParseTextToArray; $1)
	C_TEXT:C284(ut_PRJRemoveExtraCharacters; $0)
	C_TEXT:C284(ut_PRJRemoveExtraCharacters; ${-1})
	C_TEXT:C284(ut_PRJRemoveExtraCharacters; $1)
	C_TEXT:C284(ut_PRJRemoveExtraCharacters; $2)
	C_TEXT:C284(ut_PRJRemoveExtraCharacters; $3)
	C_TEXT:C284(ut_PRJRemoveExtraCharacters; $4)
	C_TEXT:C284(ut_PRJRemoveExtraCharacters; $5)
	C_BOOLEAN:C305(ut_PRJRetrieveCPName; $0)
	C_BOOLEAN:C305(ut_PRJRetrieveDesignContracts; $0)
	C_BOOLEAN:C305(ut_PRJRetrieveModifiedProjects; $0)
	C_BOOLEAN:C305(ut_PRJRetrieveOffice_EstAndOpen; $0)
	C_DATE:C307(ut_PRJReturnEarliestDate; $0)
	C_TEXT:C284(ut_PRJReturnEarliestDate; $1)
	C_BOOLEAN:C305(ut_PRJRetrieveDCAmounts; $0)
	C_POINTER:C301(ut_PRJ_ControlDDChange; $1)
	C_TEXT:C284(ut_PRJ_ControlDDChange; $2)
	C_POINTER:C301(ut_PRJ_ControlDDChange; $3)
	C_POINTER:C301(ut_PRJ_ControlDDChange; $4)
	C_POINTER:C301(ut_PRJ_ControlDDChange; $5)
	C_LONGINT:C283(ut_PRJ_ControlDDChange; $6)
	C_DATE:C307(ut_PRJ_SetDate; $0)
	C_TEXT:C284(ut_PRJ_SetDate; $1)
	C_TEXT:C284(ut_PRJ_IdentifyHighestGroup; $0)
	C_BOOLEAN:C305(PRJ_SetAccessButtonsPage_2; $1)
	C_BOOLEAN:C305(PRJ_ReturnAccessAllowed; $0)
	C_BOOLEAN:C305(ut_PRJRetrieveProjectFileData; $0)
	C_BOOLEAN:C305(PRJ_SetUpFederalReview; $1)
	C_TEXT:C284(ut_PRJSetWindowTitle; $1)
	C_POINTER:C301(ut_PRJSetWindowTitle; $2)
	C_TEXT:C284(ut_PRJUpdateDCAmounts; $1)
	C_TEXT:C284(ut_PRJUpdateDCAmounts; $2)
	C_REAL:C285(PRJ_ProjectStage; $0)
	C_BOOLEAN:C305(PRJ_SetPage0Detail; $1)
	C_TEXT:C284(ut_PRJUpdateFromImport; $0)
	C_BLOB:C604(ut_PRJUpdateFromImport; $1)
	C_BOOLEAN:C305(ut_PRJRetrieveAttributes; $0)
	C_BOOLEAN:C305(ut_PRJRetrievePRJxrefs; $0)
	C_BOOLEAN:C305(ut_PRJRetrievePRJ_Bridge; $0)
	C_TEXT:C284(ut_PRJNewFiscal; $0)
	C_POINTER:C301(ut_PRJCreateDCPFJoinRecord; $1)
	C_POINTER:C301(ut_PRJCreateDCPFJoinRecord; $2)
	C_POINTER:C301(ut_PRJCreateDCPFJoinRecord; $3)
	C_LONGINT:C283(PRJ_FillConsAndSetButton; $1)
	C_POINTER:C301(PRJ_SetConsultantToUse; $1)
	C_REAL:C285(PRJ_FillDCForDisplay; $0)
	C_BOOLEAN:C305(ut_PRJRetrieveProjTypes; $0)
	C_BOOLEAN:C305(ut_PRJGetCPAmounts; $0)
	C_TEXT:C284(ut_PRJCntrlRetrieveOfAmounts; $1)
	//UT_PRJRETRIEVEVENDORID
	C_BOOLEAN:C305(ut_PRJRetrieveVendorID; $0)
	//UT_PRJRETRIEVEPROJECTEVENTS
	C_BOOLEAN:C305(ut_PRJRetrieveProjectEvents; $0)
	C_LONGINT:C283(PRJ_LTR_BrgSketch_fill; $1)
	C_TEXT:C284(PRJ_LTR_BrgSketch_fill; $2)
	C_TEXT:C284(PRJ_LTR_BrgSketch_fill; $3)
	C_TEXT:C284(PRJ_LTR_BrgSketch_fill; $4)
	C_TEXT:C284(PRJ_LTR_BrgSketch_fill; $5)
	C_LONGINT:C283(PRJ_LTR_BrgSketch_fill; $6)
	C_TEXT:C284(PRJ_LTR_BrgSketch_fill; $7)
	C_LONGINT:C283(PRJ_LTR_FHA_fill; $1)
	C_TEXT:C284(PRJ_LTR_FHA_fill; $2)
	C_TEXT:C284(PRJ_LTR_FHA_fill; $3)
	C_TEXT:C284(PRJ_LTR_FHA_fill; $4)
	C_TEXT:C284(PRJ_LTR_FHA_fill; $5)
	C_LONGINT:C283(PRJ_LTR_FHA_fill; $6)
	C_TEXT:C284(PRJ_LTR_FHA_fill; $7)
	C_LONGINT:C283(PRJ_LTR_PSEAPP_fill; $1)
	C_TEXT:C284(PRJ_LTR_PSEAPP_fill; $2)
	C_TEXT:C284(PRJ_LTR_PSEAPP_fill; $3)
	C_TEXT:C284(PRJ_LTR_PSEAPP_fill; $4)
	C_TEXT:C284(PRJ_LTR_PSEAPP_fill; $5)
	C_LONGINT:C283(PRJ_LTR_PSEAPP_fill; $6)
	C_TEXT:C284(PRJ_WRT_ProjectLetters; $1)  // was length of 80
	C_LONGINT:C283(PRJ_LTR_RevwCmmt_fill; $1)
	C_TEXT:C284(PRJ_LTR_RevwCmmt_fill; $2)
	C_TEXT:C284(PRJ_LTR_RevwCmmt_fill; $3)
	C_TEXT:C284(PRJ_LTR_RevwCmmt_fill; $4)
	C_TEXT:C284(PRJ_LTR_RevwCmmt_fill; $5)
	C_LONGINT:C283(PRJ_LTR_RevwCmmt_fill; $6)
	C_TEXT:C284(PRJ_LTR_RevwCmmt_fill; $7)
	C_DATE:C307(PRJ_LTR_SktchSubmDate; $0)
	C_TEXT:C284(PRJ_ShowAdPrjStatus; $1)
	C_POINTER:C301(PRJ_LTR_LetterDate; $1)
	C_TEXT:C284(PRJ_LTR_LetterDate; $2)
	C_BOOLEAN:C305(PRJ_SetChapter85Access; $1)
	C_POINTER:C301(PRJ_BPGM_LoadArrays_2; $1)
	C_TEXT:C284(PRJ_UpdateLastAction; $1)
	C_TEXT:C284(PRJ_SetUpUnasssignedBins; $1)
	C_POINTER:C301(PRJ_MoveSelectedArray; $1)
	C_POINTER:C301(PRJ_MoveSelectedArray; $2)
	C_POINTER:C301(PRJ_MoveSelectedArray; $3)
	C_POINTER:C301(PRJ_MoveSelectedArray; $4)
	C_POINTER:C301(PRJ_MoveSelectedArray; $5)
	C_POINTER:C301(PRJ_MoveSelectedArray; $6)
	C_TEXT:C284(PRJ_ProcessExisting; $1)  // was length of 6
	C_LONGINT:C283(PRJ_CreateNewIncludeBIN; $1)
	C_TEXT:C284(PRJ_QR_ReturnAttributes; $0)
	C_TEXT:C284(PRJ_QR_ReturnAttributes; $1)
	C_TEXT:C284(PRJ_QRSDFOStatus; $0)
	C_TEXT:C284(PRJ_QRBINList; $0)
	C_LONGINT:C283(PRJ_QR_NumBridgesSamePFILE; $0)
	C_LONGINT:C283(PRJ_QR_NumBridgesSamePFILE; $1)
	C_LONGINT:C283(PRJ_QRNoBINs; $0)
	C_TEXT:C284(PRJ_QRNoBINs; $1)
	C_REAL:C285(PRJ_QRNoBINs; $2)
	C_REAL:C285(PRJ_QRNoBINs; $3)
	C_TEXT:C284(PRJ_QR_BridgeRank; $0)
	C_BOOLEAN:C305(PRJ_QR_BridgeRank; $1)
	C_BOOLEAN:C305(PRJ_QR_BridgeRank; $2)
	C_TEXT:C284(PRJ_GetDataSheetFedAidNos; $0)
	//PRJ_QR_BRIDGERANK
	C_LONGINT:C283(PRJ_QR_BridgeRank; $3)
	C_TEXT:C284(PRJ_SETUTILITY; $1)
	C_LONGINT:C283(PRJ_ReturnFileNumber; $0)
	C_LONGINT:C283(PRJ_ReturnFileNumber; $1)
	
	C_TEXT:C284(ut_PRJ_CreateFolderPath; $0)
	C_TEXT:C284(ut_PRJ_CreateFolderPath; $1)
	C_TEXT:C284(ut_PRJ_CreateFolderPath; $2)
	
	C_TEXT:C284(ut_TestandCreateFolder; $0)
	C_TEXT:C284(ut_TestandCreateFolder; $1)
	
	C_BLOB:C604(PRJ_SetUpDetailList; $1; $0)
	
	C_TEXT:C284(PRJ_LB_ReturnBridgeNo; $0)
	C_POINTER:C301(PRJ_LB_ReturnBridgeNo; $1; $2; $3)
	
	C_POINTER:C301(PRJ_PrintFromOutput_LB; $1)
	C_TEXT:C284(PRJ_PrintFromOutput_LB; $2; $3)
	
	C_TEXT:C284(PRJ_DesignContractLBReturnName; $0)
	C_TEXT:C284(PRJ_DetailsResetLBArrays; $1)
	
End if 
//End Compiler_PRJ
