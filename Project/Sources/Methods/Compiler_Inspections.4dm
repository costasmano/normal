//%attributes = {"invisible":true}
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 02/14/13, 14:25:05
//----------------------------------------------------
//Method: COMPILER_Inspections
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2013_02  //r001 ` 
	//Modified by: Charles Miller (2/14/13 14:25:07)
	// Modified by: Costas Manousakis-(Designer)-(5/1/13 13:57:30)
	Mods_2013_05
	//  `INSP_Inspection_list_txt
	// Modified by: Costas Manousakis-(Designer)-(9/9/13 13:49:19)
	Mods_2013_09
	//  `INSP_TunnelStructType_txt
	// Modified by: Costas Manousakis-(Designer)-(9/30/13 11:08:50)
	Mods_2013_09
	//  `
	// Modified by: Costas Manousakis-(Designer)-(10/22/13 10:44:15)
	Mods_2013_10
	//  `added boolean indicating that page count has been done and method INSP_IsInspRoutine_b
	// Modified by: Costas Manousakis-(Designer)-(10/31/13 16:07:45)
	Mods_2013_10
	//  `Added variables for the sort buttons ion the inspreview form
	// Modified by: Costas Manousakis-(Designer)-(11/8/13 14:26:05)
	Mods_2013_11
	//  `added def for INSP_SavePhoto
	// Modified by: Costas Manousakis-(Designer)-(12/3/13 09:50:53)
	Mods_2013_12
	//  `added G_InspExtraCmtsBtn and moved method declarations from Compiler_methods
	// Modified by: Costas Manousakis-(Designer)-(2/18/14 14:21:05)
	Mods_2014_02
	//  `Freeze thaw vars
	// Modified by: Costas Manousakis-(Designer)-(4/14/14 17:09:05)
	Mods_2014_04
	//  `INSP_CountSpMbOnForm and  INSP_SetSpMbPrintForm
	// Modified by: Costas Manousakis-(Designer)-(4/15/14 15:32:04)
	Mods_2014_04
	//  `added INSP_MBTABridgeType_txt ; INSP_ElmtLoadRated_OM
	//  `added INSP_LoadElmRtgDefs ; INSP_SetElmRatingValue
	// Modified by: Costas Manousakis-(Designer)-(6/17/14 16:20:47)
	Mods_2014_06_bug
	//  `Added code to print the Orientation text if it does not fit on page 1
	// Modified by: Costas Manousakis-(Designer)-(1/16/15 11:28:24)
	Mods_2015_01
	//  `added  C_DATE(◊INSPFORMREVDATE_8)
	//  `added  INSP_FieldWorkComplCheck
	// Modified by: Costas Manousakis-(Designer)-(10/23/15 17:29:07)
	Mods_2015_10_bug
	//  `added INSP_DWNLD_ElmtRR_ratings
	// Modified by: Costas Manousakis-(Designer)-(5/23/16 14:18:20)
	Mods_2016_05
	//  `moved  declarations from Compiler_methods
	// Modified by: Costas Manousakis-(Designer)-(9/28/16 15:52:57)
	Mods_2016_09
	//  `added Insp_PrintRemarks
	// Modified by: Costas Manousakis-(Designer)-(11/16/16 10:41:33)
	Mods_2016_11
	//  `added INSP_ImageNavigation_OM  and  INSP_ElementNavigation_OM
	// Modified by: Costas Manousakis-(Designer)-(12/9/16 12:34:10)
	Mods_2016_12
	//  `added INSP_CheckImages
	Mods_2017_05  //  //Add code to allow for re-import of converted pictures. Also seperate options into pop menu
	//Modified by: Chuck Miller (5/9/17 14:51:24)
	Mods_2019_04  //change to Listboxes on inspection forms
	//Changed from template to on form for header buttons
	//changed first/prev/next/last buttons to no action
	//Modified by: Chuck Miller (4/23/19 16:40:07)
	Mods_2021_01  //Add code that will create PDFs of all [Inspections]InspApproved=2
	
