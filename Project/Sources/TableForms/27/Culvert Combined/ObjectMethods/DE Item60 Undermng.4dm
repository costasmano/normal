If (Form event code:C388=On Clicked:K2:4)
	PushChange(1; Self:C308)
End if 
OBJECT SET ENTERABLE:C238([Inspections:27]UnderminingTxt:102; (Self:C308->))
If (Not:C34(Self:C308->))
	If (Form event code:C388=On Clicked:K2:4)
		[Inspections:27]UnderminingTxt:102:=""
		PushChange(1; ->[Inspections:27]UnderminingTxt:102)
	End if 
	OBJECT SET ENABLED:C1123(*; "DE I60Under@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
Else 
	OBJECT SET ENABLED:C1123(*; "DE I60Under@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
	If ([Inspections:27]UnderminingTxt:102="")
		//Alert user to enter text
		OBJECT SET RGB COLORS:C628(*; "DE I60Under@"; Col_paletteToRGB(Abs:C99(-(Red:K11:4))%256); Col_paletteToRGB(Abs:C99(-(Red:K11:4))\256))  // **Replaced o OBJECT SET COLOR(*; "DE I60Under@"; -(Red))
	Else 
		OBJECT SET RGB COLORS:C628(*; "DE I60Under@"; Col_paletteToRGB(Abs:C99(-(Black:K11:16))%256); Col_paletteToRGB(Abs:C99(-(Black:K11:16))\256))  // **Replaced o OBJECT SET COLOR(*; "DE I60Under@"; -(Black))
		
	End if 
End if 
