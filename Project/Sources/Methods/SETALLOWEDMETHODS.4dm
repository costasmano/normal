//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/29/10, 11:44:23
	// ----------------------------------------------------
	// Method: SETALLOWEDMETHODS
	// Description
	//  ` Create an array containing the allowed methods for users in the  Formulas editor
	//  ` Designer and Admin have access to all visible - set in parameters.
	//
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_11  //Copied to Server on : 11/29/10, 11:47:11
End if 

ARRAY TEXT:C222($MethodNames_as; 0)  //Command Replaced was o_ARRAY string length was 40
APPEND TO ARRAY:C911($MethodNames_as; "QR_@")
APPEND TO ARRAY:C911($MethodNames_as; "PRJ_QR@")
APPEND TO ARRAY:C911($MethodNames_as; "CM_QR@")
APPEND TO ARRAY:C911($MethodNames_as; "AnglicizeQ")
APPEND TO ARRAY:C911($MethodNames_as; "bCOEBridge")
APPEND TO ARRAY:C911($MethodNames_as; "bDEMBridge")
APPEND TO ARRAY:C911($MethodNames_as; "bDNBridge")
APPEND TO ARRAY:C911($MethodNames_as; "BDoneInMonthYr")
APPEND TO ARRAY:C911($MethodNames_as; "bFEDBridge")
APPEND TO ARRAY:C911($MethodNames_as; "bFuncObsCheck")
APPEND TO ARRAY:C911($MethodNames_as; "bHighwayBridge")
APPEND TO ARRAY:C911($MethodNames_as; "bInMonth")
APPEND TO ARRAY:C911($MethodNames_as; "bIsNumeric")
APPEND TO ARRAY:C911($MethodNames_as; "bMBTABridge")
APPEND TO ARRAY:C911($MethodNames_as; "bMDCBridge")
APPEND TO ARRAY:C911($MethodNames_as; "bMPABridge")
APPEND TO ARRAY:C911($MethodNames_as; "fMUNBridge")
APPEND TO ARRAY:C911($MethodNames_as; "FN_IFF")
APPEND TO ARRAY:C911($MethodNames_as; "FN_LastNameFirst")
APPEND TO ARRAY:C911($MethodNames_as; "fOutofFreq")
APPEND TO ARRAY:C911($MethodNames_as; "fStateBridge")
APPEND TO ARRAY:C911($MethodNames_as; "fTWNBridge")
APPEND TO ARRAY:C911($MethodNames_as; "FullName")
APPEND TO ARRAY:C911($MethodNames_as; "F_AnglicizeOrder")
APPEND TO ARRAY:C911($MethodNames_as; "f_Boolean2String")
APPEND TO ARRAY:C911($MethodNames_as; "f_BrgStatus_PCT")
APPEND TO ARRAY:C911($MethodNames_as; "f_BridgeInspected_MMYY")
APPEND TO ARRAY:C911($MethodNames_as; "f_CapitalizeTxt")
APPEND TO ARRAY:C911($MethodNames_as; "f_Date2String")
APPEND TO ARRAY:C911($MethodNames_as; "F_dateToString")
APPEND TO ARRAY:C911($MethodNames_as; "F_FiscalYear")
APPEND TO ARRAY:C911($MethodNames_as; "F_GetCityOrTown")
APPEND TO ARRAY:C911($MethodNames_as; "F_Meters_to_FTIN")
APPEND TO ARRAY:C911($MethodNames_as; "f_TrimStr")
APPEND TO ARRAY:C911($MethodNames_as; "GetDeficTrans")
APPEND TO ARRAY:C911($MethodNames_as; "Get_County")
APPEND TO ARRAY:C911($MethodNames_as; "Get_District")
APPEND TO ARRAY:C911($MethodNames_as; "HistoricalTrans")
APPEND TO ARRAY:C911($MethodNames_as; "iAgeofBridge")
APPEND TO ARRAY:C911($MethodNames_as; "MatchInArr")
APPEND TO ARRAY:C911($MethodNames_as; "MaxDate")
APPEND TO ARRAY:C911($MethodNames_as; "MaxNum")
APPEND TO ARRAY:C911($MethodNames_as; "MetricizeQ")
APPEND TO ARRAY:C911($MethodNames_as; "MinDate")
APPEND TO ARRAY:C911($MethodNames_as; "MinNum")
APPEND TO ARRAY:C911($MethodNames_as; "Set_Date")
APPEND TO ARRAY:C911($MethodNames_as; "Strip")
//APPEND TO ARRAY($MethodNames_as;"ut_executeMethod")

SET ALLOWED METHODS:C805($MethodNames_as)