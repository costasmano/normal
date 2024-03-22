If (False:C215)
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		OBJECT SET FILTER:C235(Self:C308->; "&"+Char:C90(Double quote:K15:41)+" -~;|"+Char:C90(13)+Char:C90(Double quote:K15:41))
		
	: (Form event code:C388=On Data Change:K2:15)
		Self:C308->:=f_TrimStr(Self:C308->; True:C214; True:C214)
		//Self->:=f_TrimStyledText (New object("texttotrim";Self->;"trimleading";True;"trimtrailing";True))
		PushChange(1; Self:C308)
		
End case 