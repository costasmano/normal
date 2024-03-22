
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 10/20/15, 16:43:10
//----------------------------------------------------
//Method: Form Method: [NTI_TunnelInfo]New_TIN
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_11  //Add new method of assigning Tunnel number
	//Modified by: administrator (11/10/15 16:45:30)
	
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		utl_SetSpellandContextMenu
		OBJECT SET ENABLED:C1123(*; "TrapEnter_L"; True:C214)  // **replaced _ o _ENABLE BUTTON(*;"TrapEnter_L")
		OBJECT SET ENABLED:C1123(*; "bValidate"; False:C215)  // **replaced _ o _DISABLE BUTTON(*;"bValidate")
		ARRAY POINTER:C280(ptr_Changes; 0; 0)
		InitChangeStack(1)  //[LSS_Inventory]
		
		[NTI_TunnelInfo:181]NTI_i3_L:8:=25
		OBJECT SET RGB COLORS:C628(*; "NoEntry@"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "NoEntry@"; <>Color_Not_Editable)
		
		OBJECT SET RGB COLORS:C628(*; "NTI_i1_s@"; Col_paletteToRGB(Abs:C99(<>Color_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "NTI_i1_s@"; <>Color_editable)
		OBJECT SET RGB COLORS:C628(*; "NTI_i2_s@"; Col_paletteToRGB(Abs:C99(<>Color_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "NTI_i2_s@"; <>Color_editable)
		OBJECT SET RGB COLORS:C628(*; "NTI_i7_s@"; Col_paletteToRGB(Abs:C99(<>Color_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "NTI_i7_s@"; <>Color_editable)
		OBJECT SET RGB COLORS:C628(*; "NTI_i10_s@"; Col_paletteToRGB(Abs:C99(<>Color_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "NTI_i10_s@"; <>Color_editable)
		OBJECT SET RGB COLORS:C628(*; "NTI_Number_s"; Col_paletteToRGB(Abs:C99(<>Color_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "NTI_Number_s"; <>Color_editable)
		
		NTI_TownCode_s:=""
		NTI_Number_s:=""
		NTI_Vent_s:=""
		NTI_Owner_s:=""
		NTI_TunnelID_s:=""
		NTI_Prefix_txt:=""
		NTI_i8_s_atxt:=0
		NTI_i8_s_atxt{0}:="Select Route Direction"
		NTI_i9_L_atxt:=0
		NTI_i9_L_atxt{0}:="Select Route Type"
		NTI_TunnelID_atxt:=0
		NTI_TunnelID_atxt{0}:="Select Tunnel ID"
		NTI_Owner_atxt:=0
		NTI_Owner_atxt{0}:="Select Tunnel Owner"
		NTI_VentID_atxt:=0
		NTI_VentID_atxt{0}:="Select Vent Zone"
		NTI_TownName_atxt:=0
		NTI_TownName_atxt{0}:="Select Town"
		
		OBJECT SET ENABLED:C1123(*; "NTI_TownName_atxt"; True:C214)  // **replaced _ o _ENABLE BUTTON(*;"NTI_TownName_atxt")
		OBJECT SET ENABLED:C1123(*; "NTI_i8_s_atxt"; True:C214)  // **replaced _ o _ENABLE BUTTON(*;"NTI_i8_s_atxt")
		OBJECT SET ENABLED:C1123(*; "NTI_i9_L_atxt"; True:C214)  // **replaced _ o _ENABLE BUTTON(*;"NTI_i9_L_atxt")
		
End case 
//End Form Method: [NTI_TunnelInfo]New_TIN

