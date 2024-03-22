If (Self:C308->)
	OBJECT SET ENTERABLE:C238(*; "DE@"; False:C215)
	OBJECT SET RGB COLORS:C628(*; "DE@"; Col_paletteToRGB(Abs:C99(<>Color_not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_not_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE@"; <>Color_not_editable)
	OBJECT SET ENABLED:C1123(*; "DE@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
	OBJECT SET VISIBLE:C603(*; "DE subform1"; False:C215)
	OBJECT SET VISIBLE:C603(*; "DE subform2"; True:C214)
Else 
	OBJECT SET ENTERABLE:C238(*; "DE@"; True:C214)
	OBJECT SET RGB COLORS:C628(*; "DE@"; Col_paletteToRGB(Abs:C99(<>Color_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE@"; <>Color_editable)
	OBJECT SET ENABLED:C1123(*; "DE@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
	OBJECT SET VISIBLE:C603(*; "DE subform1"; True:C214)
	OBJECT SET VISIBLE:C603(*; "DE subform2"; False:C215)
End if 