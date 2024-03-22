//%attributes = {"invisible":true}
//Method: Compiler_NTI
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
	//----------------------------------------------------
	//User name (OS): administrator
	//Date and time: 10/20/15, 16:44:28
	//----------------------------------------------------
	Mods_2015_11  //Add new method of assigning Tunnel number
	//Modified by: administrator (11/10/15 16:45:30)
	// Modified by: Costas Manousakis-(Designer)-(5/18/16 17:27:03)
	Mods_2016_NTE
	//  `
	// Modified by: Costas Manousakis-(Designer)-(9/13/16 09:49:56)
	Mods_2016_09
	//  `C_TEXT(NTI_ListPendingTINInsp ;$1)
	// Modified by: Costas Manousakis-(Designer)-(4/25/17 17:36:55)
	Mods_2017_04
	//  `added NTI_D1_txt   NTI_D2_txt
	Mods_2017_12  //Add comment types for NTI Inspections
	//Add code to allow for nti inspection comment types
	//Modified by: Chuck Miller (12/21/17 14:37:40)
	Mods_2018_01  //Fix Compiler issues Methods not in Compiler directives
	//Modified by: Chuck Miller (1/9/18 13:06:22)
	Compiler_XMLUtils
	Mods_2018_04  //Add code to print [NTI_TunnelInfo];"NTIED_Print"
	//Modified by: Chuck Miller (4/25/18 13:13:24)
	Mods_2019_07
	//Modified by: Chuck Miller (7/2/19 10:28:44)
End if 
If (False:C215)
	C_LONGINT:C283(FM_NTI_Input; $1)
	C_LONGINT:C283(FM_All_Items_Tunnel_Inspection; $1)
	C_BOOLEAN:C305(NTI_SaveandUpdateComments; $1)
	
	C_POINTER:C301(TIN_SetYNorNA; $1)
	C_TEXT:C284(NTI_Export_Elem_Defects; $1)
	C_TEXT:C284(NTI_Export_Elem_Defects; $2)
	C_TEXT:C284(FM_ReturnInspectionTitle; $0)
	
End if 
C_BOOLEAN:C305(NTI_CanAdd_B; NTI_Modify_B; NTI_CanDelete_B)
ARRAY BOOLEAN:C223(NTI_ADDTunnelInfo_aB; 0)
ARRAY BOOLEAN:C223(NTI_DELTunnelInfo_aB; 0)
ARRAY BOOLEAN:C223(NTI_MODTunnelInfo_aB; 0)

ARRAY TEXT:C222(NTI_TownName_atxt; 0)
ARRAY TEXT:C222(NTI_Codes_atxt; 0)

ARRAY TEXT:C222(NTI_i8_s_atxt; 0)
ARRAY TEXT:C222(NTI_i9_L_atxt; 0)
ARRAY TEXT:C222(NTI_i18_s_atxt; 0)
ARRAY TEXT:C222(NTI_A8_L_atxt; 0)
ARRAY TEXT:C222(NTI_C1_s_atxt; 0)
ARRAY TEXT:C222(NTI_C2_s_atxt; 0)

ARRAY TEXT:C222(NTI_C3_s_atxt; 0)
ARRAY TEXT:C222(NTI_C4_s_atxt; 0)
ARRAY TEXT:C222(NTI_C7_L_atxt; 0)
ARRAY TEXT:C222(NTI_C8_s_atxt; 0)
ARRAY TEXT:C222(NTI_L1_s_atxt; 0)
ARRAY TEXT:C222(NTI_L4_s_atxt; 0)
ARRAY TEXT:C222(NTI_S2_L_atxt; 0)
ARRAY TEXT:C222(NTI_S3_L_atxt; 0)
ARRAY TEXT:C222(NTI_S4_L_atxt; 0)
ARRAY TEXT:C222(NTI_N3_s_atxt; 0)

ARRAY TEXT:C222(NTI_TunnelID_atxt; 0)
ARRAY TEXT:C222(NTI_VentID_atxt; 0)
ARRAY TEXT:C222(NTI_Owner_atxt; 0)
ARRAY TEXT:C222(NTI_A_Bins_atxt; 0)
ARRAY TEXT:C222(NTI_A_Item2_atxt; 0)
ARRAY TEXT:C222(NTI_A_Item8_atxt; 0)
ARRAY TEXT:C222(NTI_A_Item7_atxt; 0)
ARRAY TEXT:C222(NTI_A_Item6a_atxt; 0)
ARRAY TEXT:C222(NTI_S_Bins_atxt; 0)
ARRAY TEXT:C222(NTI_A_Item2_atxt; 0)
ARRAY TEXT:C222(NTI_S_Item8_atxt; 0)
ARRAY TEXT:C222(NTI_S_Item7_atxt; 0)
ARRAY TEXT:C222(NTI_S_Item6a_atxt; 0)
ARRAY TEXT:C222(NTI_S_Item2_atxt; 0)
ARRAY LONGINT:C221(NTI_FontColor_al; 0)
ARRAY TEXT:C222(TINInspCommentTypes_atxt; 0)

