//Method: Form Method: [BridgeRankCalc]Input
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/16/14, 16:12:09
	// ----------------------------------------------------
	//Created : 
	Mods_2014_05
End if 
//

Case of 
	: (Form event code:C388=On Load:K2:1)
		utl_SetSpellandContextMenu
		READ ONLY:C145([BridgeRankResult:157])
		READ ONLY:C145([Bridge MHD NBIS:1])
		QUERY:C277([BridgeRankResult:157]; [BridgeRankResult:157]RunID_L:1=[BridgeRankCalc:156]RunID_L:1)
		ORDER BY:C49([BridgeRankResult:157]; [BridgeRankResult:157]Rank_L:4; >; [BridgeRankResult:157]BIN:3; >)
		
	: (Form event code:C388=On Validate:K2:3)
		
End case 

//End Form Method: [BridgeRankCalc]Input