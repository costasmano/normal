//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/11/06, 09:20:17
	// ----------------------------------------------------
	// Method: SC_CalcSingleBridgeData
	// Description
	// Calculate Scour Data for a single Bridge record
	// 
	// Parameters
	// ----------------------------------------------------
	
End if 

SC_P_LifeRemain:=SC_RemainLife_Net
SC_P_AnnualFailProb_r:=SC_AnnualFailProb
SC_WriteSingleDataCol(String:C10(SC_P_AnnualFailProb_r))
SC_P_LifeTimeProbFail_r:=1-((1-SC_P_AnnualFailProb_r)^SC_P_LifeRemain)
SC_WriteSingleDataCol(String:C10(SC_P_LifeTimeProbFail_r))
SC_P_ContinuityF:=SC_ContinuityF
SC_WriteSingleDataCol(String:C10(SC_P_ContinuityF))
SC_P_AdjustedFailProb_r:=SC_P_LifeTimeProbFail_r*SC_P_ContinuityF
SC_WriteSingleDataCol(String:C10(SC_P_AdjustedFailProb_r))
SC_P_TotalFailCost_r:=SC_TotalFailCost
SC_WriteSingleDataCol(String:C10(SC_P_TotalFailCost_r))
SC_P_LifeTimeRisk_r:=SC_P_AdjustedFailProb_r*SC_P_TotalFailCost_r
SC_WriteSingleDataCol(String:C10(SC_P_LifeTimeRisk_r))
SC_P_Category_S:=SC_SetScourCategory(SC_P_LifeTimeRisk_r)
SC_WriteSingleDataCol(SC_P_Category_S; "String")
SC_WriteRowEnd