ARRAY BOOLEAN:C223(AvailableBins_LB; 0)
ARRAY BOOLEAN:C223(SelectedBins_LB; 0)

C_BOOLEAN:C305(NTI_MovingRecords_B)
C_LONGINT:C283(NTI_TunnelRow_L; NTI_CurrentPage_L)

C_TEXT:C284(NTI_L2_txt; NTI_L3_txt)
//Tunnel number parts

C_TEXT:C284(NTI_TownCode_s; NTI_Vent_s; NTI_Owner_s; NTI_TunnelID_s)  // old C_STRING length 3
C_TEXT:C284(NTI_Number_s)  // old C_STRING length 2
ARRAY TEXT:C222(NTI_Tabs; 0)  // old _ O _ARRAY STRING length 31

C_LONGINT:C283(Feet_L; Inches_L; Feet1_L; Inches1_L)
C_LONGINT:C283(NTI_Tunnel_LB)
ARRAY LONGINT:C221(NTI_ENVKEY_aL; 0)
ARRAY TEXT:C222(NTI_ENVDESC_atxt; 0)
ARRAY LONGINT:C221(NTI_MASTERELEM_KEY_aL; 0)
ARRAY TEXT:C222(NTI_MASTERELEM_Desc_atxt; 0)
ARRAY LONGINT:C221(NTI_SFLAGSELEM_KEY_aL; 0)
ARRAY TEXT:C222(NTI_SFLAGSELEM_Desc_atxt; 0)

C_TEXT:C284(NTI_DEFECT_ELEM_TREE; NTI_DEFECT_LANG_TREE)

C_LONGINT:C283(NTI_CombineBINs)
C_TEXT:C284(InspectionPreviewToCheck_txt)

ARRAY LONGINT:C221(NTI_MASTER_TIN_KEY_aL; 0)
ARRAY TEXT:C222(NTI_MASTER_TIN_Desc_atxt; 0)

C_TEXT:C284(NTI_NewTINInspType_txt)
C_TEXT:C284(NTI_PrintSection_txt)
C_BOOLEAN:C305(NTI_ImageSortNeeded_b)

C_LONGINT:C283(bTunnelInfo; PrintNTIE_L)

C_TEXT:C284(NTI_INSPREQUIREMENTSTREE_txt; NTI_REVIEWPERMISSIONSTREE_txt; NTI_CSWTFACTORSTREE_txt)

C_DATE:C307(NTI_DROPBININSPDATE; NTI_DROPBINBTSINSPDATE)

ARRAY LONGINT:C221(NTI_SelectedRN_aL; 0)

C_TEXT:C284(NTI_D1_txt; NTI_D2_txt)
C_BOOLEAN:C305(NTI_FirstCommentPrinted_B)

ARRAY LONGINT:C221(NTI_PROTSYSELEM_KEY_aL; 0)
ARRAY TEXT:C222(NTI_PROTSYSELEM_Desc_atxt; 0)

C_TEXT:C284(NTI_FHWAExportOpt_txt)

