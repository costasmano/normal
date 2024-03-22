Case of 
	: (Form event code:C388=On Load:K2:1)
		
	: (Form event code:C388=On Data Change:K2:15)
		C_LONGINT:C283($clicked)
		$clicked:=ut_request_choises
		ut_request_value_txt:=ut_request_choises{0}
		
	: (Form event code:C388=On Clicked:K2:4)
		C_LONGINT:C283($clicked)
		$clicked:=ut_request_choises
		ut_request_value_txt:=ut_request_choises{$clicked}
		
End case 
