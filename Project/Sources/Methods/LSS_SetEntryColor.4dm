//%attributes = {"invisible":true}

// ----------------------------------------------------
// User name (OS): administrator
// Date and time: 09/04/14, 17:35:55
// ----------------------------------------------------
// Method: LSS_SetEntryColor
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// Modified by: Costas Manousakis-(Designer)-(2021-12-27 18:51:29)
	Mods_2021_12_bug
	//  `converted object set color to object set RGB colors
End if 

C_POINTER:C301($1; $Table_ptr)
$Table_ptr:=$1

Case of 
	: (Table name:C256($Table_ptr)="LSS_Inventory")
		Case of 
			: (Not:C34(LSS_AllowNewInventoryItem_b)) & (Not:C34(LSS_AllowInventoryEdit_B))
				OBJECT SET RGB COLORS:C628(*; "@"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced OBJECT SET COLOR(*;"@";<>Color_Not_Editable)
			: (Read only state:C362($Table_ptr->))
				OBJECT SET RGB COLORS:C628(*; "@"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced OBJECT SET COLOR(*;"@";<>Color_Not_Editable)
			Else 
				OBJECT SET RGB COLORS:C628(*; "@"; Col_paletteToRGB(Abs:C99(<>Color_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_editable)\256))  // **Replaced OBJECT SET COLOR(*;"@";<>Color_editable)
				OBJECT SET RGB COLORS:C628(*; "LSS_IDs@"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced OBJECT SET COLOR(*;"LSS_IDs@";<>Color_Not_Editable)
		End case 
		
		OBJECT SET RGB COLORS:C628(*; "@_LB"; Col_paletteToRGB(Abs:C99(<>LSS_ListBoxColor_L)%256); Col_paletteToRGB(Abs:C99(<>LSS_ListBoxColor_L)\256))  // **Replaced OBJECT SET COLOR(*;"@_LB";<>LSS_ListBoxColor_L)
		
	: (Table name:C256($Table_ptr)="LSS_Inspection")
		OBJECT SET RGB COLORS:C628(*; "DisplayOnly@"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced OBJECT SET COLOR(*;"DisplayOnly@";<>Color_Not_Editable)
		Case of 
			: (Not:C34(LSS_AllowInspectionEdit_B))
				OBJECT SET RGB COLORS:C628(*; "@"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced OBJECT SET COLOR(*;"@";<>Color_Not_Editable)
			: (Read only state:C362($Table_ptr->))
				OBJECT SET RGB COLORS:C628(*; "@"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced OBJECT SET COLOR(*;"@";<>Color_Not_Editable)
			Else 
				OBJECT SET RGB COLORS:C628(*; "@"; Col_paletteToRGB(Abs:C99(<>Color_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_editable)\256))  // **Replaced OBJECT SET COLOR(*;"@";<>Color_editable)
		End case 
		
		OBJECT SET RGB COLORS:C628(*; "@_LB"; Col_paletteToRGB(Abs:C99(<>LSS_ListBoxColor_L)%256); Col_paletteToRGB(Abs:C99(<>LSS_ListBoxColor_L)\256))  // **Replaced OBJECT SET COLOR(*;"@_LB";<>LSS_ListBoxColor_L)
		
	Else 
		Case of 
			: (Not:C34(LSS_AllowInspectionEdit_B))
				OBJECT SET RGB COLORS:C628(*; "@"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced OBJECT SET COLOR(*;"@";<>Color_Not_Editable)
			: (Read only state:C362($Table_ptr->))
				OBJECT SET RGB COLORS:C628(*; "@"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced OBJECT SET COLOR(*;"@";<>Color_Not_Editable)
			Else 
				OBJECT SET RGB COLORS:C628(*; "@"; Col_paletteToRGB(Abs:C99(<>Color_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_editable)\256))  // **Replaced OBJECT SET COLOR(*;"@";<>Color_editable)
		End case 
		OBJECT SET RGB COLORS:C628(*; "DisplayOnly@"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced OBJECT SET COLOR(*;"DisplayOnly@";<>Color_Not_Editable)
		
		OBJECT SET RGB COLORS:C628(*; "@_LB"; Col_paletteToRGB(Abs:C99(<>LSS_ListBoxColor_L)%256); Col_paletteToRGB(Abs:C99(<>LSS_ListBoxColor_L)\256))  // **Replaced OBJECT SET COLOR(*;"@_LB";<>LSS_ListBoxColor_L)
		
		
End case 