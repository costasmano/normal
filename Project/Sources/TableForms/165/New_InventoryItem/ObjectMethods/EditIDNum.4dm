//Method: [LSS_Inventory].New_InventoryItem.EditIDNum
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 03/20/18, 15:40:56
	// ----------------------------------------------------
	//Created : 
	Mods_2018_03_bug
End if 
//
Case of 
	: ([LSS_Inventory:165]LSS_InventoryType_s:28="")
		ALERT:C41("You can not edit the "+LSS_SIN_Label_txt+" without an inventory type")
	: ([LSS_Inventory:165]LSS_Route_s:9="")
		ALERT:C41("You can not edit the "+LSS_SIN_Label_txt+" without a route")
		
	: ([LSS_Inventory:165]LSS_District_L:3=0)
		ALERT:C41("You can not edit the "+LSS_SIN_Label_txt+" without a district")
		
		
	Else 
		
		OBJECT SET ENABLED:C1123(*; "EditIDNum"; False:C215)
		
		OBJECT SET ENABLED:C1123(bValidate; False:C215)  // Command Replaced was o_DISABLE BUTTON //disable the accept button - user must 
		OBJECT SET ENTERABLE:C238(*; "LSS_SIN_2_L@"; True:C214)
		OBJECT SET RGB COLORS:C628(*; "LSS_SIN_2_L@"; Col_paletteToRGB(Abs:C99(<>color_editable)%256); Col_paletteToRGB(Abs:C99(<>color_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "LSS_SIN_2_L@"; <>color_editable)
		//SET FILTER(*;"LSS_SIN_2_L@";"&9"+"#####")
		GOTO OBJECT:C206(*; "LSS_SIN_2_L@")
		
		OBJECT SET ENABLED:C1123(*; "LSS_TownName_atxt"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENABLED:C1123(*; "LSS_StructureClass_atxt"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENABLED:C1123(*; "LSS_RouteDesignation_atxt"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENABLED:C1123(*; "LSS_RouteDirection_as"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENTERABLE:C238(*; "LSS_Route_L"; False:C215)
		OBJECT SET ENTERABLE:C238(*; "LSS_KiloPoint_r"; False:C215)
		OBJECT SET ENTERABLE:C238(*; "LSS_MilePoint_r"; False:C215)
		OBJECT SET RGB COLORS:C628(*; "LSS_Route_L@"; Col_paletteToRGB(Abs:C99(<>color_not_editable)%256); Col_paletteToRGB(Abs:C99(<>color_not_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "LSS_Route_L@"; <>color_not_editable)
		OBJECT SET RGB COLORS:C628(*; "LSS_MilePoint_r@"; Col_paletteToRGB(Abs:C99(<>color_not_editable)%256); Col_paletteToRGB(Abs:C99(<>color_not_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "LSS_MilePoint_r@"; <>color_not_editable)
		OBJECT SET RGB COLORS:C628(*; "LSS_KiloPoint_r@"; Col_paletteToRGB(Abs:C99(<>color_not_editable)%256); Col_paletteToRGB(Abs:C99(<>color_not_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "LSS_KiloPoint_r@"; <>color_not_editable)
End case 

//End [LSS_Inventory].New_InventoryItem.EditIDNum