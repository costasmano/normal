
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 04/29/14, 13:17:11
//----------------------------------------------------
//Object Method: [LSS_Inventory].Edit_SIN.LSS_RouteDirection_as 
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2016_01_bug  // Add item that user can change in Structure number
	//Modified by: administrator (1/7/16 14:53:31)
End if 
Case of 
	: (Form event code:C388=On Clicked:K2:4)
		If (LSS_RouteDirection_as>1)
			
			[LSS_Inventory:165]LSS_RouteDirection_s:14:=LSS_RouteDirection_as{LSS_RouteDirection_as}
			If (LSS_RouteSuffix_L=0)
				[LSS_Inventory:165]LSS_Route_s:9:=LSS_RouteDesignation_s+String:C10(LSS_Route_L; "0000")+Substring:C12([LSS_Inventory:165]LSS_RouteDirection_s:14; 1; 1)
			Else 
				[LSS_Inventory:165]LSS_Route_s:9:=LSS_RouteDesignation_s+String:C10(LSS_Route_L; "000A")+Substring:C12([LSS_Inventory:165]LSS_RouteDirection_s:14; 1; 1)
			End if 
			
			v_165_006_txt:=LSS_UpdateStructNumPart(v_165_006_txt; [LSS_Inventory:165]LSS_Route_s:9; 3)
			
			OBJECT SET ENABLED:C1123(*; "ApplyButton"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		End if 
End case 
//End Object Method: [LSS_Inventory].New_InventoryItem.LSS_Cities_atxt

