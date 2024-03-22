//Method: Object Method: [LSS_Inventory].New_InventoryItem.LSS_Route_L
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/15/15, 19:24:51
	// ----------------------------------------------------
	//Created : 
	Mods_2015_02
	// Modified by: Costas Manousakis-(Designer)-(12/23/15 10:40:41)
	Mods_2015_12_bug
	//  `Added route suffix to add "A"  after route number
	Mods_2018_03_bug  //Re-adjust how and when get next number
	//Modified by: Chuck Miller (3/20/18 15:36:1
End if 
//
If (Form event code:C388=On Data Change:K2:15)
	//update for display only - gets recalculated in LSS_SetInventoryNumber
	If (LSS_RouteSuffix_L=0)
		[LSS_Inventory:165]LSS_Route_s:9:=LSS_RouteDesignation_s+String:C10(LSS_Route_L; "0000")
	Else 
		[LSS_Inventory:165]LSS_Route_s:9:=LSS_RouteDesignation_s+String:C10(LSS_Route_L; "000A")
	End if 
	LSS_SIN_2_L:=0
	
	LSS_SetInventoryNumber
	
End if 
//End Object Method: [LSS_Inventory].New_InventoryItem.LSS_Route_L