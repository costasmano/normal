If (False:C215)
	
	// ----------------------------------------------------
	// User name (OS): Administrator
	// Date and time: 05/27/14, 15:15:34
	// ----------------------------------------------------
	// Method: Object Method: [LSS_Inventory].New_InventoryItem.LSS_RouteDesignation_atxt
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	// Modified by: Costas Manousakis-(Designer)-(12/23/15 15:41:50)
	Mods_2015_12_bug
	//  `added case for LSS_RouteSuffix_L
	Mods_2018_03_bug  //Re-adjust how and when get next number
	//Modified by: Chuck Miller (3/20/18 15:36:1
End if 
Case of 
	: (LSS_RouteDesignation_atxt>1)
		LSS_RouteDesignation_s:=Substring:C12(LSS_RouteDesignation_atxt{LSS_RouteDesignation_atxt}; 1; 1)
		If (LSS_RouteSuffix_L=0)
			[LSS_Inventory:165]LSS_Route_s:9:=LSS_RouteDesignation_s+String:C10(LSS_Route_L; "0000")
		Else 
			[LSS_Inventory:165]LSS_Route_s:9:=LSS_RouteDesignation_s+String:C10(LSS_Route_L; "000A")
		End if 
		LSS_SIN_2_L:=0
		LSS_SetInventoryNumber
	: (LSS_RouteDesignation_atxt=1)
		LSS_RouteDesignation_s:=""
		[LSS_Inventory:165]LSS_Route_s:9:=""
		LSS_SIN_2_L:=0
		LSS_SetInventoryNumber
End case 