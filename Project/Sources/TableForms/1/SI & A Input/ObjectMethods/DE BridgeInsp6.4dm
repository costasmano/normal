If (Form event code:C388=On Data Change:K2:15)
	PushChange(1; Self:C308)
	If ([Bridge MHD NBIS:1]Item92CB:168>0)
		If ([Bridge MHD NBIS:1]Item92CA:167=False:C215)
			[Bridge MHD NBIS:1]Item92CA:167:=True:C214
			PushChange(1; ->[Bridge MHD NBIS:1]Item92CA:167)
		End if 
	Else 
		If ([Bridge MHD NBIS:1]Item92CA:167=True:C214)
			[Bridge MHD NBIS:1]Item92CA:167:=False:C215
			PushChange(1; ->[Bridge MHD NBIS:1]Item92CA:167)
		End if 
	End if 
	CalcItem91
	PushChange(1; ->[Bridge MHD NBIS:1]Item91:162)
End if 