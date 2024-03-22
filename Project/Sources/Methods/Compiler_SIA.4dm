//%attributes = {"invisible":true}
//Method: Compiler_SIA
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/31/13, 08:21:58
	// ----------------------------------------------------
	//Created : 
	Mods_2013_05  //**** BUG FIX
	//  `Added array text(SIA_Tabs_atxt;0)
	// Modified by: Costas Manousakis-(Designer)-(3/7/14 10:33:09)
	Mods_2014_03
	//  `moved from Compiler_methods the declatations for SIA_@ methods ; added SIA_RAILINPUT_FM
	// Modified by: Costas Manousakis-(Designer)-(5/22/14 14:16:58)
	Mods_2014_05
	//  `added vars for Item5 
	// Modified by: Costas Manousakis-(Designer)-(10/7/14 18:34:34)
	Mods_2014_10_bug
	//  `added new params for SET_Item67
	// Modified by: Costas Manousakis-(Designer)-(2/2/15 10:04:21)
	Mods_2015_02
	//  `added optional parameter for SIA_Item8Owner_OM
	// Modified by: Costas Manousakis-(Designer)-(10/14/15 10:59:09)
	Mods_2015_10_bug
	//  `Added SIA_PrintForms
	// Modified by: Costas Manousakis-(Designer)-(3/29/16 12:15:09)
	Mods_2016_03_bug
	//  `added new param 2 for SET_Item70
	// Modified by: Costas Manousakis-(Designer)-(12/15/16 16:12:43)
	Mods_2016_12
	//  `added SIA_SelectAvailableBIN
	// Modified by: Costas Manousakis-(Designer)-(3/1/17 12:03:42)
	Mods_2017_03
	//  `added global vars to indicate  MetricTon or RatingFactor for item 63,65
