PushChange(1; Self:C308)

If ([Bridge MHD NBIS:1]Item8 BridgeCat:207="DES")
	
	[Bridge MHD NBIS:1]Item34:100:=[Bridge Design:75]SkewAngle:28
	PushChange(2; ->[Bridge MHD NBIS:1]Item34:100)
	
End if 