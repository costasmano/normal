//%attributes = {"invisible":true}
//Method: COMPILER_QRMethods
//Description
// contains compiler declarations for QR_@ methods
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/10/12
	// ----------------------------------------------------
	//Created : 
	Mods_2012_09
	// Modified by: Costas Manousakis-(Designer)-(2/22/13 14:24:59)
	Mods_2013_02
	//Added QR_BridgeArea_r
	// Modified by: Costas Manousakis-(Designer)-(11/20/15 15:54:03)
	Mods_2015_11
	//  `mods to QR_itemxx methods - add opt param - change all params to text
	//removed QR_Archive directives that are already in COMPILER_Archive.
	// Modified by: Costas Manousakis-(Designer)-(10/13/16 09:41:00)
	Mods_2016_10
	//  `added QR_CalcDistrRank
	// Modified by: Costas Manousakis-(Designer)-(10/14/16 12:23:15)
	Mods_2016_10
	//  `QR_ReturnPhotoType
End if 
//
//IP Variables
C_TEXT:C284(QRCust_Item58_txt; QRCust_Item59_txt; QRCust_Item60_txt; QRCust_Item62_txt)
C_TEXT:C284(QRCustMyYear_txt; QRCustom_MyBIN_txt)
C_TEXT:C284(QRcust1_txt; QRcust2_txt; QRcust3_txt; QRcust4_txt; QRcust5_txt; QRcust6_txt)
C_LONGINT:C283(QRCust1_L; QRCust2_L)
C_DATE:C307(QRCust1_d)
//methods
If (False:C215)
	C_TEXT:C284(QR_BridgeCondCategory; $0)
	C_REAL:C285(QR_BridgeCondCategory; $1)
	C_TEXT:C284(QR_LegacyOwner; $0; $1; $2)
	C_LONGINT:C283(QR_Appraisal_LTE4_L; $0)
	C_TEXT:C284(QR_Appraisal_LTE4_L; $1; $2; $3; $4)
	C_TEXT:C284(QR_AvgBridgeCondCategory; $0; $1; $2; $3; $4)
	C_TEXT:C284(QR_CurrBridgeOwner; $0)
	C_TEXT:C284(QR_CurrBridgeOwner; $1)
	C_TEXT:C284(fn_BridgeCondCategory; $0)
	C_REAL:C285(fn_BridgeCondCategory; $1)
	C_TEXT:C284(QR_I43A_MajorGroups; $0)
	C_TEXT:C284(QR_I43A_MajorGroups; $1)
	C_TEXT:C284(fn_ReturnName; $0)
	C_POINTER:C301(fn_ReturnName; $1)
	C_LONGINT:C283(QR_YearBuiltReBuilt; $0)
	C_LONGINT:C283(QR_YearBuiltReBuilt; $1)
	C_LONGINT:C283(QR_YearBuiltReBuilt; $2)
	C_REAL:C285(QR_BridgeArea_r; $0)
	C_REAL:C285(QR_BridgeArea_r; $1)
	C_REAL:C285(QR_BridgeArea_r; $2)
	C_REAL:C285(QR_BridgeArea_r; $3)
	C_REAL:C285(QR_BridgeArea_r; $4)
	C_TEXT:C284(QR_Item26OnOff; $0)  // was length of 3
	C_TEXT:C284(QR_Item26OnOff; $1)  // was length of 2
	C_TEXT:C284(QR_Item21; $0)
	C_TEXT:C284(QR_Item21; $1)
	C_TEXT:C284(QR_Item22; $0)
	C_TEXT:C284(QR_Item22; $1)
	C_TEXT:C284(QR_Item31; $0)
	C_TEXT:C284(QR_Item31; $1)
	C_TEXT:C284(QR_Item41; $0)
	C_TEXT:C284(QR_Item41; $1)
	C_TEXT:C284(QR_Item26; $0)
	C_TEXT:C284(QR_Item26; $1)
	C_TEXT:C284(QR_TLineBrNo; $0)
	C_TEXT:C284(QR_TLineTown; $0)
	C_TEXT:C284(QR_Item43A; $0)
	C_TEXT:C284(QR_Item43A; $1)
	C_TEXT:C284(QR_Item43B; $0)
	C_TEXT:C284(QR_Item43B; $1)
	C_TEXT:C284(QR_Item42A; $0)
	C_TEXT:C284(QR_Item42A; $1)
	C_TEXT:C284(QR_Item42B; $0)
	C_TEXT:C284(QR_Item42B; $1)
	C_TEXT:C284(QR_Item107; $0)
	C_TEXT:C284(QR_Item107; $1)
	C_TEXT:C284(QR_Item75a; $0)
	C_TEXT:C284(QR_Item75a; $1)
	C_TEXT:C284(QR_SearchElements; $0)
	C_TEXT:C284(QR_SearchElements; $1)
	C_TEXT:C284(QR_SearchElements; $2)
	C_LONGINT:C283(QR_SearchElements; $3)
	C_TEXT:C284(QR_SearchElements; $4)
	C_LONGINT:C283(QR_CalcDistrRank; $0)
	C_TEXT:C284(QR_CalcDistrRank; $1)
	C_TEXT:C284(QR_CalcDistrRank; $2)
	C_LONGINT:C283(QR_CalcDistrRank; $3)
	C_LONGINT:C283(QR_NumPontisAfter; $0)
	C_LONGINT:C283(QR_NumPontisAfter; $1)
	C_DATE:C307(QR_LastPontisInspDate; $0)
	C_LONGINT:C283(QR_BridgeAge; $0)
	C_LONGINT:C283(QR_BridgeAge; $1)
	C_LONGINT:C283(QR_BridgeAge; $2)
	C_LONGINT:C283(QR_GroupBy; $0)
	C_REAL:C285(QR_GroupBy; ${-1})
	C_REAL:C285(QR_GroupBy; $1)
	C_REAL:C285(QR_GroupBy; $2)
	C_REAL:C285(QR_GroupBy; $3)
	C_REAL:C285(QR_GroupBy; $4)
	C_REAL:C285(QR_GroupBy; $5)
	C_REAL:C285(QR_GroupBy; $6)
	C_REAL:C285(QR_GroupBy; $7)
	C_REAL:C285(QR_GroupBy; $8)
	C_REAL:C285(QR_NBIItemAvg; $0)
	C_TEXT:C284(QR_NBIItemAvg; ${1})  // was length of 2
	C_LONGINT:C283(QR_GetProjInfoNo; $0)
	C_TEXT:C284(QR_GetProjInfoNo; $1)  // was length of 3
	C_DATE:C307(QR_GetProjInfoNo; $2)
	C_DATE:C307(QR_GetProjInfoNo; $3)
	C_LONGINT:C283(QR_MinCondition; $0)
	C_TEXT:C284(QR_ConsInspElecSubm; $0)
	C_TEXT:C284(QR_ConsInspElecSubm; $1)
	C_TEXT:C284(QR_MinElementValue; $0)  // was length of 1
	C_TEXT:C284(QR_MinElementValue; $1)  // was length of 3
	C_TEXT:C284(QR_MinElementValue; $2)
	C_TEXT:C284(QR_MinElementValue; $3)  // was length of 1
	C_TEXT:C284(QR_CountyName; $0)
	C_TEXT:C284(QR_CountyName; $1)  // was length of 6
	C_TEXT:C284(QR_TLineBrNo_2; $0)  // was length of 6
	C_TEXT:C284(QR_ReturnPhotoType; $0)
	C_PICTURE:C286(QR_ReturnPhotoType; $1)
	C_REAL:C285(QR_HandleCommand; $1)
	C_REAL:C285(QR_HandleCommand; $2)
	C_TEXT:C284(QR_Itm22_Sta_Loc; $0)
	C_TEXT:C284(QR_Itm22_Sta_Loc; $1)  // was length of 2
	C_TEXT:C284(QR_Itm22_Sta_Loc; $2)
	C_TEXT:C284(QR_Itm26_Category; $0)
	C_TEXT:C284(QR_Itm26_Category; $1)  // was length of 2
	C_TEXT:C284(QR_Itm26_Category; $2)
	C_TEXT:C284(QR_RPCNames; $0)
	C_TEXT:C284(QR_RPCNames; $1)
	C_TEXT:C284(QR_RPCNames; $2)
	C_TEXT:C284(QR_PNFInfo; $0)
	C_TEXT:C284(QR_Item113; $0)
	C_TEXT:C284(QR_Item113; $1)  // was length of 2
	C_TEXT:C284(QR_ScourCategory; $0)
	C_TEXT:C284(QR_ScourCategory; $1)
	C_TEXT:C284(CM_QRAssignmentInfo; $0)
	C_TEXT:C284(CM_QRAssignmentInfo; $1)
	C_TEXT:C284(QR_PersonName; $0)
	C_LONGINT:C283(QR_PersonName; $1)
	C_DATE:C307(QR_NextInspDate; $0)
	C_TEXT:C284(QR_NextInspDate; $1)
	C_DATE:C307(QR_NextInspDate; $2)
	C_REAL:C285(QR_Floor; $0)
	C_REAL:C285(QR_Floor; $1)
	C_REAL:C285(QR_Floor; $2)
	C_REAL:C285(QR_Ceiling; $0)
	C_REAL:C285(QR_Ceiling; $1)
	C_REAL:C285(QR_Ceiling; $2)
	C_TEXT:C284(QR_Decade; $0)
	C_LONGINT:C283(QR_Decade; $1)
	C_LONGINT:C283(QR_Decade; $2)
	C_LONGINT:C283(QR_Decade; $3)
	C_REAL:C285(QR_AverageBridgeCondition; $0)
	C_TEXT:C284(QR_AverageBridgeCondition; $1)
	C_TEXT:C284(QR_GetPFILEDesigner; $0)
	C_TEXT:C284(QR_GetConstrContrInfo; $0)
	C_TEXT:C284(QR_GetConstrContrInfo; $1)  // was length of 3
	C_DATE:C307(QR_GetConstrContrInfo; $2)
	C_DATE:C307(QR_GetConstrContrInfo; $3)
	C_TEXT:C284(QR_Choise_txt; $0)
	C_TEXT:C284(QR_Choise_txt; ${2})
	C_LONGINT:C283(QR_Choise_txt; $1)
	C_TEXT:C284(QR_SearchInspections; $1)
	C_LONGINT:C283(QR_SearchInspections; $2)
	C_TEXT:C284(QR_NextInspInfo; $0)
	C_TEXT:C284(QR_NextInspInfo; $1)
	C_TEXT:C284(QR_NextInspInfo; $2)
	C_TEXT:C284(QR_NextInspInfo; $3)
	C_LONGINT:C283(QR_CountRelated; $0)
	C_POINTER:C301(QR_CountRelated; $1)
	C_POINTER:C301(QR_CountRelated; $2)
	C_TEXT:C284(QR_MarksReport; $0)
	C_TEXT:C284(QR_MarksReport; $1)
	C_TEXT:C284(QR_InspSchedInfo; $1)
	C_TEXT:C284(QR_InspSchedInfo; $2)
	C_TEXT:C284(QR_InspTmMembers; $0)
	C_LONGINT:C283(QR_InspTmMembers; $1)  //optional
	
	C_TEXT:C284(QR_LSS_ElementDescr; $0)
	
	C_OBJECT:C1216(QR_GetBridgeStairsInfo; $0)
	C_TEXT:C284(QR_GetBridgeStairsInfo; $1)
	
	C_POINTER:C301(QR_RunReportToExcel; $1)
	
	C_POINTER:C301(QR_RunStoredQRtoExcel; $1)
	C_TEXT:C284(QR_RunStoredQRtoExcel; $2)
	
End if 
//End COMPILER_QRMethods