End if 
//
C_TEXT:C284(SIA_1STREC_0_TXT)
C_TEXT:C284(SIA_ACCEPTTIP_0_TXT)
C_LONGINT:C283(SIA_COPYLATLON)
C_LONGINT:C283(SIA_FTROUND_L)
C_DATE:C307(SIA_INSPECTIONMONTH_D)
C_TEXT:C284(SIA_NEXTINSPTYPE_TXT)
C_DATE:C307(SIA_NEXTINSP_DATE)
C_LONGINT:C283(SIA_QSELBYFORMULA)
C_TEXT:C284(SIA_RPCS_TXT)
C_REAL:C285(SIA_RRITEM10FT_R)
C_REAL:C285(SIA_RRITEM10IN_R)
C_REAL:C285(SIA_RRITEM116_R)
C_REAL:C285(SIA_RRITEM34_R)
C_LONGINT:C283(SIA_RRITEM35_L)
C_TEXT:C284(SIA_RRITEM38_R)
C_REAL:C285(SIA_RRITEM39_R)
C_REAL:C285(SIA_RRITEM40_R)
C_REAL:C285(SIA_RRITEM47_R)
C_REAL:C285(SIA_RRITEM48_R)
C_REAL:C285(SIA_RRITEM49_R)
C_REAL:C285(SIA_RRITEM50A_R)
C_REAL:C285(SIA_RRITEM50B_R)
C_REAL:C285(SIA_RRITEM51_R)
C_REAL:C285(SIA_RRITEM52_R)
C_REAL:C285(SIA_RRITEM53FT_R)
C_REAL:C285(SIA_RRITEM53IN_R)
C_TEXT:C284(SIA_RRITEM54A_S)  // Command Replaced was o_C_STRING length was 1
C_REAL:C285(SIA_RRITEM54FT_R)
C_REAL:C285(SIA_RRITEM54IN_R)
C_TEXT:C284(SIA_RRITEM55A_S)  // Command Replaced was o_C_STRING length was 1
C_REAL:C285(SIA_RRITEM55_R)
C_REAL:C285(SIA_RRITEM56_R)
C_REAL:C285(SIA_RRITEM76_R)
C_LONGINT:C283(SIA_RR_CANCEL)
C_LONGINT:C283(SIA_RR_SAVE)
C_TEXT:C284(SIA_SCCAT_S)  // Command Replaced was o_C_STRING length was 2
C_LONGINT:C283(SIA_SCRANK_L)
C_TEXT:C284(SIA_SELECTLISTINFO_TXT)
C_TEXT:C284(SIA_UW_60_S)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(SIA_UW_61_S)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(SIA_UW_62_S)  // Command Replaced was o_C_STRING length was 1
ARRAY TEXT:C222(SIA_Tabs_atxt; 0)
C_TEXT:C284(Item5A_txt)
C_TEXT:C284(Item5D_txt)
ARRAY TEXT:C222(Item5B_atxt; 0)
ARRAY TEXT:C222(Item5C_atxt; 0)
ARRAY TEXT:C222(Item5E_atxt; 0)
C_TEXT:C284(<>SIA_LoadRtg_63_MT_txt; <>SIA_LoadRtg_63_RF_txt)
If (False:C215)
	C_LONGINT:C283(SIA_RRInput_FM; $1)
	C_TEXT:C284(SIA_RRVariableUtil; $1)
	C_POINTER:C301(SIA_RRVariableUtil; $2)
	C_POINTER:C301(SIA_RRVariableUtil; $3)
	C_POINTER:C301(SIA_RRVariableUtil; $4)
	C_TEXT:C284(SIA_MountModule; $1)
	C_BOOLEAN:C305(SIA_MountModule; $2)
	C_LONGINT:C283(SIA_MountModule; $3)
	C_LONGINT:C283(SIA_SearchByTown; $0)
	C_TEXT:C284(SIA_SearchByTown; $1)
	C_BOOLEAN:C305(SIA_SearchByTown; $2)
	C_POINTER:C301(SIA_Feature_OM; $1)
	C_POINTER:C301(SIA_Feature_OM; $2)
	C_POINTER:C301(SIA_Feature_OM; $3)
	C_POINTER:C301(SIA_Feature_OM; $4)
	C_POINTER:C301(SIA_Feature_OM; $5)
	C_POINTER:C301(SIA_Feature_OM; $6)
	C_POINTER:C301(SIA_Feature_OM; $7)
	C_LONGINT:C283(SIA_Feature_OM; $8)
	C_TEXT:C284(SIA_SecureInputForm; $1)
	C_POINTER:C301(SIA_Description_OM; $1)
	C_POINTER:C301(SIA_Description_OM; $2)
	C_POINTER:C301(SIA_Description_OM; $3)
	C_POINTER:C301(SIA_Description_OM; $4)
	C_LONGINT:C283(SIA_Description_OM; $5)
	C_POINTER:C301(SIA_Suffix_OM; $1)
	C_POINTER:C301(SIA_Suffix_OM; $2)
	C_POINTER:C301(SIA_Suffix_OM; $3)
	C_POINTER:C301(SIA_Suffix_OM; $4)
	C_POINTER:C301(SIA_Suffix_OM; $5)
	C_LONGINT:C283(SIA_Suffix_OM; $6)
	C_POINTER:C301(SIA_RteNum_OM; $1)
	C_POINTER:C301(SIA_RteNum_OM; $2)
	C_POINTER:C301(SIA_RteNum_OM; $3)
	C_POINTER:C301(SIA_RteNum_OM; $4)
	C_LONGINT:C283(SIA_RteNum_OM; $5)
	C_LONGINT:C283(SIA_BridgeRankOM; $1)
	C_TEXT:C284(SIA_DesignLoadTrans; $0)
	C_TEXT:C284(SIA_DesignLoadTrans; $1)
	C_LONGINT:C283(SIA_ScourRank_OM; $1)
	C_TEXT:C284(SIA_HelpTipCtrl; $1)
	C_LONGINT:C283(SIA_BridgeInput_FM; $1)
	C_LONGINT:C283(SIA_BridgeInpNavCTRL; $1)
	C_TEXT:C284(SIA_DataCheck; $0)
	C_POINTER:C301(SIA_FieldPtr; $0)
	C_LONGINT:C283(SIA_FieldPtr; $1)
	C_POINTER:C301(SIA_FieldPtr; $2)
	C_REAL:C285(AASHTO_SuffRat; $0)
	C_TEXT:C284(SET_Item67; $0)  // old C_STRING length 2
	C_REAL:C285(SET_Item67; $1)
	C_LONGINT:C283(SET_Item67; $2)
	C_TEXT:C284(SET_Item67; $3; $4; $5; $7; $8; $9; $10)  // old C_STRING length 2
	C_TEXT:C284(SET_Item67; $6)  // old C_STRING length 3
	C_TEXT:C284(SET_Item68; $0)  // was length of 2
	C_TEXT:C284(SET_Item68; $1)  // was length of 1
	C_TEXT:C284(SET_Item68; $2)  // was length of 2
	C_LONGINT:C283(SET_Item68; $3)
	C_LONGINT:C283(SET_Item68; $4)
	C_TEXT:C284(SET_Item68; $5)  // was length of 1
	C_REAL:C285(SET_Item68; $6)
	C_REAL:C285(SET_Item68; $7)
	C_REAL:C285(SET_Item68; $8)
	C_TEXT:C284(SET_Item68; $9)  // was length of 2
	C_TEXT:C284(SET_Item68; $10)  // was length of 1
	C_TEXT:C284(SET_Item69; $0)  // was length of 2
	C_TEXT:C284(SET_Item70; $0)  // was length of 1
	C_REAL:C285(SET_Item70; $1)
	C_TEXT:C284(SET_Item70; $2)  // was length of 1
	C_TEXT:C284(SIA_SET_Item67; $0)  // was length of 2
	C_REAL:C285(SIA_SET_Item67; $1)
	C_LONGINT:C283(SIA_SET_Item67; $2)
	C_TEXT:C284(SIA_SET_Item67; $3)
	C_TEXT:C284(SIA_SET_Item67; $4)
	C_TEXT:C284(SIA_SET_Item67; $5)
	C_TEXT:C284(SIA_SET_Item67; $6)
	C_TEXT:C284(SIA_SET_Item67; $7)
	C_TEXT:C284(SIA_SET_Item67; $8)
	C_TEXT:C284(SIA_SET_Item67; $9)
	C_TEXT:C284(SIA_SET_Item68; $0)  // was length of 2
	C_TEXT:C284(SIA_SET_Item68; $1)
	C_TEXT:C284(SIA_SET_Item68; $2)
	C_LONGINT:C283(SIA_SET_Item68; $3)
	C_LONGINT:C283(SIA_SET_Item68; $4)
	C_TEXT:C284(SIA_SET_Item68; $5)
	C_REAL:C285(SIA_SET_Item68; $6)
	C_REAL:C285(SIA_SET_Item68; $7)
	C_REAL:C285(SIA_SET_Item68; $8)
	C_TEXT:C284(SIA_SET_Item68; $9)
	C_TEXT:C284(SIA_SET_Item68; $10)
	C_TEXT:C284(SIA_SET_Item68; $11)
	C_TEXT:C284(SIA_SET_Item69; $0)  // was length of 2
	C_TEXT:C284(SIA_SET_Item69; $1)
	C_TEXT:C284(SIA_SET_Item69; $2)
	C_TEXT:C284(SIA_SET_Item69; $3)
	C_TEXT:C284(SIA_SET_Item69; $4)
	C_TEXT:C284(SIA_SET_Item69; $5)
	C_TEXT:C284(SIA_SET_Item69; $6)
	C_REAL:C285(SIA_SET_Item69; $7)
	C_REAL:C285(SIA_SET_Item69; $8)
	C_REAL:C285(SIA_SET_Item69; $9)
	C_TEXT:C284(SIA_SET_Item69; $10)
	C_DATE:C307(SIA_SET_Item69; $11)
	C_REAL:C285(SIA_AASHTO_SuffRat; $0)
	//SIA_SETUPLISTBOXES
	C_LONGINT:C283(SIA_SetUpListBoxes; $1)
	//SIA_GOTOPAGE
	C_LONGINT:C283(SIA_GoToPage; $1)
	//SIA_RESETWIDTHS
	C_TEXT:C284(SIA_ResetWidths; $1)
	C_BOOLEAN:C305(SIA_ResetWidths; $2)
	//SIA_NEWOPENMODULE
	C_TEXT:C284(SIA_NewOpenModule; $1)
	C_LONGINT:C283(SIA_NewOpenModule; $2)
	C_TEXT:C284(SIA_NewOpenModule; $3)
	C_LONGINT:C283(SIA_RAILINPUT_FM; $1)
	C_TEXT:C284(SIA_GetItem5FromFeature; $1)
	C_POINTER:C301(SIA_GetItem5FromFeature; $2; $3; $4; $5)
	C_POINTER:C301(SIA_Item5_OM; $1)
	C_LONGINT:C283(SIA_Item5_OM; $2)
	C_LONGINT:C283(SIA_Item5_OM; $3)
	C_POINTER:C301(SIA_CheckOther2ND; $1)
	C_POINTER:C301(SIA_CheckOther2ND; $2)
	C_TEXT:C284(SIA_CheckOther2ND; $3)  // was length of 3
	C_LONGINT:C283(SIA_CheckOther2ND; $4)
	C_TEXT:C284(SIA_Item8Owner_OM; $1)
	C_LONGINT:C283(SIA_PrintForms; $1)
	C_LONGINT:C283(SIA_PrintForms; $2)
	C_LONGINT:C283(SIA_PrintForms; $3)
	C_TEXT:C284(SIA_SelectAvailableBIN; $0)
	C_POINTER:C301(SIA_LoadSelectionListInfo; $1)
	C_POINTER:C301(SIA_LoadSelectionListInfo; $2)
	C_TEXT:C284(SIA_BridgeCondRating; $0)
	C_TEXT:C284(SIA_BridgeCondRating; $1)
	C_TEXT:C284(SIA_BridgeCondRating; $2)
	C_TEXT:C284(SIA_BridgeCondRating; $3)
	C_TEXT:C284(SIA_BridgeCondRating; $4)
	C_BOOLEAN:C305(SIA_NewBridgeStatCalc; $0)
	
	C_LONGINT:C283(SIA_StairsOn_OM; $1)
	C_LONGINT:C283(SIA_StairsLB_OM; $0)
	C_LONGINT:C283(SIA_StairsLB_OM; $1)
	C_OBJECT:C1216(SIA_Stairs_GetLBArrays; $0)
	
	C_POINTER:C301(SIA_Item63_65_OM; $1)
	C_POINTER:C301(SIA_Item63_65_OM; $2)
	C_POINTER:C301(SIA_Item63_65_OM; $3)
	C_POINTER:C301(SIA_Item63_65_OM; $4)
	C_POINTER:C301(SIA_Item63_65_OM; $5)
	
	C_POINTER:C301(SIA_UpdateRealField; $1)
	C_TEXT:C284(SIA_UpdateRealField; $2)
	C_LONGINT:C283(SIA_UpdateRealField; $3)
	
	C_POINTER:C301(SIA_UpdateDateField; $1)
	C_TEXT:C284(SIA_UpdateDateField; $2)
	
	C_POINTER:C301(SIA_UpdateAlphaField; $1)
	C_TEXT:C284(SIA_UpdateAlphaField; $2)
	
	C_POINTER:C301(SIA_UpdateItem37; $1)
	C_TEXT:C284(SIA_UpdateItem37; $2)
	
	C_TEXT:C284(SIA_GetAvailableBIN; $0)
	
	C_TEXT:C284(SIA_ReturnBINtoAvailable; $1)
	
End if 
//End Compiler_SIA
