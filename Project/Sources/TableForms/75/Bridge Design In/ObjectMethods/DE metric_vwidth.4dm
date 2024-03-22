If ([Bridge Design:75]MetricUnit:38=True:C214)
	[Bridge Design:75]WideOutToOut:26:=Round:C94(metric_vwidth*3.280839850131; 5)
	PushChange(1; ->[Bridge Design:75]WideOutToOut:26)
	
	If ([Bridge MHD NBIS:1]Item8 BridgeCat:207="DES")
		[Bridge MHD NBIS:1]Item52:97:=Round:C94(metric_vwidth; 4)
		PushChange(2; ->[Bridge MHD NBIS:1]Item52:97)
	End if 
	
	If (([Bridge Design:75]WideOutToOut:26*[Bridge Design:75]StructLength:43)#0)
		C_REAL:C285(area)
		area:=([Bridge Design:75]WideOutToOut:26*0.3048*[Bridge Design:75]StructLength:43*0.3048)
		[Bridge Design:75]CostPerSQM:37:=[Bridge Design:75]TotalOfficeEstimate:6/area
		PushChange(1; ->[Bridge Design:75]CostPerSQM:37)
	End if 
	
End if 