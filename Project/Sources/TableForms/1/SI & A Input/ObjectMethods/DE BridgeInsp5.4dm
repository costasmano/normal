If (Form event code:C388=On Data Change:K2:15)
	PushChange(1; Self:C308)
	If ([Bridge MHD NBIS:1]Item92AB:164>0)
		If ([Bridge MHD NBIS:1]Item92AA:163=False:C215)
			[Bridge MHD NBIS:1]Item92AA:163:=True:C214
			PushChange(1; ->[Bridge MHD NBIS:1]Item92AA:163)
		End if 
	Else 
		If ([Bridge MHD NBIS:1]Item92AA:163=True:C214)
			[Bridge MHD NBIS:1]Item92AA:163:=False:C215
			PushChange(1; ->[Bridge MHD NBIS:1]Item92AA:163)
		End if 
	End if 
	CalcItem91
	PushChange(1; ->[Bridge MHD NBIS:1]Item91:162)
End if 