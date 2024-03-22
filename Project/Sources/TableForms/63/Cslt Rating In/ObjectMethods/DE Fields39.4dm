Case of 
	: (Form event code:C388=On Getting Focus:K2:7)
		If (Self:C308->="")
			Self:C308->:=[Conslt Rating:63]AssignRatCons:5
			PushChange(1; Self:C308)
			
		End if 
		
	: (Form event code:C388=On Data Change:K2:15)
		PushChange(1; Self:C308)
	: (Form event code:C388=On Clicked:K2:4)
		
End case 