End if 
If (Not:C34(Is compiled mode:C492))
	C_TEXT:C284(WP_3S2_S)  // Command Replaced was o_C_STRING length was 8
	C_TEXT:C284(WP_3_S)  // Command Replaced was o_C_STRING length was 8
	C_TEXT:C284(WP_H20_S)  // Command Replaced was o_C_STRING length was 8
	C_TEXT:C284(WP_H_S)  // Command Replaced was o_C_STRING length was 8
	C_TEXT:C284(WP_SINGLE_S)  // Command Replaced was o_C_STRING length was 8
	C_LONGINT:C283(vSortBrMIlePost)
	C_TEXT:C284(INSP_Inspection_list_txt)
	C_TEXT:C284(INSP_TunnelStructType_txt)
	C_TEXT:C284(INSP_TunnelSp1Desc_s; INSP_TunnelSp2Desc_s; INSP_TunnelSp3Desc_s)  // Command Replaced was o_C_STRING length was 255
	C_TEXT:C284(INSP_SpecMemFreqCheck_txt)
	C_LONGINT:C283(INSP_TunnelSp1Freq_L; INSP_TunnelSp2Freq_L; INSP_TunnelSp3Freq_L; INSP_TunnelSpecMemReq_L)
	C_BOOLEAN:C305(INSP_TunnelSpMDataChg_b)
	C_LONGINT:C283(INSP_TunnelSpMStack_L)
	C_BOOLEAN:C305(INSP_PageCountDone_b)
	C_LONGINT:C283(SortBdept; SortBIN; SorttmLdr; SortInspType; SortInspDate; SortInspCompl; SortInspApprove; SortInspReview)  //Command Replaced was o_C_INTEGER
End if 
C_BOOLEAN:C305(INSP_CreatePDFsofApproved_B; Insp_PrintLandscapeRotated)
ARRAY TEXT:C222(PictureList_atxt; 0)
C_TEXT:C284(ConvertedPicturePath_txt; StartFolder_txt)
C_LONGINT:C283(FRZACTION_1_L)
C_TEXT:C284(FRZACTION_1_TXT)
C_LONGINT:C283(FRZACTION_2_L)
C_TEXT:C284(FRZACTION_2_TXT)
C_LONGINT:C283(FRZACTION_3_L)
C_TEXT:C284(FRZACTION_3_TXT)
C_LONGINT:C283(FRZACTION_4_L)
C_TEXT:C284(FRZACTION_4_TXT)
C_TEXT:C284(FRZDESC_1_TXT)
C_TEXT:C284(FRZDESC_2_TXT)
C_TEXT:C284(FRZDESC_3_TXT)
C_TEXT:C284(FRZDESC_4_TXT)
C_TEXT:C284(FRZFIELDTESTS_TXT)
C_LONGINT:C283(FRZNA_1_L)
C_LONGINT:C283(FRZNA_2_L)
C_LONGINT:C283(FRZNA_3_L)
C_LONGINT:C283(FRZNA_4_L)
C_LONGINT:C283(FRZNOACTION_1_L)
C_LONGINT:C283(FRZNOACTION_2_L)
C_LONGINT:C283(FRZNOACTION_3_L)
C_LONGINT:C283(FRZNOACTION_4_L)
C_LONGINT:C283(FRZNOACTION_L)
C_LONGINT:C283(FRZNOPROBLEM_L)
C_LONGINT:C283(FRZNOPROB_1_L)
C_LONGINT:C283(FRZNOPROB_2_L)
C_LONGINT:C283(FRZNOPROB_3_L)
C_LONGINT:C283(FRZNOPROB_4_L)
C_LONGINT:C283(FRZNOTAPPL_L)
C_LONGINT:C283(FRZPROB_1_L)
C_TEXT:C284(FRZPROB_1_TXT)
C_LONGINT:C283(FRZPROB_2_L)
C_TEXT:C284(FRZPROB_2_TXT)
C_LONGINT:C283(FRZPROB_3_L)
C_TEXT:C284(FRZPROB_3_TXT)
C_LONGINT:C283(FRZPROB_4_L)
C_TEXT:C284(FRZPROB_4_TXT)
C_LONGINT:C283(FRZ_DISTNO)
C_TEXT:C284(FRZ_ELEMENTDESC_TXT)
C_TEXT:C284(FRZ_LIST1FILE)
C_TEXT:C284(FRZ_LIST2FILE)
C_TEXT:C284(FRZ_LIST3FILE)
C_TEXT:C284(FRZ_LIST_1_S)
C_TEXT:C284(FRZ_LIST_2_S)
C_TEXT:C284(FRZ_LIST_3_S)
C_LONGINT:C283(FRZ_PROBLEM_NO)
C_LONGINT:C283(FRZ_PROBLEM_YES)
C_LONGINT:C283(FRZ_FURTHERACTION)
C_BOOLEAN:C305(FRZ_OrientationOnPg1_b)
C_TEXT:C284(FRZ_OrientationPg1_txt)
C_DATE:C307(<>INSPFORMREVDATE_1)
C_DATE:C307(<>INSPFORMREVDATE_2)
C_DATE:C307(<>INSPFORMREVDATE_3)
C_DATE:C307(<>INSPFORMREVDATE_4)
C_DATE:C307(<>INSPFORMREVDATE_5)
C_DATE:C307(<>INSPFORMREVDATE_6)
C_DATE:C307(<>INSPFORMREVDATE_7)
C_DATE:C307(<>INSPFORMREVDATE_8)
ARRAY TEXT:C222(MBTA_Queryby_atxt; 0)
ARRAY TEXT:C222(aI62aCollisionDamage; 0)  //Command Replaced was o_ARRAY string length was 20
ARRAY TEXT:C222(aI62bCollisionDamage; 0)  //Command Replaced was o_ARRAY string length was 20
C_TEXT:C284(INSP_MBTABridgeType_txt)
C_TEXT:C284(INSP_RevenueLbl_txt)
C_TEXT:C284(INSP_WorkCarLbl_txt)
C_TEXT:C284(INSP_PR_RevenueLbl_txt)
C_TEXT:C284(INSP_PR_WorkCarLbl_txt)
C_TEXT:C284(INSP_RevenueINPLbl_txt; INSP_WorkCarINPLbl_txt)
C_DATE:C307(<>Insp_ESignatureStart)

