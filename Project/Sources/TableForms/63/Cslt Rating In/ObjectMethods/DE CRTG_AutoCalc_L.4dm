Case of 
	: (Form event code:C388=On Load:K2:1)
		C_TEXT:C284($CurrUser_txt)
		$CurrUser_txt:=Current user:C182
		
		If (User in group:C338($CurrUser_txt; "Conslt Rating - ReadWrite") | User in group:C338($CurrUser_txt; "Design Access Group"))
			OBJECT SET VISIBLE:C603(Self:C308->; True:C214)
		End if 
		Self:C308->:=0
	: (Form event code:C388=On Data Change:K2:15)
		
	: (Form event code:C388=On Clicked:K2:4)
		
End case 