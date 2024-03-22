//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 11/05/15, 11:45:47
//----------------------------------------------------
//Method: NTI_SetLoadRatingEntry
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_10  // 
	//Modified by: administrator (11/5/15 11:45:48)
	
End if 
C_BOOLEAN:C305($Enterable_B)
$Enterable_B:=(Not:C34([NTI_TunnelInfo:181]NTI_L1_s:59="N"))
If ($Enterable_B)
	OBJECT SET RGB COLORS:C628(*; "NTI_L2_r"; Col_paletteToRGB(Abs:C99(<>Color_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "NTI_L2_r"; <>Color_editable)
	OBJECT SET RGB COLORS:C628(*; "NTI_L3_r"; Col_paletteToRGB(Abs:C99(<>Color_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "NTI_L3_r"; <>Color_editable)
Else 
	OBJECT SET RGB COLORS:C628(*; "NTI_L2_r"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "NTI_L2_r"; <>Color_Not_Editable)
	OBJECT SET RGB COLORS:C628(*; "NTI_L3_r"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "NTI_L3_r"; <>Color_Not_Editable)
	[NTI_TunnelInfo:181]NTI_L3_r:61:=0
	[NTI_TunnelInfo:181]NTI_L2_r:60:=0
End if 
OBJECT SET RGB COLORS:C628(*; "NonEntry"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "NonEntry"; <>Color_Not_Editable)

//End NTI_SetLoadRatingEntry

