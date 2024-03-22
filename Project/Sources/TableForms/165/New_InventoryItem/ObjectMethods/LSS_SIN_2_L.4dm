//Method: [LSS_Inventory].New_InventoryItem.LSS_SIN_2_L
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 03/20/18, 14:20:06
	// ----------------------------------------------------
	//Created : 
	Mods_2018_03_bug  //Re-adjust how and when get next number
	//Moved code to under entry after edit
	//Modified by: Chuck Miller (3/20/18 15:36:11) 
End if 
//
If (Form event code:C388=On Data Change:K2:15)
	//check if number exists
	
	C_LONGINT:C283($MaxNumber_L; $Count_L; $Distr_L)
	C_TEXT:C284($Type_txt; $Route_txt; $ID_txt)
	//this will only happen if we were allowed to edit SIN part 2 which makes sure that type and route are filled
	$Type_txt:=[LSS_Inventory:165]LSS_InventoryType_s:28
	$Route_txt:=Substring:C12([LSS_Inventory:165]LSS_Route_s:9; 1; 5)+"%"  //SQL wildcard
	$Distr_L:=[LSS_Inventory:165]LSS_District_L:3
	$MaxNumber_L:=[LSS_Inventory:165]LSS_District_L:3*100000+LSS_SIN_2_L
	$ID_txt:=[LSS_Inventory:165]LSS_InventoryId_s:1
	OBJECT SET ENABLED:C1123(*; "bValidate"; True:C214)
	OBJECT SET ENTERABLE:C238(*; "LSS_SIN_2_L"; False:C215)
	OBJECT SET RGB COLORS:C628(*; "LSS_SIN_2_L@"; Col_paletteToRGB(Abs:C99(<>color_not_editable)%256); Col_paletteToRGB(Abs:C99(<>color_not_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "LSS_SIN_2_L@"; <>color_not_editable)
	OBJECT SET VISIBLE:C603(*; "EditIDNum"; True:C214)
	
	Begin SQL
		select count(*)
		from
		[LSS_Inventory]
		where
		[LSS_Inventory].[LSS_Route_s] LIKE :$Route_txt
		and
		[LSS_Inventory].[LSS_InventoryType_s] = :$Type_txt
		and
		[LSS_Inventory].[LSS_District_L] = :$Distr_L
		and
		[LSS_Inventory].[LSS_IdentificationNumber_L] = :$MaxNumber_L
		and 
		[LSS_Inventory].[LSS_InventoryId_s] <> :$ID_txt
		into :$Count_L;
	End SQL
	If ($Count_L>0)
		C_TEXT:C284($MSG_TXT)
		$MSG_TXT:="Structure Identification Number "+String:C10([LSS_Inventory:165]LSS_District_L:3*100000+LSS_SIN_2_L)
		$MSG_TXT:=$MSG_TXT+" already exists for Structure Class "+$Type_txt+" on Route "+Substring:C12($Route_txt; 1; 5)
		$MSG_TXT:=$MSG_TXT+" in District "+String:C10([LSS_Inventory:165]LSS_District_L:3)+" !!"
		$MSG_TXT:=$MSG_TXT+Char:C90(13)+"The Identification number has been reset!"
		ALERT:C41($MSG_TXT)
		[LSS_Inventory:165]LSS_IdentificationNumber_L:5:=0
		LSS_SIN_2_L:=0
		LSS_SetInventoryNumber
		OBJECT SET ENABLED:C1123(*; "bValidate"; True:C214)
		OBJECT SET ENTERABLE:C238(*; "LSS_SIN_2_L"; False:C215)
		OBJECT SET RGB COLORS:C628(*; "LSS_SIN_2_L@"; Col_paletteToRGB(Abs:C99(<>color_not_editable)%256); Col_paletteToRGB(Abs:C99(<>color_not_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "LSS_SIN_2_L@"; <>color_not_editable)
		OBJECT SET VISIBLE:C603(*; "EditIDNum"; True:C214)
		OBJECT SET ENABLED:C1123(*; "EditIDNum"; True:C214)
		
		OBJECT SET ENABLED:C1123(*; "LSS_TownName_atxt"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		OBJECT SET ENABLED:C1123(*; "LSS_StructureClass_atxt"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		OBJECT SET ENABLED:C1123(*; "LSS_RouteDesignation_atxt"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		OBJECT SET ENABLED:C1123(*; "LSS_RouteDirection_as"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		OBJECT SET ENTERABLE:C238(*; "LSS_Route_L"; True:C214)
		OBJECT SET ENTERABLE:C238(*; "LSS_KiloPoint_r"; True:C214)
		OBJECT SET ENTERABLE:C238(*; "LSS_MilePoint_r"; True:C214)
		OBJECT SET RGB COLORS:C628(*; "LSS_Route_L@"; Col_paletteToRGB(Abs:C99(<>color_editable)%256); Col_paletteToRGB(Abs:C99(<>color_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "LSS_Route_L@"; <>color_editable)
		OBJECT SET RGB COLORS:C628(*; "LSS_MilePoint_r@"; Col_paletteToRGB(Abs:C99(<>color_editable)%256); Col_paletteToRGB(Abs:C99(<>color_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "LSS_MilePoint_r@"; <>color_editable)
		OBJECT SET RGB COLORS:C628(*; "LSS_KiloPoint_r@"; Col_paletteToRGB(Abs:C99(<>color_editable)%256); Col_paletteToRGB(Abs:C99(<>color_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "LSS_KiloPoint_r@"; <>color_editable)
	Else 
		OBJECT SET ENTERABLE:C238(*; "LSS_SIN_2_L@"; False:C215)
		OBJECT SET RGB COLORS:C628(*; "LSS_SIN_2_L@"; Col_paletteToRGB(Abs:C99(<>color_not_editable)%256); Col_paletteToRGB(Abs:C99(<>color_not_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "LSS_SIN_2_L@"; <>color_not_editable)
		[LSS_Inventory:165]LSS_IdentificationNumber_L:5:=[LSS_Inventory:165]LSS_District_L:3*100000+LSS_SIN_2_L
		LSS_SetInventoryNumber(False:C215)
		OBJECT SET VISIBLE:C603(*; "EditIDNum"; True:C214)
		OBJECT SET ENABLED:C1123(*; "EditIDNum"; True:C214)
		OBJECT SET ENABLED:C1123(*; "LSS_TownName_atxt"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		OBJECT SET ENABLED:C1123(*; "LSS_StructureClass_atxt"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		OBJECT SET ENABLED:C1123(*; "LSS_RouteDesignation_atxt"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		OBJECT SET ENABLED:C1123(*; "LSS_RouteDirection_as"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		OBJECT SET ENTERABLE:C238(*; "LSS_Route_L"; True:C214)
		OBJECT SET ENTERABLE:C238(*; "LSS_KiloPoint_r"; True:C214)
		OBJECT SET ENTERABLE:C238(*; "LSS_MilePoint_r"; True:C214)
		OBJECT SET RGB COLORS:C628(*; "LSS_Route_L@"; Col_paletteToRGB(Abs:C99(<>color_editable)%256); Col_paletteToRGB(Abs:C99(<>color_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "LSS_Route_L@"; <>color_editable)
		OBJECT SET RGB COLORS:C628(*; "LSS_MilePoint_r@"; Col_paletteToRGB(Abs:C99(<>color_editable)%256); Col_paletteToRGB(Abs:C99(<>color_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "LSS_MilePoint_r@"; <>color_editable)
		OBJECT SET RGB COLORS:C628(*; "LSS_KiloPoint_r@"; Col_paletteToRGB(Abs:C99(<>color_editable)%256); Col_paletteToRGB(Abs:C99(<>color_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "LSS_KiloPoint_r@"; <>color_editable)
	End if 
	
	
	
End if 
//End [LSS_Inventory].New_InventoryItem.LSS_SIN_2_L