If (Form event code:C388=On Printing Detail:K2:18)
	If ([Bridge MHD NBIS:1]Item92BA:165=True:C214)
		v92B:="Y"+String:C10([Bridge MHD NBIS:1]Item92BB:166; "00")
	Else 
		v92B:="N"
	End if 
End if 