If (False:C215)  //define all of the methods
	C_TEXT:C284(NTI_SetUpAssignBINs; $1)
	
	C_TEXT:C284(m_DisplayTINs; $1)
	
	C_POINTER:C301(NTI_ControlModification; $1)
	
	C_TEXT:C284(NTI_ControlModification; $2)
	C_LONGINT:C283(FM_NTITunnelInput; $1)
	C_BOOLEAN:C305(NTI_SetUpCanAdd; $0)
	C_POINTER:C301(NTI_SetModDeleteAccess; $1; $2)
	C_BOOLEAN:C305(NTI_CheckTownSelection; $0)
	C_POINTER:C301(NTI_CheckTownSelection; $1)
	C_LONGINT:C283(NTI_CheckTownSelection; $2)
	
	C_TEXT:C284(NTI_XMLScript; $0)
	C_TEXT:C284(NTI_XMLScript; $1)
	
	C_LONGINT:C283(NTI_NTE_LB_OM; $1)
	
	C_POINTER:C301(NTI_LoadLB_elemInfo; $1; $2; $3; $4)
	
	C_TEXT:C284(NTI_ElemKeyTxt; $0)
	
	C_LONGINT:C283(NTI_ElemKeyTxt; $1)
	C_LONGINT:C283(NTI_ElemKeyTxt; $2)
	C_LONGINT:C283(NTI_ElemKeyTxt; $3)
	
	C_TEXT:C284(NTI_ElemSort; $0)
	
	C_BOOLEAN:C305(NTI_ELEMINP_SAVE; $0)
	C_POINTER:C301(NTI_ELEMINP_SAVE; $1)
	
	C_TEXT:C284(NTI_VerifyQuantity; $0)
	C_TEXT:C284(NTI_VerifyQuantity_TIN; $0)
	
	C_LONGINT:C283(NTI_OpenHelpWindow; $1)
	
	C_LONGINT:C283(NTI_RUNHelpWindow; $1)
	
	C_LONGINT:C283(NTI_PONHELP_FM; $1)
	
	C_TEXT:C284(NTI_LoadElementHelp; $0)
	C_LONGINT:C283(NTI_LoadElementHelp; $1)
	C_BOOLEAN:C305(NTI_LoadElementHelp; $2)
	
	C_TEXT:C284(NTI_ELEMINPUTIL; $1)
	
	C_LONGINT:C283(NTI_FindAllowedDefects; $1)
	C_POINTER:C301(NTI_FindAllowedDefects; $2)
	
	C_LONGINT:C283(NTI_SetElemSelectPulldown; $1; $2)
	C_POINTER:C301(NTI_SetElemSelectPulldown; $3; $4)
	C_BOOLEAN:C305(NTI_SetElemSelectPulldown; $5)
	
	C_LONGINT:C283(NTI_NoQuantityState1; $1)
	C_BOOLEAN:C305(NTI_NoQuantityState1; $0)
	
	C_TEXT:C284(NTI_NavigateInput_OM; $1)
	
	C_LONGINT:C283(NTI_ELEMINPTOOL_OM; $1)
	
	C_BOOLEAN:C305(NTI_ElemInp_AddChild; $1)
	
	C_TEXT:C284(NTI_VerifyNTIQuantities; $0)
	C_POINTER:C301(NTI_VerifyNTIQuantities; $1)
	
	C_LONGINT:C283(NTI_ELEMDAMLB_OM; $1)
	
	C_LONGINT:C283(NTI_ELEMINP_FM; $1)
	
	C_LONGINT:C283(NTI_BIN_LB_RowColor; $0)
	
	C_LONGINT:C283(NTI_PrintNTEs_FM; $1)
	
	C_POINTER:C301(NTI_ElmSftySpellCheck; $1)
	
	C_POINTER:C301(NTI_ElmtRemarksArea; $1)
	C_LONGINT:C283(NTI_ElmtRemarksArea; $2)
	C_LONGINT:C283(NTI_ElmtRemarksArea; $3)
	
	C_BOOLEAN:C305(NTI_ModifiedRecord; $0)
	C_POINTER:C301(NTI_ModifiedRecord; $1)
	
	C_POINTER:C301(NTI_OpenElement; $1)
	
	C_LONGINT:C283(NTI_Print_comments_BIN; $0)
	
	C_TEXT:C284(NTI_ELEMINPUTIL_TIN; $1)
	
	C_BOOLEAN:C305(NTI_ValidateElemInput; $0)
	C_POINTER:C301(NTI_ValidateElemInput; $1)
	
	C_BOOLEAN:C305(NTI_VERIFYUNIQELEM_b; $0)
	C_LONGINT:C283(NTI_VERIFYUNIQELEM_b; $1; $2)
	C_POINTER:C301(NTI_VERIFYUNIQELEM_b; $3)
	C_LONGINT:C283(NTI_VERIFYUNIQELEM_b; $4)
	
	C_POINTER:C301(NTI_RecordAllChanges; $1)
	C_POINTER:C301(NTI_SetupChildParams; $1)
	C_POINTER:C301(NTI_Preview; $1)
	C_LONGINT:C283(NTI_ELEMINPTOOL_OM_TIN; $1)
	
	C_TEXT:C284(NTI_ElemSort_TIN; $0)  // old C_STRING length 80
	
	C_LONGINT:C283(NTI_NTE_LB_OM_TIN; $1)
	C_LONGINT:C283(NTI_PrintNTEs_FM_TIN; $1)
	
	C_LONGINT:C283(NTI_Print_comments_TIN; $0)
	
	C_LONGINT:C283(NTI_TIN_LB_RowColor; $0)
	
	C_BOOLEAN:C305(NTI_AllowAdd_Tin_insp; $0)
	
	C_POINTER:C301(NTI_AddChildElem; $1)
	C_BOOLEAN:C305(NTI_AddChildElem; $2)
	
	C_BOOLEAN:C305(NTI_InspectionPermission; $0)
	
	C_LONGINT:C283(NTI_ELEMINP_TIN_FM; $1)
	
	C_LONGINT:C283(NTI_CreateImageLog; $1)
	
	C_BOOLEAN:C305(NTI_PrintSketchChartSingle; $0; $1; $2)
	
	C_BOOLEAN:C305(NTI_PrintSketchChart; $0; $1)
	C_LONGINT:C283(NTI_PrintSketchChart; $2)
	
	C_LONGINT:C283(NTI_Print_comments_TIN; $0)
	C_BOOLEAN:C305(NTI_Print_comments_TIN; $1)
	C_BOOLEAN:C305(NTI_Print_comments_TIN; $2)
	
	C_TEXT:C284(NTI_SaveImage; $1)
	
	C_POINTER:C301(NTI_PrintNTEList; $1)
	C_TEXT:C284(NTI_PrintNTEList; $2)
	
	C_TEXT:C284(NTI_MoveImages; $1)
	
	C_TEXT:C284(NTI_GetReviewGroups; $1)
	C_POINTER:C301(NTI_GetReviewGroups; $2)
	C_POINTER:C301(NTI_GetReviewGroups; $3)
	
	C_TEXT:C284(NTI_GetInspRequirements; $1)
	C_POINTER:C301(NTI_GetInspRequirements; $2)
	C_POINTER:C301(NTI_GetInspRequirements; $3)
	
	C_TEXT:C284(NTI_ListPendingTINInsp; $1)
	
	C_TEXT:C284(NTI_GetInspResp; $0)
	C_TEXT:C284(NTI_GetInspResp; $1)
	
	C_TEXT:C284(NTI_LoadExportArrays; $0; $1)
	
	C_TEXT:C284(NTI_GroupSuffix; $0)
	C_TEXT:C284(NTI_GroupSuffix; $1)
	C_TEXT:C284(NTI_GroupSuffix; $2)
	
	C_LONGINT:C283(NTI_NoQuantityState; $0)
	C_LONGINT:C283(NTI_NoQuantityState; $1)
	
	C_LONGINT:C283(NTI_CalculateRating; $0)
	C_REAL:C285(NTI_CalculateRating; $1)
	C_REAL:C285(NTI_CalculateRating; $2)
	C_REAL:C285(NTI_CalculateRating; $3)
	C_REAL:C285(NTI_CalculateRating; $4)
	C_REAL:C285(NTI_CalculateRating; $5)
	
	C_LONGINT:C283(NTI_ElemQuantity_OM; $1)
	
	C_OBJECT:C1216(NTI_CheckInspComplete; $0)
	
	C_LONGINT:C283(NTI_ELEMPROTLB_OM; $1)
	
	C_OBJECT:C1216(NTI_VerifyNTECondRtg; $0)
	
	C_OBJECT:C1216(NTI_DisplayInspChkMsgs; $1)
	C_TEXT:C284(NTI_DisplayInspChkMsgs; $2)
	
	C_LONGINT:C283(NTI_DuplicateElements; $1)
	C_LONGINT:C283(NTI_DuplicateElements; $2)
	
	C_BOOLEAN:C305(NTI_UpdateDBfromXML; $0)
	C_TEXT:C284(NTI_UpdateDBfromXML; $1)
	C_TEXT:C284(NTI_UpdateDBfromXML; $2)
	C_TEXT:C284(NTI_UpdateDBfromXML; $3)
	
	C_LONGINT:C283(NTI_DuplicateElements; $1; $2; $3)
	C_OBJECT:C1216(NTI_DuplicateElements; $4)
	
	C_LONGINT:C283(FM_TunnelRatingInput; $1)
	
	C_TEXT:C284(NTI_SortByFormula; $0)
	C_LONGINT:C283(NTI_SortByFormula; $1)
	
	C_OBJECT:C1216(NTI_CombineRecent; $0)
	C_BOOLEAN:C305(NTI_CombineRecent; $1)
	C_BOOLEAN:C305(NTI_CombineRecent; $2)
	C_DATE:C307(NTI_CombineRecent; $3)
	
	
	C_LONGINT:C283(NTI_InspReviewLB_OM; $0)
	
End if 

//End Compiler_NTI