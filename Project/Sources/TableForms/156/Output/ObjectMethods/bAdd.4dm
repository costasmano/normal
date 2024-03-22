//Method: Object Method: [BridgeRankCalc];"Output".bAdd
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/16/14, 15:39:37
	// ----------------------------------------------------
	//Created : 
	Mods_2014_05
End if 
//
BridgeRank

ALL RECORDS:C47([BridgeRankCalc:156])
ORDER BY:C49([BridgeRankCalc:156]; [BridgeRankCalc:156]RunDate_d:2; <; [BridgeRankCalc:156]RunID_L:1; <)
//End Object Method: [BridgeRankCalc].Output.bAdd