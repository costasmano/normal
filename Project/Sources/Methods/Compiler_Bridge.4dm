//%attributes = {"invisible":true}
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 03/07/13, 16:46:33
//----------------------------------------------------
//Method: Compiler_Bridge
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2013_03  //r001 ` 
	//Modified by: Charles Miller (3/7/13 16:46:34)
	// Modified by: Costas Manousakis-(Designer)-(8/16/13 17:21:39)
	Mods_2013_08
	//  `added arrays from the BDEPT Input form method (New BIN)
	// Modified by: Costas Manousakis-(Designer)-(1/27/14 17:39:44)
	Mods_2014_01
	//  `added vars for bridgerank calciultaions - moved Pontis metrics 
	// Modified by: Costas Manousakis-(Designer)-(3/21/14 09:45:36)
	Mods_2014_03
	//  `additional vars for bridgeranking
	// Modified by: Costas Manousakis-(Designer)-(2/6/15 16:26:19)
	Mods_2015_02
	//  `added /moved here ConvertBIN , ConvertBINtoNumber , Find1stMissingBIN
	Mods_2020_07  //Movement and Storage of signed inpsection reports
	//Modified by: CJ (7/23/20 12:20:02)
End if 
C_TEXT:C284(mbta_BridgeType_txt)
ARRAY TEXT:C222(abrkey; 0)  //Command Replaced was o_ARRAY string length was 12
ARRAY TEXT:C222(aItem5; 0)  //Command Replaced was o_ARRAY string length was 9
ARRAY TEXT:C222(aItem6; 0)  //Command Replaced was o_ARRAY string length was 24
ARRAY BOOLEAN:C223(aItem6b; 0)
ARRAY TEXT:C222(aItem7; 0)  //Command Replaced was o_ARRAY string length was 18
ARRAY TEXT:C222(aItem9; 0)  //Command Replaced was o_ARRAY string length was 25
ARRAY REAL:C219(aItem11; 0)
ARRAY INTEGER:C220(aItem16a; 0)
ARRAY INTEGER:C220(aItem16b; 0)
ARRAY REAL:C219(aItem16c; 0)
ARRAY INTEGER:C220(aItem17a; 0)
ARRAY INTEGER:C220(aItem17b; 0)
ARRAY REAL:C219(aItem17c; 0)
ARRAY TEXT:C222(aItem98a; 0)  //Command Replaced was o_ARRAY string length was 3
ARRAY TEXT:C222(aItem98b; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(aItem99; 0)  //Command Replaced was o_ARRAY string length was 15
ARRAY TEXT:C222(aInspResp; 0)  //Command Replaced was o_ARRAY string length was 5
ARRAY TEXT:C222(Item42_as; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY LONGINT:C221(Item29_aL; 0)
ARRAY INTEGER:C220(Item30_ai; 0)
ARRAY INTEGER:C220(Item109_ai; 0)
ARRAY INTEGER:C220(Item19_ai; 0)
ARRAY TEXT:C222(Item38_as; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY BOOLEAN:C223(Item104_ab; 0)
ARRAY TEXT:C222(Item26_as; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(Item100_as; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(Item101_as; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(Item102_as; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(Item105_as; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY BOOLEAN:C223(Item110_ab; 0)
ARRAY TEXT:C222(Item20_as; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(Item21_as; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(Item22_as; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(BridgeName_as; 0)  //Command Replaced was o_ARRAY string length was 80
ARRAY TEXT:C222(ParBIN_as; 0)  //Command Replaced was o_ARRAY string length was 3
ARRAY TEXT:C222(Item8Owner_as; 0)  //Command Replaced was o_ARRAY string length was 3
ARRAY TEXT:C222(Item8LegacyOwner_as; 0)  //Command Replaced was o_ARRAY string length was 3
ARRAY TEXT:C222(RRBranch_as; 0)  //Command Replaced was o_ARRAY string length was 20
ARRAY REAL:C219(RRBridgeNo_ar; 0)
ARRAY TEXT:C222(AgencyBrNo_as; 0)  //Command Replaced was o_ARRAY string length was 20
ARRAY BOOLEAN:C223(aTownLineb; 0)
ARRAY TEXT:C222(RefBINSelector_atxt; 0)
C_TEXT:C284(BIN_txt)
ARRAY TEXT:C222(TownLineBdepts_atxt; 0)
C_REAL:C285(BridgeRankingAvgCondition; BridgeRankingConditionLost; BridgeRankingHealthIndexChange; BridgeRankingADTValue; BridgeRankingDetourValue)
C_TEXT:C284(BridgerankingScourCritical)
C_REAL:C285(BridgeRankingDetourValue)
C_REAL:C285(BridgeRankingClassValue)
C_REAL:C285(BridgeRankingStrucEvalValue)
C_REAL:C285(BridgeRankingAdHealthIndChange)
C_REAL:C285(BridgeRankingDeckValue)
C_REAL:C285(BridgeRankingHWYEvalValue)
C_REAL:C285(BridgeRankingEvalFactor)
C_REAL:C285(BridgeRankingRankFactor)
C_BOOLEAN:C305(BridgeRankUseArchive_b)
C_DATE:C307(BridgeRankArchiveDate_d)
C_DATE:C307(BridgeRankPontisMetricDate_d)
C_LONGINT:C283(BridgeRank4DValue_L)
C_LONGINT:C283(bToolButton)
C_LONGINT:C283(BrgCalcLB)
C_TEXT:C284(BridgeRankHIChgByAvgCond_txt)
C_OBJECT:C1216(SRC_BridgeElemParams_o)
C_LONGINT:C283(MovePage_L)
C_TEXT:C284(MoveSignedInspFolder_txt)
If (False:C215)
	C_REAL:C285(PM_GetYearHI; $0)
	C_LONGINT:C283(PM_GetYearHI; $1)
	C_REAL:C285(PM_GetPctDeteriorationDiff; $0)
	C_LONGINT:C283(PM_GetPctDeteriorationDiff; $1)
	C_LONGINT:C283(PM_GetPctDeteriorationDiff; $2)
	C_REAL:C285(PM_GetPctDeteriorationByRunDate; $0)
	C_DATE:C307(PM_GetPctDeteriorationByRunDate; $1)
	C_TEXT:C284(PM_GetPctDeteriorationByRunDate; $2)
	C_REAL:C285(PM_GetPctDeteriorationByRunDate; $3)
	C_POINTER:C301(PM_CreateMetricRecord; $1)
	C_POINTER:C301(PM_CreateMetricRecord; $2)
	C_POINTER:C301(PM_CreateMetricRecord; $3)
	C_POINTER:C301(PM_CreateMetricRecord; $4)
	C_TEXT:C284(PM_ControlLogDocument; $1)  // was length of 1
	C_POINTER:C301(PM_ControlLogDocument; $2)
	C_POINTER:C301(PM_ControlLogDocument; $3)
	C_TEXT:C284(ConvertBIN; $0)  // was length of 3
	C_LONGINT:C283(ConvertBIN; $1)
	C_LONGINT:C283(ConvertBINtoNumber; $0)
	C_TEXT:C284(ConvertBINtoNumber; $1)  // was length of 3
	C_TEXT:C284(Find1stMissingBIN; $0)  // was length of 3
	
End if 

//End Compiler_Bridge
