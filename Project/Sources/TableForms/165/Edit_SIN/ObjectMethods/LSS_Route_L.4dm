//Method: Object Method: [LSS_Inventory]."New_InventoryItem".LSS_Route_L
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
	Mods_2018_02_bug  //Fix problem where duplicate structure numbers can be created
	//Modified by: Chuck Miller (2/27/18 13:53:23)
	
End if 
//
Case of 
	: (Form event code:C388=On Data Change:K2:15)
		//update for display only - gets recalculated in LSS_SetInventoryNumber
		If (LSS_RouteDesignation_s#"")
			
			If (LSS_RouteSuffix_L=0)
				[LSS_Inventory:165]LSS_Route_s:9:=LSS_RouteDesignation_s+String:C10(LSS_Route_L; "0000")+Substring:C12([LSS_Inventory:165]LSS_RouteDirection_s:14; 1; 1)
			Else 
				[LSS_Inventory:165]LSS_Route_s:9:=LSS_RouteDesignation_s+String:C10(LSS_Route_L; "000A")+Substring:C12([LSS_Inventory:165]LSS_RouteDirection_s:14; 1; 1)
			End if 
			LSS_SetInventoryNumber
			//v_165_006_txt:=LSS_UpdateStructNumPart (v_165_006_txt;[LSS_Inventory]LSS_Route_s;3)
			
			OBJECT SET ENABLED:C1123(*; "ApplyButton"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		End if 
		
	: (Form event code:C388=On After Keystroke:K2:26)
		OBJECT SET ENABLED:C1123(*; "ApplyButton"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
End case 
//End Object Method: [LSS_Inventory].New_InventoryItem.LSS_Route_L