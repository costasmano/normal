//Make sure the year of improvement cost is current within 8 years
C_LONGINT:C283($y)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($i97)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(Itm97save)  //Command Replaced was o_C_INTEGER

Case of 
	: (Form event code:C388=On Load:K2:1)
		Itm97save:=[Bridge MHD NBIS:1]Item97:158
	: (Form event code:C388=On Data Change:K2:15)
		$y:=Year of:C25(Current date:C33(*))  //Get the current year
		$i97:=[Bridge MHD NBIS:1]Item97:158  //Get what the user entered
		$i97:=$i97+1900
		If ($i97<1950)
			$i97:=$i97+100  //assume this is in the year 2000
		End if 
		If ($i97<=($y-8))
			ALERT:C41("Year of improvement cost must be 8 years current!")
			[Bridge MHD NBIS:1]Item97:158:=Itm97save
		Else 
			PushChange(1; Self:C308)
		End if 
End case 