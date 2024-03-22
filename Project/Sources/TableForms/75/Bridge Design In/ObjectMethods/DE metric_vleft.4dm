If ([Bridge Design:75]MetricUnit:38=True:C214)
	[Bridge Design:75]SidewalkLeft:23:=Round:C94(metric_vleft*3.280839850131; 5)
	PushChange(1; ->[Bridge Design:75]SidewalkLeft:23)
	
	If ([Bridge MHD NBIS:1]Item8 BridgeCat:207="DES")
		[Bridge MHD NBIS:1]Item50A:94:=Round:C94(metric_vleft; 4)
		PushChange(2; ->[Bridge MHD NBIS:1]Item50A:94)
	End if 
End if 