//Method: Object Method: [LSS_Inventory].New_InventoryItem.LSS_RouteSuffix_L
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 12/23/15, 10:45:21
	// ----------------------------------------------------
	//Created : 
	Mods_2015_12_bug
	// New case to allow Route suffix
	Mods_2018_03_bug  //Re-adjust how and when get next number
	//Modified by: Chuck Miller (3/20/18 15:36:1
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		LSS_RouteSuffix_L:=0
		OBJECT SET FORMAT:C236(*; "LSS_Route_L"; "0000")
	: (Form event code:C388=On Clicked:K2:4)
		
		If (LSS_RouteSuffix_L=0)
			[LSS_Inventory:165]LSS_Route_s:9:=LSS_RouteDesignation_s+String:C10(LSS_Route_L; "0000")
			OBJECT SET FORMAT:C236(*; "LSS_Route_L"; "0000")
		Else 
			[LSS_Inventory:165]LSS_Route_s:9:=LSS_RouteDesignation_s+String:C10(LSS_Route_L; "000A")
			OBJECT SET FORMAT:C236(*; "LSS_Route_L"; "000")
		End if 
		LSS_SIN_2_L:=0
		LSS_SetInventoryNumber
		
End case 

//End Object Method: [LSS_Inventory].New_InventoryItem.LSS_RouteSuffix_L