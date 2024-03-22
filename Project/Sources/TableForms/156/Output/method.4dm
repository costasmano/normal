//Method: Form Method: [BridgeRankCalc]Output
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/16/14, 16:25:18
	// ----------------------------------------------------
	//Created : 
	Mods_2014_05
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		ALL RECORDS:C47([BridgeRankCalc:156])
		ORDER BY:C49([BridgeRankCalc:156]; [BridgeRankCalc:156]RunDate_d:2; <; [BridgeRankCalc:156]RunID_L:1; <)
End case 

//End Form Method: [BridgeRankCalc]Output