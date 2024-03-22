If ([Bridge Design:75]MetricUnit:38=True:C214)
	[Bridge Design:75]SidewalkRight:24:=Round:C94(metric_vright*3.280839850131; 5)
	PushChange(1; ->[Bridge Design:75]SidewalkRight:24)
	
	If ([Bridge MHD NBIS:1]Item8 BridgeCat:207="DES")
		[Bridge MHD NBIS:1]Item50B:95:=Round:C94(metric_vright; 4)
		PushChange(2; ->[Bridge MHD NBIS:1]Item50B:95)
	End if 
End if 