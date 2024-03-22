//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/10/06, 15:58:13
	// ----------------------------------------------------
	// Method: SC_TotalFailCost
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM03
End if 
C_REAL:C285($0; $TotalFailCost_r)
C_REAL:C285($FatalCost_r; $MileageCost_r; $TimeCost_r; $ReconstrCost_r; $AdjustDetLen_r; $ReplaceDur_r)
$FatalCost_r:=SC_Fatalities*SC_CostPerFatality
SC_WriteSingleDataCol(String:C10($FatalCost_r))
$AdjustDetLen_r:=SC_DetourLen
$ReplaceDur_r:=SC_ReplacementDuration
$MileageCost_r:=(365*$ReplaceDur_r)*$AdjustDetLen_r*[Bridge MHD NBIS:1]Item29:88*SC_KilometerCost_r
SC_WriteSingleDataCol(String:C10($MileageCost_r))
$TimeCost_r:=SC_CalcTravelCost($ReplaceDur_r; $AdjustDetLen_r)
SC_WriteSingleDataCol(String:C10($TimeCost_r))
$ReconstrCost_r:=SC_CalcReconstrCost
SC_WriteSingleDataCol(String:C10($ReconstrCost_r))
$TotalFailCost_r:=$FatalCost_r+$MileageCost_r+$TimeCost_r+$ReconstrCost_r
$0:=$TotalFailCost_r