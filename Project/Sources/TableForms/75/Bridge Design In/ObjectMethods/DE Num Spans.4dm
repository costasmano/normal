PushChange(1; Self:C308)

If ([Bridge MHD NBIS:1]Item8 BridgeCat:207="DES")
	[Bridge MHD NBIS:1]Item45:77:=[Bridge Design:75]NumSpans:27
	PushChange(2; ->[Bridge MHD NBIS:1]Item45:77)
End if 