C_OBJECT:C1216(<>INSP_WPAreaZoom_o)

C_OBJECT:C1216(INSP_InspTypeElems_o)

C_OBJECT:C1216(SpellCheckAllData_o)

If (False:C215)
	C_POINTER:C301(INSP_AddInspRecs; $1)
	C_TEXT:C284(INSP_AddInspRecs; $2)
	C_TEXT:C284(INSP_Read_Write_Tables; $1)
	C_LONGINT:C283(INSP_SpMemFreqChk_FM; $1)
	C_BOOLEAN:C305(INSP_IsInspRoutine_b; $0)
	C_TEXT:C284(INSP_IsInspRoutine_b; $1)
	C_TEXT:C284(INSP_SavePhoto; $1)
	C_LONGINT:C283(INSP_ReturnCMLength; $0)
	C_LONGINT:C283(INSP_FCPrPg1_FM; $1)
	C_TEXT:C284(G_InspExtraCmtsBtn; $1)  // was length of 132
	C_POINTER:C301(G_InspExtraCmtsBtn; $2)
	C_POINTER:C301(G_InspExtraCmtsBtn; $3)
	C_LONGINT:C283(G_InspExtraCmtsBtn; $4)
	C_LONGINT:C283(G_InspParagProt; $1)
	C_LONGINT:C283(G_InspParagProt; $2)
	C_LONGINT:C283(G_InspParagProt; $3)
	C_LONGINT:C283(G_InspParagProt; $4)
	C_LONGINT:C283(G_InspParagProt; $5)
	C_TEXT:C284(G_InspParagProt; $6)  // was length of 132
	C_BOOLEAN:C305(G_InspGetRatings; $1)
	C_BOOLEAN:C305(G_Insp_SetDirLbl; $1)
	C_LONGINT:C283(G_Insp_CountSpMs; $0)
	C_TEXT:C284(G_Insp_SetTitle; $0)  // was length of 255
	C_POINTER:C301(G_Insp_ReplyRevCmts; $1)
	C_TEXT:C284(G_Insp_ReplyRevCmts; $2)  // was length of 80
	C_LONGINT:C283(G_Insp_AddOrientation; $1)
	C_LONGINT:C283(G_Insp_AddGenCmts; $1)
	C_BOOLEAN:C305(G_Insp_LockFormOnOff; $1)
	C_BOOLEAN:C305(f_Insp_Revision1; $0)
	C_DATE:C307(f_Insp_Revision1; $1)
	C_BOOLEAN:C305(f_Insp_Revision2; $0)
	C_DATE:C307(f_Insp_Revision2; $1)
	C_BOOLEAN:C305(f_Insp_Revision3; $0)
	C_DATE:C307(f_Insp_Revision3; $1)
	C_BOOLEAN:C305(f_Insp_Revision5; $0)
	C_DATE:C307(f_Insp_Revision5; $1)
	C_BOOLEAN:C305(f_Insp_Revision6; $0)
	C_DATE:C307(f_Insp_Revision6; $1)
	C_LONGINT:C283(G_Insp_ApplyLineSpacing; $1)
	C_POINTER:C301(G_Insp_RelateInsp; ${1})
	C_TEXT:C284(G_Insp_VerifyItem; $0)  // was length of 2
	C_TEXT:C284(G_Insp_VerifyItem; $1)  // was length of 2
	C_TEXT:C284(G_Insp_ReviewUtils; $1)
	C_POINTER:C301(INSP_CheckLinks; $1)
	C_BOOLEAN:C305(INSP_GetUWValues_Btn; $1)
	C_POINTER:C301(INSP_BuildTmMbrArea; $1)
	C_POINTER:C301(INSP_UWDate_OM; $1)
	C_LONGINT:C283(INSP_SortByTmLeader; $1)
	C_LONGINT:C283(INSP_SortbyBDEPT; $1)
	C_TEXT:C284(INSP_GetUserAgency; $0)
	C_POINTER:C301(INSP_InitDwnlFldPtrArr; ${2})
	C_LONGINT:C283(INSP_InitDwnlFldPtrArr; $1)
	C_LONGINT:C283(INSP_LogTableChanges; $1)
	C_POINTER:C301(INSP_LogTableChanges; $2)
	C_POINTER:C301(INSP_LogTableChanges; $3)
	C_POINTER:C301(INSP_LogTableChanges; $4)
	C_LONGINT:C283(INSP_LogTableChanges; $5)
	C_LONGINT:C283(INSP_ViewAllComments; $1)
	C_TEXT:C284(INSP_Item107Desc; $1)
	C_TEXT:C284(INSP_Item43Desc; $1)
	C_BOOLEAN:C305(INSP_ConvertSKCH; $1)
	C_BOOLEAN:C305(INSP_PrintSketchChartSingle; $0)
	C_BOOLEAN:C305(INSP_PrintSketchChartSingle; $1)
	C_BOOLEAN:C305(INSP_PrintSketchChartSingle; $2)
	C_BOOLEAN:C305(INSP_PrintSketchChart; $0)
	C_BOOLEAN:C305(INSP_PrintSketchChart; $1)
	C_LONGINT:C283(INSP_PrintSketchChart; $2)
	C_BOOLEAN:C305(INSP_CheckSpcMfrFreq; $0)
	C_TEXT:C284(INSP_CheckSpcMfrFreq; $1)
	C_POINTER:C301(INSP_SpcFreqColorSet; $1)
	C_BOOLEAN:C305(INSP_VerifySIAChanges; $0)
	C_LONGINT:C283(INSP_VerifySIAChanges; $1)
	C_TEXT:C284(INSP_ElmtSfty_ItemNo; $0)
	C_LONGINT:C283(INSP_ElmtSfty_ItemNo; $1)
	C_BOOLEAN:C305(INSP_ElmtSfty_ItemNo; $2)
	C_TEXT:C284(INSP_UpdateInspList; $1)  // was length of 3
	C_LONGINT:C283(INSP_4DWRITE_SaveToFld; $1)
	C_POINTER:C301(INSP_4DWRITE_SaveToFld; $2)
	C_LONGINT:C283(INSP_4DWRITE_SaveToFld; $3)
	C_LONGINT:C283(INSP_Comments_OM; $1)
	C_POINTER:C301(INSP_Comments_OM; $2)
	C_REAL:C285(INSP_Comments_OM; $3)
	C_TEXT:C284(INSP_FRZElmtDesc; $0)
	C_LONGINT:C283(INSP_FRZElmtDesc; $1)
	C_LONGINT:C283(INSP_FRZ_PrintCmts; $0)
	C_BOOLEAN:C305(INSP_FRZ_PrintCmts; $1)
	C_TEXT:C284(INSP_ElmtDescUtil; $1)
	C_TEXT:C284(INSP_HICalcControl; $1)
	C_LONGINT:C283(INSP_HICalcControl; $2)
	C_TEXT:C284(INSP_PontisCTRL; $1)
	C_LONGINT:C283(INSP_CalcHI_BTN_OM; $1)
	C_BOOLEAN:C305(INSP_Approved_b; $0)
	C_TEXT:C284(INSP_Approved_b; $1)  // was length of 3
	C_LONGINT:C283(INSP_Approved_b; $2)
	C_LONGINT:C283(INSP_Approved_b; $3)
	C_LONGINT:C283(INSP_PrintInspBtn_OM; $1)
	C_BOOLEAN:C305(INSP_UserAllowed; $0)
	C_TEXT:C284(INSP_UserAllowed; $1)
	C_LONGINT:C283(INSP_PrintQAForm_OM; $1)
	C_LONGINT:C283(INSP_AddElmtCat2HL; $1)
	C_TEXT:C284(INSP_AddElmtCat2HL; $2)  // was length of 3
	C_BOOLEAN:C305(INSP_ResetButton; $1)
	C_TEXT:C284(INSP_ResetButton; $2)
	C_TEXT:C284(INSP_ResetButton; $3)
	C_TEXT:C284(INSP_ResetButton; $4)
	C_TEXT:C284(INSP_InspReviewControl; $1)
	C_TEXT:C284(INSP_MyReviewInspections; $0)
	C_BOOLEAN:C305(INSP_GetReviewRules; $0)
	C_TEXT:C284(INSP_GetReviewRules; $1)
	C_TEXT:C284(INSP_GetReviewRules; $2)
	C_POINTER:C301(INSP_GetReviewRules; $3)
	C_POINTER:C301(INSP_GetReviewRules; $4)
	C_POINTER:C301(INSP_GetReviewRules; $5)
	C_TEXT:C284(INSP_GetReviewRules; $6)
	C_POINTER:C301(INSP_GetReviewRules; $7)
	C_POINTER:C301(INSP_GetReviewRules; $8)
	C_BOOLEAN:C305(INSP_ReviewerAllowed_b; $0)
	C_TEXT:C284(INSP_ReviewerAllowed_b; $1)
	C_LONGINT:C283(INSP_ReviewerAllowed_b; $2)
	C_BOOLEAN:C305(INSP_CheckCompleteness; $0)
	C_LONGINT:C283(INSP_CheckCompleteness; $1)
	C_BOOLEAN:C305(INSP_DeleteLocalInsp; $0)
	C_BOOLEAN:C305(INSP_DownLoadInsp; $0)
	C_LONGINT:C283(INSP_DownLoadInsp; $1)
	C_LONGINT:C283(INSP_DownloadMissing; $0)
	C_BOOLEAN:C305(INSP_DownloadMissing; $1)
	C_BOOLEAN:C305(INSP_DWNLD_InspRec; $0)
	C_BOOLEAN:C305(INSP_DWNLD_PontisRec; $0)
	C_BOOLEAN:C305(INSP_DWNLD_PONTmMembers; $0)
	C_BOOLEAN:C305(INSP_DWNLD_Task; $0)
	C_TEXT:C284(INSP_DWNLD_Task; $1)
	C_BOOLEAN:C305(INSP_DWNLD_TmMembers; $0)
	C_LONGINT:C283(INSP_CommentTools; $1)
	//INSP_INSPTYPESUTIL
	C_TEXT:C284(INSP_InspTypesUtil; $0)
	C_TEXT:C284(INSP_InspTypesUtil; $1)
	C_TEXT:C284(INSP_InspTypesUtil; $2)
	//INSP_ITEM44DESC
	C_TEXT:C284(INSP_Item44Desc; $1)
	//INSP_FORMATTITLE_NEW
	C_LONGINT:C283(INSP_FormatTitle_new; $1)
	C_LONGINT:C283(FRZ_PrintPageUtil; $1)
	C_LONGINT:C283(FRZ_PrintPageUtil_A; $1)
	C_LONGINT:C283(INSP_CountSpMbOnForm; $0)
	C_TEXT:C284(INSP_SetSpMbPrintForm; $1)
	C_POINTER:C301(INSP_SetSpMbPrintForm; $2)
	C_POINTER:C301(INSP_SetSpMbPrintForm; $3)
	C_POINTER:C301(INSP_SetSpMbPrintForm; $4)
	C_POINTER:C301(INSP_SetSpMbPrintForm; $5)
	C_LONGINT:C283(INSP_ElmtLoadRated_OM; $1)
	C_LONGINT:C283(INSP_RailFCPg1_FM; $1)
	C_LONGINT:C283(INSP_LoadElmRtgDefs; $0)
	C_POINTER:C301(INSP_LoadElmRtgDefs; $1)
	C_POINTER:C301(INSP_LoadElmRtgDefs; $2)
	C_POINTER:C301(INSP_SetElmRatingValue; $1)
	C_REAL:C285(INSP_SetElmRatingValue; $2)
	C_POINTER:C301(INSP_GetTransitLoadDesc; $1)
	C_POINTER:C301(INSP_GetTransitLoadDesc; $2)
	C_LONGINT:C283(INSP_GetTransitLoadDesc; $3)
	C_TEXT:C284(INSP_SetTransitRtgLabels; $1)
	C_TEXT:C284(INSP_SetTransitRtgLabels; $2)
	C_TEXT:C284(INSP_FieldWorkComplCheck; $0)
	C_BOOLEAN:C305(INSP_DWNLD_ElmtRR_ratings; $0)
	C_LONGINT:C283(G_AddElmtTxt2Area; $1)
	C_TEXT:C284(G_AddElmtTxt2Area; $2)  // was length of 132
	C_BLOB:C604(G_AddElmtTxt2Area; $3)
	C_TEXT:C284(G_GetElmtLabel; $0)  // was length of 132
	C_BOOLEAN:C305(G_GetElmtLabel; $1)
	C_TEXT:C284(GetParentPrefix; $0)  // was length of 4
	C_LONGINT:C283(GetParentPrefix; $1)
	C_TEXT:C284(GetParentDescription; $0)  // was length of 255
	C_LONGINT:C283(GetParentDescription; $1)
	C_LONGINT:C283(Insp_PrintRemarks; $1)
	C_TEXT:C284(Insp_PrintRemarks; $2)
	C_TEXT:C284(INSP_ImageNavigation_OM; $1)  //
	C_TEXT:C284(INSP_ImageNavigation_OM; $2)  //
	C_TEXT:C284(INSP_ElementNavigation_OM; $1)  //
	C_TEXT:C284(INSP_ElementNavigation_OM; $2)  //
	C_TEXT:C284(INSP_CheckImages; $0)
	C_BOOLEAN:C305(INSP_Data2Inventory; $0)
	C_POINTER:C301(INSP_Data2InventoryCheck; $1)
	C_POINTER:C301(INSP_Data2InventoryCheck; $2)
	C_POINTER:C301(INSP_Data2InventoryCheck; $3)
	C_POINTER:C301(INSP_Data2InventoryCheck; $4)
	C_BOOLEAN:C305(INSP_Data2InventoryCheck; $5)
	//C_TEXT(INSP_FillIncompleteInsp ;$0)
	//C_POINTER(INSP_FillIncompleteInsp ;$1)
	//C_POINTER(INSP_FillIncompleteInsp ;$2)
	//C_POINTER(INSP_FillIncompleteInsp ;$3)
	C_LONGINT:C283(INSP_PostingEntry; $1)
	C_POINTER:C301(INSP_PostingEntry; $2)
	C_OBJECT:C1216(SelectInvPhotoData_o)
	C_TEXT:C284(INSP_CheckInvPhotoSelected; $0)
	C_BOOLEAN:C305(INSP_IsElementLoadRated; $0)
	C_POINTER:C301(INSP_IsElementLoadRated; $1)
	C_TEXT:C284(INSP_FitPictToFormObj; $1)
	C_POINTER:C301(INSP_FitPictToFormObj; $2)
	C_LONGINT:C283(FM_RoutineCombinedInput; $1)
	C_LONGINT:C283(FM_StandardPhotosInput; $1)
	
	C_LONGINT:C283(INSP_ElmSft_Input_FM; $1)
	
	C_LONGINT:C283(INSP_StdPhotoType_OM; $1)
	
	C_LONGINT:C283(ES_ReturnBackgroundColor; $0)
	C_LONGINT:C283(ES_ReturnFontColor; $0)
	C_LONGINT:C283(ES_ReturnStyle; $0)
	
	C_TEXT:C284(INSP_MoveImages; $1)
	C_POINTER:C301(INSP_DropImageEvent; $1)  //pointer to image type
	
	C_TEXT:C284(InspectionTypeToForm; $0)
	
	C_LONGINT:C283(CU_SetRowStyle; $1)
	C_LONGINT:C283(CU_SetLBFormat; $0)
	C_LONGINT:C283(CU_SetLBFormat; $1)
	
	C_LONGINT:C283(FM_CondUnitsIn; $1)
	
	C_LONGINT:C283(INSP_GetDefaultDBIE; $0)
	C_TEXT:C284(INSP_GetDefaultDBIE; $1)
	
	C_LONGINT:C283(INSP_GetDefaultUOE; $0)
	C_TEXT:C284(INSP_GetDefaultUOE; $1)
	
	C_LONGINT:C283(INSP_ElemSftySUB_FM; $1)
	C_LONGINT:C283(INSP_ImageSubForm_FM; $1)
	C_LONGINT:C283(PON_PonElemInspSubForm_FM; $1)
	C_LONGINT:C283(CU_CondUnitsSubForm_FM; $1)
	
	C_TEXT:C284(INSP_addTeamLeaders; $1)
	C_TEXT:C284(INSP_addTeamLeaders; $2)
	
	C_BOOLEAN:C305(INSP_PrintToPDF; $1)
	C_POINTER:C301(INSP_PrintToPDF; $2; $3)
	C_TEXT:C284(INSP_PrintToPDF; $4; $5)
	
	C_OBJECT:C1216(INSP_GetConsProjMgr; $1)
	
	C_OBJECT:C1216(INSP_QCSaveApprovalInfo; $1)
	
	C_TEXT:C284(PHOTO_ViewSIAorConsultantPages; $1)
	C_TEXT:C284(PHOTO_DelSIAorConsultantPages; $1)
	C_TEXT:C284(PHOTO_LoadSIAorConsultantPages; $1)
	
	C_TEXT:C284(INSP_QCAddNoticeToMsg; $0)
	C_TEXT:C284(INSP_QCAddNoticeToMsg; $1)
	
	C_TEXT:C284(INSP_GetElmtNumber; $0)
	C_LONGINT:C283(INSP_GetElmtNumber; $1)
	
	C_TEXT:C284(INSP_GetParentPrefix; $0)
	C_LONGINT:C283(INSP_GetParentPrefix; $1)
	
	C_OBJECT:C1216(INSP_CountInspImages; $0)
	C_LONGINT:C283(INSP_CountInspImages; $1)
	
	C_POINTER:C301(INSP_CreateAdditionalPages; $1; $2)
	
	C_TEXT:C284(insp_RemovePreviousPDF; $1)
	
End if 


//End COMPILER_Inspections