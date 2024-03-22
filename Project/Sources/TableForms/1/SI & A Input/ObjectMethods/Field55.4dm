//Make sure year is not in the future for Year of ADT Item 30

C_LONGINT:C283($y)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($i30)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(ysave30)  //Command Replaced was o_C_INTEGER

Case of 
	: (Form event code:C388=On Load:K2:1)
		ysave30:=[Bridge MHD NBIS:1]Item30:89
	: (Form event code:C388=On Data Change:K2:15)
		$y:=Year of:C25(Current date:C33(*))  //Get the current year
		$i30:=[Bridge MHD NBIS:1]Item30:89  //Get what the user entered
		If ($i30>$y)
			ALERT:C41("Year is in the future.  Please re-enter!")
			[Bridge MHD NBIS:1]Item30:89:=ysave30
		End if 
		PushChange(1; Self:C308)
End case 