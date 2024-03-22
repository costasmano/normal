Case of 
	: (Form event code:C388=On Clicked:K2:4)
		[ElementsSafety:29]Rating:2:="1"
		PushChange(2; ->[ElementsSafety:29]Rating:2)
		[ElementsSafety:29]Comments:5:=""
		PushChange(2; ->[ElementsSafety:29]Comments:5)
		OBJECT SET ENTERABLE:C238(*; "DE FRZ FieldAction@"; False:C215)
		OBJECT SET RGB COLORS:C628(*; "DE FRZ FieldAction@"; Col_paletteToRGB(Abs:C99(<>Color_not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_not_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE FRZ FieldAction@"; <>Color_not_editable)
		FRZ_Problem_Yes:=0
End case 
