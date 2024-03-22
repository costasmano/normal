//%attributes = {"invisible":true}
//Method: NTI_SetEnterableForB
//Description
// allow entry to ID and vent zone depending on NTI_Prefix_txt
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 05/10/18, 14:58:15
	// ----------------------------------------------------
	//Created : 
	Mods_2018_05_bug
End if 
//
OBJECT SET ENTERABLE:C238(*; "NoEntry6_B"; (NTI_Prefix_txt="B"))
OBJECT SET ENTERABLE:C238(*; "NoEntry4_B"; (NTI_Prefix_txt="B"))

If (NTI_Prefix_txt="B")
	OBJECT SET RGB COLORS:C628(*; "NoEntry4_B"; Col_paletteToRGB(Abs:C99(<>Color_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "NoEntry4_B"; <>Color_editable)
	OBJECT SET RGB COLORS:C628(*; "NoEntry6_B"; Col_paletteToRGB(Abs:C99(<>Color_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "NoEntry6_B"; <>Color_editable)
	OBJECT SET FILTER:C235(*; "NoEntry6_B"; "~@")
	OBJECT SET FILTER:C235(*; "NoEntry4_B"; "~@")
	
Else 
	OBJECT SET RGB COLORS:C628(*; "NoEntry4_B"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "NoEntry4_B"; <>Color_Not_Editable)
	OBJECT SET RGB COLORS:C628(*; "NoEntry6_B"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "NoEntry6_B"; <>Color_Not_Editable)
	C_LONGINT:C283($FindInArray_L)
	$FindInArray_L:=Find in array:C230(NTI_TunnelID_atxt; NTI_TunnelID_s)
	If ($FindInArray_L<1)
		NTI_TunnelID_s:=""
	End if 
	
	$FindInArray_L:=Find in array:C230(NTI_VentID_atxt; NTI_Vent_s)
	If ($FindInArray_L<1)
		NTI_Vent_s:=""
	End if 
	
End if 

//End NTI_SetEnterableForB