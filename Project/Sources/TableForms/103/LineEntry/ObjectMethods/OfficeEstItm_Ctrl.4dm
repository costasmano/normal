Case of 
	: (Form event code:C388=On Load:K2:1)
		Self:C308->:=1
	: (Form event code:C388=On Clicked:K2:4)
		Case of 
			: (Self:C308->=1)
				FORM GOTO PAGE:C247(1)
			: (Self:C308->=2)
				FORM GOTO PAGE:C247(2)
		End case 
		WKHR_LineEntry_FM(On Load:K2:1)
End case 
