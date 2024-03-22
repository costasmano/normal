//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/10/06, 15:55:48
	// ----------------------------------------------------
	// Method: SC_CalcReconstrCost
	// Description
	// Calculate the Reconstruction cost part of the total Failure Cost
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM03
End if 
C_REAL:C285($0; $ReconstrCost_r)
C_REAL:C285($RyWdth; $Skew; $ReplLen; $ReplW; $CostF)

$RyWdth:=SET_Rywdth
SC_WriteSingleDataCol(String:C10($RyWdth))
$Skew:=BRG_BridgeSkewCos
SC_WriteSingleDataCol(String:C10($Skew))
$ReplLen:=BRG_ReplLength($RyWdth; $Skew)
SC_WriteSingleDataCol(String:C10($ReplLen))
$ReplW:=BRG_ReplWidth($RyWdth)
SC_WriteSingleDataCol(String:C10($ReplW))
$CostF:=SC_ConstrCostFactor
SC_WriteSingleDataCol(String:C10($CostF))
$ReconstrCost_r:=$CostF*$ReplLen*$ReplW*SC_BrgReplCost_r

$0:=$ReconstrCost_r
