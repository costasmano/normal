//Method: ElementDeficiencyQuery.cbElemDescTxt
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 12/13/18, 13:43:51
	// ----------------------------------------------------
	//Created : 
	Mods_2018_12
End if 
//
OBJECT SET ENABLED:C1123(cboDescComparison; Not:C34(cbElemDescTxt=0))
OBJECT SET ENTERABLE:C238(SRC_ELEMDESC_txt; Not:C34(cbElemDescTxt=0))
cboDescComparison:=0
SRC_ELEMDESC_txt:=""
OBJECT SET ENABLED:C1123(*; "FindButton"; LSS_EditCheckDefQRY)
If (cbElemDescTxt=0)
	OBJECT SET RGB COLORS:C628(*; "SRC_ELEMDESC_txt"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "SRC_ELEMDESC_txt"; <>Color_Not_Editable)
Else 
	OBJECT SET RGB COLORS:C628(*; "SRC_ELEMDESC_txt"; Col_paletteToRGB(Abs:C99(<>Color_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "SRC_ELEMDESC_txt"; <>Color_editable)
End if 
//End ElementDeficiencyQuery.cbElemDescTxt