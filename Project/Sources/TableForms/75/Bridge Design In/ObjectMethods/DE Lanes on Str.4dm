PushChange(1; Self:C308)

If ([Bridge MHD NBIS:1]Item8 BridgeCat:207="DES")
	
	[Bridge MHD NBIS:1]Item28A:86:=[Bridge Design:75]LanesOnStruct:39
	PushChange(2; ->[Bridge MHD NBIS:1]Item28A:86)
	
End if 