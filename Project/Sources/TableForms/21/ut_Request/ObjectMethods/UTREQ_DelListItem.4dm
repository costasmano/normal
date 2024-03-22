Case of 
		
	: (Form event code:C388=On Clicked:K2:4)
		C_LONGINT:C283($row_L)
		$row_L:=Find in array:C230(ut_request_Choises; ut_Request_Value_txt)
		If ($row_L>0)
			DELETE FROM ARRAY:C228(ut_request_Choises; $row_L)
			ut_Request_Value_txt:=""
			ut_request_Choises{0}:=""
		End if 
		
End case 