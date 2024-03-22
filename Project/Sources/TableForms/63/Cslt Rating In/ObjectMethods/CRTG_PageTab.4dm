
Case of 
	: (Form event code:C388=On Load:K2:1)
		Case of 
			: (FORM Get current page:C276=1)
				Self:C308->:=1
			: (FORM Get current page:C276=2)
				Self:C308->:=2
			: (FORM Get current page:C276=3)
				Self:C308->:=3
			: (FORM Get current page:C276=4)
				Self:C308->:=4
			: (FORM Get current page:C276=5)
				If ((User in group:C338(Current user:C182; "Design Access Group")) | User in group:C338(Current user:C182; "Ratings and Overloads"))
					Self:C308->:=2
				Else 
					
				End if 
				
		End case 
		
	: (Form event code:C388=On Clicked:K2:4)
		Case of 
			: (Self:C308->=1)
				FORM GOTO PAGE:C247(1)
			: (Self:C308->=2)
				If ((User in group:C338(Current user:C182; "Design Access Group")) | User in group:C338(Current user:C182; "Ratings and Overloads"))
					FORM GOTO PAGE:C247(5)
				Else 
					FORM GOTO PAGE:C247(2)
				End if 
			: (Self:C308->=3)
				FORM GOTO PAGE:C247(3)
			: (Self:C308->=4)
				FORM GOTO PAGE:C247(4)
		End case 
		
End case 
