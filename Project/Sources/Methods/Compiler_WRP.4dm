//%attributes = {"invisible":true}
//Method: Compiler_WRP
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 12/23/20, 08:44:35
	// ----------------------------------------------------
	//Created : 
	
End if 
//
If (False:C215)
	
	C_OBJECT:C1216(wrpGetDocPagePositions; $1)
	C_LONGINT:C283(wrpGetDocPagePositions; $2)
	C_COLLECTION:C1488(wrpGetDocPagePositions; $0)
	
	C_OBJECT:C1216(wrpGetPageAtCharPos; $1)
	C_LONGINT:C283(wrpGetPageAtCharPos; $2)
	C_LONGINT:C283(wrpGetPageAtCharPos; $0)
	
	C_OBJECT:C1216(wrpNewTemplate; $1)
	C_OBJECT:C1216(wrpNewTemplate; $0)
	
	C_OBJECT:C1216(wrpNewTemplateNewProperties; $0)
	
	C_TEXT:C284(wrpNewTempStandards; $1)
	C_BOOLEAN:C305(wrpNewTempStandards; $2)
	C_OBJECT:C1216(wrpNewTempStandards; $0)
	
	C_OBJECT:C1216(wrpPrintInPartsSplitPages; $1)
	C_REAL:C285(wrpPrintInPartsSplitPages; $2)
	C_REAL:C285(wrpPrintInPartsSplitPages; $3)
	C_OBJECT:C1216(wrpPrintInPartsSplitPages; $4)
	C_COLLECTION:C1488(wrpPrintInPartsSplitPages; $0)  // Result-Collection: One Page is one standalone wpDocItem in the collection
	
	C_BLOB:C604(Convert_WKStyleTxtToWP; $0)
	C_BLOB:C604(Convert_WKStyleTxtToWP; $1)
	C_LONGINT:C283(Convert_WKStyleTxtToWP; $2)
	
	C_POINTER:C301(pageBreakFind; $1; $2)
	C_LONGINT:C283(pageBreakFind; $3)
	
	C_OBJECT:C1216(wrpSplitPages; $1)
	C_COLLECTION:C1488(wrpSplitPages; $0)
	
	C_OBJECT:C1216(wrpGetParagraphsStartEnd; $1)
	C_COLLECTION:C1488(wrpGetParagraphsStartEnd; $0)
	
	C_LONGINT:C283(wrpPosInsideParagraph; $1)
	C_COLLECTION:C1488(wrpPosInsideParagraph; $2)
	C_BOOLEAN:C305(wrpPosInsideParagraph; $0)
	
	C_OBJECT:C1216(wrpCustomPrintParts; $1)
	C_OBJECT:C1216(wrpCustomPrintParts; $2)
	
	C_LONGINT:C283(Print_CUL_Cmts_WP; $0)
	C_OBJECT:C1216(Print_CUL_Cmts_WP; $1)
	
	C_OBJECT:C1216(INSP_InitializeWPArea; $0)
	
	C_OBJECT:C1216(Insp_PrintRemarks_WP; $1)
	C_TEXT:C284(Insp_PrintRemarks_WP; $2)
	
	C_OBJECT:C1216(INSP_ViewAllComments_WP; $1)
	
	C_LONGINT:C283(INSP_PrintComments_WP; $0)
	C_OBJECT:C1216(INSP_PrintComments_WP; $1)
	
	C_TEXT:C284(menuContext)
	C_BLOB:C604(TempSave)
	C_OBJECT:C1216(INSP_Comments_WP)
	C_TEXT:C284(WPDisplaymenuContext)
	
	C_OBJECT:C1216(INSP_WPOrientation; INSP_WPGenRemarks; INSP_WPElemComments)
	
	C_OBJECT:C1216(INSP_Comments_WP_OM; $1)
	
	C_TEXT:C284(wrpPrintInPartsNewParamObj; $1)  // Optional, any ID if you want to have your own id
	C_OBJECT:C1216(wrpPrintInPartsNewParamObj; $0)
	
	C_OBJECT:C1216(INSP_Comments_WP_OM; $1)
	
	C_TEXT:C284(INSP_CreateWPPopupMenu; $0)
	
	C_POINTER:C301(WP_CleanupComments; $1)
	
	C_OBJECT:C1216(INSP_SaveComments_WP; $1)
	
	C_OBJECT:C1216(INSP_LoadComments_WP; $1)
	
	C_TEXT:C284(INSP_ConvertWRtoWP; $0)
	
	C_OBJECT:C1216(G_AddElmtTxt2Area_WP; $1)
	C_TEXT:C284(G_AddElmtTxt2Area_WP; $2)
	C_BLOB:C604(G_AddElmtTxt2Area_WP; $3)
	
	C_OBJECT:C1216(G_Insp_AddOrientation_WP; $1)
	
	C_OBJECT:C1216(G_Insp_AddGenCmts_WP; $1)
	
	C_OBJECT:C1216(INSP_AddTextToArea_WP; $1)
	C_TEXT:C284(INSP_AddTextToArea_WP; $2)
	C_TEXT:C284(INSP_AddTextToArea_WP; $3)
	C_TEXT:C284(INSP_AddTextToArea_WP; $4)
	
	C_OBJECT:C1216(G_CreateImageLog_WP; $1)
	
	C_OBJECT:C1216(wrp_GetTextProperties; $0)
	C_BLOB:C604(wrp_GetTextProperties; $1)
	
	C_LONGINT:C283(Print_RTN_Cmts_WP; $0)
	C_OBJECT:C1216(Print_RTN_Cmts_WP; $1)
	
	C_TEXT:C284(INSP_ConvertWRtoWP; $0)
	C_OBJECT:C1216(INSP_ConvertWRtoWP; $1)
	
	C_BLOB:C604(INSP_GetWPDocFromBlob; $0; $1)
	
	C_LONGINT:C283(Print_Tunnel_Cmts_WP; $0)
	C_OBJECT:C1216(Print_Tunnel_Cmts_WP; $1)
	
	C_TEXT:C284(NTI_ConvertWRToWP; $0)
	C_OBJECT:C1216(NTI_ConvertWRToWP; $1)
	
	C_LONGINT:C283(NTI_Print_CommentsWP_TIN; $0)
	C_OBJECT:C1216(NTI_Print_CommentsWP_TIN; $1)
	
	C_OBJECT:C1216(NTI_CreateImageLog_WP; $1)
	
	C_OBJECT:C1216(NTI_PrintRemarks_WP; $1)
	
	C_BOOLEAN:C305(NTI_SaveAndUpdateComments_WP; $1)
	
	C_POINTER:C301(WP_GetExpressions; $1)
	C_POINTER:C301(WP_GetExpressions; $2)
	C_POINTER:C301(WP_GetExpressions; $3)
	C_LONGINT:C283(WP_GetExpressions; $0)
	
	C_LONGINT:C283(NTI_Print_CommentsWP_BIN; $0)
	
	C_LONGINT:C283(LSS_PrintInspection_WP; $1)
	
	C_OBJECT:C1216(LSS_NonDamageAddHeader_WP; $1)
	C_TEXT:C284(LSS_NonDamageAddHeader_WP; $2)
	C_BOOLEAN:C305(LSS_NonDamageAddHeader_WP; $3)
	C_LONGINT:C283(LSS_NonDamageAddHeader_WP; $4)
	
	C_LONGINT:C283(LSS_CountandPrintDamagePages_WP; $1)
	
	C_OBJECT:C1216(LSS_AddHeader_WP; $1)
	C_TEXT:C284(LSS_AddHeader_WP; $2)
	C_BOOLEAN:C305(LSS_AddHeader_WP; $3)
	C_LONGINT:C283(LSS_AddHeader_WP; $4)
	C_POINTER:C301(LSS_AddHeader_WP; $5)
	
	C_OBJECT:C1216(INSP_InitializeWPArea; $0)
	C_OBJECT:C1216(INSP_InitializeWPArea; $1)
	
	C_LONGINT:C283(INSP_FRZ_PrintCmts_WP; $0)
	C_BOOLEAN:C305(INSP_FRZ_PrintCmts_WP; $1)
	
	C_OBJECT:C1216(INSP_ElemCommentsList_WP; $1)
	
	C_BLOB:C604(INSP_ConvertInspections; $1)
	
	C_TEXT:C284(WP_4WRTemplNameToWP; $0; $1)
	
End if 
//End Compiler_WRP