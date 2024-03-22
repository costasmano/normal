C_TEXT:C284($errMsg)

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		C_TEXT:C284($password_t)
		C_LONGINT:C283($connected_l)
		$password_t:=(OBJECT Get pointer:C1124(Object named:K67:5; "USR_userPassword_t")->)
		
		$connected_l:=__USR_checkCredential(USR_userName_t; USR_UserPassword_t)
		Case of 
			: ($connected_l=-1)
				
				$errMsg:="unknown user ..."
				(OBJECT Get pointer:C1124(Object named:K67:5; "errMessage")->):=$errMsg
				__WIN_shake
				REJECT:C38
				
			: ($connected_l=0)
				
				GOTO OBJECT:C206(*; "USR_userPassword_t")
				HIGHLIGHT TEXT:C210(*; "USR_userPassword_t"; 1; MAXLONG:K35:2)
				$errMsg:="wrong password ..."
				(OBJECT Get pointer:C1124(Object named:K67:5; "errMessage")->):=$errMsg
				__WIN_shake
				REJECT:C38
				
			: ($connected_l=1)
				SET USER ALIAS:C1666(USR_userName_t)
				ACCEPT:C269
				OK:=1
		End case 
End case 