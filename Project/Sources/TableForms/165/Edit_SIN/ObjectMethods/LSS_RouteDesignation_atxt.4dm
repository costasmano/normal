
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 01/07/16, 15:54:21
//----------------------------------------------------
//Method: Object Method: [LSS_Inventory].Edit_SIN.LSS_RouteDesignation_atxt
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2016_01_bug  // Add item that user can change in Structure number
	//Modified by: administrator (1/7/16 14:53:31)
	Mods_2018_02_bug  //Fix problem where duplicate structure numbers can be created
	//Modified by: Chuck Miller (2/27/18 13:53:23)
	
End if 
Case of 
	: (Form event code:C388=On Clicked:K2:4)
		Case of 
			: (LSS_RouteDesignation_atxt>1)
				LSS_RouteDesignation_s:=Substring:C12(LSS_RouteDesignation_atxt{LSS_RouteDesignation_atxt}; 1; 1)
				If (LSS_RouteSuffix_L=0)
					[LSS_Inventory:165]LSS_Route_s:9:=LSS_RouteDesignation_s+String:C10(LSS_Route_L; "0000")+Substring:C12([LSS_Inventory:165]LSS_RouteDirection_s:14; 1; 1)
				Else 
					[LSS_Inventory:165]LSS_Route_s:9:=LSS_RouteDesignation_s+String:C10(LSS_Route_L; "000A")+Substring:C12([LSS_Inventory:165]LSS_RouteDirection_s:14; 1; 1)
				End if 
				LSS_SetInventoryNumber
				If (False:C215)
					C_TEXT:C284($SaveSIN_txt)
					$SaveSIN_txt:=[LSS_Inventory:165]LSS_StructureNumber_s:6
					LSS_SetInventoryNumber
					v_165_006_txt:=[LSS_Inventory:165]LSS_StructureNumber_s:6
					[LSS_Inventory:165]LSS_StructureNumber_s:6:=$SaveSIN_txt
					
				End if 
				//v_165_006_txt:=LSS_UpdateStructNumPart (v_165_006_txt;[LSS_Inventory]LSS_Route_s;3)
			: (LSS_RouteDesignation_atxt=1)
		End case 
		
		OBJECT SET ENABLED:C1123(*; "ApplyButton"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
End case 
//End Object Method: [LSS_Inventory].Edit_SIN.LSS_RouteDesignation_atxt

