//Data are stored as decimal feet

If ([Bridge Design:75]MetricUnit:38=True:C214)
	
	[Bridge Design:75]TotalSpanLength:25:=Round:C94(metric_vspanLength*3.280839850131; 5)
	PushChange(1; ->[Bridge Design:75]TotalSpanLength:25)
	
	If ([Bridge MHD NBIS:1]Item8 BridgeCat:207="DES")
		[Bridge MHD NBIS:1]Item48:92:=Round:C94(metric_vspanLength; 4)
		PushChange(2; ->[Bridge MHD NBIS:1]Item48:92)
	End if 
	
End if 