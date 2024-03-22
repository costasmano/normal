PushChange(1; Self:C308)

If ([Bridge MHD NBIS:1]Item8 BridgeCat:207="DES")
	
	[Bridge MHD NBIS:1]Item30:89:=[Bridge Design:75]YearADT:42
	PushChange(2; ->[Bridge MHD NBIS:1]Item30:89)
	
End if 