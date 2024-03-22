If (Form event code:C388=On Clicked:K2:4)
	C_BOOLEAN:C305($vbPwdChk)
	$vbPwdChk:=Validate password:C638(f_GetUserID(Current user:C182); vsPassword)
	If (Not:C34($vbPwdChk))
		ALERT:C41("Invalid Password for user "+Current user:C182)
	Else 
		ACCEPT:C269
	End if 
End if 