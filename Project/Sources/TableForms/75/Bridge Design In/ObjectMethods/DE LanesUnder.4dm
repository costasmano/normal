PushChange(1; Self:C308)

If ([Bridge MHD NBIS:1]Item8 BridgeCat:207="DES")
	
	[Bridge MHD NBIS:1]Item28B:87:=[Bridge Design:75]LanesUnderStruct:40
	PushChange(2; ->[Bridge MHD NBIS:1]Item28B:87)
	
End if 