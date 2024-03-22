PushChange(1; Self:C308)

If ([Bridge MHD NBIS:1]Item8 BridgeCat:207="DES")
	
	[Bridge MHD NBIS:1]Item29:88:=[Bridge Design:75]AvgDailyTraffic:41
	PushChange(2; ->[Bridge MHD NBIS:1]Item29:88)
	
End if 