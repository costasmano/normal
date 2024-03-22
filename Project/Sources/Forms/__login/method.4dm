Case of 
	: (Form event code:C388=On Load:K2:1)
		Form_Show_Pass:=False:C215
		USR_userName_t:=""
		USR_UserPassword_t:=""
		OBJECT SET FONT:C164(*; "USR_userPassword_t"; "%password")
		SET WINDOW TITLE:C213("Login to MassDOT BMS")
	: (Form event code:C388=On Validate:K2:3)
		
	: (Form event code:C388=On Close Box:K2:21)
		
	: (Form event code:C388=On Unload:K2:2)
		
End case 

