//%attributes = {}
//Method: fn_BridgeCondMeasure
//Description
//  ` will return either "GOOD", "FAIR" or "POOR" based on FHWA Performance meeasure
//  ` 9-7 = Good , 6-5 = Fair , 4-0 = Poor
// Parameters
// $0 : $BridgeCondMeas_s
// $1 : $MinBridgeCond_L (optional - if not passed will use the min cond of current bridge record)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/14/15, 16:51:11
	// ----------------------------------------------------
	//Created : 
	Mods_2015_01
End if 
//
C_TEXT:C284($0)
C_TEXT:C284($BridgeCondMeas_s)
$BridgeCondMeas_s:=""
C_LONGINT:C283($minCond_L)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$minCond_L:=$1
Else 
	$minCond_L:=fn_MinBridgeCondition
End if 

Case of 
	: ($minCond_L>=7)
		$BridgeCondMeas_s:="GOOD"
	: ($minCond_L>=5)
		$BridgeCondMeas_s:="FAIR"
	: ($minCond_L>=0)
		$BridgeCondMeas_s:="POOR"
End case 

$0:=$BridgeCondMeas_s
//End fn_BridgeCondMeasure