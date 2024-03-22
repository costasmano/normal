//Error check for Item 115

C_LONGINT:C283($y; $y1; $y2)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($i115)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(ysave115)  //Command Replaced was o_C_INTEGER

Case of 
	: (Form event code:C388=On Load:K2:1)
		ysave115:=[Bridge MHD NBIS:1]Item115:160
	: (Form event code:C388=On Data Change:K2:15)
		$y:=Year of:C25(Current date:C33(*))  //Get the current year
		$i115:=[Bridge MHD NBIS:1]Item115:160  //Get what the user entered
		$y1:=$y+17
		$y2:=$y+22
		If (($i115>$y2) | ($i115<$y1))
			ALERT:C41("Year of Future ADT must be 17 years into the future but not more than 22 years!")
			[Bridge MHD NBIS:1]Item115:160:=ysave115
		Else 
			PushChange(1; Self:C308)
		End if 
		
End case 