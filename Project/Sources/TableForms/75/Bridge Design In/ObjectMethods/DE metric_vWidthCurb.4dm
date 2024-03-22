If ([Bridge Design:75]MetricUnit:38=True:C214)
	[Bridge Design:75]WidthCurbToCurb:44:=Round:C94(metric_vWidthCurb*3.280839850131; 5)
	PushChange(1; ->[Bridge Design:75]WidthCurbToCurb:44)
	
	If ([Bridge MHD NBIS:1]Item8 BridgeCat:207="DES")
		[Bridge MHD NBIS:1]Item51:96:=Round:C94(metric_vWidthCurb; 4)
		PushChange(2; ->[Bridge MHD NBIS:1]Item51:96)
	End if 
End if 