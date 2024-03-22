Case of 
	: (Form event code:C388=On Data Change:K2:15)
		FRZFieldTests_txt:=f_TrimStr(FRZFieldTests_txt; True:C214; True:C214)
		If (FRZFieldTests_txt="")
			SET BLOB SIZE:C606([ElementsSafety:29]ElmComments:23; 0)
		Else 
			VARIABLE TO BLOB:C532(FRZFieldTests_txt; [ElementsSafety:29]ElmComments:23)
		End if 
		
		PushChange(2; ->[ElementsSafety:29]ElmComments:23)
		
End case 
