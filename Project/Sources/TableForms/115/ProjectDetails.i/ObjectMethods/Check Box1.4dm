// ----------------------------------------------------
// Object Method: PRJ_AllowBridgeEntry_l
// User name (OS): cjmiller
// Date and time: 02/03/06, 13:27:51
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
End if 
If (PRJ_AllowBridgeEntry_l=1)
	OBJECT SET ENTERABLE:C238(PRJ_DEBridgeNo_s; True:C214)
	OBJECT SET ENTERABLE:C238(PRJ_DEBin_s; True:C214)
	OBJECT SET RGB COLORS:C628(PRJ_DEBridgeNo_s; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)\256))  // **Replaced o OBJECT SET COLOR(PRJ_DEBridgeNo_s; <>PRJ_Color_Editable)
	OBJECT SET RGB COLORS:C628(PRJ_DEBin_s; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Editable)\256))  // **Replaced o OBJECT SET COLOR(PRJ_DEBin_s; <>PRJ_Color_Editable)
Else 
	OBJECT SET ENTERABLE:C238(PRJ_DEBridgeNo_s; False:C215)
	OBJECT SET ENTERABLE:C238(PRJ_DEBin_s; False:C215)
	OBJECT SET RGB COLORS:C628(PRJ_DEBridgeNo_s; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)\256))  // **Replaced o OBJECT SET COLOR(PRJ_DEBridgeNo_s; <>PRJ_Color_Not_editable)
	OBJECT SET RGB COLORS:C628(PRJ_DEBin_s; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)\256))  // **Replaced o OBJECT SET COLOR(PRJ_DEBin_s; <>PRJ_Color_Not_editable)
	
End if 
//End Object Method: PRJ_AllowBridgeEntry_l