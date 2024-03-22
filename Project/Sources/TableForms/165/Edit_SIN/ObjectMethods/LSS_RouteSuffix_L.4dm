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
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		LSS_RouteSuffix_L:=0
		OBJECT SET FORMAT:C236(*; "LSS_Route_L"; "0000")
	: (Form event code:C388=On Clicked:K2:4)
		If (LSS_RouteDesignation_s#"")
			
			If (LSS_RouteSuffix_L=0)
				[LSS_Inventory:165]LSS_Route_s:9:=LSS_RouteDesignation_s+String:C10(LSS_Route_L; "0000")+Substring:C12([LSS_Inventory:165]LSS_RouteDirection_s:14; 1; 1)
				OBJECT SET FORMAT:C236(*; "LSS_Route_L"; "0000")
			Else 
				[LSS_Inventory:165]LSS_Route_s:9:=LSS_RouteDesignation_s+String:C10(LSS_Route_L; "000A")+Substring:C12([LSS_Inventory:165]LSS_RouteDirection_s:14; 1; 1)
				OBJECT SET FORMAT:C236(*; "LSS_Route_L"; "000")
			End if 
			
			v_165_006_txt:=LSS_UpdateStructNumPart(v_165_006_txt; [LSS_Inventory:165]LSS_Route_s:9; 3)
			
			OBJECT SET ENABLED:C1123(*; "ApplyButton"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			
		End if 
		
End case 

//End Object Method: [LSS_Inventory].New_InventoryItem.LSS_RouteSuffix_L