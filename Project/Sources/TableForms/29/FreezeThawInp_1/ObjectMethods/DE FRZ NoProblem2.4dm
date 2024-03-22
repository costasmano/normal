Case of 
	: (Form event code:C388=On Clicked:K2:4)
		[ElementsSafety:29]Rating:2:="2"
		PushChange(2; ->[ElementsSafety:29]Rating:2)
		FRZ_Problem_No:=0
		OBJECT SET ENTERABLE:C238(*; "DE FRZ FieldAction@"; True:C214)
		OBJECT SET RGB COLORS:C628(*; "DE FRZ FieldAction@"; Col_paletteToRGB(Abs:C99(<>Color_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE FRZ FieldAction@"; <>Color_editable)
		
End case 
