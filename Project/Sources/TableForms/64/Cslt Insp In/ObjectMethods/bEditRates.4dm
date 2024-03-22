If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/06/08, 15:10:28
	// ----------------------------------------------------
	// Method: Object Method: bEditRates
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2008_CM_5404
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		If ((Current user:C182="Designer"))
			OBJECT SET VISIBLE:C603(Self:C308->; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(Self:C308->; False:C215)
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		OBJECT SET ENTERABLE:C238(*; "overheadRate"; True:C214)
		OBJECT SET ENTERABLE:C238(*; "netFeeRate"; True:C214)
		OBJECT SET RGB COLORS:C628(*; "overheadRate"; Col_paletteToRGB(Abs:C99(<>Color_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "overheadRate"; <>Color_editable)
		OBJECT SET RGB COLORS:C628(*; "netFeeRate"; Col_paletteToRGB(Abs:C99(<>Color_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "netFeeRate"; <>Color_editable)
		REDRAW WINDOW:C456
		GOTO OBJECT:C206(*; "overheadRate")
		POST KEY:C465(Tab key:K12:28)
		POST KEY:C465(Tab key:K12:28; Shift key mask:K16:3)
		
End case 
