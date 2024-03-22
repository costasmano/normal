Case of 
	: (Form event code:C388=On Load:K2:1)
		If ([Inspections:27]YrPainted:157=-1)
			Self:C308->:=1
		Else 
			Self:C308->:=0
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		If (Self:C308->=0)
			[Inspections:27]YrPainted:157:=0
			OBJECT SET ENTERABLE:C238([Inspections:27]YrPainted:157; True:C214)
			OBJECT SET RGB COLORS:C628([Inspections:27]YrPainted:157; Col_paletteToRGB(Abs:C99(<>Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Editable)\256))  // **Replaced o OBJECT SET COLOR([Inspections]YrPainted; <>Color_Editable)
		Else 
			[Inspections:27]YrPainted:157:=-1
			OBJECT SET ENTERABLE:C238([Inspections:27]YrPainted:157; False:C215)
			OBJECT SET RGB COLORS:C628([Inspections:27]YrPainted:157; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR([Inspections]YrPainted; <>Color_Not_Editable)
		End if 
		PushChange(1; ->[Inspections:27]YrPainted:157)
End case 
