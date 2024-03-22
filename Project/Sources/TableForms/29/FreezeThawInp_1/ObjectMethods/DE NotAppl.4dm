Case of 
	: (Form event code:C388=On Clicked:K2:4)
		InitChangeStack(2)
		If (Self:C308->=1)
			OBJECT SET ENTERABLE:C238(*; "DE FRZ@"; False:C215)
			OBJECT SET RGB COLORS:C628(*; "DE FRZ@"; Col_paletteToRGB(Abs:C99(<>Color_not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_not_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE FRZ@"; <>Color_not_editable)
			OBJECT SET ENABLED:C1123(*; "DE FRZ@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			FRZFieldTests_txt:=""
			SET BLOB SIZE:C606([ElementsSafety:29]ElmComments:23; 0)
			PushChange(2; ->[ElementsSafety:29]ElmComments:23)
			[ElementsSafety:29]Comments:5:=""
			PushChange(2; ->[ElementsSafety:29]Comments:5)
			FRZNoProblem_L:=0
			[ElementsSafety:29]Rating:2:=String:C10(FRZNoProblem_L)
			PushChange(2; ->[ElementsSafety:29]Rating:2)
			FRZNoAction_L:=0
			[ElementsSafety:29]Deficiency:3:=String:C10(FRZNoAction_L)
			PushChange(2; ->[ElementsSafety:29]Deficiency:3)
		Else 
			OBJECT SET ENTERABLE:C238(*; "DE FRZ@"; True:C214)
			OBJECT SET RGB COLORS:C628(*; "DE FRZ@"; Col_paletteToRGB(Abs:C99(<>Color_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE FRZ@"; <>Color_editable)
			OBJECT SET ENABLED:C1123(*; "DE FRZ@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		End if 
		If ([ElementsSafety:29]Crack:9=(Self:C308->=1))
			
		Else 
			[ElementsSafety:29]Crack:9:=(Self:C308->=1)
			PushChange(2; ->[ElementsSafety:29]Crack:9)
			
		End if 
		If (Modified record:C314([ElementsSafety:29]))
			SAVE RECORD:C53([ElementsSafety:29])
			FlushGrpChgs(2; ->[Inspections:27]InspID:2; ->[ElementsSafety:29]InspID:4; ->[ElementsSafety:29]ElmSafetyID:7; 2)
		End if 
		
End case 