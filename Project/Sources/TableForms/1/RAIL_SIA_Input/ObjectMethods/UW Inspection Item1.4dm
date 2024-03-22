If (Form event code:C388=On Data Change:K2:15)
	If (User in group:C338(Current user:C182; "MDC")=False:C215)
		PushChange(1; Self:C308)
	End if 
	If ([Bridge MHD NBIS:1]Item92BB:166>0)
		If ([Bridge MHD NBIS:1]Item92BA:165=False:C215)
			[Bridge MHD NBIS:1]Item92BA:165:=True:C214
			PushChange(1; ->[Bridge MHD NBIS:1]Item92BA:165)
		End if 
	Else 
		If ([Bridge MHD NBIS:1]Item92BA:165=True:C214)
			[Bridge MHD NBIS:1]Item92BA:165:=False:C215
			PushChange(1; ->[Bridge MHD NBIS:1]Item92BA:165)
		End if 
	End if 
	CalcItem91
	PushChange(1; ->[Bridge MHD NBIS:1]Item91:162)
End if 